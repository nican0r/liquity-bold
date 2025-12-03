# Function: getTotalVotesAndState()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `getTotalVotesAndState()`
- **Visibility**: external
- **Source Range**: 6515:234:110

## Implementation

```solidity
function getTotalVotesAndState() override external view returns (VoteSnapshot memory snapshot, GlobalState memory state, bool shouldUpdate) {
    return governance.getTotalVotesAndState();
}
```

## External Calls

- **Governance::getTotalVotesAndState()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.getTotalVotesAndState() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Return the most up to date global snapshot and state as well as a flag to notify whether the state can be updated
 This is a convenience function to always retrieve the most up to date state values
