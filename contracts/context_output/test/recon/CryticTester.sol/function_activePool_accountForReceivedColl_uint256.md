# Function: activePool_accountForReceivedColl(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `activePool_accountForReceivedColl(uint256)`
- **Visibility**: public
- **Source Range**: 796:134:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function activePool_accountForReceivedColl(uint256 _amount) public asAdmin() {
    activePool.accountForReceivedColl(_amount);
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

- **ActivePool::accountForReceivedColl(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.activePool_accountForReceivedColl(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
