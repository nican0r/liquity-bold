# Contract: MockTroveManager

## Metadata

- **Name**: MockTroveManager
- **Type**: Contract
- **Path**: test/SortedTroves.t.sol

## State Variables

### _troves

```solidity
mapping(TroveId => Trove) private _troves
```

### _batches

```solidity
mapping(BatchId => Batch) private _batches
```

### _troveIds

```solidity
TroveId[] private _troveIds
```

### _batchIds

```solidity
BatchId[] private _batchIds
```

### _nextTroveId

```solidity
uint256 public _nextTroveId = 1
```

### _nextBatchId

```solidity
uint160 public _nextBatchId = 1
```

### _sortedTroves

```solidity
SortedTroves private _sortedTroves
```

**SortedTroves**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Structs

### Trove

```solidity
struct Trove {
    uint256 arrayIndex;
    uint256 annualInterestRate;
    BatchId batchId;
}
```

### Batch

```solidity
struct Batch {
    uint256 annualInterestRate;
}
```

## Public/External Functions

### constructor(contract SortedTroves)

- **Signature**: `constructor(contract SortedTroves)`
- **Visibility**: public
- **Source Range**: 773:84:247
- **Details**: [function_constructor_contract_SortedTroves.md](./function_constructor_contract_SortedTroves.md)

**Signature:**
```solidity
constructor(SortedTroves sortedTroves);
```

### getTroveCount()

- **Signature**: `getTroveCount()`
- **Visibility**: external
- **Source Range**: 983:97:247
- **Details**: [function_getTroveCount.md](./function_getTroveCount.md)

**Signature:**
```solidity
/// 
///  Partial implementation of TroveManager interface
///  Just the parts needed by SortedTroves
function getTroveCount() external view returns (uint256);
```

### getTroveId(uint256)

