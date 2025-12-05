# Function: userProxyImplementation()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `userProxyImplementation()`
- **Visibility**: external
- **Source Range**: 9201:136:110

## Implementation

```solidity
function userProxyImplementation() override external view returns (address) {
    return governance.userProxyImplementation();
}
```

## External Calls

- **Governance::userProxyImplementation()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.userProxyImplementation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Address of the UserProxy implementation contract
 @return implementation Address of the UserProxy implementation contract
