# Function: registerInitiative(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `registerInitiative(address)`
- **Visibility**: external
- **Source Range**: 8259:126:110

## Implementation

```solidity
function registerInitiative(address _initiative) override external {
    governance.registerInitiative(_initiative);
}
```

## External Calls

- **Governance::registerInitiative(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.registerInitiative(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Registers a new initiative
 @param _initiative Address of the initiative
