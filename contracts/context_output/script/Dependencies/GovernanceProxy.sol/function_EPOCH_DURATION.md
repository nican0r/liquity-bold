# Function: EPOCH_DURATION()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `EPOCH_DURATION()`
- **Visibility**: external
- **Source Range**: 1460:118:110

## Implementation

```solidity
function EPOCH_DURATION() override external view returns (uint256) {
    return governance.EPOCH_DURATION();
}
```

## External Calls

- **Governance::EPOCH_DURATION()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.EPOCH_DURATION() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Duration of an epoch in seconds (e.g. 1 week)
 @return epochDuration Epoch duration
