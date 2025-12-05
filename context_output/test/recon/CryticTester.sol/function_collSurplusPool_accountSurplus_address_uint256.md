# Function: collSurplusPool_accountSurplus(address,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `collSurplusPool_accountSurplus(address,uint256)`
- **Visibility**: public
- **Source Range**: 3636:156:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function collSurplusPool_accountSurplus(address _account, uint256 _amount) public asAdmin() {
    collSurplusPool.accountSurplus(_account, _amount);
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

- **CollSurplusPool::accountSurplus(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.collSurplusPool_accountSurplus(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
