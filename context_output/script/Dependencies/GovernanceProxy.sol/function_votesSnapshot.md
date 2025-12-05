# Function: votesSnapshot()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `votesSnapshot()`
- **Visibility**: external
- **Source Range**: 2800:140:110

## Implementation

```solidity
function votesSnapshot() override external view returns (uint256 votes, uint256 forEpoch) {
    return governance.votesSnapshot();
}
```

## External Calls

- **Governance::votesSnapshot()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.votesSnapshot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the vote count snapshot of the previous epoch
 @return votes Number of votes
 @return forEpoch Epoch for which the votes are counted
