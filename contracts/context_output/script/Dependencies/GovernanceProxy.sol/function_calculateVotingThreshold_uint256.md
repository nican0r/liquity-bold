# Function: calculateVotingThreshold(uint256)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `calculateVotingThreshold(uint256)`
- **Visibility**: external
- **Source Range**: 6351:158:110

## Implementation

```solidity
function calculateVotingThreshold(uint256 _votes) override external view returns (uint256) {
    return governance.calculateVotingThreshold(_votes);
}
```

## External Calls

- **Governance::calculateVotingThreshold(uint256)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.calculateVotingThreshold(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@dev Utility function to compute the threshold votes without recomputing the snapshot
 Note that `boldAccrued` is a cached value, this function works correctly only when called after an accrual
