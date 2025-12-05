# Function: lqtyToVotes(uint256,uint256,uint256)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `lqtyToVotes(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5942:264:110

## Implementation

```solidity
function lqtyToVotes(uint256 _lqtyAmount, uint256 _timestamp, uint256 _offset) override external pure returns (uint256) {
    uint256 prod = _lqtyAmount * _timestamp;
    return (prod > _offset) ? (prod - _offset) : 0;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.lqtyToVotes(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the voting power for an entity (i.e. user or initiative) at a given timestamp
 @param _lqtyAmount Amount of LQTY associated with the entity
 @param _timestamp Timestamp at which to calculate voting power
 @param _offset The entity's offset sum
 @return votes Number of votes
