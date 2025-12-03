# Function: globalState()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `globalState()`
- **Visibility**: external
- **Source Range**: 3771:155:110

## Implementation

```solidity
function globalState() override external view returns (uint256 countedVoteLQTY, uint256 countedVoteOffset) {
    return governance.globalState();
}
```

## External Calls

- **Governance::globalState()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.globalState() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the global state
 @return countedVoteLQTY Total LQTY that is included in vote counting
 @return countedVoteOffset Offset associated with countedVoteLQTY
