# Function: snapshotVotesForInitiative(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `snapshotVotesForInitiative(address)`
- **Visibility**: external
- **Source Range**: 7265:274:110

## Implementation

```solidity
function snapshotVotesForInitiative(address _initiative) override external returns (VoteSnapshot memory voteSnapshot, InitiativeVoteSnapshot memory initiativeVoteSnapshot) {
    return governance.snapshotVotesForInitiative(_initiative);
}
```

## External Calls

- **Governance::snapshotVotesForInitiative(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.snapshotVotesForInitiative(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Snapshots votes for the previous epoch and accrues funds for the current epoch
 @param _initiative Address of the initiative
 @return voteSnapshot Vote snapshot
 @return initiativeVoteSnapshot Vote snapshot of the initiative
