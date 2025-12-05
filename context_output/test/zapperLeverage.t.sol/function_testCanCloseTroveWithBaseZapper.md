# Function: testCanCloseTroveWithBaseZapper()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testCanCloseTroveWithBaseZapper()`
- **Visibility**: external
- **Source Range**: 63911:180:338

## Implementation

```solidity
function testCanCloseTroveWithBaseZapper() external {
    for (uint256 i = 0; i < NUM_COLLATERALS; i++) {
        _testCanCloseTrove(baseZapperArray[i], i);
    }
}
```

## Related Implementations

### _testCanCloseTrove(contract IZapper,uint256)

- **Kind**: internal
- **Source**: 67056:2197:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testCanCloseTrove(contract IZapper,uint256)`

```solidity
function _testCanCloseTrove(IZapper _zapper, uint256 _branch) internal {
    uint256 collAmount = 10 ether;
    uint256 boldAmount = 10000e18;
    bool lst = _branch > 0;
    uint256 troveId = openTrove(_zapper, A, 0, collAmount, boldAmount, lst);
    openTrove(_zapper, B, 0, 100 ether, 10000e18, lst);
    uint256 boldBalanceBefore = boldToken.balanceOf(A);
    uint256 collBalanceBefore = contractsArray[_branch].collToken.balanceOf(A);
    uint256 ethBalanceBefore = A.balance;
    (uint256 price, ) = contractsArray[_branch].priceFeed.fetchPrice();
    uint256 debtInColl = (getTroveEntireDebt(contractsArray[_branch].troveManager, troveId) * DECIMAL_PRECISION) / price;
    closeTrove(_zapper, troveId, contractsArray[_branch].troveManager, contractsArray[_branch].priceFeed);
    assertEq(getTroveEntireColl(contractsArray[_branch].troveManager, troveId), 0, "Coll mismatch");
    assertEq(getTroveEntireDebt(contractsArray[_branch].troveManager, troveId), 0, "Debt mismatch");
    assertGe(boldToken.balanceOf(A), boldBalanceBefore, "BOLD bal should not decrease");
    assertLe(boldToken.balanceOf(A), (boldBalanceBefore * 105) / 100, "BOLD bal can only increase by slippage margin");
    if (lst) {
        assertGe(contractsArray[_branch].collToken.balanceOf(A), collBalanceBefore, "Coll bal should not decrease");
        assertApproxEqAbs(contractsArray[_branch].collToken.balanceOf(A), (collBalanceBefore + collAmount) - debtInColl, 3e17, "Coll bal mismatch");
        assertEq(A.balance, ethBalanceBefore + ETH_GAS_COMPENSATION, "ETH bal mismatch");
    } else {
        assertEq(contractsArray[_branch].collToken.balanceOf(A), collBalanceBefore, "Coll bal mismatch");
        assertGe(A.balance, ethBalanceBefore, "ETH bal should not decrease");
        assertApproxEqAbs(A.balance, ((ethBalanceBefore + collAmount) + ETH_GAS_COMPENSATION) - debtInColl, 3e17, "ETH bal mismatch");
    }
}
```

### openTrove(contract IZapper,address,uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 65720:322:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:openTrove(contract IZapper,address,uint256,uint256,uint256,bool)`

```solidity
function openTrove(IZapper _zapper, address _account, uint256 _index, uint256 _collAmount, uint256 _boldAmount, bool _lst) internal returns (uint256) {
    return openTrove(_zapper, _account, _index, _collAmount, _boldAmount, _lst, MIN_ANNUAL_INTEREST_RATE);
}
```

### openTrove(contract IZapper,address,uint256,uint256,uint256,bool,uint256)

