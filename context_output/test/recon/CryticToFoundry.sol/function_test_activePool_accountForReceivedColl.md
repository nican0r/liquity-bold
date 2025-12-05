# Function: test_activePool_accountForReceivedColl()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_activePool_accountForReceivedColl()`
- **Visibility**: public
- **Source Range**: 863:113:315

## Implementation

```solidity
function test_activePool_accountForReceivedColl() public {
    activePool_accountForReceivedColl(1e18);
}
```

## Related Implementations

### activePool_accountForReceivedColl(uint256)

- **Kind**: internal
- **Source**: 796:134:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:activePool_accountForReceivedColl(uint256)`

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function activePool_accountForReceivedColl(uint256 _amount) public asAdmin() {
    activePool.accountForReceivedColl(_amount);
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
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_activePool_accountForReceivedColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.activePool_accountForReceivedColl(uint256) (NodeID: 1)
      💬 Args: [1e18]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
