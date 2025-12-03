# Contract: BaseMultiCollateralTest

## Metadata

- **Name**: BaseMultiCollateralTest
- **Type**: Contract
- **Path**: test/TestContracts/BaseMultiCollateralTest.sol

## State Variables

### weth

```solidity
IERC20 internal weth
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### collateralRegistry

```solidity
ICollateralRegistry internal collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### boldToken

```solidity
IBoldToken internal boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### hintHelpers

```solidity
HintHelpers internal hintHelpers
```

**HintHelpers**: [src/HintHelpers.sol/contract_HintHelpers.md]

### branches

```solidity
TestDeployer.LiquityContractsDev[] internal branches
```

## Structs

### Contracts

```solidity
struct Contracts {
    IWETH weth;
    ICollateralRegistry collateralRegistry;
    IBoldToken boldToken;
    HintHelpers hintHelpers;
    TestDeployer.LiquityContractsDev[] branches;
}
```
