# Function: allocateLQTY(address[],address[],int256[],int256[])

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `allocateLQTY(address[],address[],int256[],int256[])`
- **Visibility**: external
- **Source Range**: 8527:330:110

## Implementation

```solidity
function allocateLQTY(address[] calldata _resetInitiatives, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory absoluteLQTYVetos) override external {
    governance.allocateLQTY(_resetInitiatives, _initiatives, _absoluteLQTYVotes, absoluteLQTYVetos);
}
```

## External Calls

- **Governance::allocateLQTY(address[],address[],int256[],int256[])**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.allocateLQTY(address[],address[],int256[],int256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Allocates the user's LQTY to initiatives
 @dev The user can only allocate to active initiatives (older than 1 epoch) and has to have enough unallocated
 LQTY available, the initiatives listed must be unique, and towards the end of the epoch a user can only maintain or reduce their votes
 @param _initiativesToReset Addresses of the initiatives the caller was previously allocated to, must be reset to prevent desynch of voting power
 @param _initiatives Addresses of the initiatives to allocate to, can match or be different from `_resetInitiatives`
 @param _absoluteLQTYVotes LQTY to allocate to the initiatives as votes
 @param _absoluteLQTYVetos LQTY to allocate to the initiatives as vetos
