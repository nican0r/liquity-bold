# Function: testGetEntireSystemDebtReturns0For0TrovesOpen()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testGetEntireSystemDebtReturns0For0TrovesOpen()`
- **Visibility**: public
- **Source Range**: 53192:344:306

## Implementation

```solidity
function testGetEntireSystemDebtReturns0For0TrovesOpen() public {
    uint256 entireSystemDebt_1 = troveManager.getEntireBranchDebt();
    assertEq(entireSystemDebt_1, 0);
    vm.warp(block.timestamp + 1 days);
    uint256 entireSystemDebt_2 = troveManager.getEntireBranchDebt();
    assertEq(entireSystemDebt_2, 0);
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

- **ITroveManagerTester::getEntireBranchDebt()**
- **Vm::warp(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testGetEntireSystemDebtReturns0For0TrovesOpen() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [entireSystemDebt_1, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [entireSystemDebt_2, 0]
      👁️  Def: internal
```
