# Function: deployMetadata(bytes32)

**Contract**: [test/TestContracts/Deployment.t.sol/contract_TestDeployer.md]

## Metadata

- **Contract**: TestDeployer
- **Signature**: `deployMetadata(bytes32)`
- **Visibility**: public
- **Source Range**: 550:282:274
- **Inherited From**: MetadataDeployment

## Implementation

```solidity
function deployMetadata(bytes32 _salt) public returns (MetadataNFT) {
    _loadFiles();
    _storeFile();
    _deployFixedAssetReader(_salt);
    MetadataNFT metadataNFT = new MetadataNFT{salt: _salt}(initializedFixedAssetReader);
    return metadataNFT;
}
```

## Related Implementations

### _loadFiles()

- **Kind**: internal
- **Source**: 838:1597:274
- **Link**: `test/TestContracts/MetadataDeployment.sol:MetadataDeployment:_loadFiles()`

```solidity
function _loadFiles() internal {
    string memory root = string.concat(vm.projectRoot(), "/utils/assets/");
    uint256 offset = 0;
    bytes memory boldFile = bytes(vm.readFile(string.concat(root, "bold_logo.txt")));
    File memory bold = File(boldFile, offset, offset + boldFile.length);
    offset += boldFile.length;
    files[bytes4(keccak256("BOLD"))] = bold;
    bytes memory ethFile = bytes(vm.readFile(string.concat(root, "weth_logo.txt")));
    File memory eth = File(ethFile, offset, offset + ethFile.length);
    offset += ethFile.length;
    files[bytes4(keccak256("WETH"))] = eth;
    bytes memory wstethFile = bytes(vm.readFile(string.concat(root, "wsteth_logo.txt")));
    File memory wsteth = File(wstethFile, offset, offset + wstethFile.length);
    offset += wstethFile.length;
    files[bytes4(keccak256("wstETH"))] = wsteth;
    bytes memory rethFile = bytes(vm.readFile(string.concat(root, "reth_logo.txt")));
    File memory reth = File(rethFile, offset, offset + rethFile.length);
    offset += rethFile.length;
    files[bytes4(keccak256("rETH"))] = reth;
    bytes memory geistFile = bytes(vm.readFile(string.concat(root, "geist.txt")));
    File memory geist = File(geistFile, offset, offset + geistFile.length);
    offset += geistFile.length;
    files[bytes4(keccak256("geist"))] = geist;
}
```

### _storeFile()

- **Kind**: internal
- **Source**: 2441:448:274
- **Link**: `test/TestContracts/MetadataDeployment.sol:MetadataDeployment:_storeFile()`

```solidity
function _storeFile() internal {
    bytes memory data = bytes.concat(files[bytes4(keccak256("BOLD"))].data, files[bytes4(keccak256("WETH"))].data, files[bytes4(keccak256("wstETH"))].data, files[bytes4(keccak256("rETH"))].data, files[bytes4(keccak256("geist"))].data);
    pointer = SSTORE2.write(data);
}
```

### write(bytes)

- **Kind**: internal
- **Source**: 2052:1785:2
- **Link**: `lib/Solady/src/utils/SSTORE2.sol:SSTORE2:write(bytes)`

```solidity
/// @dev Writes `data` into the bytecode of a storage contract and returns its address.
function write(bytes memory data) internal returns (address pointer) {
    /// @solidity memory-safe-assembly
    assembly {
        let n := mload(data)
        mstore(add(data, gt(n, 0xfffe)), add(0xfe61000180600a3d393df300, shl(0x40, n)))
        pointer := create(0, add(data, 0x15), add(n, 0xb))
        if iszero(pointer) {
            mstore(0x00, 0x30116425)
            revert(0x1c, 0x04)
        }
        mstore(data, n)
    }
}
```

### _deployFixedAssetReader(bytes32)

- **Kind**: internal
- **Source**: 2895:1371:274
- **Link**: `test/TestContracts/MetadataDeployment.sol:MetadataDeployment:_deployFixedAssetReader(bytes32)`

```solidity
function _deployFixedAssetReader(bytes32 _salt) internal {
    bytes4[] memory sigs = new bytes4[](5);
    sigs[0] = bytes4(keccak256("BOLD"));
    sigs[1] = bytes4(keccak256("WETH"));
    sigs[2] = bytes4(keccak256("wstETH"));
    sigs[3] = bytes4(keccak256("rETH"));
    sigs[4] = bytes4(keccak256("geist"));
    FixedAssetReader.Asset[] memory FixedAssets = new FixedAssetReader.Asset[](5);
    FixedAssets[0] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("BOLD"))].start), uint128(files[bytes4(keccak256("BOLD"))].end));
    FixedAssets[1] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("WETH"))].start), uint128(files[bytes4(keccak256("WETH"))].end));
    FixedAssets[2] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("wstETH"))].start), uint128(files[bytes4(keccak256("wstETH"))].end));
    FixedAssets[3] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("rETH"))].start), uint128(files[bytes4(keccak256("rETH"))].end));
    FixedAssets[4] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("geist"))].start), uint128(files[bytes4(keccak256("geist"))].end));
    initializedFixedAssetReader = new FixedAssetReader{salt: _salt}(pointer, sigs, FixedAssets);
}
```

## External Calls

- **unknown::unknown**

## State Variable Reads

- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]
- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)

## State Variable Writes

- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)
- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MetadataDeployment.deployMetadata(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MetadataDeployment._loadFiles() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MetadataDeployment._storeFile() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SSTORE2.write(bytes) (NodeID: 3)
  │     💬 Args: [data]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MetadataDeployment._deployFixedAssetReader(bytes32) (NodeID: 4)
      💬 Args: [_salt]
      👁️  Def: internal
```
