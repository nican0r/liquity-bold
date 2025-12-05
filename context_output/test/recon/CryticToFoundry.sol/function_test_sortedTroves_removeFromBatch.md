# Function: test_sortedTroves_removeFromBatch()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_sortedTroves_removeFromBatch()`
- **Visibility**: public
- **Source Range**: 22455:404:315

## Implementation

```solidity
function test_sortedTroves_removeFromBatch() public {
    borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
    BatchId batchId = BatchId.wrap(_getActor());
    sortedTroves_insertIntoBatch(1, batchId, 5e16, 0, 0);
    sortedTroves_removeFromBatch(1);
}
```

## Related Implementations

### borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128)

- **Kind**: internal
- **Source**: 3422:380:322
- **Link**: `test/recon/targets/BorrowerOperationsTargets.sol:BorrowerOperationsTargets:borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128)`

```solidity
function borrowerOperations_registerBatchManager(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) public asActor() {
    borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
}
```

### asActor()

- **Kind**: modifier
- **Source**: 13959:75:317
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

### sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 4593:256:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)`

```solidity
function sortedTroves_insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin() {
    sortedTroves.insertIntoBatch(_troveId, _batchId, _annualInterestRate, _prevId, _nextId);
}
```

### asAdmin()

- **Kind**: modifier
- **Source**: 13885:68:317
- **Link**: `test/recon/Setup.sol:Setup:asAdmin()`

```solidity
/// === MODIFIERS === ///
///  Prank admin and actor
modifier asAdmin() {
    vm.prank(address(this));
    _;
}
```

### sortedTroves_removeFromBatch(uint256)

- **Kind**: internal
- **Source**: 5401:116:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:sortedTroves_removeFromBatch(uint256)`

```solidity
function sortedTroves_removeFromBatch(uint256 _id) public asAdmin() {
    sortedTroves.removeFromBatch(_id);
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_sortedTroves_removeFromBatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128) (NodeID: 1)
  │   💬 Args: [5e16, 10e16, 5e16, 1e16, 7 days]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AdminTargets.sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [1, batchId, 5e16, 0, 0]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 6)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: AdminTargets.sortedTroves_removeFromBatch(uint256) (NodeID: 7)
      💬 Args: [1]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 8)
        💬 Args: [no args]
```
