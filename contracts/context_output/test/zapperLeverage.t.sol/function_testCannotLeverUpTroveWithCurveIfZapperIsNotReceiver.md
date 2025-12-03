# Function: testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 29961:256:338

## Implementation

```solidity
function testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver() external {
    for (uint256 i = 0; i < NUM_COLLATERALS; i++) {
        _testCannotLeverUpTroveIfZapperIsNotReceiver(leverageZapperCurveArray[i], ExchangeType.Curve, i);
    }
}
```

## Related Implementations

### _testCannotLeverUpTroveIfZapperIsNotReceiver(contract ILeverageZapper,enum ZapperLeverageMainnet.ExchangeType,uint256)

- **Kind**: internal
- **Source**: 30787:2461:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testCannotLeverUpTroveIfZapperIsNotReceiver(contract ILeverageZapper,enum ZapperLeverageMainnet.ExchangeType,uint256)`

```solidity
function _testCannotLeverUpTroveIfZapperIsNotReceiver(ILeverageZapper _leverageZapper, ExchangeType _exchangeType, uint256 _branch) internal {
    TestVars memory vars;
    vars.collAmount = 10 ether;
    vars.initialLeverageRatio = 2e18;
    OpenLeveragedTroveWithIndexParams memory openTroveParams;
    openTroveParams.leverageZapper = _leverageZapper;
    openTroveParams.collToken = contractsArray[_branch].collToken;
    openTroveParams.index = 0;
    openTroveParams.collAmount = vars.collAmount;
    openTroveParams.leverageRatio = vars.initialLeverageRatio;
    openTroveParams.priceFeed = contractsArray[_branch].priceFeed;
    openTroveParams.exchangeType = _exchangeType;
    openTroveParams.branch = _branch;
    openTroveParams.batchManager = address(0);
    (vars.troveId, ) = openLeveragedTroveWithIndex(openTroveParams);
    vars.initialDebt = getTroveEntireDebt(contractsArray[_branch].troveManager, vars.troveId);
    vars.newLeverageRatio = 2.5e18;
    vars.resultingCollateralRatio = _leverageZapper.leverageRatioToCollateralRatio(vars.newLeverageRatio);
    LeverUpParams memory getterParams;
    getterParams.leverageZapper = _leverageZapper;
    getterParams.collToken = contractsArray[_branch].collToken;
    getterParams.troveId = vars.troveId;
    getterParams.leverageRatio = vars.newLeverageRatio;
    getterParams.troveManager = contractsArray[_branch].troveManager;
    getterParams.priceFeed = contractsArray[_branch].priceFeed;
    getterParams.exchangeType = _exchangeType;
    getterParams.branch = _branch;
    (uint256 flashLoanAmount, uint256 effectiveBoldAmount) = _getLeverUpFlashLoanAndBoldAmount(getterParams);
    ILeverageZapper.LeverUpTroveParams memory params = ILeverageZapper.LeverUpTroveParams({troveId: vars.troveId, flashLoanAmount: flashLoanAmount, boldAmount: effectiveBoldAmount, maxUpfrontFee: 1000e18});
    vm.startPrank(A);
    contractsArray[_branch].borrowerOperations.setRemoveManagerWithReceiver(vars.troveId, address(_leverageZapper), C);
    vm.expectRevert("BZ: Zapper is not receiver for this trove");
    _leverageZapper.leverUpTrove(params);
    vm.stopPrank();
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

### _getLeverUpFlashLoanAndBoldAmount(struct ZapperLeverageMainnet.LeverUpParams)

- **Kind**: internal
- **Source**: 23025:1290:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_getLeverUpFlashLoanAndBoldAmount(struct ZapperLeverageMainnet.LeverUpParams)`

```solidity
function _getLeverUpFlashLoanAndBoldAmount(LeverUpParams memory _params) internal returns (uint256, uint256) {
    LeverVars memory vars;
    (vars.price, ) = _params.priceFeed.fetchPrice();
    vars.currentCR = _params.troveManager.getCurrentICR(_params.troveId, vars.price);
    vars.currentLR = _params.leverageZapper.leverageRatioToCollateralRatio(vars.currentCR);
    assertGt(_params.leverageRatio, vars.currentLR, "Leverage ratio should increase");
    vars.currentCollAmount = getTroveEntireColl(_params.troveManager, _params.troveId);
    vars.flashLoanAmount = ((vars.currentCollAmount * _params.leverageRatio) / vars.currentLR) - vars.currentCollAmount;
    vars.expectedBoldAmount = (vars.flashLoanAmount * vars.price) / DECIMAL_PRECISION;
    vars.maxNetDebtIncrease = (vars.expectedBoldAmount * 105) / 100;
    vars.effectiveBoldAmount = _getBoldAmountToSwap(_params.exchangeType, _params.branch, vars.expectedBoldAmount, vars.maxNetDebtIncrease, vars.flashLoanAmount, _params.collToken);
    return (vars.flashLoanAmount, vars.effectiveBoldAmount);
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

## State Variable Reads

- **NUM_COLLATERALS** (`uint256`)
- **leverageZapperCurveArray** (`contract ILeverageZapper[]`) [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
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
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testCannotLeverUpTroveIfZapperIsNotReceiver(contract ILeverageZapper,enum ZapperLeverageMainnet.ExchangeType,uint256) (NodeID: 1)
      💬 Args: [leverageZapperCurveArray[i], ExchangeType.Curve, i]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet.openLeveragedTroveWithIndex(struct ZapperLeverageMainnet.OpenLeveragedTroveWithIndexParams) (NodeID: 2)
    │   💬 Args: [openTroveParams]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwap(enum ZapperLeverageMainnet.ExchangeType,uint256,uint256,uint256,uint256,contract IERC20) (NodeID: 3)
    │ │   💬 Args: [_inputParams.exchangeType, _inputParams.branch, vars.expectedBoldAmount, vars.maxNetDebt, vars.flashLoanAmount, _inputParams.collToken]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapCurve(uint256,uint256,uint256,uint256) (NodeID: 4)
    │ │ │   💬 Args: [_branch, _boldAmount, _maxBoldAmount, _minCollAmount]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapUniV3(uint256,uint256,contract IERC20) (NodeID: 5)
    │ │ │   💬 Args: [_maxBoldAmount, _minCollAmount, _collToken]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapHybrid(uint256,uint256,contract IERC20) (NodeID: 6)
    │ │     💬 Args: [_maxBoldAmount, _minCollAmount, _collToken]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 7)
    │ │       💬 Args: [(boldAmountToSwap * 101) / 100, _maxBoldAmount]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 8)
    │     💬 Args: [address(_inputParams.leverageZapper), A, _inputParams.index]
    │     👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 9)
    │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
    │       👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: BaseTest.getTroveEntireDebt(contract ITroveManager,uint256) (NodeID: 10)
    │   💬 Args: [contractsArray[_branch].troveManager, vars.troveId]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet._getLeverUpFlashLoanAndBoldAmount(struct ZapperLeverageMainnet.LeverUpParams) (NodeID: 11)
        💬 Args: [getterParams]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 12)
      │   💬 Args: [_params.leverageRatio, vars.currentLR, "Leverage ratio should increase"]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseTest.getTroveEntireColl(contract ITroveManager,uint256) (NodeID: 13)
      │   💬 Args: [_params.troveManager, _params.troveId]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwap(enum ZapperLeverageMainnet.ExchangeType,uint256,uint256,uint256,uint256,contract IERC20) (NodeID: 14)
          💬 Args: [_params.exchangeType, _params.branch, vars.expectedBoldAmount, vars.maxNetDebtIncrease, vars.flashLoanAmount, _params.collToken]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapCurve(uint256,uint256,uint256,uint256) (NodeID: 15)
        │   💬 Args: [_branch, _boldAmount, _maxBoldAmount, _minCollAmount]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapUniV3(uint256,uint256,contract IERC20) (NodeID: 16)
        │   💬 Args: [_maxBoldAmount, _minCollAmount, _collToken]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: ZapperLeverageMainnet._getBoldAmountToSwapHybrid(uint256,uint256,contract IERC20) (NodeID: 17)
            💬 Args: [_maxBoldAmount, _minCollAmount, _collToken]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 18)
              💬 Args: [(boldAmountToSwap * 101) / 100, _maxBoldAmount]
              👁️  Def: internal
```
