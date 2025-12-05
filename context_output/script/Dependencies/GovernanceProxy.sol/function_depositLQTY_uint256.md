# Function: depositLQTY(uint256)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `depositLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 4438:112:110

## Implementation

```solidity
function depositLQTY(uint256 _lqtyAmount) override external {
    governance.depositLQTY(_lqtyAmount);
}
```

## External Calls

- **Governance::depositLQTY(uint256)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.depositLQTY(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Deposits LQTY
 @dev The caller has to approve their `UserProxy` address to spend the LQTY tokens
 @param _lqtyAmount Amount of LQTY to deposit
