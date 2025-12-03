# Function: withdrawBold100pct(address,uint256,uint256)

**Contract**: [test/liquidations.t.sol/contract_LiquidationsTest.md]

## Metadata

- **Contract**: LiquidationsTest
- **Signature**: `withdrawBold100pct(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 12286:279:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function withdrawBold100pct(address _account, uint256 _troveId, uint256 _debtIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.withdrawBold(_troveId, _debtIncrease, predictAdjustTroveUpfrontFee(_troveId, _debtIncrease));
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
- **IBorrowerOperationsTester::withdrawBold(uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.withdrawBold100pct(address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [_troveId, _debtIncrease]
      👁️  Def: internal
```
