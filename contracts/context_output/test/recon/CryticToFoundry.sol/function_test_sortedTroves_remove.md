# Function: test_sortedTroves_remove()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_sortedTroves_remove()`
- **Visibility**: public
- **Source Range**: 22267:182:315

## Implementation

```solidity
function test_sortedTroves_remove() public {
    sortedTroves_insert(1, 5e16, 0, 0);
    sortedTroves_remove(1);
}
```

## Related Implementations

### sortedTroves_insert(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 4387:200:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:sortedTroves_insert(uint256,uint256,uint256,uint256)`

```solidity
function sortedTroves_insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin() {
    sortedTroves.insert(_id, _annualInterestRate, _prevId, _nextId);
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

### sortedTroves_remove(uint256)

- **Kind**: internal
- **Source**: 5297:98:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:sortedTroves_remove(uint256)`

```solidity
function sortedTroves_remove(uint256 _id) public asAdmin() {
    sortedTroves.remove(_id);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_sortedTroves_remove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.sortedTroves_insert(uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [1, 5e16, 0, 0]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: AdminTargets.sortedTroves_remove(uint256) (NodeID: 3)
      💬 Args: [1]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 4)
        💬 Args: [no args]
```
