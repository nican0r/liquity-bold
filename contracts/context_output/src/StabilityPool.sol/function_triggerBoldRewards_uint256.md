# Function: triggerBoldRewards(uint256)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `triggerBoldRewards(uint256)`
- **Visibility**: external
- **Source Range**: 15696:146:187

## Implementation

```solidity
function triggerBoldRewards(uint256 _boldYield) external {
    _requireCallerIsActivePool();
    _updateYieldRewardsSum(_boldYield);
}
```

## Related Implementations

### _requireCallerIsActivePool()

- **Kind**: internal
- **Source**: 25797:154:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireCallerIsActivePool()`

```solidity
function _requireCallerIsActivePool() internal view {
    require(msg.sender == address(activePool), "StabilityPool: Caller is not ActivePool");
}
```

### _updateYieldRewardsSum(uint256)

- **Kind**: internal
- **Source**: 15848:734:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateYieldRewardsSum(uint256)`

```solidity
function _updateYieldRewardsSum(uint256 _newYield) internal {
    uint256 accumulatedYieldGains = yieldGainsPending + _newYield;
    if (accumulatedYieldGains == 0) return;
    if (totalBoldDeposits < MIN_BOLD_IN_SP) {
        yieldGainsPending = accumulatedYieldGains;
        return;
    }
    yieldGainsOwed += accumulatedYieldGains;
    yieldGainsPending = 0;
    scaleToB[currentScale] += (P * accumulatedYieldGains) / totalBoldDeposits;
    emit B_Updated(scaleToB[currentScale], currentScale);
}
```

## State Variable Reads

- **yieldGainsPending** (`uint256`)
- **totalBoldDeposits** (`uint256`)
- **currentScale** (`uint256`)
- **P** (`uint256`)
- **scaleToB** (`mapping(uint256 => uint256)`)

## State Variable Writes

- **yieldGainsPending** (`uint256`)
- **yieldGainsOwed** (`uint256`)
- **scaleToB** (`mapping(uint256 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.triggerBoldRewards(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireCallerIsActivePool() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StabilityPool._updateYieldRewardsSum(uint256) (NodeID: 2)
      💬 Args: [_boldYield]
      👁️  Def: internal
```
