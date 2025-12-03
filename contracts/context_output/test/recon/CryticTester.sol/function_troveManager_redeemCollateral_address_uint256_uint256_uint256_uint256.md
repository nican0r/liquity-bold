# Function: troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 9541:270:320
- **Inherited From**: AdminTargets

## Implementation

```solidity
function troveManager_redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) public asAdmin() {
    troveManager.redeemCollateral(_redeemer, _boldamount, _price, _redemptionRate, _maxIterations);
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

- **TroveManagerTester::redeemCollateral(address,uint256,uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
