# Function: getCompoundedBoldDeposit(address)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getCompoundedBoldDeposit(address)`
- **Visibility**: public
- **Source Range**: 23059:899:187

## Implementation

```solidity
function getCompoundedBoldDeposit(address _depositor) override public view returns (uint256 compoundedDeposit) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots storage snapshots = depositSnapshots[_depositor];
    uint256 scaleDiff = currentScale - snapshots.scale;
    if (scaleDiff <= MAX_SCALE_FACTOR_EXPONENT) {
        compoundedDeposit = ((initialDeposit * P) / snapshots.P) / (SCALE_FACTOR ** scaleDiff);
    } else {
        compoundedDeposit = 0;
    }
}
```

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **currentScale** (`uint256`)
- **MAX_SCALE_FACTOR_EXPONENT** (`uint256`)
- **P** (`uint256`)
- **SCALE_FACTOR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getCompoundedBoldDeposit(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
