# Function: EPOCH_VOTING_CUTOFF()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `EPOCH_VOTING_CUTOFF()`
- **Visibility**: external
- **Source Range**: 1584:128:110

## Implementation

```solidity
function EPOCH_VOTING_CUTOFF() override external view returns (uint256) {
    return governance.EPOCH_VOTING_CUTOFF();
}
```

## External Calls

- **Governance::EPOCH_VOTING_CUTOFF()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.EPOCH_VOTING_CUTOFF() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Voting period of an epoch in seconds (e.g. 6 days)
 @return epochVotingCutoff Epoch voting cutoff
