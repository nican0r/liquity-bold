# Function: test_RedeemCollateralEmitsTroveUpdatedForEachRedeemedTrove()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_RedeemCollateralEmitsTroveUpdatedForEachRedeemedTrove()`
- **Visibility**: external
- **Source Range**: 19664:2112:303

## Implementation

```solidity
function test_RedeemCollateralEmitsTroveUpdatedForEachRedeemedTrove() external {
    uint256[3] memory troveId;
    (troveId[0], ) = openTroveHelper(A, 0, 100 ether, 10_000 ether, 0.01 ether);
    (troveId[1], ) = openTroveHelper(A, 1, 200 ether, 20_000 ether, 0.02 ether);
    (troveId[2], ) = openTroveHelper(A, 2, 300 ether, 30_000 ether, 0.03 ether);
    uint256[3] memory redeemBold;
    redeemBold[0] = troveManager.getTroveEntireDebt(troveId[0]);
    redeemBold[1] = troveManager.getTroveEntireDebt(troveId[1]);
    redeemBold[2] = troveManager.getTroveEntireDebt(troveId[2]) / 2;
    uint256 price = priceFeed.getPrice();
    uint256 totalRedeemedBold = (redeemBold[0] + redeemBold[1]) + redeemBold[2];
    uint256 redemptionRate = collateralRegistry.getRedemptionRateForRedeemedAmount(totalRedeemedBold);
    vm.recordLogs();
    for (uint256 i = 0; i < 3; ++i) {
        uint256 redeemEth = (redeemBold[i] * DECIMAL_PRECISION) / price;
        uint256 redeemFee = (redeemEth * redemptionRate) / DECIMAL_PRECISION;
        uint256 debt = troveManager.getTroveEntireDebt(troveId[i]) - redeemBold[i];
        uint256 coll = (troveManager.getTroveEntireColl(troveId[i]) - redeemEth) + redeemFee;
        uint256 stake = coll;
        uint256 interestRate = troveManager.getTroveAnnualInterestRate(troveId[i]);
        emit TroveUpdated(troveId[i], debt, coll, stake, interestRate, 0, 0);
    }
    Vm.Log[] memory expectedTroveUpdatedEvents = vm.getRecordedLogs();
    vm.prank(A);
    collateralRegistry.redeemCollateral(totalRedeemedBold, 3, _100pct);
    Vm.Log[] memory actualTroveUpdatedEvents = vm.getRecordedLogs().filter(TroveUpdated.selector);
    assertEqLogs(actualTroveUpdatedEvents, expectedTroveUpdatedEvents, "Wrong TroveUpdated events");
}
```

## Related Implementations

### openTroveHelper(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7338:704:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveHelper(address,uint256,uint256,uint256,uint256)`

```solidity
function openTroveHelper(address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId, uint256 upfrontFee) {
    upfrontFee = predictOpenTroveUpfrontFee(_boldAmount, _annualInterestRate);
    vm.startPrank(_account);
    troveId = borrowerOperations.openTrove(_account, _index, _coll, _boldAmount, 0, 0, _annualInterestRate, upfrontFee, address(0), address(0), address(0));
    vm.stopPrank();
}
```

### predictOpenTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3546:209:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictOpenTroveUpfrontFee(uint256,uint256)`

```solidity
function predictOpenTroveUpfrontFee(uint256 borrowedAmount, uint256 interestRate) internal view returns (uint256) {
    return hintHelpers.predictOpenTroveUpfrontFee(0, borrowedAmount, interestRate);
}
```

### filter(struct VmSafe.Log[],bytes32)

- **Kind**: free-function
- **Source**: 1005:448:303
- **Link**: `test/events.t.sol:filter(struct VmSafe.Log[],bytes32)`

```solidity
function filter(Vm.Log[] memory logs, bytes32 selector) pure returns (Vm.Log[] memory matchingLogs) {
    uint256 j = 0;
    for (uint256 i = 0; i < logs.length; ++i) {
        if (logs[i].topics[0] == selector) {
            ++j;
        }
    }
    matchingLogs = new Vm.Log[](j);
    j = 0;
    for (uint256 i = 0; i < logs.length; ++i) {
        if (logs[i].topics[0] == selector) {
            matchingLogs[j++] = logs[i];
        }
    }
}
```

