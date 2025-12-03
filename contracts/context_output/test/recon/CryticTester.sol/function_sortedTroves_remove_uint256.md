# Function: sortedTroves_remove(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `sortedTroves_remove(uint256)`
- **Visibility**: public
- **Source Range**: 5297:98:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function sortedTroves_remove(uint256 _id) public asAdmin() {
    sortedTroves.remove(_id);
}
```

## Related Implementations

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

## External Calls

- **SortedTroves::remove(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.sortedTroves_remove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
