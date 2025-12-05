# Function: REGISTRATION_THRESHOLD_FACTOR()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `REGISTRATION_THRESHOLD_FACTOR()`
- **Visibility**: external
- **Source Range**: 2078:148:110

## Implementation

```solidity
function REGISTRATION_THRESHOLD_FACTOR() override external view returns (uint256) {
    return governance.REGISTRATION_THRESHOLD_FACTOR();
}
```

## External Calls

- **Governance::REGISTRATION_THRESHOLD_FACTOR()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.REGISTRATION_THRESHOLD_FACTOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Share of all votes that are necessary to register a new initiative
 @return registrationThresholdFactor Threshold factor
