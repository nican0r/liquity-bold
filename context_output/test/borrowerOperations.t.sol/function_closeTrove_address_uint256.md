# Function: closeTrove(address,uint256)

**Contract**: [test/borrowerOperations.t.sol/contract_BorrowerOperationsTest.md]

## Metadata

- **Contract**: BorrowerOperationsTest
- **Signature**: `closeTrove(address,uint256)`
- **Visibility**: public
- **Source Range**: 12104:176:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function closeTrove(address _account, uint256 _troveId) public {
    vm.startPrank(_account);
    borrowerOperations.closeTrove(_troveId);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::closeTrove(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.closeTrove(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
