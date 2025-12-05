# Function: depositLQTY(uint256,bool,address)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `depositLQTY(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 4556:181:110

## Implementation

```solidity
function depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) override external {
    governance.depositLQTY(_lqtyAmount, _doSendRewards, _recipient);
}
```

## External Calls

- **Governance::depositLQTY(uint256,bool,address)**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.depositLQTY(uint256,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Deposits LQTY
 @dev The caller has to approve their `UserProxy` address to spend the LQTY tokens
 @param _lqtyAmount Amount of LQTY to deposit
 @param _doSendRewards If true, send rewards claimed from LQTY staking
 @param _recipient Address to which the tokens should be sent
