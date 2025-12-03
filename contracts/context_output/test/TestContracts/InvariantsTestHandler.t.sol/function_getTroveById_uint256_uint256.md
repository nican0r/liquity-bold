# Function: getTroveById(uint256,uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getTroveById(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 14841:664:270

## Implementation

```solidity
function getTroveById(uint256 i, uint256 troveId) public view returns (uint256 coll, uint256 debt, ITroveManager.Status status, address batchManager, uint256 totalCollRedist_, uint256 totalDebtRedist_) {
    Trove memory trove = _troves[i][troveId];
    trove.applyPending();
    coll = trove.coll;
    debt = trove.debt;
    status = _isZombie(i, troveId) ? ZOMBIE : ACTIVE;
    batchManager = _batchManagerOf[i][troveId];
    totalCollRedist_ = trove.totalCollRedist;
    totalDebtRedist_ = trove.totalDebtRedist;
}
```

## Related Implementations

### applyPending(struct Trove)

- **Kind**: internal
- **Source**: 2366:185:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPending(struct Trove)`

```solidity
function applyPending(Trove memory trove) internal pure {
    trove.applyPendingRedist();
    trove.applyPendingInterest();
    trove.applyPendingBatchManagementFee();
}
```

### applyPendingRedist(struct Trove)

- **Kind**: internal
- **Source**: 1585:361:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPendingRedist(struct Trove)`

```solidity
function applyPendingRedist(Trove memory trove) internal pure {
    trove.coll += trove._pendingCollRedist;
    trove.debt += trove._pendingDebtRedist;
    trove.totalCollRedist += trove._pendingCollRedist;
    trove.totalDebtRedist += trove._pendingDebtRedist;
    trove._pendingCollRedist = 0;
    trove._pendingDebtRedist = 0;
}
```

### applyPendingInterest(struct Trove)

- **Kind**: internal
- **Source**: 1952:186:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPendingInterest(struct Trove)`

```solidity
function applyPendingInterest(Trove memory trove) internal pure {
    trove.debt += trove._pendingInterest / (ONE_YEAR * DECIMAL_PRECISION);
    trove._pendingInterest = 0;
}
```

### applyPendingBatchManagementFee(struct Trove)

- **Kind**: internal
- **Source**: 2144:216:293
- **Link**: `test/Utils/Trove.sol:TroveMethods:applyPendingBatchManagementFee(struct Trove)`

```solidity
function applyPendingBatchManagementFee(Trove memory trove) internal pure {
    trove.debt += trove._pendingBatchManagementFee / (ONE_YEAR * DECIMAL_PRECISION);
    trove._pendingBatchManagementFee = 0;
}
```

### _isZombie(uint256,uint256)

- **Kind**: internal
- **Source**: 110541:131:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_isZombie(uint256,uint256)`

```solidity
function _isZombie(uint256 i, uint256 troveId) internal view returns (bool) {
    return _zombieTroveIds[i].has(troveId);
}
```

### has(struct EnumerableSet,uint256)

- **Kind**: internal
- **Source**: 372:136:288
- **Link**: `test/Utils/EnumerableSet.sol:EnumerableSetMethods:has(struct EnumerableSet,uint256)`

```solidity
function has(EnumerableSet storage set, uint256 element) internal view returns (bool) {
    return set._indexOf[element] != 0;
}
```

## State Variable Reads

- **_troves** (`mapping(uint256 => mapping(uint256 => struct Trove))`)
- **ZOMBIE** (`enum ITroveManager.Status`)
- **ACTIVE** (`enum ITroveManager.Status`)
- **_batchManagerOf** (`mapping(uint256 => mapping(uint256 => address))`)
- **_zombieTroveIds** (`mapping(uint256 => struct EnumerableSet)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getTroveById(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TroveMethods.applyPending(struct Trove) (NodeID: 1)
  │   💬 Args: [trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingRedist(struct Trove) (NodeID: 2)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingInterest(struct Trove) (NodeID: 3)
  │ │   💬 Args: [trove]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveMethods.applyPendingBatchManagementFee(struct Trove) (NodeID: 4)
  │     💬 Args: [trove]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._isZombie(uint256,uint256) (NodeID: 5)
      💬 Args: [i, troveId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSetMethods.has(struct EnumerableSet,uint256) (NodeID: 6)
        💬 Args: [_zombieTroveIds[i], troveId]
        👁️  Def: internal
```
