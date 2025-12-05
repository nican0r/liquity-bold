# Function: test_BatchLiquidateTrovesEmitsTroveOperationForEachLiquidatedTrove()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_BatchLiquidateTrovesEmitsTroveOperationForEachLiquidatedTrove()`
- **Visibility**: external
- **Source Range**: 15328:1620:303

## Implementation

```solidity
function test_BatchLiquidateTrovesEmitsTroveOperationForEachLiquidatedTrove() external {
    openTroveHelper(B, 0, 1_000 ether, 10_000 ether, 0.01 ether);
    uint256[] memory liquidateTroveIds = new uint256[](3);
    for (uint256 i = 0; i < liquidateTroveIds.length; ++i) {
        (liquidateTroveIds[i], ) = openTroveWithExactICRAndDebt(A, i, MCR, 10_000 ether, 0.01 ether);
    }
    priceFeed.setPrice((priceFeed.getPrice() * 99) / 100);
    vm.recordLogs();
    for (uint256 i = 0; i < liquidateTroveIds.length; ++i) {
        uint256 debt = troveManager.getTroveEntireDebt(liquidateTroveIds[i]);
        uint256 coll = troveManager.getTroveEntireColl(liquidateTroveIds[i]);
        emit TroveOperation(liquidateTroveIds[i], Operation.liquidate, 0, 0, 0, -int256(debt), 0, -int256(coll));
    }
    Vm.Log[] memory expectedTroveUpdatedEvents = vm.getRecordedLogs();
    troveManager.batchLiquidateTroves(liquidateTroveIds);
    Vm.Log[] memory actualTroveUpdatedEvents = vm.getRecordedLogs().filter(TroveOperation.selector);
    assertEqLogs(actualTroveUpdatedEvents, expectedTroveUpdatedEvents, "Wrong TroveOperation events");
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

### openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 8562:619:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256)`

```solidity
function openTroveWithExactICRAndDebt(address _account, uint256 _index, uint256 _ICR, uint256 _debt, uint256 _interestRate) public returns (uint256 troveId, uint256 coll) {
    (uint256 borrow, uint256 upfrontFee) = findAmountToBorrowWithOpenTrove(_debt, _interestRate);
    uint256 price = priceFeed.getPrice();
    coll = mulDivCeil(_debt, _ICR, price);
    vm.prank(_account);
    troveId = borrowerOperations.openTrove(_account, _index, coll, borrow, 0, 0, _interestRate, upfrontFee, address(0), address(0), address(0));
}
```

### findAmountToBorrowWithOpenTrove(uint256,uint256)

- **Kind**: internal
- **Source**: 4817:815:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:findAmountToBorrowWithOpenTrove(uint256,uint256)`

```solidity
function findAmountToBorrowWithOpenTrove(uint256 targetDebt, uint256 interestRate) internal view returns (uint256 borrow, uint256 upfrontFee) {
    uint256 borrowRight = targetDebt;
    upfrontFee = predictOpenTroveUpfrontFee(borrowRight, interestRate);
    uint256 borrowLeft = borrowRight - upfrontFee;
    for (uint256 i = 0; i < 256; ++i) {
        borrow = (borrowLeft + borrowRight) / 2;
        upfrontFee = predictOpenTroveUpfrontFee(borrow, interestRate);
        uint256 actualDebt = borrow + upfrontFee;
        if (actualDebt == targetDebt) {
            break;
        } else if (actualDebt < targetDebt) {
            borrowLeft = borrow;
        } else {
            borrowRight = borrow;
        }
    }
}
```

### mulDivCeil(uint256,uint256,uint256)

- **Kind**: free-function
- **Source**: 764:186:290
- **Link**: `test/Utils/Math.sol:mulDivCeil(uint256,uint256,uint256)`

```solidity
function mulDivCeil(uint256 x, uint256 multiplier, uint256 divider) pure returns (uint256) {
    assert(divider != 0);
    return (x == 0) ? 0 : ((((x * multiplier) + divider) - 1) / divider);
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

- **IPriceFeedTestnet::setPrice(uint256)**
- **IPriceFeedTestnet::getPrice()**
- **Vm::recordLogs()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::getTroveEntireColl(uint256)**
- **Vm::getRecordedLogs()**
- **ITroveManagerTester::batchLiquidateTroves(uint256[])**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_BatchLiquidateTrovesEmitsTroveOperationForEachLiquidatedTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [B, 0, 1_000 ether, 10_000 ether, 0.01 ether]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [A, i, MCR, 10_000 ether, 0.01 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 4)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 5)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 7)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.filter(struct VmSafe.Log[],bytes32) (NodeID: 8)
  │   💬 Args: [vm.getRecordedLogs(), TroveOperation.selector]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EventsTest.assertEqLogs(struct VmSafe.Log[],struct VmSafe.Log[],string) (NodeID: 9)
      💬 Args: [actualTroveUpdatedEvents, expectedTroveUpdatedEvents, "Wrong TroveOperation events"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
    │   💬 Args: [a.length, b.length, concat(errPrefix, " - log count mismatch")]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 11)
    │     💬 Args: [errPrefix, " - log count mismatch"]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
    │   💬 Args: [a[i].topics.length, b[i].topics.length, concat(errPrefix, " - topic count mismatch")]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 13)
    │     💬 Args: [errPrefix, " - topic count mismatch"]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 14)
    │   💬 Args: [a[i].topics[j], b[i].topics[j], concat(errPrefix, " - topic mismatch")]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 15)
    │     💬 Args: [errPrefix, " - topic mismatch"]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq0(bytes,bytes,string) (NodeID: 16)
        💬 Args: [a[i].data, b[i].data, concat(errPrefix, " - data mismatch")]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Unknown.concat(string,string) (NodeID: 18)
      │   💬 Args: [errPrefix, " - data mismatch"]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 17)
          💬 Args: [left, right, err]
          👁️  Def: internal
```