- **Kind**: internal
- **Source**: 66048:1002:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:openTrove(contract IZapper,address,uint256,uint256,uint256,bool,uint256)`

```solidity
function openTrove(IZapper _zapper, address _account, uint256 _index, uint256 _collAmount, uint256 _boldAmount, bool _lst, uint256 _interestRate) internal returns (uint256) {
    IZapper.OpenTroveParams memory openParams = IZapper.OpenTroveParams({owner: _account, ownerIndex: _index, collAmount: _collAmount, boldAmount: _boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: _interestRate, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(_account);
    uint256 value = _lst ? ETH_GAS_COMPENSATION : (_collAmount + ETH_GAS_COMPENSATION);
    uint256 troveId = _zapper.openTroveWithRawETH{value: value}(openParams);
    vm.stopPrank();
    return troveId;
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

### closeTrove(contract IZapper,uint256,contract ITroveManager,contract IPriceFeed)

- **Kind**: internal
- **Source**: 65247:467:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:closeTrove(contract IZapper,uint256,contract ITroveManager,contract IPriceFeed)`

```solidity
function closeTrove(IZapper _zapper, uint256 _troveId, ITroveManager _troveManager, IPriceFeed _priceFeed) internal {
    (uint256 flashLoanAmount, uint256 minExpectedCollateral) = _getCloseFlashLoanAmount(_troveId, _troveManager, _priceFeed);
    vm.startPrank(A);
    _zapper.closeTroveFromCollateral(_troveId, flashLoanAmount, minExpectedCollateral);
    vm.stopPrank();
}
```

### _getCloseFlashLoanAmount(uint256,contract ITroveManager,contract IPriceFeed)

- **Kind**: internal
- **Source**: 64706:535:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_getCloseFlashLoanAmount(uint256,contract ITroveManager,contract IPriceFeed)`

```solidity
function _getCloseFlashLoanAmount(uint256 _troveId, ITroveManager _troveManager, IPriceFeed _priceFeed) internal returns (uint256, uint256) {
    (uint256 price, ) = _priceFeed.fetchPrice();
    uint256 currentDebt = getTroveEntireDebt(_troveManager, _troveId);
    uint256 currentColl = getTroveEntireColl(_troveManager, _troveId);
    uint256 flashLoanAmount = (((currentDebt * DECIMAL_PRECISION) / price) * 105) / 100;
    return (flashLoanAmount, currentColl - flashLoanAmount);
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

### assertApproxEqAbs(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 16826:208:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbs(uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string memory err) virtual internal pure {
    vm.assertApproxEqAbs(left, right, maxDelta, err);
}
```

## State Variable Reads

- **NUM_COLLATERALS** (`uint256`)
- **baseZapperArray** (`contract IZapper[]`) [src/Zappers/Interfaces/IZapper.sol/interface_IZapper.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testCanCloseTroveWithBaseZapper() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testCanCloseTrove(contract IZapper,uint256) (NodeID: 1)
      💬 Args: [baseZapperArray[i], i]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet.openTrove(contract IZapper,address,uint256,uint256,uint256,bool) (NodeID: 2)
    │   💬 Args: [_zapper, A, 0, collAmount, boldAmount, lst]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ZapperLeverageMainnet.openTrove(contract IZapper,address,uint256,uint256,uint256,bool,uint256) (NodeID: 3)
    │     💬 Args: [_zapper, _account, _index, _collAmount, _boldAmount, _lst, MIN_ANNUAL_INTEREST_RATE]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet.openTrove(contract IZapper,address,uint256,uint256,uint256,bool) (NodeID: 4)
    │   💬 Args: [_zapper, B, 0, 100 ether, 10000e18, lst]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ZapperLeverageMainnet.openTrove(contract IZapper,address,uint256,uint256,uint256,bool,uint256) (NodeID: 5)
    │     💬 Args: [_zapper, _account, _index, _collAmount, _boldAmount, _lst, MIN_ANNUAL_INTEREST_RATE]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest.getTroveEntireDebt(contract ITroveManager,uint256) (NodeID: 6)
    │   💬 Args: [contractsArray[_branch].troveManager, troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet.closeTrove(contract IZapper,uint256,contract ITroveManager,contract IPriceFeed) (NodeID: 7)
    │   💬 Args: [_zapper, troveId, contractsArray[_branch].troveManager, contractsArray[_branch].priceFeed]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ZapperLeverageMainnet._getCloseFlashLoanAmount(uint256,contract ITroveManager,contract IPriceFeed) (NodeID: 8)
    │     💬 Args: [_troveId, _troveManager, _priceFeed]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: BaseTest.getTroveEntireDebt(contract ITroveManager,uint256) (NodeID: 9)
    │   │   💬 Args: [_troveManager, _troveId]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: BaseTest.getTroveEntireColl(contract ITroveManager,uint256) (NodeID: 10)
    │       💬 Args: [_troveManager, _troveId]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
    │   💬 Args: [getTroveEntireColl(contractsArray[_branch].troveManager, troveId), 0, "Coll mismatch"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseTest.getTroveEntireColl(contract ITroveManager,uint256) (NodeID: 12)
    │     💬 Args: [contractsArray[_branch].troveManager, troveId]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 13)
    │   💬 Args: [getTroveEntireDebt(contractsArray[_branch].troveManager, troveId), 0, "Debt mismatch"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseTest.getTroveEntireDebt(contract ITroveManager,uint256) (NodeID: 14)
    │     💬 Args: [contractsArray[_branch].troveManager, troveId]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 15)
    │   💬 Args: [boldToken.balanceOf(A), boldBalanceBefore, "BOLD bal should not decrease"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 16)
    │   💬 Args: [boldToken.balanceOf(A), (boldBalanceBefore * 105) / 100, "BOLD bal can only increase by slippage margin"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 17)
    │   💬 Args: [contractsArray[_branch].collToken.balanceOf(A), collBalanceBefore, "Coll bal should not decrease"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 18)
    │   💬 Args: [contractsArray[_branch].collToken.balanceOf(A), (collBalanceBefore + collAmount) - debtInColl, 3e17, "Coll bal mismatch"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 19)
    │   💬 Args: [A.balance, ethBalanceBefore + ETH_GAS_COMPENSATION, "ETH bal mismatch"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 20)
    │   💬 Args: [contractsArray[_branch].collToken.balanceOf(A), collBalanceBefore, "Coll bal mismatch"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 21)
    │   💬 Args: [A.balance, ethBalanceBefore, "ETH bal should not decrease"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 22)
        💬 Args: [A.balance, ((ethBalanceBefore + collAmount) + ETH_GAS_COMPENSATION) - debtInColl, 3e17, "ETH bal mismatch"]
        👁️  Def: internal
```
