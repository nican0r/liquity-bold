# Function: initiativeStates(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `initiativeStates(address)`
- **Visibility**: external
- **Source Range**: 3486:279:110

## Implementation

```solidity
function initiativeStates(address _initiative) override external view returns (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, uint256 lastEpochClaim) {
    return governance.initiativeStates(_initiative);
}
```

## External Calls

- **Governance::initiativeStates(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.initiativeStates(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the initiative's state
 @param _initiative Address of the initiative
 @return voteLQTY LQTY allocated vouching for the initiative
 @return voteOffset Offset associated with voteLQTY
 @return vetoLQTY LQTY allocated vetoing the initiative
 @return vetoOffset Offset associated with vetoLQTY
 @return lastEpochClaim // Last epoch at which rewards were claimed
