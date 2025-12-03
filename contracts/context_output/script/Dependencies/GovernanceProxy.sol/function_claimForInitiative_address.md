# Function: claimForInitiative(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `claimForInitiative(address)`
- **Visibility**: external
- **Source Range**: 9036:159:110

## Implementation

```solidity
function claimForInitiative(address _initiative) override external returns (uint256 claimed) {
    return governance.claimForInitiative(_initiative);
}
```

## External Calls

- **Governance::claimForInitiative(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.claimForInitiative(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Splits accrued funds according to votes received between all initiatives
 @param _initiative Addresse of the initiative
 @return claimed Amount of BOLD claimed
