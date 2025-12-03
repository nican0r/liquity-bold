# Function: transferBold(address,address,uint256)

**Contract**: [test/borrowerOperations.t.sol/contract_BorrowerOperationsTest.md]

## Metadata

- **Contract**: BorrowerOperationsTest
- **Signature**: `transferBold(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 13415:177:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function transferBold(address _from, address _to, uint256 _amount) public {
    vm.startPrank(_from);
    boldToken.transfer(_to, _amount);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBoldToken::transfer(address,uint256)**
- **Vm::stopPrank()**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
