# Function: MIN_ACCRUAL()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `MIN_ACCRUAL()`
- **Visibility**: external
- **Source Range**: 1832:112:110

## Implementation

```solidity
function MIN_ACCRUAL() override external view returns (uint256) {
    return governance.MIN_ACCRUAL();
}
```

## External Calls

- **Governance::MIN_ACCRUAL()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.MIN_ACCRUAL() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Minimum amount of BOLD that have to be accrued for an epoch, otherwise accrual will be skipped for
 that epoch
 @return minAccrual Minimum amount of BOLD
