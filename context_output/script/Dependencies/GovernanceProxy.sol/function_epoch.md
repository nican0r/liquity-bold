# Function: epoch()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `epoch()`
- **Visibility**: external
- **Source Range**: 5588:100:110

## Implementation

```solidity
function epoch() override external view returns (uint256) {
    return governance.epoch();
}
```

## External Calls

- **Governance::epoch()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.epoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the current epoch number
 @return epoch Current epoch
