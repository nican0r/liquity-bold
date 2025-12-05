# Function: getLatestVotingThreshold()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `getLatestVotingThreshold()`
- **Visibility**: external
- **Source Range**: 7121:138:110

## Implementation

```solidity
function getLatestVotingThreshold() override external view returns (uint256) {
    return governance.getLatestVotingThreshold();
}
```

## External Calls

- **Governance::getLatestVotingThreshold()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.getLatestVotingThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Voting threshold is the max. of either:
   - 4% of the total voting LQTY in the previous epoch
   - or the minimum number of votes necessary to claim at least MIN_CLAIM BOLD
 This value can be offsynch, use the non view `calculateVotingThreshold` to always retrieve the most up to date value
 @return votingThreshold Voting threshold
