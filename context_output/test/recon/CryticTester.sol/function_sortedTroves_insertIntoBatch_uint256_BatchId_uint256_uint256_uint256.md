# Function: sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4593:256:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function sortedTroves_insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin() {
    sortedTroves.insertIntoBatch(_troveId, _batchId, _annualInterestRate, _prevId, _nextId);
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

- **SortedTroves::insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
