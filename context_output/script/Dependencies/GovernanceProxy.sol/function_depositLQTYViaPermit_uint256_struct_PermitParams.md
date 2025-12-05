# Function: depositLQTYViaPermit(uint256,struct PermitParams)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `depositLQTYViaPermit(uint256,struct PermitParams)`
- **Visibility**: external
- **Source Range**: 4743:144:110

## Implementation

```solidity
function depositLQTYViaPermit(uint256, PermitParams calldata) override external pure {
    revert("GovernanceProxy: not-implemented");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.depositLQTYViaPermit(uint256,struct PermitParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Deposits LQTY via Permit
 @param _lqtyAmount Amount of LQTY to deposit
 @param _permitParams Permit parameters
