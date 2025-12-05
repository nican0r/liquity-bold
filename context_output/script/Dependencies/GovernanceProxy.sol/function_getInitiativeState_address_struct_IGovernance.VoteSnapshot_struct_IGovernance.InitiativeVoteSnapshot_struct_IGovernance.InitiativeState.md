# Function: getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 7795:458:110

## Implementation

```solidity
function getInitiativeState(address _initiative, VoteSnapshot memory _votesSnapshot, InitiativeVoteSnapshot memory _votesForInitiativeSnapshot, InitiativeState memory _initiativeState) override external view returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount) {
    return governance.getInitiativeState(_initiative, _votesSnapshot, _votesForInitiativeSnapshot, _initiativeState);
}
```

## External Calls

- **Governance::getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
