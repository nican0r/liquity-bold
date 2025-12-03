# Function: testCanOpenTroveAndJoinBatchWithHybrid()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testCanOpenTroveAndJoinBatchWithHybrid()`
- **Visibility**: external
- **Source Range**: 16592:298:338

## Implementation

```solidity
function testCanOpenTroveAndJoinBatchWithHybrid() external {
    for (uint256 i = 0; i < 3; i++) {
        _registerBatchManager(B, i);
        _testCanOpenTrove(leverageZapperHybridArray[i], ExchangeType.HybridCurveUniV3, i, B);
    }
}
```

## Related Implementations

### _registerBatchManager(address,uint256)

- **Kind**: internal
- **Source**: 16896:329:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_registerBatchManager(address,uint256)`

```solidity
function _registerBatchManager(address _account, uint256 _branch) internal {
    vm.startPrank(_account);
    contractsArray[_branch].borrowerOperations.registerBatchManager(uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
    vm.stopPrank();
}
```

### _testCanOpenTrove(contract ILeverageZapper,enum ZapperLeverageMainnet.ExchangeType,uint256,address)

- **Kind**: internal
- **Source**: 17231:3947:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testCanOpenTrove(contract ILeverageZapper,enum ZapperLeverageMainnet.ExchangeType,uint256,address)`

```solidity
function _testCanOpenTrove(ILeverageZapper _leverageZapper, ExchangeType _exchangeType, uint256 _branch, address _batchManager) internal {
    TestVars memory vars;
    vars.collAmount = 10 ether;
    vars.newLeverageRatio = 2e18;
    vars.resultingCollateralRatio = _leverageZapper.leverageRatioToCollateralRatio(vars.newLeverageRatio);
    _setInitialBalances(_leverageZapper, _branch, vars);
    OpenLeveragedTroveWithIndexParams memory openTroveParams;
    openTroveParams.leverageZapper = _leverageZapper;
    openTroveParams.collToken = contractsArray[_branch].collToken;
    openTroveParams.index = 0;
    openTroveParams.collAmount = vars.collAmount;
    openTroveParams.leverageRatio = vars.newLeverageRatio;
    openTroveParams.priceFeed = contractsArray[_branch].priceFeed;
    openTroveParams.exchangeType = _exchangeType;
    openTroveParams.branch = _branch;
    openTroveParams.batchManager = _batchManager;
    uint256 expectedMinNetDebt;
    (vars.troveId, expectedMinNetDebt) = openLeveragedTroveWithIndex(openTroveParams);
    (vars.price, ) = contractsArray[_branch].priceFeed.fetchPrice();
    assertEq(contractsArray[_branch].troveNFT.ownerOf(vars.troveId), A, "Wrong owner");
    assertGt(vars.troveId, 0, "Trove id should be set");
    assertEq(getTroveEntireColl(contractsArray[_branch].troveManager, vars.troveId), (vars.collAmount * vars.newLeverageRatio) / DECIMAL_PRECISION, "Coll mismatch");
    uint256 expectedMaxNetDebt = (expectedMinNetDebt * 105) / 100;
    uint256 troveEntireDebt = getTroveEntireDebt(contractsArray[_branch].troveManager, vars.troveId);
    assertGe(troveEntireDebt, expectedMinNetDebt, "Debt too low");
    assertLe(troveEntireDebt, expectedMaxNetDebt, "Debt too high");
    uint256 ICR = contractsArray[_branch].troveManager.getCurrentICR(vars.troveId, vars.price);
    assertTrue((ICR >= vars.resultingCollateralRatio) || ((vars.resultingCollateralRatio - ICR) < 3e16), "Wrong CR");
    assertEq(boldToken.balanceOf(A), vars.boldBalanceBeforeA, "BOLD bal mismatch");
    assertEq(boldToken.balanceOf(address(_leverageZapper)), vars.boldBalanceBeforeZapper, "Zapper should not keep BOLD");
    assertEq(boldToken.balanceOf(address(_leverageZapper.exchange())), vars.boldBalanceBeforeExchange, "Exchange should not keep BOLD");
    assertEq(contractsArray[_branch].collToken.balanceOf(address(_leverageZapper)), vars.collBalanceBeforeZapper, "Zapper should not keep Coll");
    assertEq(contractsArray[_branch].collToken.balanceOf(address(_leverageZapper.exchange())), vars.collBalanceBeforeExchange, "Exchange should not keep Coll");
    assertEq(address(_leverageZapper).balance, vars.ethBalanceBeforeZapper, "Zapper should not keep ETH");
    assertEq(address(_leverageZapper.exchange()).balance, vars.ethBalanceBeforeExchange, "Exchange should not keep ETH");
    if (_branch > 0) {
        assertEq(A.balance, vars.ethBalanceBeforeA - ETH_GAS_COMPENSATION, "ETH bal mismatch");
        assertGe(contractsArray[_branch].collToken.balanceOf(A), vars.collBalanceBeforeA - vars.collAmount, "Coll bal mismatch");
    } else {
        assertEq(A.balance, (vars.ethBalanceBeforeA - ETH_GAS_COMPENSATION) - vars.collAmount, "ETH bal mismatch");
        assertGe(contractsArray[_branch].collToken.balanceOf(A), vars.collBalanceBeforeA, "Coll bal mismatch");
    }
}
```

### _setInitialBalances(contract ILeverageZapper,uint256,struct ZapperLeverageMainnet.TestVars)

- **Kind**: internal
- **Source**: 14401:913:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_setInitialBalances(contract ILeverageZapper,uint256,struct ZapperLeverageMainnet.TestVars)`

```solidity
function _setInitialBalances(ILeverageZapper _leverageZapper, uint256 _branch, TestVars memory vars) internal view {
    vars.boldBalanceBeforeA = boldToken.balanceOf(A);
    vars.ethBalanceBeforeA = A.balance;
    vars.collBalanceBeforeA = contractsArray[_branch].collToken.balanceOf(A);
    vars.boldBalanceBeforeZapper = boldToken.balanceOf(address(_leverageZapper));
    vars.ethBalanceBeforeZapper = address(_leverageZapper).balance;
    vars.collBalanceBeforeZapper = contractsArray[_branch].collToken.balanceOf(address(_leverageZapper));
    vars.boldBalanceBeforeExchange = boldToken.balanceOf(address(_leverageZapper.exchange()));
    vars.ethBalanceBeforeExchange = address(_leverageZapper.exchange()).balance;
    vars.collBalanceBeforeExchange = contractsArray[_branch].collToken.balanceOf(address(_leverageZapper.exchange()));
}
```

### openLeveragedTroveWithIndex(struct ZapperLeverageMainnet.OpenLeveragedTroveWithIndexParams)

- **Kind**: internal
- **Source**: 12414:1981:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:openLeveragedTroveWithIndex(struct ZapperLeverageMainnet.OpenLeveragedTroveWithIndexParams)`

```solidity
function openLeveragedTroveWithIndex(OpenLeveragedTroveWithIndexParams memory _inputParams) internal returns (uint256, uint256) {
    OpenTroveVars memory vars;
    (vars.price, ) = _inputParams.priceFeed.fetchPrice();
    vars.flashLoanAmount = (_inputParams.collAmount * (_inputParams.leverageRatio - DECIMAL_PRECISION)) / DECIMAL_PRECISION;
    vars.expectedBoldAmount = (vars.flashLoanAmount * vars.price) / DECIMAL_PRECISION;
    vars.maxNetDebt = (vars.expectedBoldAmount * 105) / 100;
    vars.effectiveBoldAmount = _getBoldAmountToSwap(_inputParams.exchangeType, _inputParams.branch, vars.expectedBoldAmount, vars.maxNetDebt, vars.flashLoanAmount, _inputParams.collToken);
    ILeverageZapper.OpenLeveragedTroveParams memory params = ILeverageZapper.OpenLeveragedTroveParams({owner: A, ownerIndex: _inputParams.index, collAmount: _inputParams.collAmount, flashLoanAmount: vars.flashLoanAmount, boldAmount: vars.effectiveBoldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: (_inputParams.batchManager == address(0)) ? 5e16 : 0, batchManager: _inputParams.batchManager, maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    vars.value = (_inputParams.branch > 0) ? ETH_GAS_COMPENSATION : (_inputParams.collAmount + ETH_GAS_COMPENSATION);
    _inputParams.leverageZapper.openLeveragedTroveWithRawETH{value: vars.value}(params);
    vars.troveId = addressToTroveIdThroughZapper(address(_inputParams.leverageZapper), A, _inputParams.index);
    vm.stopPrank();
    return (vars.troveId, vars.effectiveBoldAmount);
}
```

### _getBoldAmountToSwap(enum ZapperLeverageMainnet.ExchangeType,uint256,uint256,uint256,uint256,contract IERC20)

- **Kind**: internal
- **Source**: 83776:652:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_getBoldAmountToSwap(enum ZapperLeverageMainnet.ExchangeType,uint256,uint256,uint256,uint256,contract IERC20)`

```solidity
function _getBoldAmountToSwap(ExchangeType _exchangeType, uint256 _branch, uint256 _boldAmount, uint256 _maxBoldAmount, uint256 _minCollAmount, IERC20 _collToken) internal returns (uint256) {
    if (_exchangeType == ExchangeType.Curve) {
        return _getBoldAmountToSwapCurve(_branch, _boldAmount, _maxBoldAmount, _minCollAmount);
    }
    if (_exchangeType == ExchangeType.UniV3) {
        return _getBoldAmountToSwapUniV3(_maxBoldAmount, _minCollAmount, _collToken);
    }
    return _getBoldAmountToSwapHybrid(_maxBoldAmount, _minCollAmount, _collToken);
}
```

### _getBoldAmountToSwapCurve(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 84434:1093:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_getBoldAmountToSwapCurve(uint256,uint256,uint256,uint256)`

```solidity
function _getBoldAmountToSwapCurve(uint256 _branch, uint256 _boldAmount, uint256 _maxBoldAmount, uint256 _minCollAmount) internal view returns (uint256) {
    ICurvePool curvePool = CurveExchange(address(leverageZapperCurveArray[_branch].exchange())).curvePool();
    uint256 step = (_maxBoldAmount - _boldAmount) / 5;
    uint256 dy;
    uint256 lastBoldAmount = _maxBoldAmount + step;
    do {
        lastBoldAmount -= step;
        dy = curvePool.get_dy(BOLD_TOKEN_INDEX, COLL_TOKEN_INDEX, lastBoldAmount);
    } while((dy > _minCollAmount) && (lastBoldAmount > step));
    uint256 boldAmountToSwap = (dy >= _minCollAmount) ? lastBoldAmount : (lastBoldAmount + step);
    require(boldAmountToSwap <= _maxBoldAmount, "Bold amount required too high");
    return boldAmountToSwap;
}
```

### _getBoldAmountToSwapUniV3(uint256,uint256,contract IERC20)

- **Kind**: internal
- **Source**: 85826:629:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_getBoldAmountToSwapUniV3(uint256,uint256,contract IERC20)`

```solidity
function _getBoldAmountToSwapUniV3(uint256 _maxBoldAmount, uint256 _minCollAmount, IERC20 _collToken) internal returns (uint256) {
    IQuoterV2.QuoteExactOutputSingleParams memory params = IQuoterV2.QuoteExactOutputSingleParams({tokenIn: address(boldToken), tokenOut: address(_collToken), amount: _minCollAmount, fee: UNIV3_FEE, sqrtPriceLimitX96: 0});
    (uint256 amountIn, , , ) = uniV3Quoter.quoteExactOutputSingle(params);
    require(amountIn <= _maxBoldAmount, "Price too high");
    return amountIn;
}
```

### _getBoldAmountToSwapHybrid(uint256,uint256,contract IERC20)

- **Kind**: internal
- **Source**: 86461:1526:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_getBoldAmountToSwapHybrid(uint256,uint256,contract IERC20)`

```solidity
function _getBoldAmountToSwapHybrid(uint256 _maxBoldAmount, uint256 _minCollAmount, IERC20 _collToken) internal returns (uint256) {
    uint256 wethAmount;
    IQuoterV2.QuoteExactOutputSingleParams memory quoterParams;
    if (address(WETH) != address(_collToken)) {
        quoterParams = IQuoterV2.QuoteExactOutputSingleParams({tokenIn: address(WETH), tokenOut: address(_collToken), amount: _minCollAmount, fee: UNIV3_FEE_WETH_COLL, sqrtPriceLimitX96: 0});
        (wethAmount, , , ) = uniV3Quoter.quoteExactOutputSingle(quoterParams);
    } else {
        wethAmount = _minCollAmount;
    }
    quoterParams = IQuoterV2.QuoteExactOutputSingleParams({tokenIn: address(USDC), tokenOut: address(WETH), amount: wethAmount, fee: UNIV3_FEE_USDC_WETH, sqrtPriceLimitX96: 0});
    (uint256 usdcAmount, , , ) = uniV3Quoter.quoteExactOutputSingle(quoterParams);
    uint256 boldAmountToSwap = usdcCurvePool.get_dx(int128(BOLD_TOKEN_INDEX), int128(USDC_INDEX), usdcAmount);
    require(boldAmountToSwap <= _maxBoldAmount, "Bold amount required too high");
    boldAmountToSwap = Math.min((boldAmountToSwap * 101) / 100, _maxBoldAmount);
    return boldAmountToSwap;
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### addressToTroveIdThroughZapper(address,address,uint256)

- **Kind**: internal
- **Source**: 908:242:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveIdThroughZapper(address,address,uint256)`

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    return addressToTroveIdThroughZapper(_zapper, _owner, _owner, _ownerIndex);
}
```

### addressToTroveIdThroughZapper(address,address,address,uint256)

- **Kind**: internal
- **Source**: 578:324:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveIdThroughZapper(address,address,address,uint256)`

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    uint256 index = uint256(keccak256(abi.encode(_sender, _ownerIndex)));
    return uint256(keccak256(abi.encode(_zapper, _owner, index)));
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### getTroveEntireColl(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 2698:230:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:getTroveEntireColl(contract ITroveManager,uint256)`

