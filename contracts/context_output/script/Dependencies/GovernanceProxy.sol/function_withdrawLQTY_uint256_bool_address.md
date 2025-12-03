# Function: withdrawLQTY(uint256,bool,address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `withdrawLQTY(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 5178:183:110

## Implementation

```solidity
function withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) override external {
    governance.withdrawLQTY(_lqtyAmount, _doSendRewards, _recipient);
}
```

## External Calls

- **Governance::withdrawLQTY(uint256,bool,address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.withdrawLQTY(uint256,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Withdraws LQTY and claims any accrued LUSD and ETH rewards from StakingV1
 @param _lqtyAmount Amount of LQTY to withdraw
 @param _doSendRewards If true, send rewards claimed from LQTY staking
 @param _recipient Address to which the tokens should be sent
