# Function: getMultipleSortedTroves(uint256,int256,uint256)

**Contract**: [src/MultiTroveGetter.sol/contract_MultiTroveGetter.md]

## Metadata

- **Contract**: MultiTroveGetter
- **Signature**: `getMultipleSortedTroves(uint256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 520:1329:172

## Implementation

```solidity
function getMultipleSortedTroves(uint256 _collIndex, int256 _startIdx, uint256 _count) external view returns (CombinedTroveData[] memory _troves) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    require(address(troveManager) != address(0), "Invalid collateral index");
    ISortedTroves sortedTroves = troveManager.sortedTroves();
    assert(address(sortedTroves) != address(0));
    uint256 startIdx;
    bool descend;
    if (_startIdx >= 0) {
        startIdx = uint256(_startIdx);
        descend = true;
    } else {
        startIdx = uint256(-(_startIdx + 1));
        descend = false;
    }
    uint256 sortedTrovesSize = sortedTroves.getSize();
    if (startIdx >= sortedTrovesSize) {
        _troves = new CombinedTroveData[](0);
    } else {
        uint256 maxCount = sortedTrovesSize - startIdx;
        if (_count > maxCount) {
            _count = maxCount;
        }
        if (descend) {
            _troves = _getMultipleSortedTrovesFromHead(troveManager, sortedTroves, startIdx, _count);
        } else {
            _troves = _getMultipleSortedTrovesFromTail(troveManager, sortedTroves, startIdx, _count);
        }
    }
}
```

## Related Implementations

### _getMultipleSortedTrovesFromHead(contract ITroveManager,contract ISortedTroves,uint256,uint256)

- **Kind**: internal
- **Source**: 3070:688:172
- **Link**: `src/MultiTroveGetter.sol:MultiTroveGetter:_getMultipleSortedTrovesFromHead(contract ITroveManager,contract ISortedTroves,uint256,uint256)`

```solidity
function _getMultipleSortedTrovesFromHead(ITroveManager _troveManager, ISortedTroves _sortedTroves, uint256 _startIdx, uint256 _count) internal view returns (CombinedTroveData[] memory _troves) {
    uint256 currentTroveId = _sortedTroves.getFirst();
    for (uint256 idx = 0; idx < _startIdx; ++idx) {
        currentTroveId = _sortedTroves.getNext(currentTroveId);
    }
    _troves = new CombinedTroveData[](_count);
    for (uint256 idx = 0; idx < _count; ++idx) {
        _getOneTrove(_troveManager, currentTroveId, _troves[idx]);
        currentTroveId = _sortedTroves.getNext(currentTroveId);
    }
}
```

### _getOneTrove(contract ITroveManager,uint256,struct IMultiTroveGetter.CombinedTroveData)

- **Kind**: internal
- **Source**: 1855:1209:172
- **Link**: `src/MultiTroveGetter.sol:MultiTroveGetter:_getOneTrove(contract ITroveManager,uint256,struct IMultiTroveGetter.CombinedTroveData)`

```solidity
function _getOneTrove(ITroveManager _troveManager, uint256 _id, CombinedTroveData memory _out) internal view {
    _out.id = _id;
    LatestTroveData memory troveData = _troveManager.getLatestTroveData(_id);
    _out.entireDebt = troveData.entireDebt;
    _out.entireColl = troveData.entireColl;
    _out.redistBoldDebtGain = troveData.redistBoldDebtGain;
    _out.redistCollGain = troveData.redistCollGain;
    _out.accruedInterest = troveData.accruedInterest;
    _out.recordedDebt = troveData.recordedDebt;
    _out.annualInterestRate = troveData.annualInterestRate;
    _out.accruedBatchManagementFee = troveData.accruedBatchManagementFee;
    _out.lastInterestRateAdjTime = troveData.lastInterestRateAdjTime;
    (, , _out.stake, , , _out.lastDebtUpdateTime, , , _out.interestBatchManager, _out.batchDebtShares) = _troveManager.Troves(_id);
    (_out.snapshotETH, _out.snapshotBoldDebt) = _troveManager.rewardSnapshots(_id);
}
```

### _getMultipleSortedTrovesFromTail(contract ITroveManager,contract ISortedTroves,uint256,uint256)

- **Kind**: internal
- **Source**: 3764:687:172
- **Link**: `src/MultiTroveGetter.sol:MultiTroveGetter:_getMultipleSortedTrovesFromTail(contract ITroveManager,contract ISortedTroves,uint256,uint256)`

```solidity
function _getMultipleSortedTrovesFromTail(ITroveManager _troveManager, ISortedTroves _sortedTroves, uint256 _startIdx, uint256 _count) internal view returns (CombinedTroveData[] memory _troves) {
    uint256 currentTroveId = _sortedTroves.getLast();
    for (uint256 idx = 0; idx < _startIdx; ++idx) {
        currentTroveId = _sortedTroves.getPrev(currentTroveId);
    }
    _troves = new CombinedTroveData[](_count);
    for (uint256 idx = 0; idx < _count; ++idx) {
        _getOneTrove(_troveManager, currentTroveId, _troves[idx]);
        currentTroveId = _sortedTroves.getPrev(currentTroveId);
    }
}
```

## External Calls

- **ICollateralRegistry::getTroveManager(uint256)**
- **ITroveManager::sortedTroves()**
- **ISortedTroves::getSize()**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MultiTroveGetter.getMultipleSortedTroves(uint256,int256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MultiTroveGetter._getMultipleSortedTrovesFromHead(contract ITroveManager,contract ISortedTroves,uint256,uint256) (NodeID: 1)
  │   💬 Args: [troveManager, sortedTroves, startIdx, _count]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MultiTroveGetter._getOneTrove(contract ITroveManager,uint256,struct IMultiTroveGetter.CombinedTroveData) (NodeID: 2)
  │     💬 Args: [_troveManager, currentTroveId, _troves[idx]]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MultiTroveGetter._getMultipleSortedTrovesFromTail(contract ITroveManager,contract ISortedTroves,uint256,uint256) (NodeID: 3)
      💬 Args: [troveManager, sortedTroves, startIdx, _count]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MultiTroveGetter._getOneTrove(contract ITroveManager,uint256,struct IMultiTroveGetter.CombinedTroveData) (NodeID: 4)
        💬 Args: [_troveManager, currentTroveId, _troves[idx]]
        👁️  Def: internal
```
