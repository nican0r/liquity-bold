# Function: testSPDeposit()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `testSPDeposit()`
- **Visibility**: public
- **Source Range**: 5632:830:297

## Implementation

```solidity
function testSPDeposit() public {
    priceFeed.setPrice(2000e18);
    vm.startPrank(A);
    borrowerOperations.openTrove(A, 0, 2e18, 2000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    makeSPDepositAndClaim(A, 100e18);
    vm.warp(block.timestamp + 7 days);
    makeSPDepositAndClaim(A, 100e18);
    assertGt(boldToken.balanceOf(A), 1800e18, "Wrong bold balance");
    assertLt(boldToken.balanceOf(A), 1801e18, "Wrong bold balance");
    assertApproximatelyEqual(stabilityPool.getCompoundedBoldDeposit(A), 200e18, 1e3, "Wrong SP deposit");
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

### assertApproximatelyEqual(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 20170:170:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:assertApproximatelyEqual(uint256,uint256,uint256,string)`

```solidity
function assertApproximatelyEqual(uint256 _x, uint256 _y, uint256 _margin, string memory _reason) public pure {
    assertApproxEqAbs(_x, _y, _margin, _reason);
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
┌─ [0] ⚙️ FUNCTION: BasicOps.testSPDeposit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 1)
  │   💬 Args: [A, 100e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 2)
  │   💬 Args: [A, 100e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [boldToken.balanceOf(A), 1800e18, "Wrong bold balance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [boldToken.balanceOf(A), 1801e18, "Wrong bold balance"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256,string) (NodeID: 5)
      💬 Args: [stabilityPool.getCompoundedBoldDeposit(A), 200e18, 1e3, "Wrong SP deposit"]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 6)
        💬 Args: [_x, _y, _margin, _reason]
        👁️  Def: internal
```
