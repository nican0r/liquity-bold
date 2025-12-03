# Function: withdrawColl(address,uint256,uint256)

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `withdrawColl(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 13003:218:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function withdrawColl(address _account, uint256 _troveId, uint256 _collDecrease) public {
    vm.startPrank(_account);
    borrowerOperations.withdrawColl(_troveId, _collDecrease);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::withdrawColl(uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.withdrawColl(address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
