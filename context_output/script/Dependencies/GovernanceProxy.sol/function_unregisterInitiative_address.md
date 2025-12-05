# Function: unregisterInitiative(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `unregisterInitiative(address)`
- **Visibility**: external
- **Source Range**: 8391:130:110

## Implementation

```solidity
function unregisterInitiative(address _initiative) override external {
    governance.unregisterInitiative(_initiative);
}
```

## External Calls

- **Governance::unregisterInitiative(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.unregisterInitiative(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
