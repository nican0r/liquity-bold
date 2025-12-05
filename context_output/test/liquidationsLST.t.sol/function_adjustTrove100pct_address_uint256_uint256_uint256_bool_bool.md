# Function: adjustTrove100pct(address,uint256,uint256,uint256,bool,bool)

**Contract**: [test/liquidationsLST.t.sol/contract_LiquidationsLSTTest.md]

## Metadata

- **Contract**: LiquidationsLSTTest
- **Signature**: `adjustTrove100pct(address,uint256,uint256,uint256,bool,bool)`
- **Visibility**: public
- **Source Range**: 9187:605:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function adjustTrove100pct(address _account, uint256 _troveId, uint256 _collChange, uint256 _boldChange, bool _isCollIncrease, bool _isDebtIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, predictAdjustTroveUpfrontFee(_troveId, _isDebtIncrease ? _boldChange : 0));
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
- **IBorrowerOperationsTester::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.adjustTrove100pct(address,uint256,uint256,uint256,bool,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [_troveId, _isDebtIncrease ? _boldChange : 0]
      👁️  Def: internal
```
