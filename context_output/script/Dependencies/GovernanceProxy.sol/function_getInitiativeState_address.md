# Function: getInitiativeState(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `getInitiativeState(address)`
- **Visibility**: external
- **Source Range**: 7545:244:110

## Implementation

```solidity
function getInitiativeState(address _initiative) override external returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount) {
    return governance.getInitiativeState(_initiative);
}
```

## External Calls

- **Governance::getInitiativeState(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.getInitiativeState(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
