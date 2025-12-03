# Function: test_troveNFT_approve()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveNFT_approve()`
- **Visibility**: public
- **Source Range**: 32708:189:315

## Implementation

```solidity
function test_troveNFT_approve() public {
    troveNFT_mint(_getActor(), 0);
    troveNFT_approve(_getActors()[0], 0);
}
```

## Related Implementations

### troveNFT_mint(address,uint256)

- **Kind**: internal
- **Source**: 10191:120:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveNFT_mint(address,uint256)`

```solidity
function troveNFT_mint(address _owner, uint256 _troveId) public asAdmin() {
    troveNFT.mint(_owner, _troveId);
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

### troveNFT_approve(address,uint256)

- **Kind**: internal
- **Source**: 608:116:331
- **Link**: `test/recon/targets/TroveNFTTargets.sol:TroveNFTTargets:troveNFT_approve(address,uint256)`

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function troveNFT_approve(address to, uint256 tokenId) public asActor() {
    troveNFT.approve(to, tokenId);
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

## State Variable Reads

- **_actor** (`address`)
- **_actors** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveNFT_approve() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.troveNFT_mint(address,uint256) (NodeID: 1)
  │   💬 Args: [_getActor(), 0]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: TroveNFTTargets.troveNFT_approve(address,uint256) (NodeID: 4)
      💬 Args: [_getActors()[0], 0]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 7)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 8)
    │     💬 Args: [_actors]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 9)
    │       💬 Args: [set._inner]
    │       👁️  Def: private
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 5)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 6)
          💬 Args: [no args]
          👁️  Def: internal
```
