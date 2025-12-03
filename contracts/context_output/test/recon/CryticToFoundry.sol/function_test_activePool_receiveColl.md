# Function: test_activePool_receiveColl()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_activePool_receiveColl()`
- **Visibility**: public
- **Source Range**: 2633:91:315

## Implementation

```solidity
function test_activePool_receiveColl() public {
    activePool_receiveColl(1e18);
}
```

## Related Implementations

### activePool_receiveColl(uint256)

- **Kind**: internal
- **Source**: 1510:112:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:activePool_receiveColl(uint256)`

```solidity
function activePool_receiveColl(uint256 _amount) public asAdmin() {
    activePool.receiveColl(_amount);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_activePool_receiveColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.activePool_receiveColl(uint256) (NodeID: 1)
      💬 Args: [1e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
