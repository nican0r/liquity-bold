# Function: makeSPWithdrawalNoClaim(address,uint256)

**Contract**: [test/TestContracts/BaseTest.sol/contract_BaseTest.md]

## Metadata

- **Contract**: BaseTest
- **Signature**: `makeSPWithdrawalNoClaim(address,uint256)`
- **Visibility**: public
- **Source Range**: 11740:193:254

## Implementation

```solidity
function makeSPWithdrawalNoClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.withdrawFromSP(_amount, false);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IStabilityPool::withdrawFromSP(uint256,bool)**
- **Vm::stopPrank()**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalNoClaim(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
