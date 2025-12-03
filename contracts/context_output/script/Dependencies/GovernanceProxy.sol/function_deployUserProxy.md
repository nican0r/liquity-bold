# Function: deployUserProxy()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `deployUserProxy()`
- **Visibility**: external
- **Source Range**: 9501:132:110

## Implementation

```solidity
function deployUserProxy() override external returns (address userProxyAddress) {
    return governance.deployUserProxy();
}
```

## External Calls

- **Governance::deployUserProxy()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.deployUserProxy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Deploy a new UserProxy contract for the sender
 @return userProxyAddress Address of the deployed UserProxy contract
