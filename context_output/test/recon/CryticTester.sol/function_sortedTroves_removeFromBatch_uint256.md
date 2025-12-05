# Function: sortedTroves_removeFromBatch(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `sortedTroves_removeFromBatch(uint256)`
- **Visibility**: public
- **Source Range**: 5401:116:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function sortedTroves_removeFromBatch(uint256 _id) public asAdmin() {
    sortedTroves.removeFromBatch(_id);
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

- **SortedTroves::removeFromBatch(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.sortedTroves_removeFromBatch(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
