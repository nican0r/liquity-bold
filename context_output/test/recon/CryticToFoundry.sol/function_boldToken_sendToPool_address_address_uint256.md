# Function: boldToken_sendToPool(address,address,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `boldToken_sendToPool(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2491:170:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function boldToken_sendToPool(address _sender, address _poolAddress, uint256 _amount) public asAdmin() {
    boldToken.sendToPool(_sender, _poolAddress, _amount);
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

- **BoldToken::sendToPool(address,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.boldToken_sendToPool(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
