# Function: testCanOpenTrove()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `testCanOpenTrove()`
- **Visibility**: external
- **Source Range**: 1924:1286:339

## Implementation

```solidity
function testCanOpenTrove() external {
    uint256 ethAmount = 10 ether;
    uint256 boldAmount = 10000e18;
    uint256 ethBalanceBefore = A.balance;
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: 0, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: 5e16, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = wethZapper.openTroveWithRawETH{value: ethAmount + ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    assertEq(troveNFT.ownerOf(troveId), A, "Wrong owner");
    assertGt(troveId, 0, "Trove id should be set");
    assertEq(troveManager.getTroveEntireColl(troveId), ethAmount, "Coll mismatch");
    assertGt(troveManager.getTroveEntireDebt(troveId), boldAmount, "Debt mismatch");
    assertEq(boldToken.balanceOf(A), boldAmount, "BOLD bal mismatch");
    assertEq(A.balance, ethBalanceBefore - (ethAmount + ETH_GAS_COMPENSATION), "ETH bal mismatch");
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **ITroveNFT::ownerOf(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.testCanOpenTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [troveNFT.ownerOf(troveId), A, "Wrong owner"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [troveId, 0, "Trove id should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [troveManager.getTroveEntireColl(troveId), ethAmount, "Coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), boldAmount, "Debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [boldToken.balanceOf(A), boldAmount, "BOLD bal mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [A.balance, ethBalanceBefore - (ethAmount + ETH_GAS_COMPENSATION), "ETH bal mismatch"]
      👁️  Def: internal
```
