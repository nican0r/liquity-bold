# Interface: ILiquidityGaugeV6

## Metadata

- **Name**: ILiquidityGaugeV6
- **Type**: Interface
- **Path**: test/Interfaces/Curve/ILiquidityGaugeV6.sol

## Public/External Functions

### add_reward(address,address)

- **Signature**: `add_reward(address,address)`
- **Visibility**: external
- **Source Range**: 199:74:238

**Signature:**
```solidity
function add_reward(address _reward_token, address _distributor) external;;
```

### set_reward_distributor(address,address)

- **Signature**: `set_reward_distributor(address,address)`
- **Visibility**: external
- **Source Range**: 278:86:238

**Signature:**
```solidity
function set_reward_distributor(address _reward_token, address _distributor) external;;
```

### set_gauge_manager(address)

- **Signature**: `set_gauge_manager(address)`
- **Visibility**: external
- **Source Range**: 369:60:238

**Signature:**
```solidity
function set_gauge_manager(address _gauge_manager) external;;
```

### deposit_reward_token(address,uint256,uint256)

- **Signature**: `deposit_reward_token(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 434:95:238

**Signature:**
```solidity
function deposit_reward_token(address _reward_token, uint256 _amount, uint256 _epoch) external;;
```

### deposit(uint256)

- **Signature**: `deposit(uint256)`
- **Visibility**: external
- **Source Range**: 534:43:238

**Signature:**
```solidity
function deposit(uint256 _amount) external;;
```

### claim_rewards()

- **Signature**: `claim_rewards()`
- **Visibility**: external
- **Source Range**: 582:34:238

**Signature:**
```solidity
function claim_rewards() external;;
```

### lp_token()

- **Signature**: `lp_token()`
- **Visibility**: external
- **Source Range**: 621:59:238

**Signature:**
```solidity
function lp_token() external view returns (IERC20Metadata);;
```

### manager()

- **Signature**: `manager()`
- **Visibility**: external
- **Source Range**: 685:51:238

**Signature:**
```solidity
function manager() external view returns (address);;
```
