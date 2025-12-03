# Function: withdrawLQTY(uint256)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `withdrawLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 5058:114:110

## Implementation

```solidity
function withdrawLQTY(uint256 _lqtyAmount) override external {
    governance.withdrawLQTY(_lqtyAmount);
}
```

## External Calls

- **Governance::withdrawLQTY(uint256)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.withdrawLQTY(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Withdraws LQTY and claims any accrued LUSD and ETH rewards from StakingV1
 @param _lqtyAmount Amount of LQTY to withdraw
