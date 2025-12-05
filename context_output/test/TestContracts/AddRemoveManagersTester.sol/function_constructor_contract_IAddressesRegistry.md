# Function: constructor(contract IAddressesRegistry)

**Contract**: [test/TestContracts/AddRemoveManagersTester.sol/contract_AddRemoveManagersTester.md]

## Metadata

- **Contract**: AddRemoveManagersTester
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 168:91:249

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) AddRemoveManagers(_addressesRegistry) {}
```

## Related Implementations

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 1988:164:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    troveNFT = _addressesRegistry.troveNFT();
    emit TroveNFTAddressChanged(address(troveNFT));
}
```

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: AddRemoveManagersTester.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: AddRemoveManagersTester
  └─ [1] 🏗️ CONSTRUCTOR: AddRemoveManagers.constructor(contract IAddressesRegistry) (NodeID: 1)
      💬 Args: [_addressesRegistry]
      🏗️  Contract: AddRemoveManagers
```
