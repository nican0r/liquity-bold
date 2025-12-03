# Interface: IVault

## Metadata

- **Name**: IVault
- **Type**: Interface
- **Path**: script/Interfaces/Balancer/IVault.sol

## Structs

### JoinPoolRequest

```solidity
struct JoinPoolRequest {
    IERC20[] assets;
    uint256[] maxAmountsIn;
    bytes userData;
    bool fromInternalBalance;
}
```

## Public/External Functions

### joinPool(bytes32,address,address,struct IVault.JoinPoolRequest)

- **Signature**: `joinPool(bytes32,address,address,struct IVault.JoinPoolRequest)`
- **Visibility**: external
- **Source Range**: 312:110:117

**Signature:**
```solidity
function joinPool(bytes32 poolId, address sender, address recipient, JoinPoolRequest memory request) external;;
```
