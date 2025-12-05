# Function: testBaseRateDecayCannotBeSlowedDown()

**Contract**: [test/redemptions.t.sol/contract_Redemptions.md]

## Metadata

- **Contract**: Redemptions
- **Signature**: `testBaseRateDecayCannotBeSlowedDown()`
- **Visibility**: external
- **Source Range**: 47561:934:332

## Implementation

```solidity
function testBaseRateDecayCannotBeSlowedDown() external {
    openTroveHelper({_account: A, _index: 0, _coll: 1e4 ether, _boldAmount: 1e6 ether, _annualInterestRate: MIN_ANNUAL_INTEREST_RATE});
    uint256 initialBaseRate = collateralRegistry.baseRate();
    for (uint256 i = 0; i < 60; ++i) {
        skip(2 minutes - 1 seconds);
        redeem(A, 1 wei);
    }
    uint256 finalBaseRate = collateralRegistry.baseRate();
    assertApproxEqAbsDecimal(finalBaseRate, (initialBaseRate * LiquityMath._decPow(REDEMPTION_MINUTE_DECAY_FACTOR, 119)) / DECIMAL_PRECISION, 100, 18, "wrong final base rate");
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

### skip(uint256)

- **Kind**: internal
- **Source**: 24925:100:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:skip(uint256)`

```solidity
function skip(uint256 time) virtual internal {
    vm.warp(vm.getBlockTimestamp() + time);
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

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
}
```

### _decPow(uint256,uint256)

- **Kind**: internal
- **Source**: 1800:686:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_decPow(uint256,uint256)`

```solidity
function _decPow(uint256 _base, uint256 _minutes) internal pure returns (uint256) {
    if (_minutes > 525600000) _minutes = 525600000;
    if (_minutes == 0) return DECIMAL_PRECISION;
    uint256 y = DECIMAL_PRECISION;
    uint256 x = _base;
    uint256 n = _minutes;
    while (n > 1) {
        if ((n % 2) == 0) {
            x = decMul(x, x);
            n = n / 2;
        } else {
            y = decMul(x, y);
            x = decMul(x, x);
            n = (n - 1) / 2;
        }
    }
    return decMul(x, y);
}
```

### decMul(uint256,uint256)

- **Kind**: internal
- **Source**: 752:192:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:decMul(uint256,uint256)`

```solidity
function decMul(uint256 x, uint256 y) internal pure returns (uint256 decProd) {
    uint256 prod_xy = x * y;
    decProd = (prod_xy + (DECIMAL_PRECISION / 2)) / DECIMAL_PRECISION;
}
```

## External Calls

- **ICollateralRegistry::baseRate()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Redemptions.testBaseRateDecayCannotBeSlowedDown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [A, 0, 1e4 ether, 1e6 ether, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_boldAmount, _annualInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 3)
  │   💬 Args: [2 minutes - 1 seconds]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 4)
  │   💬 Args: [A, 1 wei]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 5)
      💬 Args: [finalBaseRate, (initialBaseRate * LiquityMath._decPow(REDEMPTION_MINUTE_DECAY_FACTOR, 119)) / DECIMAL_PRECISION, 100, 18, "wrong final base rate"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LiquityMath._decPow(uint256,uint256) (NodeID: 6)
        💬 Args: [REDEMPTION_MINUTE_DECAY_FACTOR, 119]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 7)
      │   💬 Args: [x, x]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 8)
      │   💬 Args: [x, y]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 9)
      │   💬 Args: [x, x]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 10)
          💬 Args: [x, y]
          👁️  Def: internal
```
