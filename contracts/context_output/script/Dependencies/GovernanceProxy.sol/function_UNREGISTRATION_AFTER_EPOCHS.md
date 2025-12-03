# Function: UNREGISTRATION_AFTER_EPOCHS()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `UNREGISTRATION_AFTER_EPOCHS()`
- **Visibility**: external
- **Source Range**: 2390:144:110

## Implementation

```solidity
function UNREGISTRATION_AFTER_EPOCHS() override external view returns (uint256) {
    return governance.UNREGISTRATION_AFTER_EPOCHS();
}
```

## External Calls

- **Governance::UNREGISTRATION_AFTER_EPOCHS()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.UNREGISTRATION_AFTER_EPOCHS() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Number of epochs an initiative has to be inactive before it can be unregistered
 @return unregistrationAfterEpochs Number of epochs
