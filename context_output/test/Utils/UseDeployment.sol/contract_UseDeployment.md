# Contract: UseDeployment

## Metadata

- **Name**: UseDeployment
- **Type**: Contract
- **Path**: test/Utils/UseDeployment.sol

## State Variables

### VM_ADDRESS (inherited from CommonBase)

```solidity
address internal constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))))
```

### CONSOLE (inherited from CommonBase)

```solidity
address internal constant CONSOLE = 0x000000000000000000636F6e736F6c652e6c6f67
```

### CREATE2_FACTORY (inherited from CommonBase)

```solidity
address internal constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### DEFAULT_SENDER (inherited from CommonBase)

```solidity
address internal constant DEFAULT_SENDER = address(uint160(uint256(keccak256("foundry default caller"))))
```

### DEFAULT_TEST_CONTRACT (inherited from CommonBase)

```solidity
address internal constant DEFAULT_TEST_CONTRACT = 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
```

### MULTICALL3_ADDRESS (inherited from CommonBase)

```solidity
address internal constant MULTICALL3_ADDRESS = 0xcA11bde05977b3631167028862bE2a173976CA11
```

### SECP256K1_ORDER (inherited from CommonBase)

```solidity
uint256 internal constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from CommonBase)

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### vm (inherited from CommonBase)

```solidity
Vm internal constant vm = Vm(VM_ADDRESS)
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### stdstore (inherited from CommonBase)

```solidity
StdStorage internal stdstore
```

### WETH

```solidity
address internal WETH
```

### WSTETH

```solidity
address internal WSTETH
```

### RETH

```solidity
address internal RETH
```

### BOLD

```solidity
address internal BOLD
```

### USDC

```solidity
address internal USDC
```

### LQTY

```solidity
address internal LQTY
```

### LUSD

```solidity
address internal LUSD
```

### ETH_GAS_COMPENSATION

```solidity
uint256 internal ETH_GAS_COMPENSATION
```

### MIN_DEBT

```solidity
uint256 internal MIN_DEBT
```

### EPOCH_START

```solidity
uint256 internal EPOCH_START
```

### EPOCH_DURATION

```solidity
uint256 internal EPOCH_DURATION
```

### REGISTRATION_FEE

```solidity
uint256 internal REGISTRATION_FEE
```

### weth

```solidity
IWETH internal weth
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### usdc

```solidity
IERC20 internal usdc
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### lqty

```solidity
IERC20 internal lqty
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### lusd

```solidity
IERC20 internal lusd
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

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
IHintHelpers internal hintHelpers
```

**IHintHelpers**: [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]

### exchangeHelpers

```solidity
IExchangeHelpers internal exchangeHelpers
```

**IExchangeHelpers**: [src/Zappers/Interfaces/IExchangeHelpers.sol/interface_IExchangeHelpers.md]

### governance

```solidity
Governance internal governance
```

**Governance**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

### curveUsdcBold

```solidity
ICurveStableSwapNG internal curveUsdcBold
```

**ICurveStableSwapNG**: [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]

### curveUsdcBoldGauge

```solidity
ILiquidityGaugeV6 internal curveUsdcBoldGauge
```

**ILiquidityGaugeV6**: [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]

### curveUsdcBoldInitiative

```solidity
CurveV2GaugeRewards internal curveUsdcBoldInitiative
```

**CurveV2GaugeRewards**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

### curveLusdBold

```solidity
ICurveStableSwapNG internal curveLusdBold
```

**ICurveStableSwapNG**: [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]

### curveLusdBoldGauge

```solidity
ILiquidityGaugeV6 internal curveLusdBoldGauge
```

**ILiquidityGaugeV6**: [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]

### curveLusdBoldInitiative

```solidity
CurveV2GaugeRewards internal curveLusdBoldInitiative
```

**CurveV2GaugeRewards**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

### defiCollectiveInitiative

```solidity
address internal defiCollectiveInitiative
```

### initialInitiatives

```solidity
address[] internal initialInitiatives
```

### branches

```solidity
BranchContracts[] internal branches
```

## Structs

### BranchContracts

```solidity
struct BranchContracts {
    IERC20 collToken;
    IAddressesRegistry addressesRegistry;
    IPriceFeed priceFeed;
    ITroveNFT troveNFT;
    ITroveManager troveManager;
    IBorrowerOperations borrowerOperations;
    ISortedTroves sortedTroves;
    IActivePool activePool;
    IDefaultPool defaultPool;
    IStabilityPool stabilityPool;
    ILeverageZapper leverageZapper;
    IZapper zapper;
}
```
