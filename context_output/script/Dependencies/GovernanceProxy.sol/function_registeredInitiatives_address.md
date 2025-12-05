# Function: registeredInitiatives(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `registeredInitiatives(address)`
- **Visibility**: external
- **Source Range**: 4262:170:110

## Implementation

```solidity
function registeredInitiatives(address _initiative) override external view returns (uint256 atEpoch) {
    return governance.registeredInitiatives(_initiative);
}
```

## External Calls

- **Governance::registeredInitiatives(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.registeredInitiatives(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns when an initiative was registered
 @param _initiative Address of the initiative
 @return atEpoch If `_initiative` is an active initiative, returns the epoch at which it was registered.
                 If `_initiative` hasn't been registered, returns 0.
                 If `_initiative` has been unregistered, returns `UNREGISTERED_INITIATIVE`.
