# Function: constructor(contract ICollateralRegistry,contract IHintHelpers)

**Contract**: [src/DebtInFrontHelper.sol/contract_DebtInFrontHelper.md]

## Metadata

- **Contract**: DebtInFrontHelper
- **Signature**: `constructor(contract ICollateralRegistry,contract IHintHelpers)`
- **Visibility**: public
- **Source Range**: 820:173:131

## Implementation

```solidity
constructor(ICollateralRegistry _collateralRegistry, IHintHelpers _hintHelpers) {
    collateralRegistry = _collateralRegistry;
    hintHelpers = _hintHelpers;
}
```

## State Variable Writes

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **hintHelpers** (`contract IHintHelpers`) [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: DebtInFrontHelper.constructor(contract ICollateralRegistry,contract IHintHelpers) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: DebtInFrontHelper
```
