# Function: testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor()

**Contract**: [test/stabilityPool.t.sol/contract_SPTest.md]

## Metadata

- **Contract**: SPTest
- **Signature**: `testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor()`
- **Visibility**: public
- **Source Range**: 4267:782:334

## Implementation

```solidity
function testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor() public {
    _setupStashedAndCurrentCollGains();
    uint256 stashedCollGain = stabilityPool.stashedColl(A);
    uint256 currentCollGain = stabilityPool.getDepositorCollGain(A);
    assertGt(stashedCollGain, 0);
    assertGt(currentCollGain, 0);
    uint256 collBal_A = collToken.balanceOf(A);
    assertGt(collBal_A, 0);
    makeSPDepositAndClaim(A, 1e18);
    assertEq(collToken.balanceOf(A), (collBal_A + stashedCollGain) + currentCollGain);
}
```

## Related Implementations

### _setupStashedAndCurrentCollGains()

- **Kind**: internal
- **Source**: 2315:920:334
- **Link**: `test/stabilityPool.t.sol:SPTest:_setupStashedAndCurrentCollGains()`

```solidity
function _setupStashedAndCurrentCollGains() internal {
    ABCDEF memory troveIDs = _setupForSPDepositAdjustments();
    makeSPDepositNoClaim(A, 1e18);
    liquidate(A, troveIDs.D);
    assertEq(uint8(troveManager.getTroveStatus(troveIDs.D)), uint8(ITroveManager.Status.closedByLiquidation));
    uint256 stashedCollGain_A = stabilityPool.stashedColl(A);
    uint256 currentCollGain_A = stabilityPool.getDepositorCollGain(A);
    assertGt(stashedCollGain_A, 0);
    assertGt(currentCollGain_A, 0);
    uint256 stashedCollGain_B = stabilityPool.stashedColl(B);
    uint256 currentCollGain_B = stabilityPool.getDepositorCollGain(B);
    assertEq(stashedCollGain_B, 0);
    assertGt(currentCollGain_B, 0);
}
```

### _setupForSPDepositAdjustments()

- **Kind**: internal
- **Source**: 5907:548:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_setupForSPDepositAdjustments()`

```solidity
function _setupForSPDepositAdjustments() internal returns (ABCDEF memory troveIDs) {
    (troveIDs.A, troveIDs.B, troveIDs.C, troveIDs.D) = _setupForBatchLiquidateTrovesPureOffset(1);
    liquidate(A, troveIDs.C);
    transferBold(D, A, boldToken.balanceOf(D) / 2);
    transferBold(D, B, boldToken.balanceOf(D));
    assertEq(uint8(troveManager.getTroveStatus(troveIDs.C)), uint8(ITroveManager.Status.closedByLiquidation));
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

### transferBold(address,address,uint256)

- **Kind**: internal
- **Source**: 13415:177:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:transferBold(address,address,uint256)`

```solidity
function transferBold(address _from, address _to, uint256 _amount) public {
    vm.startPrank(_from);
    boldToken.transfer(_to, _amount);
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

- **IStabilityPool::stashedColl(address)**
- **IStabilityPool::getDepositorCollGain(address)**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPTest.testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SPTest._setupStashedAndCurrentCollGains() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DevTestSetup._setupForSPDepositAdjustments() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: DevTestSetup._setupForBatchLiquidateTrovesPureOffset(uint256) (NodeID: 3)
  │ │ │   💬 Args: [1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 4)
  │ │ │ │   💬 Args: [A, 5 ether * _magnitude, troveDebtRequest_A, interestRate]
  │ │ │ │   👁️  Def: public
  │ │ │ │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 5)
  │ │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │ │     👁️  Def: public
  │ │ │ │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 6)
  │ │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 7)
  │ │ │ │   💬 Args: [B, 5 ether * _magnitude, troveDebtRequest_B, interestRate]
  │ │ │ │   👁️  Def: public
  │ │ │ │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 8)
  │ │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │ │     👁️  Def: public
  │ │ │ │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 9)
  │ │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 10)
  │ │ │ │   💬 Args: [C, 25e17 * _magnitude, troveDebtRequest_C, interestRate]
  │ │ │ │   👁️  Def: public
  │ │ │ │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 11)
  │ │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │ │     👁️  Def: public
  │ │ │ │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 12)
  │ │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 13)
  │ │ │ │   💬 Args: [D, 25e17 * _magnitude, troveDebtRequest_D, interestRate]
  │ │ │ │   👁️  Def: public
  │ │ │ │ └─ [5] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 14)
  │ │ │ │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │ │ │ │     👁️  Def: public
  │ │ │ │   └─ [6] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 15)
  │ │ │ │       💬 Args: [_boldAmount, _annualInterestRate]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 16)
  │ │ │ │   💬 Args: [A, troveDebtRequest_A]
  │ │ │ │   👁️  Def: public
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 17)
  │ │ │ │   💬 Args: [B, troveDebtRequest_B]
  │ │ │ │   👁️  Def: public
  │ │ │ ├─ [4] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 18)
  │ │ │ │   💬 Args: [troveManager.checkBelowCriticalThreshold(price)]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 19)
  │ │ │ │   💬 Args: [troveManager.getCurrentICR(troveIDs.C, price), MCR]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 20)
  │ │ │     💬 Args: [troveManager.getCurrentICR(troveIDs.D, price), MCR]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 21)
  │ │ │   💬 Args: [A, troveIDs.C]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 22)
  │ │ │   💬 Args: [D, A, boldToken.balanceOf(D) / 2]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 23)
  │ │ │   💬 Args: [D, B, boldToken.balanceOf(D)]
  │ │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 24)
  │ │     💬 Args: [uint8(troveManager.getTroveStatus(troveIDs.C)), uint8(ITroveManager.Status.closedByLiquidation)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 25)
  │ │   💬 Args: [A, 1e18]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.liquidate(address,uint256) (NodeID: 26)
  │ │   💬 Args: [A, troveIDs.D]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 27)
  │ │   💬 Args: [uint8(troveManager.getTroveStatus(troveIDs.D)), uint8(ITroveManager.Status.closedByLiquidation)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 28)
  │ │   💬 Args: [stashedCollGain_A, 0]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 29)
  │ │   💬 Args: [currentCollGain_A, 0]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 30)
  │ │   💬 Args: [stashedCollGain_B, 0]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 31)
  │     💬 Args: [currentCollGain_B, 0]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 32)
  │   💬 Args: [stashedCollGain, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 33)
  │   💬 Args: [currentCollGain, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 34)
  │   💬 Args: [collBal_A, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 35)
  │   💬 Args: [A, 1e18]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 36)
      💬 Args: [collToken.balanceOf(A), (collBal_A + stashedCollGain) + currentCollGain]
      👁️  Def: internal
```
