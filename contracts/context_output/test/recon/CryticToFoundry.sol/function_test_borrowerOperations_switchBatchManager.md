# Function: test_borrowerOperations_switchBatchManager()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_borrowerOperations_switchBatchManager()`
- **Visibility**: public
- **Source Range**: 17232:1304:315

## Implementation

```solidity
function test_borrowerOperations_switchBatchManager() public {
    borrowerOperations_registerBatchManager(5e16, 10e16, 5e16, 1e16, 7 days);
    address batchManager1 = _getActor();
    IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: _getActor(), ownerIndex: 0, collAmount: 10e18, boldAmount: 2000e18, upperHint: 0, lowerHint: 0, interestBatchManager: batchManager1, maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    borrowerOperations_openTroveAndJoinInterestBatchManager(params);
    switchActor(1);
    borrowerOperations_registerBatchManager(5e16, 10e16, 6e16, 1e16, 7 days);
    address batchManager2 = _getActor();
    switchActor(0);
    borrowerOperations_switchBatchManager(0, 0, 0, batchManager2, 0, 0, 100e18);
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

### borrowerOperations_openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)

- **Kind**: internal
- **Source**: 3176:240:322
- **Link**: `test/recon/targets/BorrowerOperationsTargets.sol:BorrowerOperationsTargets:borrowerOperations_openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)`

```solidity
function borrowerOperations_openTroveAndJoinInterestBatchManager(IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory _params) public asActor() {
    borrowerOperations.openTroveAndJoinInterestBatchManager(_params);
}
```

### switchActor(uint256)

- **Kind**: internal
- **Source**: 680:83:327
- **Link**: `test/recon/targets/ManagersTargets.sol:ManagersTargets:switchActor(uint256)`

```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public {
    _switchActor(entropy);
}
```

### _switchActor(uint256)

- **Kind**: internal
- **Source**: 2547:143:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_switchActor(uint256)`

```solidity
/// @dev Expose this in the `TargetFunctions` contract to let the fuzzer switch actors
///    NOTE: We revert if the entropy is greater than the number of actors, for Halmos compatibility
///  @dev This may reduce fuzzing performance if using multiple actors, if so add explicitly clamped handlers to ManagersTargets using the index of all added actors
///  @notice Switches the current actor based on the entropy
///  @param entropy The entropy to choose a random actor in the array for switching
///  @return target The new active actor
function _switchActor(uint256 entropy) internal returns (address target) {
    target = _actors.at(entropy);
    _actor = target;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9563:156:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4912:118:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

### borrowerOperations_switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 6164:392:322
- **Link**: `test/recon/targets/BorrowerOperationsTargets.sol:BorrowerOperationsTargets:borrowerOperations_switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)`

```solidity
function borrowerOperations_switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) public asActor() {
    borrowerOperations.switchBatchManager(_troveId, _removeUpperHint, _removeLowerHint, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
}
```

## State Variable Reads

- **_actor** (`address`)
- **_actors** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_borrowerOperations_switchBatchManager() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams) (NodeID: 6)
  │   💬 Args: [params]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 7)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 8)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ManagersTargets.switchActor(uint256) (NodeID: 9)
  │   💬 Args: [1]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 10)
  │     💬 Args: [entropy]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 11)
  │       💬 Args: [_actors, entropy]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 12)
  │         💬 Args: [set._inner, index]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128) (NodeID: 13)
  │   💬 Args: [5e16, 10e16, 6e16, 1e16, 7 days]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 14)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 15)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 16)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ManagersTargets.switchActor(uint256) (NodeID: 17)
  │   💬 Args: [0]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 18)
  │     💬 Args: [entropy]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 19)
  │       💬 Args: [_actors, entropy]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 20)
  │         💬 Args: [set._inner, index]
  │         👁️  Def: private
  └─ [1] ⚙️ FUNCTION: BorrowerOperationsTargets.borrowerOperations_switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256) (NodeID: 21)
      💬 Args: [0, 0, 0, batchManager2, 0, 0, 100e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 22)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 23)
          💬 Args: [no args]
          👁️  Def: internal
```
