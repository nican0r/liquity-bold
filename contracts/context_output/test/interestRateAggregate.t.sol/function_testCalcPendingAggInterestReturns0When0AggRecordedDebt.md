# Function: testCalcPendingAggInterestReturns0When0AggRecordedDebt()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testCalcPendingAggInterestReturns0When0AggRecordedDebt()`
- **Visibility**: public
- **Source Range**: 979:485:306

## Implementation

```solidity
function testCalcPendingAggInterestReturns0When0AggRecordedDebt() public {
    priceFeed.setPrice(2000e18);
    assertEq(activePool.aggRecordedDebt(), 0);
    assertEq(activePool.aggWeightedDebtSum(), 0);
    assertEq(activePool.calcPendingAggInterest(), 0);
    vm.warp(block.timestamp + 1000);
    assertEq(activePool.aggRecordedDebt(), 0);
    assertEq(activePool.aggWeightedDebtSum(), 0);
    assertEq(activePool.calcPendingAggInterest(), 0);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **IActivePool::aggRecordedDebt()**
- **IActivePool::aggWeightedDebtSum()**
- **IActivePool::calcPendingAggInterest()**
- **Vm::warp(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testCalcPendingAggInterestReturns0When0AggRecordedDebt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [activePool.aggRecordedDebt(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [activePool.aggWeightedDebtSum(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [activePool.calcPendingAggInterest(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [activePool.aggRecordedDebt(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [activePool.aggWeightedDebtSum(), 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
      💬 Args: [activePool.calcPendingAggInterest(), 0]
      👁️  Def: internal
```
