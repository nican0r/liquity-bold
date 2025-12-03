# Function: getDepositorYieldGainWithPending(address)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getDepositorYieldGainWithPending(address)`
- **Visibility**: external
- **Source Range**: 21759:1259:187

## Implementation

```solidity
function getDepositorYieldGainWithPending(address _depositor) override external view returns (uint256) {
    if (totalBoldDeposits < MIN_BOLD_IN_SP) return 0;
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots storage snapshots = depositSnapshots[_depositor];
    uint256 newYieldGainsOwed = yieldGainsOwed;
    uint256 normalizedGains = scaleToB[snapshots.scale] - snapshots.B;
    for (uint256 i = 1; i <= SCALE_SPAN; ++i) {
        normalizedGains += scaleToB[snapshots.scale + i] / (SCALE_FACTOR ** i);
    }
    uint256 pendingSPYield = activePool.calcPendingSPYield();
    newYieldGainsOwed += pendingSPYield;
    if (currentScale <= (snapshots.scale + SCALE_SPAN)) {
        normalizedGains += ((P * pendingSPYield) / totalBoldDeposits) / (SCALE_FACTOR ** (currentScale - snapshots.scale));
    }
    return LiquityMath._min((initialDeposit * normalizedGains) / snapshots.P, newYieldGainsOwed);
}
```

## Related Implementations

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

## External Calls

- **IActivePool::calcPendingSPYield()**

## State Variable Reads

- **totalBoldDeposits** (`uint256`)
- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **yieldGainsOwed** (`uint256`)
- **scaleToB** (`mapping(uint256 => uint256)`)
- **SCALE_SPAN** (`uint256`)
- **SCALE_FACTOR** (`uint256`)
- **currentScale** (`uint256`)
- **P** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getDepositorYieldGainWithPending(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 1)
      💬 Args: [(initialDeposit * normalizedGains) / snapshots.P, newYieldGainsOwed]
      👁️  Def: internal
```
