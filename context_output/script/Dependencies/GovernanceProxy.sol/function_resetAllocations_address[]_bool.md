# Function: resetAllocations(address[],bool)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `resetAllocations(address[],bool)`
- **Visibility**: external
- **Source Range**: 8863:167:110

## Implementation

```solidity
function resetAllocations(address[] calldata _initiativesToReset, bool _checkAll) external {
    governance.resetAllocations(_initiativesToReset, _checkAll);
}
```

## External Calls

- **Governance::resetAllocations(address[],bool)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.resetAllocations(address[],bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Deallocates the user's LQTY from initiatives
 @param _initiativesToReset Addresses of initiatives to deallocate LQTY from
 @param _checkAll When true, the call will revert if there is still some allocated LQTY left after deallocating
                  from all the addresses in `_initiativesToReset`
