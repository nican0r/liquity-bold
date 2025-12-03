# Function: VOTING_THRESHOLD_FACTOR()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `VOTING_THRESHOLD_FACTOR()`
- **Visibility**: external
- **Source Range**: 2540:136:110

## Implementation

```solidity
function VOTING_THRESHOLD_FACTOR() override external view returns (uint256) {
    return governance.VOTING_THRESHOLD_FACTOR();
}
```

## External Calls

- **Governance::VOTING_THRESHOLD_FACTOR()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.VOTING_THRESHOLD_FACTOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Share of all votes that are necessary for an initiative to be included in the vote count
 @return votingThresholdFactor Voting threshold factor
