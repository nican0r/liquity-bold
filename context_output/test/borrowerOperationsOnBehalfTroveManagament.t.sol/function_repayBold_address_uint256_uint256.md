# Function: repayBold(address,uint256,uint256)

**Contract**: [test/borrowerOperationsOnBehalfTroveManagament.t.sol/contract_BorrowerOperationsOnBehalfTroveManagamentTest.md]

## Metadata

- **Contract**: BorrowerOperationsOnBehalfTroveManagamentTest
- **Signature**: `repayBold(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 12571:212:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function repayBold(address _account, uint256 _troveId, uint256 _debtDecrease) public {
    vm.startPrank(_account);
    borrowerOperations.repayBold(_troveId, _debtDecrease);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::repayBold(uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.repayBold(address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
