# Function: changeInterestRateNoHints(address,uint256,uint256)

**Contract**: [test/events.t.sol/contract_StabilityPoolEventsTest.md]

## Metadata

- **Contract**: StabilityPoolEventsTest
- **Signature**: `changeInterestRateNoHints(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 10473:420:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function changeInterestRateNoHints(address _account, uint256 _troveId, uint256 _newAnnualInterestRate) public returns (uint256 upfrontFee) {
    upfrontFee = predictAdjustInterestRateUpfrontFee(_troveId, _newAnnualInterestRate);
    vm.startPrank(_account);
    borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, 0, 0, upfrontFee);
    vm.stopPrank();
}
```

## Related Implementations

### predictAdjustInterestRateUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3761:247:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustInterestRateUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustInterestRateUpfrontFee(uint256 troveId, uint256 newInterestRate) internal view returns (uint256) {
    return hintHelpers.predictAdjustInterestRateUpfrontFee(0, troveId, newInterestRate);
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.changeInterestRateNoHints(address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.predictAdjustInterestRateUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [_troveId, _newAnnualInterestRate]
      👁️  Def: internal
```
