# Function: defaultPool_decreaseBoldDebt(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `defaultPool_decreaseBoldDebt(uint256)`
- **Visibility**: public
- **Source Range**: 3833:124:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function defaultPool_decreaseBoldDebt(uint256 _amount) public asAdmin() {
    defaultPool.decreaseBoldDebt(_amount);
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

- **DefaultPool::decreaseBoldDebt(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.defaultPool_decreaseBoldDebt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
