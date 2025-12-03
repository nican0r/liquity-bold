# Function: testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz(uint256)

**Contract**: [test/stabilityPool.t.sol/contract_SPTest.md]

## Metadata

- **Contract**: SPTest
- **Signature**: `testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 90934:1860:334

## Implementation

```solidity
function testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz(uint256 _toRedist) public {
    _toRedist = bound(_toRedist, 1, 1e18);
    uint256 rate = 5e16;
    priceFeed.setPrice(3000e18);
    uint256 toSP = 5000e18;
    uint256 troveIdA = openTroveNoHints100pct(A, 5 ether, toSP, rate);
    uint256 debtABefore = troveManager.getTroveEntireDebt(troveIdA);
    uint256 B_targetDebt = (toSP - 1e18) + _toRedist;
    (uint256 B_borrow, ) = findAmountToBorrowWithOpenTrove(B_targetDebt, rate);
    uint256 troveIdB = openTroveNoHints100pct(B, 5 ether, B_borrow, rate);
    makeSPDepositNoClaim(A, toSP);
    assertLt(stabilityPool.getTotalBoldDeposits() - troveManager.getTroveEntireDebt(troveIdB), 1e18);
    priceFeed.setPrice(300e18);
    liquidate(A, troveIdB);
    console.log(troveManager.getTroveEntireDebt(troveIdA), "A debt after");
    console.log(debtABefore, "A debt before");
    console.log(getTroveEntireDebt(troveIdA) - debtABefore, "A debt after - A debt before");
    console.log(_toRedist, "_toRedist");
    assertApproximatelyEqual(troveManager.getTroveEntireDebt(troveIdA), debtABefore + _toRedist, 1e3);
}
```

## Related Implementations

### bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2915:199:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:bound(uint256,uint256,uint256)`

```solidity
function bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    result = _bound(x, min, max);
    console2_log_StdUtils("Bound result", result);
}
```

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1646:1263:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### console2_log_StdUtils(string,uint256)

- **Kind**: internal
- **Source**: 10318:162:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:console2_log_StdUtils(string,uint256)`

```solidity
function console2_log_StdUtils(string memory p0, uint256 p1) private pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### openTroveNoHints100pct(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 6736:267:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveNoHints100pct(address,uint256,uint256,uint256)`

```solidity
function openTroveNoHints100pct(address _account, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId) {
    (troveId, ) = openTroveHelper(_account, 0, _coll, _boldAmount, _annualInterestRate);
}
```

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

### makeSPDepositNoClaim(address,uint256)

- **Kind**: internal
- **Source**: 11348:187:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:makeSPDepositNoClaim(address,uint256)`

```solidity
function makeSPDepositNoClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.provideToSP(_amount, false);
    vm.stopPrank();
}
```

### assertLt(uint256,uint256)

- **Kind**: internal
- **Source**: 11928:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256)`

```solidity
function assertLt(uint256 left, uint256 right) virtual internal pure {
    vm.assertLt(left, right);
}
```

### liquidate(address,uint256)

- **Kind**: internal
- **Source**: 13598:162:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:liquidate(address,uint256)`

```solidity
function liquidate(address _from, uint256 _troveId) public {
    vm.startPrank(_from);
    troveManager.liquidate(_troveId);
    vm.stopPrank();
}
```

### log(uint256,string)

- **Kind**: internal
- **Source**: 6702:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(uint256,string)`

```solidity
function log(uint256 p0, string memory p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(uint256,string)", p0, p1));
}
```

### getTroveEntireDebt(uint256)

- **Kind**: internal
- **Source**: 2492:200:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:getTroveEntireDebt(uint256)`

```solidity
function getTroveEntireDebt(uint256 _troveId) internal view returns (uint256) {
    LatestTroveData memory trove = troveManager.getLatestTroveData(_troveId);
    return trove.entireDebt;
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IStabilityPool::getTotalBoldDeposits()**

## State Variable Reads

- **UINT256_MAX** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPTest.testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_toRedist, 1, 1e18]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 3)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [A, 5 ether, toSP, rate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 7)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 8)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 9)
  │   💬 Args: [B_targetDebt, rate]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 10)
  │ │   💬 Args: [borrowRight, interestRate]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 11)
  │     💬 Args: [borrow, interestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 12)
  │   💬 Args: [B, 5 ether, B_borrow, rate]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 13)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 14)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 15)
  │   💬 Args: [A, toSP]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 16)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits() - troveManager.getTroveEntireDebt(troveIdB), 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 17)
  │   💬 Args: [A, troveIdB]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 18)
  │   💬 Args: [troveManager.getTroveEntireDebt(troveIdA), "A debt after"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 21)
  │   💬 Args: [debtABefore, "A debt before"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 22)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 23)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 24)
  │   💬 Args: [getTroveEntireDebt(troveIdA) - debtABefore, "A debt after - A debt before"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.getTroveEntireDebt(uint256) (NodeID: 27)
  │ │   💬 Args: [troveIdA]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 25)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 26)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 28)
  │   💬 Args: [_toRedist, "_toRedist"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 29)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 30)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 31)
      💬 Args: [troveManager.getTroveEntireDebt(troveIdA), debtABefore + _toRedist, 1e3]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 32)
        💬 Args: [_x, _y, _margin, ""]
        👁️  Def: internal
```
