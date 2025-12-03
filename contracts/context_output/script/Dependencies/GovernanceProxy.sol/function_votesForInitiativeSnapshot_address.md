# Function: votesForInitiativeSnapshot(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `votesForInitiativeSnapshot(address)`
- **Visibility**: external
- **Source Range**: 2946:273:110

## Implementation

```solidity
function votesForInitiativeSnapshot(address _initiative) override external view returns (uint256 votes, uint256 forEpoch, uint256 lastCountedEpoch, uint256 vetos) {
    return governance.votesForInitiativeSnapshot(_initiative);
}
```

## External Calls

- **Governance::votesForInitiativeSnapshot(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.votesForInitiativeSnapshot(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the vote count snapshot for an initiative of the previous epoch
 @param _initiative Address of the initiative
 @return votes Number of votes
 @return forEpoch Epoch for which the votes are counted
 @return lastCountedEpoch Epoch at which which the votes where counted last in the global snapshot
