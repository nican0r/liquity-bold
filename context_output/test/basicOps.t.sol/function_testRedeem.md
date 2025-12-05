# Function: testRedeem()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `testRedeem()`
- **Visibility**: public
- **Source Range**: 3169:1424:297

## Implementation

```solidity
function testRedeem() public {
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    borrowerOperations.openTrove(A, 0, 5e18, 5_000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(B);
    uint256 B_Id = borrowerOperations.openTrove(B, 0, 5e18, 4_000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    uint256 debt_1 = troveManager.getTroveDebt(B_Id);
    assertGt(debt_1, 0, "Debt cannot be zero");
    uint256 coll_1 = troveManager.getTroveColl(B_Id);
    assertGt(coll_1, 0, "Coll cannot be zero");
    vm.stopPrank();
    uint256 redemptionAmount = 1000e18;
    vm.warp(block.timestamp + 7 days);
    vm.startPrank(A);
    collateralRegistry.redeemCollateral(redemptionAmount, 10, 1e18);
    uint256 debt_2 = troveManager.getTroveDebt(B_Id);
    assertLt(debt_2, debt_1, "Debt mismatch after");
    uint256 coll_2 = troveManager.getTroveColl(B_Id);
    assertLt(coll_2, coll_1, "Coll mismatch after");
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**
- **ITroveManagerTester::getTroveDebt(uint256)**
- **ITroveManagerTester::getTroveColl(uint256)**
- **Vm::warp(uint256)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasicOps.testRedeem() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [debt_1, 0, "Debt cannot be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [coll_1, 0, "Coll cannot be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [debt_2, debt_1, "Debt mismatch after"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 4)
      💬 Args: [coll_2, coll_1, "Coll mismatch after"]
      👁️  Def: internal
```
