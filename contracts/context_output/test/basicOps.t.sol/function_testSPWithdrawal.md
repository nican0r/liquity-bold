# Function: testSPWithdrawal()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `testSPWithdrawal()`
- **Visibility**: public
- **Source Range**: 6468:1040:297

## Implementation

```solidity
function testSPWithdrawal() public {
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    borrowerOperations.openTrove(A, 0, 2e18, 2000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    makeSPDepositAndClaim(A, 100e18);
    vm.warp(block.timestamp + 7 days);
    assertEq(boldToken.balanceOf(A), 1900e18);
    assertApproximatelyEqual(stabilityPool.getCompoundedBoldDeposit(A), 100e18, 1e2);
    makeSPWithdrawalAndClaim(A, 99e18);
    assertGt(boldToken.balanceOf(A), 1999e18, "Wrong bold balance");
    assertLt(boldToken.balanceOf(A), 2000e18, "Wrong bold balance");
    assertEq(stabilityPool.getCompoundedBoldDeposit(A), 1e18, "Wrong SP deposit");
}
```

## Related Implementations

### makeSPDepositAndClaim(address,uint256)

- **Kind**: internal
- **Source**: 11155:187:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPDepositAndClaim(address,uint256)`

```solidity
function makeSPDepositAndClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.provideToSP(_amount, true);
    vm.stopPrank();
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### assertApproximatelyEqual(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 20022:142:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:assertApproximatelyEqual(uint256,uint256,uint256)`

```solidity
function assertApproximatelyEqual(uint256 _x, uint256 _y, uint256 _margin) public pure {
    assertApproxEqAbs(_x, _y, _margin, "");
}
```

### assertApproxEqAbs(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 16826:208:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbs(uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string memory err) virtual internal pure {
    vm.assertApproxEqAbs(left, right, maxDelta, err);
}
```

### makeSPWithdrawalAndClaim(address,uint256)

- **Kind**: internal
- **Source**: 11541:193:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPWithdrawalAndClaim(address,uint256)`

```solidity
function makeSPWithdrawalAndClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.withdrawFromSP(_amount, true);
    vm.stopPrank();
}
```

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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::startPrank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::warp(uint256)**
- **IBoldToken::balanceOf(address)**
- **IStabilityPool::getCompoundedBoldDeposit(address)**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasicOps.testSPWithdrawal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 1)
  │   💬 Args: [A, 100e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [boldToken.balanceOf(A), 1900e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 100e18, 1e2]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 4)
  │     💬 Args: [_x, _y, _margin, ""]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 5)
  │   💬 Args: [A, 99e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [boldToken.balanceOf(A), 1999e18, "Wrong bold balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [boldToken.balanceOf(A), 2000e18, "Wrong bold balance"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
      💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 1e18, "Wrong SP deposit"]
      👁️  Def: internal
```
