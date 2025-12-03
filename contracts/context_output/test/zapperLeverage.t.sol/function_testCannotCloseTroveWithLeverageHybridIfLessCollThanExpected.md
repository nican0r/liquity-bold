# Function: testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected()`
- **Visibility**: external
- **Source Range**: 70009:239:338

## Implementation

```solidity
function testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected() external {
    for (uint256 i = 0; i < 3; i++) {
        _testCannotCloseTroveIfLessCollThanExpected(IZapper(leverageZapperHybridArray[i]), i);
    }
}
```

## Related Implementations

### _testCannotCloseTroveIfLessCollThanExpected(contract IZapper,uint256)

- **Kind**: internal
- **Source**: 70254:990:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testCannotCloseTroveIfLessCollThanExpected(contract IZapper,uint256)`

```solidity
function _testCannotCloseTroveIfLessCollThanExpected(IZapper _zapper, uint256 _branch) internal {
    uint256 collAmount = 10 ether;
    uint256 boldAmount = 10000e18;
    bool lst = _branch > 0;
    uint256 troveId = openTrove(_zapper, A, 0, collAmount, boldAmount, lst);
    openTrove(_zapper, B, 0, 100 ether, 10000e18, lst);
    (uint256 flashLoanAmount, uint256 minExpectedCollateral) = _getCloseFlashLoanAmount(troveId, contractsArray[_branch].troveManager, contractsArray[_branch].priceFeed);
    string memory revertReason = lst ? "GCZ: Not enough collateral received" : "WZ: Not enough collateral received";
    vm.startPrank(A);
    vm.expectRevert(bytes(revertReason));
    _zapper.closeTroveFromCollateral(troveId, flashLoanAmount, minExpectedCollateral * 2);
    vm.stopPrank();
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

- **leverageZapperHybridArray** (`contract ILeverageZapper[]`) [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testCannotCloseTroveIfLessCollThanExpected(contract IZapper,uint256) (NodeID: 1)
      💬 Args: [IZapper(leverageZapperHybridArray[i]), i]
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
    └─ [2] ⚙️ FUNCTION: ZapperLeverageMainnet._getCloseFlashLoanAmount(uint256,contract ITroveManager,contract IPriceFeed) (NodeID: 6)
        💬 Args: [troveId, contractsArray[_branch].troveManager, contractsArray[_branch].priceFeed]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseTest.getTroveEntireDebt(contract ITroveManager,uint256) (NodeID: 7)
      │   💬 Args: [_troveManager, _troveId]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BaseTest.getTroveEntireColl(contract ITroveManager,uint256) (NodeID: 8)
          💬 Args: [_troveManager, _troveId]
          👁️  Def: internal
```
