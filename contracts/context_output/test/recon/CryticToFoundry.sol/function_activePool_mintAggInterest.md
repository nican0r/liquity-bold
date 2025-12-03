# Function: activePool_mintAggInterest()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `activePool_mintAggInterest()`
- **Visibility**: public
- **Source Range**: 936:98:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function activePool_mintAggInterest() public asAdmin() {
    activePool.mintAggInterest();
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

- **ActivePool::mintAggInterest()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.activePool_mintAggInterest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
