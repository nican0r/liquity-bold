# Function: batchLiquidateTroves(address,uint256[])

**Contract**: [test/liquidationsLST.t.sol/contract_LiquidationsLSTTest.md]

## Metadata

- **Contract**: LiquidationsLSTTest
- **Signature**: `batchLiquidateTroves(address,uint256[])`
- **Visibility**: public
- **Source Range**: 13766:199:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function batchLiquidateTroves(address _from, uint256[] memory _trovesList) public {
    vm.startPrank(_from);
    troveManager.batchLiquidateTroves(_trovesList);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **ITroveManagerTester::batchLiquidateTroves(uint256[])**
- **Vm::stopPrank()**

## State Variable Reads

- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.batchLiquidateTroves(address,uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
