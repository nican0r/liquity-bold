# Function: test_troveManager_redeemCollateral()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_redeemCollateral()`
- **Visibility**: public
- **Source Range**: 31640:139:315

## Implementation

```solidity
function test_troveManager_redeemCollateral() public {
    troveManager_redeemCollateral(_getActor(), 100e18, 2000e18, 5e16, 10);
}
```

## Related Implementations

### troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 9541:270:320
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256)`

```solidity
function troveManager_redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) public asAdmin() {
    troveManager.redeemCollateral(_redeemer, _boldamount, _price, _redemptionRate, _maxIterations);
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_redeemCollateral() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [_getActor(), 100e18, 2000e18, 5e16, 10]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
