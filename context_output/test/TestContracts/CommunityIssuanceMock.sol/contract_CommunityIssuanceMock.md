# Contract: CommunityIssuanceMock

## Metadata

- **Name**: CommunityIssuanceMock
- **Type**: Contract
- **Path**: test/TestContracts/CommunityIssuanceMock.sol

## Public/External Functions

### setAddresses(address,address)

- **Signature**: `setAddresses(address,address)`
- **Visibility**: external
- **Source Range**: 95:91:259
- **Details**: [function_setAddresses_address_address.md](./function_setAddresses_address_address.md)

**Signature:**
```solidity
function setAddresses(address _lqtyTokenAddress, address _stabilityPoolAddress) external;
```

### issueLQTY()

- **Signature**: `issueLQTY()`
- **Visibility**: external
- **Source Range**: 192:50:259
- **Details**: [function_issueLQTY.md](./function_issueLQTY.md)

**Signature:**
```solidity
function issueLQTY() external returns (uint256);
```

### sendLQTY(address,uint256)

- **Signature**: `sendLQTY(address,uint256)`
- **Visibility**: external
- **Source Range**: 248:68:259
- **Details**: [function_sendLQTY_address_uint256.md](./function_sendLQTY_address_uint256.md)

**Signature:**
```solidity
function sendLQTY(address _account, uint256 _LQTYamount) external;
```
