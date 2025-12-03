# Function: testSPWithdrawalMintsInterestToSP()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testSPWithdrawalMintsInterestToSP()`
- **Visibility**: public
- **Source Range**: 18110:1401:306

## Implementation

```solidity
function testSPWithdrawalMintsInterestToSP() public {
    uint256 troveDebtRequest = 2000e18;
    uint256 sPdeposit = 100e18;
    priceFeed.setPrice(2000e18);
    openTroveNoHints100pct(A, 2 ether, troveDebtRequest, 25e16);
    makeSPDepositAndClaim(A, sPdeposit);
    transferBold(A, B, 1e18);
    makeSPDepositAndClaim(B, 1e18);
    makeSPWithdrawalAndClaim(A, 0);
    vm.warp(block.timestamp + 1 days);
    uint256 boldBalSP_1 = boldToken.balanceOf(address(stabilityPool));
    assertGt(boldBalSP_1, 0);
    uint256 pendingAggInterest = activePool.calcPendingAggInterest();
    assertGt(pendingAggInterest, 0);
    uint256 expectedSPYield_A = _getSPYield(pendingAggInterest);
    uint256 expectedBoldGain_A = getShareofSPReward(A, expectedSPYield_A);
    assertGt(expectedBoldGain_A, 0);
    makeSPWithdrawalAndClaim(A, sPdeposit);
    uint256 boldBalSP_2 = boldToken.balanceOf(address(stabilityPool));
    assertApproximatelyEqual(boldBalSP_2, ((boldBalSP_1 - sPdeposit) + expectedSPYield_A) - expectedBoldGain_A, 1e3);
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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### _getSPYield(uint256)

- **Kind**: internal
- **Source**: 14591:241:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:_getSPYield(uint256)`

```solidity
function _getSPYield(uint256 _aggInterest) internal pure returns (uint256) {
    uint256 spYield = (SP_YIELD_SPLIT * _aggInterest) / 1e18;
    assertGt(spYield, 0);
    assertLe(spYield, _aggInterest);
    return spYield;
}
```

### assertLe(uint256,uint256)

- **Kind**: internal
- **Source**: 14296:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256)`

```solidity
function assertLe(uint256 left, uint256 right) virtual internal pure {
    vm.assertLe(left, right);
}
```

### getShareofSPReward(address,uint256)

- **Kind**: internal
- **Source**: 14174:218:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:getShareofSPReward(address,uint256)`

```solidity
function getShareofSPReward(address _depositor, uint256 _reward) public view returns (uint256) {
    return (_reward * stabilityPool.getCompoundedBoldDeposit(_depositor)) / stabilityPool.getTotalBoldDeposits();
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
- **Vm::warp(uint256)**
- **IBoldToken::balanceOf(address)**
- **IActivePool::calcPendingAggInterest()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testSPWithdrawalMintsInterestToSP() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 2 ether, troveDebtRequest, 25e16]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 4)
  │   💬 Args: [A, sPdeposit]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.transferBold(address,address,uint256) (NodeID: 5)
  │   💬 Args: [A, B, 1e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 6)
  │   💬 Args: [B, 1e18]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 7)
  │   💬 Args: [A, 0]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 8)
  │   💬 Args: [boldBalSP_1, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 9)
  │   💬 Args: [pendingAggInterest, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DevTestSetup._getSPYield(uint256) (NodeID: 10)
  │   💬 Args: [pendingAggInterest]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 11)
  │ │   💬 Args: [spYield, 0]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 12)
  │     💬 Args: [spYield, _aggInterest]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.getShareofSPReward(address,uint256) (NodeID: 13)
  │   💬 Args: [A, expectedSPYield_A]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 14)
  │   💬 Args: [expectedBoldGain_A, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.makeSPWithdrawalAndClaim(address,uint256) (NodeID: 15)
  │   💬 Args: [A, sPdeposit]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.assertApproximatelyEqual(uint256,uint256,uint256) (NodeID: 16)
      💬 Args: [boldBalSP_2, ((boldBalSP_1 - sPdeposit) + expectedSPYield_A) - expectedBoldGain_A, 1e3]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbs(uint256,uint256,uint256,string) (NodeID: 17)
        💬 Args: [_x, _y, _margin, ""]
        👁️  Def: internal
```
