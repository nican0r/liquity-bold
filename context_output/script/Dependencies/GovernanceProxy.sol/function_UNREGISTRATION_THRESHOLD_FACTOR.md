# Function: UNREGISTRATION_THRESHOLD_FACTOR()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `UNREGISTRATION_THRESHOLD_FACTOR()`
- **Visibility**: external
- **Source Range**: 2232:152:110

## Implementation

```solidity
function UNREGISTRATION_THRESHOLD_FACTOR() override external view returns (uint256) {
    return governance.UNREGISTRATION_THRESHOLD_FACTOR();
}
```

## External Calls

- **Governance::UNREGISTRATION_THRESHOLD_FACTOR()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.UNREGISTRATION_THRESHOLD_FACTOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Multiple of the voting threshold in vetos that are necessary to unregister an initiative
 @return unregistrationThresholdFactor Unregistration threshold factor