### assertEqLogs(struct VmSafe.Log[],struct VmSafe.Log[],string)

- **Kind**: internal
- **Source**: 1627:617:303
- **Link**: `test/events.t.sol:EventsTest:assertEqLogs(struct VmSafe.Log[],struct VmSafe.Log[],string)`

```solidity
function assertEqLogs(Vm.Log[] memory a, Vm.Log[] memory b, string memory errPrefix) internal pure {
    assertEq(a.length, b.length, concat(errPrefix, " - log count mismatch"));
    for (uint256 i = 0; i < a.length; ++i) {
        assertEq(a[i].topics.length, b[i].topics.length, concat(errPrefix, " - topic count mismatch"));
        for (uint256 j = 0; j < a[i].topics.length; ++j) {
            assertEq(a[i].topics[j], b[i].topics[j], concat(errPrefix, " - topic mismatch"));
        }
        assertEq0(a[i].data, b[i].data, concat(errPrefix, " - data mismatch"));
    }
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

### concat(string,string)

- **Kind**: free-function
- **Source**: 1455:128:303
- **Link**: `test/events.t.sol:concat(string,string)`

```solidity
function concat(string memory a, string memory b) pure returns (string memory ab) {
    return string(abi.encodePacked(a, b));
}
```

### assertEq(bytes32,bytes32,string)

- **Kind**: internal
- **Source**: 3826:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32,string)`

```solidity
function assertEq(bytes32 left, bytes32 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertEq0(bytes,bytes,string)

- **Kind**: internal
- **Source**: 21055:142:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq0(bytes,bytes,string)`

```solidity
function assertEq0(bytes memory left, bytes memory right, string memory err) virtual internal pure {
    assertEq(left, right, err);
}
```

### assertEq(bytes,bytes,string)

- **Kind**: internal
- **Source**: 4626:144:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes,bytes,string)`

```solidity
function assertEq(bytes memory left, bytes memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IPriceFeedTestnet::getPrice()**
- **ICollateralRegistry::getRedemptionRateForRedeemedAmount(uint256)**
- **Vm::recordLogs()**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **ITroveManagerTester::getTroveAnnualInterestRate(uint256)**
- **Vm::getRecordedLogs()**
- **Vm::prank(address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_RedeemCollateralEmitsTroveUpdatedForEachRedeemedTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 0, 100 ether, 10_000 ether, 0.01 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [A, 1, 200 ether, 20_000 ether, 0.02 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 4)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [A, 2, 300 ether, 30_000 ether, 0.03 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.filter(struct VmSafe.Log[],bytes32) (NodeID: 7)
  │   💬 Args: [vm.getRecordedLogs(), TroveUpdated.selector]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EventsTest.assertEqLogs(struct VmSafe.Log[],struct VmSafe.Log[],string) (NodeID: 8)
      💬 Args: [actualTroveUpdatedEvents, expectedTroveUpdatedEvents, "Wrong TroveUpdated events"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
    │   💬 Args: [a.length, b.length, concat(errPrefix, " - log count mismatch")]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 10)
    │     💬 Args: [errPrefix, " - log count mismatch"]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
    │   💬 Args: [a[i].topics.length, b[i].topics.length, concat(errPrefix, " - topic count mismatch")]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 12)
    │     💬 Args: [errPrefix, " - topic count mismatch"]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 13)
    │   💬 Args: [a[i].topics[j], b[i].topics[j], concat(errPrefix, " - topic mismatch")]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 14)
    │     💬 Args: [errPrefix, " - topic mismatch"]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq0(bytes,bytes,string) (NodeID: 15)
        💬 Args: [a[i].data, b[i].data, concat(errPrefix, " - data mismatch")]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 17)
      │   💬 Args: [errPrefix, " - data mismatch"]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 16)
          💬 Args: [left, right, err]
          👁️  Def: internal
```
