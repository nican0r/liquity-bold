# Function: depositLQTYViaPermit(uint256,struct PermitParams,bool,address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `depositLQTYViaPermit(uint256,struct PermitParams,bool,address)`
- **Visibility**: external
- **Source Range**: 4893:159:110

## Implementation

```solidity
function depositLQTYViaPermit(uint256, PermitParams calldata, bool, address) override external pure {
    revert("GovernanceProxy: not-implemented");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.depositLQTYViaPermit(uint256,struct PermitParams,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Deposits LQTY via Permit
 @param _lqtyAmount Amount of LQTY to deposit
 @param _permitParams Permit parameters
 @param _doSendRewards If true, send rewards claimed from LQTY staking
 @param _recipient Address to which the tokens should be sent
