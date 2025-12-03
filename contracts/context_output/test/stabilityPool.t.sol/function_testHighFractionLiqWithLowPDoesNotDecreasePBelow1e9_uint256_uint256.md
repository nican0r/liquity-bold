# Function: testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9(uint256,uint256)

**Contract**: [test/stabilityPool.t.sol/contract_SPTest.md]

## Metadata

- **Contract**: SPTest
- **Signature**: `testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 87524:1515:334

## Implementation

```solidity
function testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9(uint256 _cheatP, uint256 _surplus) public {
    _cheatP = bound(_cheatP, 1e27, 1e29);
    vm.store(address(stabilityPool), bytes32(uint256(10)), bytes32(uint256(_cheatP)));
    uint256 storedVal = uint256(vm.load(address(stabilityPool), bytes32(uint256(10))));
    assertEq(storedVal, _cheatP, "value of slot 10 is not set");
    assertEq(stabilityPool.P(), _cheatP, "P is not set");
    ABCDEF memory troveIDs = _setupForPTests();
    uint256 scale1 = stabilityPool.currentScale();
    uint256 troveDebt = troveManager.getTroveEntireDebt(troveIDs.D);
    uint256 debtDelta = troveDebt - stabilityPool.getTotalBoldDeposits();
    _surplus = bound(_surplus, debtDelta + 1e9, debtDelta + 1e10);
    makeSPDepositAndClaim(B, _surplus);
    liquidate(A, troveIDs.D);
    uint256 scale2 = stabilityPool.currentScale();
    assertGt(scale2, scale1, "scale didnt change");
    assertGe(stabilityPool.P(), 1e27);
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### _setupForPTests()

- **Kind**: internal
- **Source**: 7678:352:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForPTests()`

```solidity
function _setupForPTests() internal returns (ABCDEF memory) {
    ABCDEF memory troveIDs;
    (troveIDs.A, troveIDs.B, troveIDs.C, troveIDs.D) = _setupForBatchLiquidateTrovesPureOffset(1);
    makeSPWithdrawalAndClaim(B, stabilityPool.getCompoundedBoldDeposit(B));
    return troveIDs;
}
```

### _setupForBatchLiquidateTrovesPureOffset(uint256)

- **Kind**: internal
- **Source**: 4424:1477:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForBatchLiquidateTrovesPureOffset(uint256)`

```solidity
function _setupForBatchLiquidateTrovesPureOffset(uint256 _magnitude) internal returns (uint256, uint256, uint256, uint256) {
    uint256 troveDebtRequest_A = 2200e18 * _magnitude;
    uint256 troveDebtRequest_B = 3200e18 * _magnitude;
    uint256 troveDebtRequest_C = 2450e18 * _magnitude;
    uint256 troveDebtRequest_D = 2450e18 * _magnitude;
    uint256 interestRate = 5e16;
    ABCDEF memory troveIDs;
    uint256 price = 2000e18;
    priceFeed.setPrice(price);
    troveIDs.A = openTroveNoHints100pct(A, 5 ether * _magnitude, troveDebtRequest_A, interestRate);
    troveIDs.B = openTroveNoHints100pct(B, 5 ether * _magnitude, troveDebtRequest_B, interestRate);
    troveIDs.C = openTroveNoHints100pct(C, 25e17 * _magnitude, troveDebtRequest_C, interestRate);
    troveIDs.D = openTroveNoHints100pct(D, 25e17 * _magnitude, troveDebtRequest_D, interestRate);
    makeSPDepositAndClaim(A, troveDebtRequest_A);
    makeSPDepositAndClaim(B, troveDebtRequest_B);
    price = 1050e18;
    priceFeed.setPrice(price);
    assertFalse(troveManager.checkBelowCriticalThreshold(price));
    assertLt(troveManager.getCurrentICR(troveIDs.C, price), MCR);
    assertLt(troveManager.getCurrentICR(troveIDs.D, price), MCR);
    return (troveIDs.A, troveIDs.B, troveIDs.C, troveIDs.D);
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

### assertFalse(bool)

- **Kind**: internal
- **Source**: 1808:91:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool)`

```solidity
function assertFalse(bool data) virtual internal pure {
    vm.assertFalse(data);
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertGe(uint256,uint256)

- **Kind**: internal
- **Source**: 15480:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256)`

```solidity
function assertGe(uint256 left, uint256 right) virtual internal pure {
    vm.assertGe(left, right);
}
```

## External Calls

- **Vm::store(address,bytes32,bytes32)**
- **Vm::load(address,bytes32)**
- **IStabilityPool::P()**
- **IStabilityPool::currentScale()**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IStabilityPool::getTotalBoldDeposits()**

## State Variable Reads

- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPTest.testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_cheatP, 1e27, 1e29]
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
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [storedVal, _cheatP, "value of slot 10 is not set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [stabilityPool.P(), _cheatP, "P is not set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._setupForPTests() (NodeID: 8)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DevTestSetup._setupForBatchLiquidateTrovesPureOffset(uint256) (NodeID: 9)
  │ │   💬 Args: [1]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 10)
  │ │ │   💬 Args: [A, 5 ether * _magnitude, troveDebtRequest_A, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 11)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 12)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 13)
  │ │ │   💬 Args: [B, 5 ether * _magnitude, troveDebtRequest_B, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 14)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 15)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 16)
  │ │ │   💬 Args: [C, 25e17 * _magnitude, troveDebtRequest_C, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 17)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 18)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 19)
  │ │ │   💬 Args: [D, 25e17 * _magnitude, troveDebtRequest_D, interestRate]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 20)
  │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │     👁️  Def: public
  │ │ │   └─ [5] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 21)
  │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 22)
  │ │ │   💬 Args: [A, troveDebtRequest_A]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 23)
  │ │ │   💬 Args: [B, troveDebtRequest_B]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 24)
  │ │ │   💬 Args: [troveManager.checkBelowCriticalThreshold(price)]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 25)
  │ │ │   💬 Args: [troveManager.getCurrentICR(troveIDs.C, price), MCR]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 26)
  │ │     💬 Args: [troveManager.getCurrentICR(troveIDs.D, price), MCR]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 27)
  │     💬 Args: [B, stabilityPool.getCompoundedBoldDeposit(B)]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 28)
  │   💬 Args: [_surplus, debtDelta + 1e9, debtDelta + 1e10]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 29)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 30)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 31)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 32)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 33)
  │   💬 Args: [B, _surplus]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 34)
  │   💬 Args: [A, troveIDs.D]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 35)
  │   💬 Args: [scale2, scale1, "scale didnt change"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256) (NodeID: 36)
      💬 Args: [stabilityPool.P(), 1e27]
      👁️  Def: internal
```