- **Signature**: `getTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 1086:99:247
- **Details**: [function_getTroveId_uint256.md](./function_getTroveId_uint256.md)

**Signature:**
```solidity
function getTroveId(uint256 i) external view returns (TroveId);
```

### getTroveAnnualInterestRate(TroveId)

- **Signature**: `getTroveAnnualInterestRate(TroveId)`
- **Visibility**: public
- **Source Range**: 1191:258:247
- **Details**: [function_getTroveAnnualInterestRate_TroveId.md](./function_getTroveAnnualInterestRate_TroveId.md)

**Signature:**
```solidity
function getTroveAnnualInterestRate(TroveId troveId) public view returns (uint256);
```

### _addIndividualTrove(uint256)

- **Signature**: `_addIndividualTrove(uint256)`
- **Visibility**: external
- **Source Range**: 1769:197:247
- **Details**: [function__addIndividualTrove_uint256.md](./function__addIndividualTrove_uint256.md)

**Signature:**
```solidity
function _addIndividualTrove(uint256 annualInterestRate) external returns (TroveId id);
```

### _addBatchedTrove(BatchId)

- **Signature**: `_addBatchedTrove(BatchId)`
- **Visibility**: external
- **Source Range**: 1972:160:247
- **Details**: [function__addBatchedTrove_BatchId.md](./function__addBatchedTrove_BatchId.md)

**Signature:**
```solidity
function _addBatchedTrove(BatchId batchId) external returns (TroveId id);
```

### _addBatch(uint256)

- **Signature**: `_addBatch(uint256)`
- **Visibility**: external
- **Source Range**: 2138:155:247
- **Details**: [function__addBatch_uint256.md](./function__addBatch_uint256.md)

**Signature:**
```solidity
function _addBatch(uint256 annualInterestRate) external returns (BatchId id);
```

### _setTroveInterestRate(TroveId,uint256)

- **Signature**: `_setTroveInterestRate(TroveId,uint256)`
- **Visibility**: external
- **Source Range**: 2299:154:247
- **Details**: [function__setTroveInterestRate_TroveId_uint256.md](./function__setTroveInterestRate_TroveId_uint256.md)

**Signature:**
```solidity
function _setTroveInterestRate(TroveId id, uint256 newAnnualInterestRate) external;
```

### _setBatchInterestRate(BatchId,uint256)

- **Signature**: `_setBatchInterestRate(BatchId,uint256)`
- **Visibility**: external
- **Source Range**: 2459:155:247
- **Details**: [function__setBatchInterestRate_BatchId_uint256.md](./function__setBatchInterestRate_BatchId_uint256.md)

**Signature:**
```solidity
function _setBatchInterestRate(BatchId id, uint256 newAnnualInterestRate) external;
```

### _removeTrove(TroveId)

- **Signature**: `_removeTrove(TroveId)`
- **Visibility**: external
- **Source Range**: 2620:399:247
- **Details**: [function__removeTrove_TroveId.md](./function__removeTrove_TroveId.md)

**Signature:**
```solidity
function _removeTrove(TroveId id) external;
```

### _getBatchCount()

- **Signature**: `_getBatchCount()`
- **Visibility**: external
- **Source Range**: 3025:98:247
- **Details**: [function__getBatchCount.md](./function__getBatchCount.md)

**Signature:**
```solidity
function _getBatchCount() external view returns (uint256);
```

### _getBatchId(uint256)

- **Signature**: `_getBatchId(uint256)`
- **Visibility**: external
- **Source Range**: 3129:100:247
- **Details**: [function__getBatchId_uint256.md](./function__getBatchId_uint256.md)

**Signature:**
```solidity
function _getBatchId(uint256 i) external view returns (BatchId);
```

### _getBatchOf(TroveId)

- **Signature**: `_getBatchOf(TroveId)`
- **Visibility**: external
- **Source Range**: 3235:116:247
- **Details**: [function__getBatchOf_TroveId.md](./function__getBatchOf_TroveId.md)

**Signature:**
```solidity
function _getBatchOf(TroveId id) external view returns (BatchId batchId);
```

### _sortedTroves_getFirst()

- **Signature**: `_sortedTroves_getFirst()`
- **Visibility**: external
- **Source Range**: 3495:128:247
- **Details**: [function__sortedTroves_getFirst.md](./function__sortedTroves_getFirst.md)

**Signature:**
```solidity
/// 
///  Wrappers around SortedTroves
///  Needed because only TroveManager has permissions to perform every operation
function _sortedTroves_getFirst() external view returns (TroveId);
```

### _sortedTroves_getLast()

- **Signature**: `_sortedTroves_getLast()`
- **Visibility**: external
- **Source Range**: 3629:126:247
- **Details**: [function__sortedTroves_getLast.md](./function__sortedTroves_getLast.md)

**Signature:**
```solidity
function _sortedTroves_getLast() external view returns (TroveId);
```

### _sortedTroves_getNext(TroveId)

- **Signature**: `_sortedTroves_getNext(TroveId)`
- **Visibility**: external
- **Source Range**: 3761:154:247
- **Details**: [function__sortedTroves_getNext_TroveId.md](./function__sortedTroves_getNext_TroveId.md)

**Signature:**
```solidity
function _sortedTroves_getNext(TroveId id) external view returns (TroveId);
```

### _sortedTroves_getPrev(TroveId)

- **Signature**: `_sortedTroves_getPrev(TroveId)`
- **Visibility**: external
- **Source Range**: 3921:154:247
- **Details**: [function__sortedTroves_getPrev_TroveId.md](./function__sortedTroves_getPrev_TroveId.md)

**Signature:**
```solidity
function _sortedTroves_getPrev(TroveId id) external view returns (TroveId);
```

### _sortedTroves_getBatchHead(BatchId)

- **Signature**: `_sortedTroves_getBatchHead(BatchId)`
- **Visibility**: external
- **Source Range**: 4081:175:247
- **Details**: [function__sortedTroves_getBatchHead_BatchId.md](./function__sortedTroves_getBatchHead_BatchId.md)

**Signature:**
```solidity
function _sortedTroves_getBatchHead(BatchId id) external view returns (TroveId);
```

### _sortedTroves_getBatchTail(BatchId)

- **Signature**: `_sortedTroves_getBatchTail(BatchId)`
- **Visibility**: external
- **Source Range**: 4262:176:247
- **Details**: [function__sortedTroves_getBatchTail_BatchId.md](./function__sortedTroves_getBatchTail_BatchId.md)

**Signature:**
```solidity
function _sortedTroves_getBatchTail(BatchId id) external view returns (TroveId);
```

### _sortedTroves_getSize()

- **Signature**: `_sortedTroves_getSize()`
- **Visibility**: external
- **Source Range**: 4444:112:247
- **Details**: [function__sortedTroves_getSize.md](./function__sortedTroves_getSize.md)

**Signature:**
```solidity
function _sortedTroves_getSize() external view returns (uint256);
```

### _sortedTroves_insert(TroveId,uint256,struct Hints)

- **Signature**: `_sortedTroves_insert(TroveId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 4562:606:247
- **Details**: [function__sortedTroves_insert_TroveId_uint256_struct_Hints.md](./function__sortedTroves_insert_TroveId_uint256_struct_Hints.md)

**Signature:**
```solidity
function _sortedTroves_insert(TroveId id, uint256 annualInterestRate, Hints memory hints) external;
```

### _sortedTroves_reInsert(TroveId,uint256,struct Hints)

- **Signature**: `_sortedTroves_reInsert(TroveId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 5174:622:247
- **Details**: [function__sortedTroves_reInsert_TroveId_uint256_struct_Hints.md](./function__sortedTroves_reInsert_TroveId_uint256_struct_Hints.md)

**Signature:**
```solidity
function _sortedTroves_reInsert(TroveId id, uint256 newAnnualInterestRate, Hints memory hints) external;
```

### _sortedTroves_remove(TroveId)

- **Signature**: `_sortedTroves_remove(TroveId)`
- **Visibility**: external
- **Source Range**: 5802:108:247
- **Details**: [function__sortedTroves_remove_TroveId.md](./function__sortedTroves_remove_TroveId.md)

**Signature:**
```solidity
function _sortedTroves_remove(TroveId id) external;
```

### _sortedTroves_insertIntoBatch(TroveId,BatchId,uint256,struct Hints)

- **Signature**: `_sortedTroves_insertIntoBatch(TroveId,BatchId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 5916:346:247
- **Details**: [function__sortedTroves_insertIntoBatch_TroveId_BatchId_uint256_struct_Hints.md](./function__sortedTroves_insertIntoBatch_TroveId_BatchId_uint256_struct_Hints.md)

**Signature:**
```solidity
function _sortedTroves_insertIntoBatch(TroveId troveId, BatchId batchId, uint256 annualInterestRate, Hints memory hints) external;
```

### _sortedTroves_reInsertBatch(BatchId,uint256,struct Hints)

- **Signature**: `_sortedTroves_reInsertBatch(BatchId,uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 6268:268:247
- **Details**: [function__sortedTroves_reInsertBatch_BatchId_uint256_struct_Hints.md](./function__sortedTroves_reInsertBatch_BatchId_uint256_struct_Hints.md)

**Signature:**
```solidity
function _sortedTroves_reInsertBatch(BatchId batchId, uint256 newAnnualInterestRate, Hints memory hints) external;
```

### _sortedTroves_removeFromBatch(TroveId)

- **Signature**: `_sortedTroves_removeFromBatch(TroveId)`
- **Visibility**: external
- **Source Range**: 6542:126:247
- **Details**: [function__sortedTroves_removeFromBatch_TroveId.md](./function__sortedTroves_removeFromBatch_TroveId.md)

**Signature:**
```solidity
function _sortedTroves_removeFromBatch(TroveId id) external;
```

### _sortedTroves_findInsertPosition(uint256,struct Hints)

- **Signature**: `_sortedTroves_findInsertPosition(uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 6674:386:247
- **Details**: [function__sortedTroves_findInsertPosition_uint256_struct_Hints.md](./function__sortedTroves_findInsertPosition_uint256_struct_Hints.md)

**Signature:**
```solidity
function _sortedTroves_findInsertPosition(uint256 annualInterestRate, Hints memory hints) external view returns (Hints memory);
```

### _sortedTroves_validInsertPosition(uint256,struct Hints)

- **Signature**: `_sortedTroves_validInsertPosition(uint256,struct Hints)`
- **Visibility**: external
- **Source Range**: 7066:303:247
- **Details**: [function__sortedTroves_validInsertPosition_uint256_struct_Hints.md](./function__sortedTroves_validInsertPosition_uint256_struct_Hints.md)

**Signature:**
```solidity
function _sortedTroves_validInsertPosition(uint256 annualInterestRate, Hints memory hints) external view returns (bool);
```
