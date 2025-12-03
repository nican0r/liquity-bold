# Function: stakingV1()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `stakingV1()`
- **Visibility**: external
- **Source Range**: 1223:113:110

## Implementation

```solidity
function stakingV1() override external view returns (ILQTYStaking) {
    return governance.stakingV1();
}
```

## External Calls

- **Governance::stakingV1()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.stakingV1() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Address of the LQTY StakingV1 contract
 @return stakingV1 Address of the LQTY StakingV1 contract
