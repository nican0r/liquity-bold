# Function: checkBelowCriticalThreshold(bool)

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `checkBelowCriticalThreshold(bool)`
- **Visibility**: public
- **Source Range**: 10899:250:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function checkBelowCriticalThreshold(bool _true) public view {
    uint256 price = priceFeed.getPrice();
    bool belowCriticalThreshold = troveManager.checkBelowCriticalThreshold(price);
    assertEq(belowCriticalThreshold, _true);
}
```

## Related Implementations

### assertEq(bool,bool)

- **Kind**: internal
- **Source**: 2026:104:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool)`

```solidity
function assertEq(bool left, bool right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **IPriceFeedTestnet::getPrice()**
- **ITroveManagerTester::checkBelowCriticalThreshold(uint256)**

## State Variable Reads

- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.checkBelowCriticalThreshold(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool) (NodeID: 1)
      💬 Args: [belowCriticalThreshold, _true]
      👁️  Def: internal
```
