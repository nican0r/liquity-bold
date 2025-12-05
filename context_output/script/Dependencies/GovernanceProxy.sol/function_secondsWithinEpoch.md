# Function: secondsWithinEpoch()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `secondsWithinEpoch()`
- **Visibility**: external
- **Source Range**: 5810:126:110

## Implementation

```solidity
function secondsWithinEpoch() override external view returns (uint256) {
    return governance.secondsWithinEpoch();
}
```

## External Calls

- **Governance::secondsWithinEpoch()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.secondsWithinEpoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the number of seconds that have gone by since the current epoch started
 @return secondsWithinEpoch Seconds within the current epoch
