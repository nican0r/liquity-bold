# Function: testGetTCRReturnsMaxUint256ForEmptySystem()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testGetTCRReturnsMaxUint256ForEmptySystem()`
- **Visibility**: public
- **Source Range**: 70593:205:306

## Implementation

```solidity
function testGetTCRReturnsMaxUint256ForEmptySystem() public {
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 TCR = troveManager.getTCR(price);
    assertEq(TCR, MAX_UINT256);
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

- **IPriceFeedTestnet::fetchPrice()**
- **ITroveManagerTester::getTCR(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testGetTCRReturnsMaxUint256ForEmptySystem() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [TCR, MAX_UINT256]
      👁️  Def: internal
```
