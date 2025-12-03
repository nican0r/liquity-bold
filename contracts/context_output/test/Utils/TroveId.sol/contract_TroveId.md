# Contract: TroveId

## Metadata

- **Name**: TroveId
- **Type**: Contract
- **Path**: test/Utils/TroveId.sol

## Public/External Functions

### addressToTroveId(address,address,uint256)

- **Signature**: `addressToTroveId(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 81:194:294
- **Details**: [function_addressToTroveId_address_address_uint256.md](./function_addressToTroveId_address_address_uint256.md)

**Signature:**
```solidity
function addressToTroveId(address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveId(address,uint256)

- **Signature**: `addressToTroveId(address,uint256)`
- **Visibility**: public
- **Source Range**: 281:162:294
- **Details**: [function_addressToTroveId_address_uint256.md](./function_addressToTroveId_address_uint256.md)

**Signature:**
```solidity
function addressToTroveId(address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveId(address)

- **Signature**: `addressToTroveId(address)`
- **Visibility**: public
- **Source Range**: 449:123:294
- **Details**: [function_addressToTroveId_address.md](./function_addressToTroveId_address.md)

**Signature:**
```solidity
function addressToTroveId(address _owner) public pure returns (uint256);
```

### addressToTroveIdThroughZapper(address,address,address,uint256)

- **Signature**: `addressToTroveIdThroughZapper(address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 578:324:294
- **Details**: [function_addressToTroveIdThroughZapper_address_address_address_uint256.md](./function_addressToTroveIdThroughZapper_address_address_address_uint256.md)

**Signature:**
```solidity
function addressToTroveIdThroughZapper(address _zapper, address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveIdThroughZapper(address,address,uint256)

- **Signature**: `addressToTroveIdThroughZapper(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 908:242:294
- **Details**: [function_addressToTroveIdThroughZapper_address_address_uint256.md](./function_addressToTroveIdThroughZapper_address_address_uint256.md)

**Signature:**
```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveIdThroughZapper(address,address)

- **Signature**: `addressToTroveIdThroughZapper(address,address)`
- **Visibility**: public
- **Source Range**: 1156:175:294
- **Details**: [function_addressToTroveIdThroughZapper_address_address.md](./function_addressToTroveIdThroughZapper_address_address.md)

**Signature:**
```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner) public pure returns (uint256);
```
