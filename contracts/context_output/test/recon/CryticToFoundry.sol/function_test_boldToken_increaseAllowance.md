# Function: test_boldToken_increaseAllowance()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_boldToken_increaseAllowance()`
- **Visibility**: public
- **Source Range**: 3661:121:315

## Implementation

```solidity
function test_boldToken_increaseAllowance() public {
    boldToken_increaseAllowance(_getActors()[0], 1000e18);
}
```

## Related Implementations

### boldToken_increaseAllowance(address,uint256)

- **Kind**: internal
- **Source**: 912:154:321
- **Link**: `test/recon/targets/BoldTokenTargets.sol:BoldTokenTargets:boldToken_increaseAllowance(address,uint256)`

```solidity
function boldToken_increaseAllowance(address spender, uint256 addedValue) public asActor() {
    boldToken.increaseAllowance(spender, addedValue);
}
```

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
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

- **_actors** (`struct EnumerableSet.AddressSet`)
- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_boldToken_increaseAllowance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BoldTokenTargets.boldToken_increaseAllowance(address,uint256) (NodeID: 1)
      💬 Args: [_getActors()[0], 1000e18]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 5)
    │     💬 Args: [_actors]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 6)
    │       💬 Args: [set._inner]
    │       👁️  Def: private
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
          💬 Args: [no args]
          👁️  Def: internal
```
