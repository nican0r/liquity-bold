# Interface: IRedemptionHelper

## Metadata

- **Name**: IRedemptionHelper
- **Type**: Interface
- **Path**: src/Interfaces/IRedemptionHelper.sol

## Structs

### SimulationContext

```solidity
struct SimulationContext {
    address troveManager;
    address sortedTroves;
    bool redeemable;
    uint256 price;
    uint256 proportion;
    uint256 attemptedBold;
    uint256 redeemedBold;
    uint256 iterations;
}
```

### Redeemed

```solidity
struct Redeemed {
    uint256 bold;
    uint256 coll;
}
```

## Public/External Functions

### simulateRedemption(uint256,uint256)

- **Signature**: `simulateRedemption(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 427:175:162

**Signature:**
```solidity
function simulateRedemption(uint256 _bold, uint256 _maxIterationsPerCollateral) external returns (SimulationContext[] memory branch, uint256 totalProportions);;
```

### truncateRedemption(uint256,uint256)

- **Signature**: `truncateRedemption(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1092:181:162

**Signature:**
```solidity
function truncateRedemption(uint256 _bold, uint256 _maxIterationsPerCollateral) external returns (uint256 truncatedBold, uint256 feePct, Redeemed[] memory redeemed);;
```

### redeemCollateral(uint256,uint256,uint256,uint256[])

- **Signature**: `redeemCollateral(uint256,uint256,uint256,uint256[])`
- **Visibility**: external
- **Source Range**: 1444:180:162

**Signature:**
```solidity
function redeemCollateral(uint256 _bold, uint256 _maxIterationsPerCollateral, uint256 _maxFeePct, uint256[] memory _minCollRedeemed) external;;
```
