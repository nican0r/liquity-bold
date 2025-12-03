# Function: getDepositorCollGain(address)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getDepositorCollGain(address)`
- **Visibility**: public
- **Source Range**: 20149:796:187

## Implementation

```solidity
function getDepositorCollGain(address _depositor) override public view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots storage snapshots = depositSnapshots[_depositor];
    uint256 normalizedGains = scaleToS[snapshots.scale] - snapshots.S;
    for (uint256 i = 1; i <= SCALE_SPAN; ++i) {
        normalizedGains += scaleToS[snapshots.scale + i] / (SCALE_FACTOR ** i);
    }
    return LiquityMath._min((initialDeposit * normalizedGains) / snapshots.P, collBalance);
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

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **scaleToS** (`mapping(uint256 => uint256)`)
- **SCALE_SPAN** (`uint256`)
- **SCALE_FACTOR** (`uint256`)
- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getDepositorCollGain(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 1)
      💬 Args: [(initialDeposit * normalizedGains) / snapshots.P, collBalance]
      👁️  Def: internal
```
