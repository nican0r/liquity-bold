# Interface: IDebtInFrontHelper

## Metadata

- **Name**: IDebtInFrontHelper
- **Type**: Interface
- **Path**: src/Interfaces/IDebtInFrontHelper.sol

## Public/External Functions

### collateralRegistry()

- **Signature**: `collateralRegistry()`
- **Visibility**: external
- **Source Range**: 205:74:150

**Signature:**
```solidity
function collateralRegistry() external view returns (ICollateralRegistry);;
```

### hintHelpers()

- **Signature**: `hintHelpers()`
- **Visibility**: external
- **Source Range**: 284:60:150

**Signature:**
```solidity
function hintHelpers() external view returns (IHintHelpers);;
```

### getDebtBetweenInterestRates(uint256,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `getDebtBetweenInterestRates(uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 350:311:150

**Signature:**
```solidity
function getDebtBetweenInterestRates(uint256 _collIndex, uint256 _interestRateLo, uint256 _interestRateHi, uint256 _excludedTroveId, uint256 _hintId, uint256 _numTrials) external view returns (uint256 debt, uint256 blockTimestamp);;
```

### getDebtBetweenInterestRateAndTrove(uint256,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `getDebtBetweenInterestRateAndTrove(uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 667:330:150

**Signature:**
```solidity
function getDebtBetweenInterestRateAndTrove(uint256 _collIndex, uint256 _interestRateLo, uint256 _interestRateHi, uint256 _troveIdToStopAt, uint256 _hintId, uint256 _numTrials) external view returns (uint256 debt, uint256 blockTimestamp);;
```
