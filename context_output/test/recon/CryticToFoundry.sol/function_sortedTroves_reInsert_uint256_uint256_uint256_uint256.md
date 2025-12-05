# Function: sortedTroves_reInsert(uint256,uint256,uint256,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `sortedTroves_reInsert(uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4855:210:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function sortedTroves_reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin() {
    sortedTroves.reInsert(_id, _newAnnualInterestRate, _prevId, _nextId);
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

- **SortedTroves::reInsert(uint256,uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.sortedTroves_reInsert(uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
