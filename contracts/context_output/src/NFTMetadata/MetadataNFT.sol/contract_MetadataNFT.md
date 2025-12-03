# Contract: MetadataNFT

## Metadata

- **Name**: MetadataNFT
- **Type**: Contract
- **Path**: src/NFTMetadata/MetadataNFT.sol

## Implements Interfaces

- **IMetadataNFT** [src/NFTMetadata/MetadataNFT.sol/interface_IMetadataNFT.md]

## State Variables

### assetReader

```solidity
FixedAssetReader public immutable assetReader
```

**FixedAssetReader**: [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

## Structs

### TroveData (inherited from IMetadataNFT)

```solidity
struct TroveData {
    uint256 _tokenId;
    address _owner;
    address _collToken;
    address _boldToken;
    uint256 _collAmount;
    uint256 _debtAmount;
    uint256 _interestRate;
    ITroveManager.Status _status;
}
```

## Public/External Functions

### constructor(contract FixedAssetReader)

- **Signature**: `constructor(contract FixedAssetReader)`
- **Visibility**: public
- **Source Range**: 801:86:173
- **Details**: [function_constructor_contract_FixedAssetReader.md](./function_constructor_contract_FixedAssetReader.md)

**Signature:**
```solidity
constructor(FixedAssetReader _assetReader);
```

### uri(struct IMetadataNFT.TroveData)

- **Signature**: `uri(struct IMetadataNFT.TroveData)`
- **Visibility**: public
- **Source Range**: 893:702:173
- **Details**: [function_uri_struct_IMetadataNFT.TroveData.md](./function_uri_struct_IMetadataNFT.TroveData.md)

**Signature:**
```solidity
function uri(TroveData memory _troveData) public view returns (string memory);
```

### attributes(struct IMetadataNFT.TroveData)

- **Signature**: `attributes(struct IMetadataNFT.TroveData)`
- **Visibility**: public
- **Source Range**: 2020:966:173
- **Details**: [function_attributes_struct_IMetadataNFT.TroveData.md](./function_attributes_struct_IMetadataNFT.TroveData.md)

**Signature:**
```solidity
function attributes(TroveData memory _troveData) public pure returns (string memory);
```

### dynamicTextComponents(struct IMetadataNFT.TroveData)

- **Signature**: `dynamicTextComponents(struct IMetadataNFT.TroveData)`
- **Visibility**: public
- **Source Range**: 2992:673:173
- **Details**: [function_dynamicTextComponents_struct_IMetadataNFT.TroveData.md](./function_dynamicTextComponents_struct_IMetadataNFT.TroveData.md)

**Signature:**
```solidity
function dynamicTextComponents(TroveData memory _troveData) public view returns (string memory);
```
