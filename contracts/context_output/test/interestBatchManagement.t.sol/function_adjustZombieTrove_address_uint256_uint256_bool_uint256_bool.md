# Function: adjustZombieTrove(address,uint256,uint256,bool,uint256,bool)

**Contract**: [test/interestBatchManagement.t.sol/contract_InterestBatchManagementTest.md]

## Metadata

- **Contract**: InterestBatchManagementTest
- **Signature**: `adjustZombieTrove(address,uint256,uint256,bool,uint256,bool)`
- **Visibility**: public
- **Source Range**: 9798:669:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function adjustZombieTrove(address _account, uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.adjustZombieTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, 0, 0, predictAdjustTroveUpfrontFee(_troveId, _isDebtIncrease ? _boldChange : 0));
    vm.stopPrank();
}
```

## Related Implementations

### predictAdjustTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 4277:199:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustTroveUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustTroveUpfrontFee(uint256 troveId, uint256 debtIncrease) internal view returns (uint256) {
    return hintHelpers.predictAdjustTroveUpfrontFee(0, troveId, debtIncrease);
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.adjustZombieTrove(address,uint256,uint256,bool,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [_troveId, _isDebtIncrease ? _boldChange : 0]
      👁️  Def: internal
```
