# Function: claimFromStakingV1(address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `claimFromStakingV1(address)`
- **Visibility**: external
- **Source Range**: 5367:215:110

## Implementation

```solidity
function claimFromStakingV1(address _rewardRecipient) override external returns (uint256 lusdSent, uint256 ethSent) {
    return governance.claimFromStakingV1(_rewardRecipient);
}
```

## External Calls

- **Governance::claimFromStakingV1(address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.claimFromStakingV1(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Claims staking rewards from StakingV1 without unstaking
 @dev Note: in the unlikely event that the caller's `UserProxy` holds any LQTY tokens, they will also be sent to `_rewardRecipient`
 @param _rewardRecipient Address that will receive the rewards
 @return lusdSent Amount of LUSD tokens sent to `_rewardRecipient` (may include previously received LUSD)
 @return ethSent Amount of ETH sent to `_rewardRecipient` (may include previously received ETH)
