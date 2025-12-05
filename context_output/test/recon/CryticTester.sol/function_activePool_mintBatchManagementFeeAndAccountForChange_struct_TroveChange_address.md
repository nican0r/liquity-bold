# Function: activePool_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `activePool_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)`
- **Visibility**: public
- **Source Range**: 1273:231:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function activePool_mintBatchManagementFeeAndAccountForChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin() {
    activePool.mintBatchManagementFeeAndAccountForChange(_troveChange, _batchAddress);
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

- **ActivePool::mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.activePool_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
