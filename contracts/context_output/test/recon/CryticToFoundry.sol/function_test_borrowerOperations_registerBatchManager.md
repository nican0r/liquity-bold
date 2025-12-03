# Function: test_borrowerOperations_registerBatchManager()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_borrowerOperations_registerBatchManager()`
- **Visibility**: public
- **Source Range**: 11282:152:315

## Implementation

```solidity
function test_borrowerOperations_registerBatchManager() public {
    borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_borrowerOperations_registerBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128) (NodeID: 1)
      💬 Args: [5e16, 10e16, 5e16, 1e16, 7 days]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
          💬 Args: [no args]
          👁️  Def: internal
```
