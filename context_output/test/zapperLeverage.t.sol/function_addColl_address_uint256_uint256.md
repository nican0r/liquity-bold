# Function: addColl(address,uint256,uint256)

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `addColl(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 12789:208:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function addColl(address _account, uint256 _troveId, uint256 _collIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.addColl(_troveId, _collIncrease);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::addColl(uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.addColl(address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
