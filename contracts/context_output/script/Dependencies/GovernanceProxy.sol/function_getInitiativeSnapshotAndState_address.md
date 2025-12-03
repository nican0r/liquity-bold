# Function: getInitiativeSnapshotAndState(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `getInitiativeSnapshotAndState(address)`
- **Visibility**: external
- **Source Range**: 6755:360:110

## Implementation

```solidity
function getInitiativeSnapshotAndState(address _initiative) override external view returns (InitiativeVoteSnapshot memory initiativeSnapshot, InitiativeState memory initiativeState, bool shouldUpdate) {
    return governance.getInitiativeSnapshotAndState(_initiative);
}
```

## External Calls

- **Governance::getInitiativeSnapshotAndState(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.getInitiativeSnapshotAndState(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@dev Given an initiative address, return it's most up to date snapshot and state as well as a flag to notify whether the state can be updated
 This is a convenience function to always retrieve the most up to date state values
