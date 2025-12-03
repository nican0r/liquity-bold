# Function: userStates(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `userStates(address)`
- **Visibility**: external
- **Source Range**: 3225:255:110

## Implementation

```solidity
function userStates(address _user) override external view returns (uint256 unallocatedLQTY, uint256 unallocatedOffset, uint256 allocatedLQTY, uint256 allocatedOffset) {
    return governance.userStates(_user);
}
```

## External Calls

- **Governance::userStates(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.userStates(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the user's state
 @return unallocatedLQTY LQTY deposited and unallocated
 @return unallocatedOffset Offset associated with unallocated LQTY
 @return allocatedLQTY allocated by the user to initatives
 @return allocatedOffset Offset associated with allocated LQTY
