# Function: MIN_CLAIM()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `MIN_CLAIM()`
- **Visibility**: external
- **Source Range**: 1718:108:110

## Implementation

```solidity
function MIN_CLAIM() override external view returns (uint256) {
    return governance.MIN_CLAIM();
}
```

## External Calls

- **Governance::MIN_CLAIM()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.MIN_CLAIM() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Minimum BOLD amount that has to be claimed, if an initiative doesn't have enough votes to meet the
 criteria then it's votes a excluded from the vote count and distribution
 @return minClaim Minimum claim amount
