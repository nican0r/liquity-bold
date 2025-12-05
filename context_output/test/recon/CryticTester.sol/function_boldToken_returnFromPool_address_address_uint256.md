# Function: boldToken_returnFromPool(address,address,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `boldToken_returnFromPool(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2303:182:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function boldToken_returnFromPool(address _poolAddress, address _receiver, uint256 _amount) public asAdmin() {
    boldToken.returnFromPool(_poolAddress, _receiver, _amount);
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

- **BoldToken::returnFromPool(address,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.boldToken_returnFromPool(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
