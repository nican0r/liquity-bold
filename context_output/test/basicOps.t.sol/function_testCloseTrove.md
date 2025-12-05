# Function: testCloseTrove()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `testCloseTrove()`
- **Visibility**: public
- **Source Range**: 1405:952:297

## Implementation

```solidity
function testCloseTrove() public {
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    borrowerOperations.openTrove(A, 0, 2e18, 2000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    boldToken.transfer(B, 100e18);
    vm.stopPrank();
    vm.startPrank(B);
    uint256 B_Id = borrowerOperations.openTrove(B, 0, 2e18, 2000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    uint256 trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 2);
    vm.startPrank(B);
    borrowerOperations.closeTrove(B_Id);
    vm.stopPrank();
    trovesCount = troveManager.getTroveIdsCount();
    assertEq(trovesCount, 1);
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
- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **IBoldToken::transfer(address,uint256)**
- **Vm::stopPrank()**
- **ITroveManagerTester::getTroveIdsCount()**
- **IBorrowerOperationsTester::closeTrove(uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasicOps.testCloseTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [trovesCount, 2]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [trovesCount, 1]
      👁️  Def: internal
```
