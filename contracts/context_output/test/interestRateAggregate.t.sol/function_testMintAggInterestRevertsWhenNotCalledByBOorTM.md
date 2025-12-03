# Function: testMintAggInterestRevertsWhenNotCalledByBOorTM()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testMintAggInterestRevertsWhenNotCalledByBOorTM()`
- **Visibility**: public
- **Source Range**: 5130:582:306

## Implementation

```solidity
function testMintAggInterestRevertsWhenNotCalledByBOorTM() public {
    TroveChange memory noChange;
    vm.startPrank(A);
    vm.expectRevert();
    activePool.mintAggInterestAndAccountForTroveChange(noChange, address(0));
    vm.stopPrank();
    vm.startPrank(address(borrowerOperations));
    activePool.mintAggInterestAndAccountForTroveChange(noChange, address(0));
    vm.stopPrank();
    vm.startPrank(address(troveManager));
    activePool.mintAggInterestAndAccountForTroveChange(noChange, address(0));
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert()**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testMintAggInterestRevertsWhenNotCalledByBOorTM() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
