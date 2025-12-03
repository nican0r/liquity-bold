# Function: constructor(contract IAddressesRegistry)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 627:131:282

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) TroveManager(_addressesRegistry) {
    BCR = _addressesRegistry.BCR();
}
```

## Related Implementations

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 6898:1438:188
- **Link**: `src/TroveManager.sol:TroveManager:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) LiquityBase(_addressesRegistry) {
    CCR = _addressesRegistry.CCR();
    MCR = _addressesRegistry.MCR();
    SCR = _addressesRegistry.SCR();
    LIQUIDATION_PENALTY_SP = _addressesRegistry.LIQUIDATION_PENALTY_SP();
    LIQUIDATION_PENALTY_REDISTRIBUTION = _addressesRegistry.LIQUIDATION_PENALTY_REDISTRIBUTION();
    troveNFT = _addressesRegistry.troveNFT();
    borrowerOperations = _addressesRegistry.borrowerOperations();
    stabilityPool = _addressesRegistry.stabilityPool();
    gasPoolAddress = _addressesRegistry.gasPoolAddress();
    collSurplusPool = _addressesRegistry.collSurplusPool();
    boldToken = _addressesRegistry.boldToken();
    sortedTroves = _addressesRegistry.sortedTroves();
    WETH = _addressesRegistry.WETH();
    collateralRegistry = _addressesRegistry.collateralRegistry();
    emit TroveNFTAddressChanged(address(troveNFT));
    emit BorrowerOperationsAddressChanged(address(borrowerOperations));
    emit StabilityPoolAddressChanged(address(stabilityPool));
    emit GasPoolAddressChanged(gasPoolAddress);
    emit CollSurplusPoolAddressChanged(address(collSurplusPool));
    emit BoldTokenAddressChanged(address(boldToken));
    emit SortedTrovesAddressChanged(address(sortedTroves));
    emit CollateralRegistryAddressChanged(address(collateralRegistry));
}
```

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 816:401:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    activePool = _addressesRegistry.activePool();
    defaultPool = _addressesRegistry.defaultPool();
    priceFeed = _addressesRegistry.priceFeed();
    emit ActivePoolAddressChanged(address(activePool));
    emit DefaultPoolAddressChanged(address(defaultPool));
    emit PriceFeedAddressChanged(address(priceFeed));
}
```

## External Calls

- **IAddressesRegistry::BCR()**

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## State Variable Writes

- **BCR** (`uint256`)
- **CCR** (`uint256`)
- **MCR** (`uint256`)
- **SCR** (`uint256`)
- **LIQUIDATION_PENALTY_SP** (`uint256`)
- **LIQUIDATION_PENALTY_REDISTRIBUTION** (`uint256`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: TroveManagerTester.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: TroveManagerTester
  └─ [1] 🏗️ CONSTRUCTOR: TroveManager.constructor(contract IAddressesRegistry) (NodeID: 1)
      💬 Args: [_addressesRegistry]
      🏗️  Contract: TroveManager
    └─ [2] 🏗️ CONSTRUCTOR: LiquityBase.constructor(contract IAddressesRegistry) (NodeID: 2)
        💬 Args: [_addressesRegistry]
        🏗️  Contract: LiquityBase
```
