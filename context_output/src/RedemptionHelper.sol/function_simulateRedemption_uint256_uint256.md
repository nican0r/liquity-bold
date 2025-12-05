# Function: simulateRedemption(uint256,uint256)

**Contract**: [src/RedemptionHelper.sol/contract_RedemptionHelper.md]

## Metadata

- **Contract**: RedemptionHelper
- **Signature**: `simulateRedemption(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2035:2842:185

## Implementation

```solidity
function simulateRedemption(uint256 _bold, uint256 _maxIterationsPerCollateral) public returns (SimulationContext[] memory branch, uint256 totalProportions) {
    branch = new SimulationContext[](numBranches);
    for (uint256 i = 0; i < numBranches; ++i) {
        branch[i].troveManager = address(addresses[i].troveManager());
        branch[i].sortedTroves = address(addresses[i].sortedTroves());
        (branch[i].proportion, branch[i].price, branch[i].redeemable) = ITroveManager(branch[i].troveManager).getUnbackedPortionPriceAndRedeemability();
        if (branch[i].redeemable) totalProportions += branch[i].proportion;
    }
    if ((0 < totalProportions) && (totalProportions < _bold)) _bold = totalProportions;
    if (totalProportions == 0) {
        for (uint256 i = 0; i < numBranches; ++i) {
            branch[i].proportion = ITroveManager(branch[i].troveManager).getEntireBranchDebt();
            if (branch[i].redeemable) totalProportions += branch[i].proportion;
        }
    }
    if (totalProportions == 0) return (branch, totalProportions);
    for (uint256 i = 0; i < numBranches; ++i) {
        if (!branch[i].redeemable) continue;
        branch[i].attemptedBold = (_bold * branch[i].proportion) / totalProportions;
        if (branch[i].attemptedBold == 0) continue;
        uint256 lastZombieTroveId = ITroveManager(branch[i].troveManager).lastZombieTroveId();
        uint256 lastTroveId = ISortedTroves(branch[i].sortedTroves).getLast();
        (uint256 troveId, uint256 nextTroveId) = (lastZombieTroveId != 0) ? (lastZombieTroveId, lastTroveId) : (lastTroveId, ISortedTroves(branch[i].sortedTroves).getPrev(lastTroveId));
        for (branch[i].iterations = 0; (branch[i].iterations < _maxIterationsPerCollateral) || (_maxIterationsPerCollateral == 0); ++branch[i].iterations) {
            if ((branch[i].redeemedBold == branch[i].attemptedBold) || (troveId == 0)) break;
            LatestTroveData memory trove = ITroveManager(branch[i].troveManager).getLatestTroveData(troveId);
            if (((trove.entireColl * branch[i].price) / trove.entireDebt) >= _100pct) {
                branch[i].redeemedBold += Math.min(branch[i].attemptedBold - branch[i].redeemedBold, trove.entireDebt);
            }
            troveId = nextTroveId;
            nextTroveId = ISortedTroves(branch[i].sortedTroves).getPrev(nextTroveId);
        }
    }
}
```

## Related Implementations

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

## External Calls

- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::sortedTroves()**
- **ITroveManager::getUnbackedPortionPriceAndRedeemability()**
- **ITroveManager::getEntireBranchDebt()**
- **ITroveManager::lastZombieTroveId()**
- **ISortedTroves::getLast()**
- **ISortedTroves::getPrev(uint256)**
- **ITroveManager::getLatestTroveData(uint256)**

## State Variable Reads

- **numBranches** (`uint256`)
- **addresses** (`contract IAddressesRegistry[]`) [src/Interfaces/IAddressesRegistry.sol/interface_IAddressesRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelper.simulateRedemption(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 1)
      💬 Args: [branch[i].attemptedBold - branch[i].redeemedBold, trove.entireDebt]
      👁️  Def: internal
```
