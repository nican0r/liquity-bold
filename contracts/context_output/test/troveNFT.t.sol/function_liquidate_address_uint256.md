# Function: liquidate(address,uint256)

**Contract**: [test/troveNFT.t.sol/contract_troveNFTTest.md]

## Metadata

- **Contract**: troveNFTTest
- **Signature**: `liquidate(address,uint256)`
- **Visibility**: public
- **Source Range**: 13598:162:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function liquidate(address _from, uint256 _troveId) public {
    vm.startPrank(_from);
    troveManager.liquidate(_troveId);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **ITroveManagerTester::liquidate(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
