# Function: constructor(contract ICollateralRegistry,contract IAddressesRegistry[])

**Contract**: [src/RedemptionHelper.sol/contract_RedemptionHelper.md]

## Metadata

- **Contract**: RedemptionHelper
- **Signature**: `constructor(contract ICollateralRegistry,contract IAddressesRegistry[])`
- **Visibility**: public
- **Source Range**: 1276:659:185

## Implementation

```solidity
constructor(ICollateralRegistry _collateralRegistry, IAddressesRegistry[] memory _addresses) {
    require(_addresses.length == _collateralRegistry.totalCollaterals(), "Wrong number of registries");
    numBranches = _addresses.length;
    collateralRegistry = _collateralRegistry;
    boldToken = _collateralRegistry.boldToken();
    for (uint256 i = 0; i < _addresses.length; ++i) {
        require(_collateralRegistry.getTroveManager(i) == _addresses[i].troveManager(), "TroveManager mismatch");
        addresses.push(_addresses[i]);
    }
    boldToken.approve(address(_collateralRegistry), type(uint256).max);
}
```

## External Calls

- **ICollateralRegistry::totalCollaterals()**
- **ICollateralRegistry::boldToken()**
- **ICollateralRegistry::getTroveManager(uint256)**
- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::push(contract IAddressesRegistry)**
- **IBoldToken::approve(address,uint256)**

## State Variable Reads

- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## State Variable Writes

- **numBranches** (`uint256`)
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **addresses** (`contract IAddressesRegistry[]`) [src/Interfaces/IAddressesRegistry.sol/interface_IAddressesRegistry.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: RedemptionHelper.constructor(contract ICollateralRegistry,contract IAddressesRegistry[]) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: RedemptionHelper
```
