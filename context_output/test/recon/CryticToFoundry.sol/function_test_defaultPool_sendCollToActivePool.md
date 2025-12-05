# Function: test_defaultPool_sendCollToActivePool()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_defaultPool_sendCollToActivePool()`
- **Visibility**: public
- **Source Range**: 20904:221:315

## Implementation

```solidity
function test_defaultPool_sendCollToActivePool() public {
    defaultPool_receiveColl(1e18);
    defaultPool_sendCollToActivePool(0.5e18);
}
```

## Related Implementations

### defaultPool_receiveColl(uint256)

- **Kind**: internal
- **Source**: 4093:114:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:defaultPool_receiveColl(uint256)`

```solidity
function defaultPool_receiveColl(uint256 _amount) public asAdmin() {
    defaultPool.receiveColl(_amount);
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

### defaultPool_sendCollToActivePool(uint256)

- **Kind**: internal
- **Source**: 4213:132:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:defaultPool_sendCollToActivePool(uint256)`

```solidity
function defaultPool_sendCollToActivePool(uint256 _amount) public asAdmin() {
    defaultPool.sendCollToActivePool(_amount);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_defaultPool_sendCollToActivePool() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.defaultPool_receiveColl(uint256) (NodeID: 1)
  │   💬 Args: [1e18]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] ⚙️ FUNCTION: AdminTargets.defaultPool_sendCollToActivePool(uint256) (NodeID: 3)
      💬 Args: [0.5e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 4)
        💬 Args: [no args]
```
