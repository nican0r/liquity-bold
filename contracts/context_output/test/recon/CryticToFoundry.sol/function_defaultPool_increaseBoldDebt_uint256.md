# Function: defaultPool_increaseBoldDebt(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `defaultPool_increaseBoldDebt(uint256)`
- **Visibility**: public
- **Source Range**: 3963:124:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function defaultPool_increaseBoldDebt(uint256 _amount) public asAdmin() {
    defaultPool.increaseBoldDebt(_amount);
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

- **DefaultPool::increaseBoldDebt(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.defaultPool_increaseBoldDebt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
