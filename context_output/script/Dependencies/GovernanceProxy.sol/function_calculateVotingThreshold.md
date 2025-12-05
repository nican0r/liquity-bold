# Function: calculateVotingThreshold()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `calculateVotingThreshold()`
- **Visibility**: external
- **Source Range**: 6212:133:110

## Implementation

```solidity
function calculateVotingThreshold() override external returns (uint256) {
    return governance.calculateVotingThreshold();
}
```

## External Calls

- **Governance::calculateVotingThreshold()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.calculateVotingThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@dev Returns the most up to date voting threshold
 In contrast to `getLatestVotingThreshold` this function updates the snapshot
 This ensures that the value returned is always the latest
