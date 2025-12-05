# Function: epochStart()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `epochStart()`
- **Visibility**: external
- **Source Range**: 5694:110:110

## Implementation

```solidity
function epochStart() override external view returns (uint256) {
    return governance.epochStart();
}
```

## External Calls

- **Governance::epochStart()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.epochStart() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the timestamp at which the current epoch started
 @return epochStart Epoch start of the current epoch
