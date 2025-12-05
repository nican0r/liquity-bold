# Function: test_GetDebtBetweenInterestRates(uint256[8],uint256,uint256,uint8)

**Contract**: [test/DebtInFrontHelper.t.sol/contract_DebtInFrontHelperTest.md]

## Metadata

- **Contract**: DebtInFrontHelperTest
- **Signature**: `test_GetDebtBetweenInterestRates(uint256[8],uint256,uint256,uint8)`
- **Visibility**: external
- **Source Range**: 511:1839:230

## Implementation

```solidity
function test_GetDebtBetweenInterestRates(uint256[8] memory debt, uint256 excludedTroveId, uint256 hintId, uint8 numTrials) external {
    for (uint256 i = 0; i < debt.length; ++i) {
        debt[i] = bound(debt[i], 2_000 ether, 10_000 ether);
    }
    excludedTroveId = bound(excludedTroveId, 0, debt.length);
    if (excludedTroveId > 0) excludedTroveId = addressToTroveId(A, excludedTroveId - 1);
    hintId = bound(hintId, 0, debt.length);
    if (hintId > 0) hintId = addressToTroveId(A, hintId - 1);
    openTroveWithExactICRAndDebt(A, 1, 2 ether, debt[1], 0.005 ether);
    openTroveWithExactICRAndDebt(A, 0, 2 ether, debt[0], 0.005 ether);
    openTroveWithExactICRAndDebt(A, 3, 2 ether, debt[3], 0.006 ether);
    openTroveWithExactICRAndDebt(A, 2, 2 ether, debt[2], 0.006 ether);
    openTroveWithExactICRAndDebt(A, 5, 2 ether, debt[5], 0.007 ether);
    openTroveWithExactICRAndDebt(A, 4, 2 ether, debt[4], 0.007 ether);
    openTroveWithExactICRAndDebt(A, 7, 2 ether, debt[7], 0.008 ether);
    openTroveWithExactICRAndDebt(A, 6, 2 ether, debt[6], 0.008 ether);
    uint256 expectedDebt = 0;
    for (uint256 i = 2; i < 6; ++i) {
        uint256 troveId = addressToTroveId(A, i);
        if (troveId != excludedTroveId) expectedDebt += troveManager.getTroveEntireDebt(troveId);
    }
    (uint256 actualDebt, ) = debtInFrontHelper.getDebtBetweenInterestRates(0, 0.006 ether, 0.008 ether, excludedTroveId, hintId, numTrials);
    assertEqDecimal(actualDebt, expectedDebt, 18);
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

### addressToTroveId(address,uint256)

- **Kind**: internal
- **Source**: 281:162:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveId(address,uint256)`

```solidity
function addressToTroveId(address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    return addressToTroveId(_owner, _owner, _ownerIndex);
}
```

### addressToTroveId(address,address,uint256)

- **Kind**: internal
- **Source**: 81:194:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveId(address,address,uint256)`

```solidity
function addressToTroveId(address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    return uint256(keccak256(abi.encode(_sender, _owner, _ownerIndex)));
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

### predictOpenTroveUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 3546:209:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:predictOpenTroveUpfrontFee(uint256,uint256)`

```solidity
function predictOpenTroveUpfrontFee(uint256 borrowedAmount, uint256 interestRate) internal view returns (uint256) {
    return hintHelpers.predictOpenTroveUpfrontFee(0, borrowedAmount, interestRate);
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

### assertEqDecimal(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2526:152:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals);
}
```

## External Calls

- **ITroveManagerTester::getTroveEntireDebt(uint256)**
- **IDebtInFrontHelper::getDebtBetweenInterestRates(uint256,uint256,uint256,uint256,uint256,uint256)**

## State Variable Reads

- **debtInFrontHelper** (`contract IDebtInFrontHelper`) [src/Interfaces/IDebtInFrontHelper.sol/interface_IDebtInFrontHelper.md]
- **UINT256_MAX** (`uint256`)
- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DebtInFrontHelperTest.test_GetDebtBetweenInterestRates(uint256[8],uint256,uint256,uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [debt[i], 2_000 ether, 10_000 ether]
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
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [excludedTroveId, 0, debt.length]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 8)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 11)
  │   💬 Args: [A, excludedTroveId - 1]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 12)
  │     💬 Args: [_owner, _owner, _ownerIndex]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 13)
  │   💬 Args: [hintId, 0, debt.length]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 14)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 15)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 16)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 17)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 18)
  │   💬 Args: [A, hintId - 1]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 19)
  │     💬 Args: [_owner, _owner, _ownerIndex]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 20)
  │   💬 Args: [A, 1, 2 ether, debt[1], 0.005 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 21)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 22)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 23)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 24)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 25)
  │   💬 Args: [A, 0, 2 ether, debt[0], 0.005 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 26)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 27)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 28)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 29)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 30)
  │   💬 Args: [A, 3, 2 ether, debt[3], 0.006 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 31)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 32)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 33)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 34)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 35)
  │   💬 Args: [A, 2, 2 ether, debt[2], 0.006 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 36)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 37)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 38)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 39)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 40)
  │   💬 Args: [A, 5, 2 ether, debt[5], 0.007 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 41)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 42)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 43)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 44)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 45)
  │   💬 Args: [A, 4, 2 ether, debt[4], 0.007 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 46)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 47)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 48)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 49)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 50)
  │   💬 Args: [A, 7, 2 ether, debt[7], 0.008 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 51)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 52)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 53)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 54)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (NodeID: 55)
  │   💬 Args: [A, 6, 2 ether, debt[6], 0.008 ether]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.findAmountToBorrowWithOpenTrove(uint256,uint256) (NodeID: 56)
  │ │   💬 Args: [_debt, _interestRate]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 57)
  │ │ │   💬 Args: [borrowRight, interestRate]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 58)
  │ │     💬 Args: [borrow, interestRate]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.mulDivCeil(uint256,uint256,uint256) (NodeID: 59)
  │     💬 Args: [_debt, _ICR, price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 60)
  │   💬 Args: [A, i]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 61)
  │     💬 Args: [_owner, _owner, _ownerIndex]
  │     👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256) (NodeID: 62)
      💬 Args: [actualDebt, expectedDebt, 18]
      👁️  Def: internal
```
