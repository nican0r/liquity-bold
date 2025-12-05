# Function: troveManager_getUnbackedPortionPriceAndRedeemability()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `troveManager_getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: public
- **Source Range**: 773:150:330
- **Inherited From**: TroveManagerTargets

## Implementation

```solidity
function troveManager_getUnbackedPortionPriceAndRedeemability() public asActor() {
    troveManager.getUnbackedPortionPriceAndRedeemability();
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 13959:75:317
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
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

## External Calls

- **TroveManagerTester::getUnbackedPortionPriceAndRedeemability()**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTargets.troveManager_getUnbackedPortionPriceAndRedeemability() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
