# Contract: LQTYStakingMock

## Metadata

- **Name**: LQTYStakingMock
- **Type**: Contract
- **Path**: test/TestContracts/LQTYStakingMock.sol

## Public/External Functions

### setAddresses(address,address,address,address,address)

- **Signature**: `setAddresses(address,address,address,address,address)`
- **Visibility**: external
- **Source Range**: 89:227:271
- **Details**: [function_setAddresses_address_address_address_address_address.md](./function_setAddresses_address_address_address_address_address.md)

**Signature:**
```solidity
function setAddresses(address _lqtyTokenAddress, address _boldTokenAddress, address _troveManagerAddress, address _borrowerOperationsAddress, address _activePoolAddress) external;
```

### stake(uint256)

- **Signature**: `stake(uint256)`
- **Visibility**: external
- **Source Range**: 322:47:271
- **Details**: [function_stake_uint256.md](./function_stake_uint256.md)

**Signature:**
```solidity
function stake(uint256 _LQTYamount) external;
```

### unstake(uint256)

- **Signature**: `unstake(uint256)`
- **Visibility**: external
- **Source Range**: 375:49:271
- **Details**: [function_unstake_uint256.md](./function_unstake_uint256.md)

**Signature:**
```solidity
function unstake(uint256 _LQTYamount) external;
```

### increaseF_ETH(uint256)

- **Signature**: `increaseF_ETH(uint256)`
- **Visibility**: external
- **Source Range**: 430:51:271
- **Details**: [function_increaseF_ETH_uint256.md](./function_increaseF_ETH_uint256.md)

**Signature:**
```solidity
function increaseF_ETH(uint256 _ETHFee) external;
```

### increaseF_bold(uint256)

- **Signature**: `increaseF_bold(uint256)`
- **Visibility**: external
- **Source Range**: 487:53:271
- **Details**: [function_increaseF_bold_uint256.md](./function_increaseF_bold_uint256.md)

**Signature:**
```solidity
function increaseF_bold(uint256 _LQTYFee) external;
```

### getPendingETHGain(address)

- **Signature**: `getPendingETHGain(address)`
- **Visibility**: external
- **Source Range**: 546:76:271
- **Details**: [function_getPendingETHGain_address.md](./function_getPendingETHGain_address.md)

**Signature:**
```solidity
function getPendingETHGain(address _user) external view returns (uint256);
```

### getPendingBoldGain(address)

- **Signature**: `getPendingBoldGain(address)`
- **Visibility**: external
- **Source Range**: 628:77:271
- **Details**: [function_getPendingBoldGain_address.md](./function_getPendingBoldGain_address.md)

**Signature:**
```solidity
function getPendingBoldGain(address _user) external view returns (uint256);
```
