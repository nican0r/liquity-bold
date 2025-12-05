# Function: testBatchRebaseToSystemInsolvency()

**Contract**: [test/rebasingBatchShares.t.sol/contract_RebasingBatchShares.md]

## Metadata

- **Contract**: RebasingBatchShares
- **Signature**: `testBatchRebaseToSystemInsolvency()`
- **Visibility**: public
- **Source Range**: 416:5255:312

## Implementation

```solidity
function testBatchRebaseToSystemInsolvency() public {
    priceFeed.setPrice(2000e18);
    openTroveNoHints100pct(C, 100 ether, 100e21, MAX_ANNUAL_INTEREST_RATE);
    vm.startPrank(C);
    boldToken.transfer(A, boldToken.balanceOf(C));
    vm.stopPrank();
    uint256 ATroveId = openTroveAndJoinBatchManager(A, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE);
    uint256 BTroveId = openTroveAndJoinBatchManager(B, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE);
    if (WITH_INTEREST) {
        vm.warp(block.timestamp + 12);
    }
    LatestBatchData memory b4Batch = troveManager.getLatestBatchData(address(B));
    _addOneDebtAndEnsureItDoesntMintShares(ATroveId, A);
    /// @audit MED impact
    LatestBatchData memory afterBatch = troveManager.getLatestBatchData(address(B));
    assertEq(b4Batch.entireDebtWithoutRedistribution + 1, afterBatch.entireDebtWithoutRedistribution, "Debt is credited to batch");
    LatestTroveData memory trove = troveManager.getLatestTroveData(BTroveId);
    uint256 bEntireDebtB4 = trove.entireDebt;
    vm.startPrank(A);
    collateralRegistry.redeemCollateral(bEntireDebtB4, 100, 1e18);
    vm.stopPrank();
    uint256 sharesAfterRedeem = _getBatchDebtShares(BTroveId);
    assertEq(sharesAfterRedeem, 0, "Must be 0, as it was fully redeemed");
    LatestTroveData memory bAfterRedeem = troveManager.getLatestTroveData(BTroveId);
    assertEq(bAfterRedeem.entireDebt, 0, "Must be 0, as it was fully redeemed");
    closeTrove(A, ATroveId);
    LatestTroveData memory afterClose = troveManager.getLatestTroveData(BTroveId);
    assertEq(afterClose.entireDebt, 0, "Still 0, as it had zero shares");
    uint256 x;
    while ((x++) < 100) {
        _openCloseRemainderLoop(1, BTroveId, x);
    }
    _logTrovesAndBatch(B, BTroveId);
    uint256 y;
    while (y < 2560) {
        _triggerInterestRateFee();
        y++;
        LatestTroveData memory troveData = troveManager.getLatestTroveData(BTroveId);
        if (troveData.entireDebt > (4000e18 + 1)) {
            break;
        }
    }
    console2.log("We have more than 2X MIN_DEBT of rebase it took us blocks:", y);
    _logTrovesAndBatch(B, BTroveId);
    uint256 anotherATroveId = openTroveAndJoinBatchManagerWithIndex(A, x + 1, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE);
    assertGt(anotherATroveId, 0);
}
```

## Related Implementations

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

### openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256)

- **Kind**: internal
- **Source**: 15259:341:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256)`

```solidity
function openTroveAndJoinBatchManager(address _troveOwner, uint256 _coll, uint256 _debt, address _batchAddress, uint256 _annualInterestRate) internal returns (uint256) {
    return openTroveAndJoinBatchManagerWithIndex(_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate);
}
```

### openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256)

- **Kind**: internal
- **Source**: 15606:1407:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256)`

```solidity
function openTroveAndJoinBatchManagerWithIndex(address _troveOwner, uint256 _index, uint256 _coll, uint256 _debt, address _batchAddress, uint256 _annualInterestRate) internal returns (uint256) {
    if (!borrowerOperations.checkBatchManagerExists(_batchAddress)) {
        registerBatchManager(_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
    }
    IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: _troveOwner, ownerIndex: _index, collAmount: _coll, boldAmount: _debt, upperHint: 0, lowerHint: 0, interestBatchManager: _batchAddress, maxUpfrontFee: 1e24, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(_troveOwner);
    uint256 troveId = borrowerOperations.openTroveAndJoinInterestBatchManager(params);
    vm.stopPrank();
    return troveId;
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

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

### _max(uint256,uint256)

- **Kind**: internal
- **Source**: 255:114:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_max(uint256,uint256)`

