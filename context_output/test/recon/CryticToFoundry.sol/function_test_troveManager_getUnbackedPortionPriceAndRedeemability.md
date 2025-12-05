# Function: test_troveManager_getUnbackedPortionPriceAndRedeemability()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_troveManager_getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: public
- **Source Range**: 24463:147:315

## Implementation

```solidity
function test_troveManager_getUnbackedPortionPriceAndRedeemability() public {
    troveManager_getUnbackedPortionPriceAndRedeemability();
}
```

## Related Implementations

### troveManager_getUnbackedPortionPriceAndRedeemability()

- **Kind**: internal
- **Source**: 773:150:330
- **Link**: `test/recon/targets/TroveManagerTargets.sol:TroveManagerTargets:troveManager_getUnbackedPortionPriceAndRedeemability()`

```solidity
function troveManager_getUnbackedPortionPriceAndRedeemability() public asActor() {
    troveManager.getUnbackedPortionPriceAndRedeemability();
}
```

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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_troveManager_getUnbackedPortionPriceAndRedeemability() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: TroveManagerTargets.troveManager_getUnbackedPortionPriceAndRedeemability() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
          💬 Args: [no args]
          👁️  Def: internal
```