```solidity
function getTroveEntireColl(ITroveManager _troveManager, uint256 _troveId) internal view returns (uint256) {
    LatestTroveData memory trove = _troveManager.getLatestTroveData(_troveId);
    return trove.entireColl;
}
```

### getTroveEntireDebt(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 2934:230:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:getTroveEntireDebt(contract ITroveManager,uint256)`

```solidity
function getTroveEntireDebt(ITroveManager _troveManager, uint256 _troveId) internal view returns (uint256) {
    LatestTroveData memory trove = _troveManager.getLatestTroveData(_troveId);
    return trove.entireDebt;
}
```

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 15596:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGe(left, right, err);
}
```

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14412:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLe(left, right, err);
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
}
```

## State Variable Reads

- **leverageZapperHybridArray** (`contract ILeverageZapper[]`) [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **leverageZapperCurveArray** (`contract ILeverageZapper[]`) [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]
- **BOLD_TOKEN_INDEX** (`uint128`)
- **COLL_TOKEN_INDEX** (`uint256`)
- **UNIV3_FEE** (`uint24`)
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]
- **UNIV3_FEE_WETH_COLL** (`uint24`)
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **UNIV3_FEE_USDC_WETH** (`uint24`)
- **usdcCurvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`uint128`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testCanOpenTroveAndJoinBatchWithHybrid() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._registerBatchManager(address,uint256) (NodeID: 1)
  │   💬 Args: [B, i]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testCanOpenTrove(contract ILeverageZapper,enum ZapperLeverageMainnet.ExchangeType,uint256,address) (NodeID: 2)
      💬 Args: [leverageZapperHybridArray[i], ExchangeType.HybridCurveUniV3, i, B]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet._setInitialBalances(contract ILeverageZapper,uint256,struct ZapperLeverageMainnet.TestVars) (NodeID: 3)
    │   💬 Args: [_leverageZapper, _branch, vars]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet.openLeveragedTroveWithIndex(struct ZapperLeverageMainnet.OpenLeveragedTroveWithIndexParams) (NodeID: 4)
    │   💬 Args: [openTroveParams]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwap(enum ZapperLeverageMainnet.ExchangeType,uint256,uint256,uint256,uint256,contract IERC20) (NodeID: 5)
    │ │   💬 Args: [_inputParams.exchangeType, _inputParams.branch, vars.expectedBoldAmount, vars.maxNetDebt, vars.flashLoanAmount, _inputParams.collToken]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapCurve(uint256,uint256,uint256,uint256) (NodeID: 6)
    │ │ │   💬 Args: [_branch, _boldAmount, _maxBoldAmount, _minCollAmount]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapUniV3(uint256,uint256,contract IERC20) (NodeID: 7)
    │ │ │   💬 Args: [_maxBoldAmount, _minCollAmount, _collToken]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapHybrid(uint256,uint256,contract IERC20) (NodeID: 8)
    │ │     💬 Args: [_maxBoldAmount, _minCollAmount, _collToken]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 9)
    │ │       💬 Args: [(boldAmountToSwap * 101) / 100, _maxBoldAmount]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 10)
    │     💬 Args: [address(_inputParams.leverageZapper), A, _inputParams.index]
    │     👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 11)
    │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
    │       👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 12)
    │   💬 Args: [contractsArray[_branch].troveNFT.ownerOf(vars.troveId), A, "Wrong owner"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 13)
    │   💬 Args: [vars.troveId, 0, "Trove id should be set"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 14)
    │   💬 Args: [getTroveEntireColl(contractsArray[_branch].troveManager, vars.troveId), (vars.collAmount * vars.newLeverageRatio) / DECIMAL_PRECISION, "Coll mismatch"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseTest.getTroveEntireColl(contract ITroveManager,uint256) (NodeID: 15)
    │     💬 Args: [contractsArray[_branch].troveManager, vars.troveId]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest.getTroveEntireDebt(contract ITroveManager,uint256) (NodeID: 16)
    │   💬 Args: [contractsArray[_branch].troveManager, vars.troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 17)
    │   💬 Args: [troveEntireDebt, expectedMinNetDebt, "Debt too low"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 18)
    │   💬 Args: [troveEntireDebt, expectedMaxNetDebt, "Debt too high"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 19)
    │   💬 Args: [(ICR >= vars.resultingCollateralRatio) || ((vars.resultingCollateralRatio - ICR) < 3e16), "Wrong CR"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 20)
    │   💬 Args: [boldToken.balanceOf(A), vars.boldBalanceBeforeA, "BOLD bal mismatch"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 21)
    │   💬 Args: [boldToken.balanceOf(address(_leverageZapper)), vars.boldBalanceBeforeZapper, "Zapper should not keep BOLD"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 22)
    │   💬 Args: [boldToken.balanceOf(address(_leverageZapper.exchange())), vars.boldBalanceBeforeExchange, "Exchange should not keep BOLD"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 23)
    │   💬 Args: [contractsArray[_branch].collToken.balanceOf(address(_leverageZapper)), vars.collBalanceBeforeZapper, "Zapper should not keep Coll"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 24)
    │   💬 Args: [contractsArray[_branch].collToken.balanceOf(address(_leverageZapper.exchange())), vars.collBalanceBeforeExchange, "Exchange should not keep Coll"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 25)
    │   💬 Args: [address(_leverageZapper).balance, vars.ethBalanceBeforeZapper, "Zapper should not keep ETH"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 26)
    │   💬 Args: [address(_leverageZapper.exchange()).balance, vars.ethBalanceBeforeExchange, "Exchange should not keep ETH"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 27)
    │   💬 Args: [A.balance, vars.ethBalanceBeforeA - ETH_GAS_COMPENSATION, "ETH bal mismatch"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 28)
    │   💬 Args: [contractsArray[_branch].collToken.balanceOf(A), vars.collBalanceBeforeA - vars.collAmount, "Coll bal mismatch"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 29)
    │   💬 Args: [A.balance, (vars.ethBalanceBeforeA - ETH_GAS_COMPENSATION) - vars.collAmount, "ETH bal mismatch"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 30)
        💬 Args: [contractsArray[_branch].collToken.balanceOf(A), vars.collBalanceBeforeA, "Coll bal mismatch"]
        👁️  Def: internal
```