```solidity
function _max(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? _a : _b;
}
```

### _addOneDebtAndEnsureItDoesntMintShares(uint256,address)

- **Kind**: internal
- **Source**: 8934:162:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_addOneDebtAndEnsureItDoesntMintShares(uint256,address)`

```solidity
function _addOneDebtAndEnsureItDoesntMintShares(uint256 troveId, address caller) internal {
    _addDebtAndEnsureItDoesntMintShares(troveId, caller, 1);
}
```

### _addDebtAndEnsureItDoesntMintShares(uint256,address,uint256)

- **Kind**: internal
- **Source**: 8535:393:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_addDebtAndEnsureItDoesntMintShares(uint256,address,uint256)`

```solidity
function _addDebtAndEnsureItDoesntMintShares(uint256 troveId, address caller, uint256 amt) internal {
    (, , , , , , , , , uint256 b4BatchDebtShares) = troveManager.Troves(troveId);
    withdrawBold100pct(caller, troveId, amt);
    (, , , , , , , , , uint256 afterBatchDebtShares) = troveManager.Troves(troveId);
    assertEq(b4BatchDebtShares, afterBatchDebtShares, "Same Shares");
}
```

### withdrawBold100pct(address,uint256,uint256)

- **Kind**: internal
- **Source**: 12286:279:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:withdrawBold100pct(address,uint256,uint256)`

```solidity
function withdrawBold100pct(address _account, uint256 _troveId, uint256 _debtIncrease) public {
    vm.startPrank(_account);
    borrowerOperations.withdrawBold(_troveId, _debtIncrease, predictAdjustTroveUpfrontFee(_troveId, _debtIncrease));
    vm.stopPrank();
}
```

### predictAdjustTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 4277:199:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictAdjustTroveUpfrontFee(uint256,uint256)`

```solidity
function predictAdjustTroveUpfrontFee(uint256 troveId, uint256 debtIncrease) internal view returns (uint256) {
    return hintHelpers.predictAdjustTroveUpfrontFee(0, troveId, debtIncrease);
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

### _getBatchDebtShares(uint256)

- **Kind**: internal
- **Source**: 9333:194:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_getBatchDebtShares(uint256)`

```solidity
function _getBatchDebtShares(uint256 troveId) internal view returns (uint256) {
    (, , , , , , , , , uint256 batchDebtShares) = troveManager.Troves(troveId);
    return batchDebtShares;
}
```

### closeTrove(address,uint256)

- **Kind**: internal
- **Source**: 12104:176:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:closeTrove(address,uint256)`

```solidity
function closeTrove(address _account, uint256 _troveId) public {
    vm.startPrank(_account);
    borrowerOperations.closeTrove(_troveId);
    vm.stopPrank();
}
```

### _openCloseRemainderLoop(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7371:753:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_openCloseRemainderLoop(uint256,uint256,uint256)`

```solidity
function _openCloseRemainderLoop(uint256 amt, uint256 BTroveId, uint256 iteration) internal {
    LatestTroveData memory troveBefore = troveManager.getLatestTroveData(BTroveId);
    uint256 ATroveId = openTroveAndJoinBatchManagerWithIndex(A, iteration + 1, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE);
    _addDebtAndEnsureItMintsShares(ATroveId, A, amt);
    closeTrove(A, ATroveId);
    LatestTroveData memory troveAfter = troveManager.getLatestTroveData(BTroveId);
    assertEq(troveAfter.entireDebt, troveBefore.entireDebt, "rebasing is not working");
    assertEq(troveAfter.entireDebt, 0, "trove B was closed");
}
```

### _addDebtAndEnsureItMintsShares(uint256,address,uint256)

