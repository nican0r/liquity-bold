# Function: EPOCH_START()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `EPOCH_START()`
- **Visibility**: external
- **Source Range**: 1342:112:110

## Implementation

```solidity
function EPOCH_START() override external view returns (uint256) {
    return governance.EPOCH_START();
}
```

## External Calls

- **Governance::EPOCH_START()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.EPOCH_START() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Timestamp at which the first epoch starts
 @return epochStart Timestamp at which the first epoch starts
