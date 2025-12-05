# Function: getShareofSPReward(address,uint256)

**Contract**: [test/liquidations.t.sol/contract_LiquidationsTest.md]

## Metadata

- **Contract**: LiquidationsTest
- **Signature**: `getShareofSPReward(address,uint256)`
- **Visibility**: public
- **Source Range**: 14174:218:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function getShareofSPReward(address _depositor, uint256 _reward) public view returns (uint256) {
    return (_reward * stabilityPool.getCompoundedBoldDeposit(_depositor)) / stabilityPool.getTotalBoldDeposits();
}
```

## External Calls

- **IStabilityPool::getCompoundedBoldDeposit(address)**
- **IStabilityPool::getTotalBoldDeposits()**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