- **Kind**: internal
- **Source**: 8130:399:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_addDebtAndEnsureItMintsShares(uint256,address,uint256)`

```solidity
function _addDebtAndEnsureItMintsShares(uint256 troveId, address caller, uint256 amt) internal {
    (, , , , , , , , , uint256 b4BatchDebtShares) = troveManager.Troves(troveId);
    withdrawBold100pct(caller, troveId, amt);
    (, , , , , , , , , uint256 afterBatchDebtShares) = troveManager.Troves(troveId);
    assertLt(b4BatchDebtShares, afterBatchDebtShares, "Shares should increase");
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

### _logTrovesAndBatch(address,uint256)

- **Kind**: internal
- **Source**: 6066:1299:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_logTrovesAndBatch(address,uint256)`

```solidity
function _logTrovesAndBatch(address batch, uint256) internal view {
    console2.log("");
    console2.log("Troves And Batch");
    uint256 batchDebt = _getLatestBatchDebt(batch);
    console2.log("Batch Debt:           ", batchDebt);
    uint256 batchShares = _getTotalBatchDebtShares(batch);
    console2.log("Batch Shares:         ", batchShares);
    uint256 batchSharesRatio = (batchShares > 0) ? (batchDebt / batchShares) : 0;
    console2.log("debt / shares ratio:  ", batchSharesRatio);
    console2.log("Ratio too high?       ", batchSharesRatio > MAX_BATCH_SHARES_RATIO);
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
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

### _getLatestBatchDebt(address)

- **Kind**: internal
- **Source**: 9102:225:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_getLatestBatchDebt(address)`

```solidity
function _getLatestBatchDebt(address batch) internal view returns (uint256) {
    LatestBatchData memory batchData = troveManager.getLatestBatchData(batch);
    return batchData.entireDebtWithoutRedistribution;
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### _getTotalBatchDebtShares(address)

- **Kind**: internal
- **Source**: 9533:201:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_getTotalBatchDebtShares(address)`

```solidity
function _getTotalBatchDebtShares(address batch) internal view returns (uint256) {
    (, , , , , , , uint256 allBatchDebtShares) = troveManager.getBatch(batch);
    return allBatchDebtShares;
}
```

### log(string,bool)

- **Kind**: internal
- **Source**: 7595:139:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,bool)`

```solidity
function log(string memory p0, bool p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
}
```

### _triggerInterestRateFee()

- **Kind**: internal
- **Source**: 5763:297:312
- **Link**: `test/rebasingBatchShares.t.sol:RebasingBatchShares:_triggerInterestRateFee()`

```solidity
function _triggerInterestRateFee() internal {
    vm.warp(block.timestamp + MIN_INTEREST_RATE_CHANGE_PERIOD);
    vm.startPrank(B);
    borrowerOperations.setBatchManagerAnnualInterestRate(1e18 - (subTractor++), 0, 0, type(uint256).max);
    vm.stopPrank();
}
```

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::startPrank(address)**
- **IBoldToken::transfer(address,uint256)**
- **IBoldToken::balanceOf(address)**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **ITroveManagerTester::getLatestBatchData(address)**
- **ITroveManagerTester::getLatestTroveData(uint256)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **WITH_INTEREST** (`bool`)
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **subTractor** (`uint128`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RebasingBatchShares.testBatchRebaseToSystemInsolvency() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [C, 100 ether, 100e21, MAX_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 4)
  │   💬 Args: [A, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 5)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 6)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 7)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 8)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 9)
  │   💬 Args: [B, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 10)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 11)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 12)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 13)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RebasingBatchShares._addOneDebtAndEnsureItDoesntMintShares(uint256,address) (NodeID: 14)
  │   💬 Args: [ATroveId, A]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: RebasingBatchShares._addDebtAndEnsureItDoesntMintShares(uint256,address,uint256) (NodeID: 15)
  │     💬 Args: [troveId, caller, 1]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest.withdrawBold100pct(address,uint256,uint256) (NodeID: 16)
  │   │   💬 Args: [caller, troveId, amt]
  │   │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 17)
  │   │     💬 Args: [_troveId, _debtIncrease]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 18)
  │       💬 Args: [b4BatchDebtShares, afterBatchDebtShares, "Same Shares"]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 19)
  │   💬 Args: [b4Batch.entireDebtWithoutRedistribution + 1, afterBatch.entireDebtWithoutRedistribution, "Debt is credited to batch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RebasingBatchShares._getBatchDebtShares(uint256) (NodeID: 20)
  │   💬 Args: [BTroveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 21)
  │   💬 Args: [sharesAfterRedeem, 0, "Must be 0, as it was fully redeemed"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 22)
  │   💬 Args: [bAfterRedeem.entireDebt, 0, "Must be 0, as it was fully redeemed"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.closeTrove(address,uint256) (NodeID: 23)
  │   💬 Args: [A, ATroveId]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 24)
  │   💬 Args: [afterClose.entireDebt, 0, "Still 0, as it had zero shares"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RebasingBatchShares._openCloseRemainderLoop(uint256,uint256,uint256) (NodeID: 25)
  │   💬 Args: [1, BTroveId, x]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 26)
  │ │   💬 Args: [A, iteration + 1, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 27)
  │ │     💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 28)
  │ │   │   💬 Args: [1e16, _annualInterestRate]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 29)
  │ │       💬 Args: [20e16, _annualInterestRate]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RebasingBatchShares._addDebtAndEnsureItMintsShares(uint256,address,uint256) (NodeID: 30)
  │ │   💬 Args: [ATroveId, A, amt]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.withdrawBold100pct(address,uint256,uint256) (NodeID: 31)
  │ │ │   💬 Args: [caller, troveId, amt]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest.predictAdjustTroveUpfrontFee(uint256,uint256) (NodeID: 32)
  │ │ │     💬 Args: [_troveId, _debtIncrease]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 33)
  │ │     💬 Args: [b4BatchDebtShares, afterBatchDebtShares, "Shares should increase"]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.closeTrove(address,uint256) (NodeID: 34)
  │ │   💬 Args: [A, ATroveId]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 35)
  │ │   💬 Args: [troveAfter.entireDebt, troveBefore.entireDebt, "rebasing is not working"]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 36)
  │     💬 Args: [troveAfter.entireDebt, 0, "trove B was closed"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RebasingBatchShares._logTrovesAndBatch(address,uint256) (NodeID: 37)
  │   💬 Args: [B, BTroveId]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 38)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 39)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 40)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 41)
  │ │   💬 Args: ["Troves And Batch"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 42)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 43)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RebasingBatchShares._getLatestBatchDebt(address) (NodeID: 44)
  │ │   💬 Args: [batch]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 45)
  │ │   💬 Args: ["Batch Debt:           ", batchDebt]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 46)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 47)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RebasingBatchShares._getTotalBatchDebtShares(address) (NodeID: 48)
  │ │   💬 Args: [batch]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 49)
  │ │   💬 Args: ["Batch Shares:         ", batchShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 50)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 51)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 52)
  │ │   💬 Args: ["debt / shares ratio:  ", batchSharesRatio]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 53)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 54)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 55)
  │     💬 Args: ["Ratio too high?       ", batchSharesRatio > MAX_BATCH_SHARES_RATIO]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 56)
  │       💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 57)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RebasingBatchShares._triggerInterestRateFee() (NodeID: 58)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 59)
  │   💬 Args: ["We have more than 2X MIN_DEBT of rebase it took us blocks:", y]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 60)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 61)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: RebasingBatchShares._logTrovesAndBatch(address,uint256) (NodeID: 62)
  │   💬 Args: [B, BTroveId]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 63)
  │ │   💬 Args: [""]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 64)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 65)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 66)
  │ │   💬 Args: ["Troves And Batch"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 67)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 68)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RebasingBatchShares._getLatestBatchDebt(address) (NodeID: 69)
  │ │   💬 Args: [batch]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 70)
  │ │   💬 Args: ["Batch Debt:           ", batchDebt]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 71)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 72)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RebasingBatchShares._getTotalBatchDebtShares(address) (NodeID: 73)
  │ │   💬 Args: [batch]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 74)
  │ │   💬 Args: ["Batch Shares:         ", batchShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 75)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 76)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 77)
  │ │   💬 Args: ["debt / shares ratio:  ", batchSharesRatio]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 78)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 79)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 80)
  │     💬 Args: ["Ratio too high?       ", batchSharesRatio > MAX_BATCH_SHARES_RATIO]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 81)
  │       💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 82)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 83)
  │   💬 Args: [A, x + 1, 100 ether, MIN_DEBT, B, MAX_ANNUAL_INTEREST_RATE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 84)
  │     💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 85)
  │   │   💬 Args: [1e16, _annualInterestRate]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 86)
  │       💬 Args: [20e16, _annualInterestRate]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 87)
      💬 Args: [anotherATroveId, 0]
      👁️  Def: internal
```
