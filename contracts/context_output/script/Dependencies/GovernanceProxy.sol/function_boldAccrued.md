# Function: boldAccrued()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `boldAccrued()`
- **Visibility**: external
- **Source Range**: 2682:112:110

## Implementation

```solidity
function boldAccrued() override external view returns (uint256) {
    return governance.boldAccrued();
}
```

## External Calls

- **Governance::boldAccrued()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.boldAccrued() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the amount of BOLD accrued since last epoch (last snapshot)
 @return boldAccrued BOLD accrued
