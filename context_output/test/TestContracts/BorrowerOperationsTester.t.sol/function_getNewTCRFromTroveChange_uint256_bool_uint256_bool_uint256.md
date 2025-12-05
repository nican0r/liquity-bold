# Function: getNewTCRFromTroveChange(uint256,bool,uint256,bool,uint256)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `getNewTCRFromTroveChange(uint256,bool,uint256,bool,uint256)`
- **Visibility**: external
- **Source Range**: 1008:419:256

## Implementation

```solidity
function getNewTCRFromTroveChange(uint256 _collChange, bool isCollIncrease, uint256 _debtChange, bool isDebtIncrease, uint256 _price) external view returns (uint256) {
    TroveChange memory troveChange;
    _initTroveChange(troveChange, _collChange, isCollIncrease, _debtChange, isDebtIncrease);
    return _getNewTCRFromTroveChange(troveChange, _price);
}
```

## Related Implementations

### _initTroveChange(struct TroveChange,uint256,bool,uint256,bool)

- **Kind**: internal
- **Source**: 15794:541:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_initTroveChange(struct TroveChange,uint256,bool,uint256,bool)`

```solidity
function _initTroveChange(TroveChange memory _troveChange, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease) internal pure {
    if (_isCollIncrease) {
        _troveChange.collIncrease = _collChange;
    } else {
        _troveChange.collDecrease = _collChange;
    }
    if (_isDebtIncrease) {
        _troveChange.debtIncrease = _boldChange;
    } else {
        _troveChange.debtDecrease = _boldChange;
    }
}
```

### _getNewTCRFromTroveChange(struct TroveChange,uint256)

- **Kind**: internal
- **Source**: 64337:571:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_getNewTCRFromTroveChange(struct TroveChange,uint256)`

```solidity
function _getNewTCRFromTroveChange(TroveChange memory _troveChange, uint256 _price) internal view returns (uint256 newTCR) {
    uint256 totalColl = getEntireBranchColl();
    totalColl += _troveChange.collIncrease;
    totalColl -= _troveChange.collDecrease;
    uint256 totalDebt = getEntireBranchDebt();
    totalDebt += _troveChange.debtIncrease;
    totalDebt += _troveChange.upfrontFee;
    totalDebt -= _troveChange.debtDecrease;
    newTCR = LiquityMath._computeCR(totalColl, totalDebt, _price);
}
```

### getEntireBranchColl()

- **Kind**: internal
- **Source**: 1265:251:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:getEntireBranchColl()`

```solidity
function getEntireBranchColl() public view returns (uint256 entireSystemColl) {
    uint256 activeColl = activePool.getCollBalance();
    uint256 liquidatedColl = defaultPool.getCollBalance();
    return activeColl + liquidatedColl;
}
```

### getEntireBranchDebt()

- **Kind**: internal
- **Source**: 1522:237:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:getEntireBranchDebt()`

```solidity
function getEntireBranchDebt() public view returns (uint256 entireSystemDebt) {
    uint256 activeDebt = activePool.getBoldDebt();
    uint256 closedDebt = defaultPool.getBoldDebt();
    return activeDebt + closedDebt;
}
```

### _computeCR(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2640:414:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_computeCR(uint256,uint256,uint256)`

```solidity
function _computeCR(uint256 _coll, uint256 _debt, uint256 _price) internal pure returns (uint256) {
    if (_debt > 0) {
        uint256 newCollRatio = (_coll * _price) / _debt;
        return newCollRatio;
    } else {
        return (2 ** 256) - 1;
    }
}
```

## State Variable Reads

- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperationsTester.getNewTCRFromTroveChange(uint256,bool,uint256,bool,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._initTroveChange(struct TroveChange,uint256,bool,uint256,bool) (NodeID: 1)
  │   💬 Args: [troveChange, _collChange, isCollIncrease, _debtChange, isDebtIncrease]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 2)
      💬 Args: [troveChange, _price]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 5)
        💬 Args: [totalColl, totalDebt, _price]
        👁️  Def: internal
```
