# Function: test_WhenBatchSharesRatioIsTooHigh_CanKickTroveFromBatch()

**Contract**: [test/rebasingBatchShares.t.sol/contract_RebasingBatchShares.md]

## Metadata

- **Contract**: RebasingBatchShares
- **Signature**: `test_WhenBatchSharesRatioIsTooHigh_CanKickTroveFromBatch()`
- **Visibility**: external
- **Source Range**: 13135:3932:312

## Implementation

```solidity
function test_WhenBatchSharesRatioIsTooHigh_CanKickTroveFromBatch() external {
    registerBatchManager({_account: B, _minInterestRate: uint128(MIN_ANNUAL_INTEREST_RATE), _maxInterestRate: uint128(MAX_ANNUAL_INTEREST_RATE), _currentInterestRate: uint128(MAX_ANNUAL_INTEREST_RATE), _fee: MAX_ANNUAL_BATCH_MANAGEMENT_FEE, _minInterestRateChangePeriod: MIN_INTEREST_RATE_CHANGE_PERIOD});
    uint256 placeholderTrove = openTroveAndJoinBatchManager({_troveOwner: C, _coll: 1_000_000 ether, _debt: MIN_DEBT, _batchAddress: B, _annualInterestRate: 0});
    uint256 targetTrove = openTroveAndJoinBatchManager({_troveOwner: A, _coll: 1_000_000 ether, _debt: MIN_DEBT, _batchAddress: B, _annualInterestRate: 0});
    openTroveHelper({_account: A, _index: 1, _coll: 1_000_000 ether, _boldAmount: 10_000_000 ether, _annualInterestRate: MAX_ANNUAL_INTEREST_RATE});
    for (uint256 i = 1; ; ++i) {
        skip(MIN_INTEREST_RATE_CHANGE_PERIOD);
        setBatchInterestRate(B, MAX_ANNUAL_INTEREST_RATE - (i % 2));
        (uint256 debt, , , , , , , uint256 shares) = troveManager.getBatch(B);
        if ((shares * MAX_BATCH_SHARES_RATIO) < debt) break;
        vm.expectRevert(BorrowerOperations.BatchSharesRatioTooLow.selector);
        borrowerOperations.kickFromBatch(targetTrove, 0, 0);
        repayBold(A, targetTrove, troveManager.getTroveEntireDebt(targetTrove) - MIN_DEBT);
        repayBold(A, placeholderTrove, troveManager.getTroveEntireDebt(placeholderTrove) - MIN_DEBT);
    }
    skip(MIN_INTEREST_RATE_CHANGE_PERIOD);
    setBatchInterestRate(B, MIN_ANNUAL_INTEREST_RATE);
    redeem(A, troveManager.getTroveEntireDebt(targetTrove));
    assertTrue(troveManager.checkTroveIsZombie(targetTrove), "not a zombie");
    (uint256 liquidatedTrove, ) = openTroveWithExactICRAndDebt({_account: D, _index: 0, _ICR: MCR, _debt: 100_000 ether, _interestRate: MIN_ANNUAL_INTEREST_RATE});
    priceFeed.setPrice((priceFeed.getPrice() * 99) / 100);
    liquidate(A, liquidatedTrove);
    assertGeDecimal(troveManager.getTroveEntireDebt(targetTrove), MIN_DEBT, 18, "debt < MIN_DEBT");
    vm.expectRevert(TroveManager.BatchSharesRatioTooHigh.selector);
    borrowerOperations.applyPendingDebt(targetTrove);
    borrowerOperations.kickFromBatch(targetTrove, 0, 0);
    borrowerOperations.applyPendingDebt(targetTrove);
    uint256 debtBefore = troveManager.getTroveEntireDebt(targetTrove);
    redeem(A, 1_000 ether);
    assertEqDecimal(troveManager.getTroveEntireDebt(targetTrove), debtBefore - 1_000 ether, 18, "wrong debt");
}
```

## Related Implementations

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

### skip(uint256)

- **Kind**: internal
- **Source**: 24925:100:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:skip(uint256)`

```solidity
function skip(uint256 time) virtual internal {
    vm.warp(vm.getBlockTimestamp() + time);
}
```

### setBatchInterestRate(address,uint256)

- **Kind**: internal
- **Source**: 17019:283:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:setBatchInterestRate(address,uint256)`

```solidity
function setBatchInterestRate(address _batchAddress, uint256 _newAnnualInterestRate) internal {
    vm.startPrank(_batchAddress);
    borrowerOperations.setBatchManagerAnnualInterestRate(uint128(_newAnnualInterestRate), 0, 0, type(uint256).max);
    vm.stopPrank();
}
```

