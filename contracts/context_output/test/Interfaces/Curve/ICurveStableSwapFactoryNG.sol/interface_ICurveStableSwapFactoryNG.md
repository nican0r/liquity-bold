# Interface: ICurveStableSwapFactoryNG

## Metadata

- **Name**: ICurveStableSwapFactoryNG
- **Type**: Interface
- **Path**: test/Interfaces/Curve/ICurveStableSwapFactoryNG.sol

## Public/External Functions

### deploy_plain_pool(string,string,address[],uint256,uint256,uint256,uint256,uint256,uint8[],bytes4[],address[])

- **Signature**: `deploy_plain_pool(string,string,address[],uint256,uint256,uint256,uint256,uint256,uint8[],bytes4[],address[])`
- **Visibility**: external
- **Source Range**: 100:423:236

**Signature:**
```solidity
function deploy_plain_pool(string calldata _name, string calldata _symbol, address[] calldata _coins, uint256 _A, uint256 _fee, uint256 _offpeg_fee_multiplier, uint256 _ma_exp_time, uint256 _implementation_idx, uint8[] calldata _asset_types, bytes4[] calldata _method_ids, address[] calldata _oracles) external returns (address);;
```

### deploy_gauge(address)

- **Signature**: `deploy_gauge(address)`
- **Visibility**: external
- **Source Range**: 529:64:236

**Signature:**
```solidity
function deploy_gauge(address _pool) external returns (address);;
```
