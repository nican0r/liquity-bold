# Function: claimAllCollGains()

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `claimAllCollGains()`
- **Visibility**: external
- **Source Range**: 15181:471:187

## Implementation

```solidity
function claimAllCollGains() external {
    _requireUserHasNoDeposit(msg.sender);
    activePool.mintAggInterest();
    uint256 collToSend = stashedColl[msg.sender];
    _requireNonZeroAmount(collToSend);
    stashedColl[msg.sender] = 0;
    emit DepositOperation(msg.sender, Operation.claimAllCollGains, 0, 0, 0, 0, 0, collToSend);
    emit DepositUpdated(msg.sender, 0, 0, 0, 0, 0, 0);
    _sendCollGainToDepositor(collToSend);
}
```

## Related Implementations

### _requireUserHasNoDeposit(address)

- **Kind**: internal
- **Source**: 26297:221:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireUserHasNoDeposit(address)`

```solidity
function _requireUserHasNoDeposit(address _address) internal view {
    uint256 initialDeposit = deposits[_address].initialValue;
    require(initialDeposit == 0, "StabilityPool: User must have no deposit");
}
```

### _requireNonZeroAmount(uint256)

- **Kind**: internal
- **Source**: 26524:141:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireNonZeroAmount(uint256)`

```solidity
function _requireNonZeroAmount(uint256 _amount) internal pure {
    require(_amount > 0, "StabilityPool: Amount must be non-zero");
}
```

### _sendCollGainToDepositor(uint256)

- **Kind**: internal
- **Source**: 24029:327:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_sendCollGainToDepositor(uint256)`

```solidity
function _sendCollGainToDepositor(uint256 _collAmount) internal {
    if (_collAmount == 0) return;
    uint256 newCollBalance = collBalance - _collAmount;
    collBalance = newCollBalance;
    emit StabilityPoolCollBalanceUpdated(newCollBalance);
    collToken.safeTransfer(msg.sender, _collAmount);
}
```

## External Calls

- **IActivePool::mintAggInterest()**

## State Variable Reads

- **stashedColl** (`mapping(address => uint256)`)
- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **collBalance** (`uint256`)
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **stashedColl** (`mapping(address => uint256)`)
- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.claimAllCollGains() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireUserHasNoDeposit(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireNonZeroAmount(uint256) (NodeID: 2)
  │   💬 Args: [collToSend]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StabilityPool._sendCollGainToDepositor(uint256) (NodeID: 3)
      💬 Args: [collToSend]
      👁️  Def: internal
```
