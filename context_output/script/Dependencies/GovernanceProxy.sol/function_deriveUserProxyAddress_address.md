# Function: deriveUserProxyAddress(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `deriveUserProxyAddress(address)`
- **Visibility**: external
- **Source Range**: 9343:152:110

## Implementation

```solidity
function deriveUserProxyAddress(address _user) override external view returns (address) {
    return governance.deriveUserProxyAddress(_user);
}
```

## External Calls

- **Governance::deriveUserProxyAddress(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.deriveUserProxyAddress(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Derive the address of a user's proxy contract
 @param _user Address of the user
 @return userProxyAddress Address of the user's proxy contract
