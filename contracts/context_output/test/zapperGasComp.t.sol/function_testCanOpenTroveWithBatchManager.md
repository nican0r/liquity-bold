# Function: testCanOpenTroveWithBatchManager()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCanOpenTroveWithBatchManager()`
- **Visibility**: external
- **Source Range**: 3812:1703:337

## Implementation

```solidity
function testCanOpenTroveWithBatchManager() external {
    uint256 collAmount = 10 ether;
    uint256 boldAmount = 10000e18;
    uint256 ethBalanceBefore = A.balance;
    uint256 collBalanceBefore = collToken.balanceOf(A);
    registerBatchManager(B);
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: 0, batchManager: B, maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    uint256 troveId = gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
    assertEq(troveNFT.ownerOf(troveId), A, "Wrong owner");
    assertGt(troveId, 0, "Trove id should be set");
    assertEq(troveManager.getTroveEntireColl(troveId), collAmount, "Coll mismatch");
    assertGt(troveManager.getTroveEntireDebt(troveId), boldAmount, "Debt mismatch");
    assertEq(boldToken.balanceOf(A), boldAmount, "BOLD bal mismatch");
    assertEq(A.balance, ethBalanceBefore - ETH_GAS_COMPENSATION, "ETH bal mismatch");
    assertEq(collToken.balanceOf(A), collBalanceBefore - collAmount, "Coll bal mismatch");
    assertEq(borrowerOperations.interestBatchManagerOf(troveId), B, "Wrong batch manager");
    (, , , , , , , , address tmBatchManagerAddress, ) = troveManager.Troves(troveId);
    assertEq(tmBatchManagerAddress, B, "Wrong batch manager (TM)");
}
```

## Related Implementations

### registerBatchManager(address)

- **Kind**: internal
- **Source**: 14398:221:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:registerBatchManager(address)`

```solidity
function registerBatchManager(address _account) internal {
    registerBatchManager(_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
}
```

### registerBatchManager(address,uint128,uint128,uint128,uint128,uint128)

- **Kind**: internal
- **Source**: 14625:474:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:registerBatchManager(address,uint128,uint128,uint128,uint128,uint128)`

```solidity
function registerBatchManager(address _account, uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _fee, uint128 _minInterestRateChangePeriod) internal {
    vm.startPrank(_account);
    borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _fee, _minInterestRateChangePeriod);
    vm.stopPrank();
}
```

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

- **IERC20::balanceOf(address)**
- **Vm::startPrank(address)**
- **unknown::unknown**
- **Vm::stopPrank()**
- **ITroveNFT::ownerOf(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IBoldToken::balanceOf(address)**
- **IBorrowerOperationsTester::interestBatchManagerOf(uint256)**
- **ITroveManagerTester::Troves(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCanOpenTroveWithBatchManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address) (NodeID: 1)
  │   💬 Args: [B]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 2)
  │     💬 Args: [_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [troveNFT.ownerOf(troveId), A, "Wrong owner"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [troveId, 0, "Trove id should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [troveManager.getTroveEntireColl(troveId), collAmount, "Coll mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveId), boldAmount, "Debt mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [boldToken.balanceOf(A), boldAmount, "BOLD bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [A.balance, ethBalanceBefore - ETH_GAS_COMPENSATION, "ETH bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [collToken.balanceOf(A), collBalanceBefore - collAmount, "Coll bal mismatch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 10)
  │   💬 Args: [borrowerOperations.interestBatchManagerOf(troveId), B, "Wrong batch manager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 11)
      💬 Args: [tmBatchManagerAddress, B, "Wrong batch manager (TM)"]
      👁️  Def: internal
```
