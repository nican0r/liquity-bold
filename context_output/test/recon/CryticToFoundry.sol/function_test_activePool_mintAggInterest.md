# Function: test_activePool_mintAggInterest()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_activePool_mintAggInterest()`
- **Visibility**: public
- **Source Range**: 982:95:315

## Implementation

```solidity
function test_activePool_mintAggInterest() public {
    activePool_mintAggInterest();
}
```

## Related Implementations

### activePool_mintAggInterest()

- **Kind**: internal
- **Source**: 936:98:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:activePool_mintAggInterest()`

```solidity
function activePool_mintAggInterest() public asAdmin() {
    activePool.mintAggInterest();
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_activePool_mintAggInterest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.activePool_mintAggInterest() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
