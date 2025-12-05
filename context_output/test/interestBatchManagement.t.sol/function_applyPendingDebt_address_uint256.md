# Function: applyPendingDebt(address,uint256)

**Contract**: [test/interestBatchManagement.t.sol/contract_InterestBatchManagementTest.md]

## Metadata

- **Contract**: InterestBatchManagementTest
- **Signature**: `applyPendingDebt(address,uint256)`
- **Visibility**: public
- **Source Range**: 13227:182:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function applyPendingDebt(address _from, uint256 _troveId) public {
    vm.startPrank(_from);
    borrowerOperations.applyPendingDebt(_troveId);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::applyPendingDebt(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.applyPendingDebt(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