### repayBold(address,uint256,uint256)

- **Kind**: internal
- **Source**: 12571:212:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:repayBold(address,uint256,uint256)`

```solidity
function repayBold(address _account, uint256 _troveId, uint256 _debtDecrease) public {
    vm.startPrank(_account);
    borrowerOperations.repayBold(_troveId, _debtDecrease);
    vm.stopPrank();
}
```

### redeem(address,uint256)

- **Kind**: internal
- **Source**: 13971:197:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:redeem(address,uint256)`

```solidity
function redeem(address _from, uint256 _boldAmount) public {
    vm.startPrank(_from);
    collateralRegistry.redeemCollateral(_boldAmount, MAX_UINT256, 1e18);
    vm.stopPrank();
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
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

### assertGeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 15894:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGeDecimal(left, right, decimals, err);
}
```

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **ITroveManagerTester::getBatch(address)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperationsTester::kickFromBatch(uint256,uint256,uint256)**
- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **ITroveManagerTester::checkTroveIsZombie(uint256)**
- **IPriceFeedTestnet::setPrice(uint256)**
- **IPriceFeedTestnet::getPrice()**
- **IBorrowerOperationsTester::applyPendingDebt(uint256)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RebasingBatchShares.test_WhenBatchSharesRatioIsTooHigh_CanKickTroveFromBatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 1)
  │   💬 Args: [B, uint128(MIN_ANNUAL_INTEREST_RATE), uint128(MAX_ANNUAL_INTEREST_RATE), uint128(MAX_ANNUAL_INTEREST_RATE), MAX_ANNUAL_BATCH_MANAGEMENT_FEE, MIN_INTEREST_RATE_CHANGE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 2)
  │   💬 Args: [C, 1_000_000 ether, MIN_DEBT, B, 0]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 3)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 4)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 5)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 6)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManager(address,uint256,uint256,address,uint256) (NodeID: 7)
  │   💬 Args: [A, 1_000_000 ether, MIN_DEBT, B, 0]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveAndJoinBatchManagerWithIndex(address,uint256,uint256,uint256,address,uint256) (NodeID: 8)
  │     💬 Args: [_troveOwner, 0, _coll, _debt, _batchAddress, _annualInterestRate]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 9)
  │       💬 Args: [_batchAddress, uint128(LiquityMath._min(1e16, _annualInterestRate)), uint128(LiquityMath._max(20e16, _annualInterestRate)), uint128(_annualInterestRate), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 10)
  │     │   💬 Args: [1e16, _annualInterestRate]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 11)
  │         💬 Args: [20e16, _annualInterestRate]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 12)
  │   💬 Args: [A, 1, 1_000_000 ether, 10_000_000 ether, MAX_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 13)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 14)
  │   💬 Args: [MIN_INTEREST_RATE_CHANGE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.setBatchInterestRate(address,uint256) (NodeID: 15)
  │   💬 Args: [B, MAX_ANNUAL_INTEREST_RATE - (i % 2)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.repayBold(address,uint256,uint256) (NodeID: 16)
  │   💬 Args: [A, targetTrove, troveManager.getTroveEntireDebt(targetTrove) - MIN_DEBT]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.repayBold(address,uint256,uint256) (NodeID: 17)
  │   💬 Args: [A, placeholderTrove, troveManager.getTroveEntireDebt(placeholderTrove) - MIN_DEBT]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 18)
  │   💬 Args: [MIN_INTEREST_RATE_CHANGE_PERIOD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.setBatchInterestRate(address,uint256) (NodeID: 19)
  │   💬 Args: [B, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 20)
  │   💬 Args: [A, troveManager.getTroveEntireDebt(targetTrove)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 21)
  │   💬 Args: [troveManager.checkTroveIsZombie(targetTrove), "not a zombie"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 22)
  │   💬 Args: [D, 0, MCR, 100_000 ether, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 23)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 24)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 25)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 26)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 27)
  │   💬 Args: [A, liquidatedTrove]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 28)
  │   💬 Args: [troveManager.getTroveEntireDebt(targetTrove), MIN_DEBT, 18, "debt < MIN_DEBT"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 29)
  │   💬 Args: [A, 1_000 ether]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 30)
      💬 Args: [troveManager.getTroveEntireDebt(targetTrove), debtBefore - 1_000 ether, 18, "wrong debt"]
      👁️  Def: internal
```
