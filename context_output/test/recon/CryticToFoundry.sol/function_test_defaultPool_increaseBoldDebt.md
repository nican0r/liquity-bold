# Function: test_defaultPool_increaseBoldDebt()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_defaultPool_increaseBoldDebt()`
- **Visibility**: public
- **Source Range**: 20693:106:315

## Implementation

```solidity
function test_defaultPool_increaseBoldDebt() public {
    defaultPool_increaseBoldDebt(1000e18);
}
```

## Related Implementations

### defaultPool_increaseBoldDebt(uint256)

- **Kind**: internal
- **Source**: 3963:124:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:defaultPool_increaseBoldDebt(uint256)`

```solidity
function defaultPool_increaseBoldDebt(uint256 _amount) public asAdmin() {
    defaultPool.increaseBoldDebt(_amount);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_defaultPool_increaseBoldDebt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.defaultPool_increaseBoldDebt(uint256) (NodeID: 1)
      💬 Args: [1000e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
