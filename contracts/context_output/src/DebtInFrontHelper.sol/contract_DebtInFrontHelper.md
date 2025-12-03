# Contract: DebtInFrontHelper

## Metadata

- **Name**: DebtInFrontHelper
- **Type**: Contract
- **Path**: src/DebtInFrontHelper.sol

## Implements Interfaces

- **IDebtInFrontHelper** [src/Interfaces/IDebtInFrontHelper.sol/interface_IDebtInFrontHelper.md]

## State Variables

### collateralRegistry

```solidity
ICollateralRegistry public immutable collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### hintHelpers

```solidity
IHintHelpers public immutable hintHelpers
```

**IHintHelpers**: [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]

## Public/External Functions

### constructor(contract ICollateralRegistry,contract IHintHelpers)

- **Signature**: `constructor(contract ICollateralRegistry,contract IHintHelpers)`
- **Visibility**: public
- **Source Range**: 820:173:131
- **Details**: [function_constructor_contract_ICollateralRegistry_contract_IHintHelpers.md](./function_constructor_contract_ICollateralRegistry_contract_IHintHelpers.md)

**Signature:**
```solidity
constructor(ICollateralRegistry _collateralRegistry, IHintHelpers _hintHelpers);
```

### getDebtBetweenInterestRates(uint256,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `getDebtBetweenInterestRates(uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3407:454:131
- **Details**: [function_getDebtBetweenInterestRates_uint256_uint256_uint256_uint256_uint256_uint256.md](./function_getDebtBetweenInterestRates_uint256_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function getDebtBetweenInterestRates(uint256 _collIndex, uint256 _interestRateLo, uint256 _interestRateHi, uint256 _excludedTroveId, uint256 _hintId, uint256 _numTrials) external view returns (uint256 debt, uint256 blockTimestamp);
```

### getDebtBetweenInterestRateAndTrove(uint256,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `getDebtBetweenInterestRateAndTrove(uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3867:472:131
- **Details**: [function_getDebtBetweenInterestRateAndTrove_uint256_uint256_uint256_uint256_uint256_uint256.md](./function_getDebtBetweenInterestRateAndTrove_uint256_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function getDebtBetweenInterestRateAndTrove(uint256 _collIndex, uint256 _interestRateLo, uint256 _interestRateHi, uint256 _troveIdToStopAt, uint256 _hintId, uint256 _numTrials) external view returns (uint256 debt, uint256 blockTimestamp);
```
