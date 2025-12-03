# Function: lqtyAllocatedByUserToInitiative(address,address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `lqtyAllocatedByUserToInitiative(address,address)`
- **Visibility**: external
- **Source Range**: 3932:324:110

## Implementation

```solidity
function lqtyAllocatedByUserToInitiative(address _user, address _initiative) override external view returns (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, uint256 atEpoch) {
    return governance.lqtyAllocatedByUserToInitiative(_user, _initiative);
}
```

## External Calls

- **Governance::lqtyAllocatedByUserToInitiative(address,address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.lqtyAllocatedByUserToInitiative(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the amount of voting and vetoing LQTY a user allocated to an initiative
 @param _user Address of the user
 @param _initiative Address of the initiative
 @return voteLQTY LQTY allocated vouching for the initiative
 @return voteOffset The offset associated with voteLQTY
 @return vetoLQTY allocated vetoing the initiative
 @return vetoOffset the offset associated with vetoLQTY
 @return atEpoch Epoch at which the allocation was last updated
