# Function: testOpenTroveSetsTroveLastDebtUpdateTimeToNow()

**Contract**: [test/interestRateBasic.t.sol/contract_InterestRateBasic.md]

## Metadata

- **Contract**: InterestRateBasic
- **Signature**: `testOpenTroveSetsTroveLastDebtUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 559:685:307

## Implementation

```solidity
function testOpenTroveSetsTroveLastDebtUpdateTimeToNow() public {
    priceFeed.setPrice(2000e18);
    assertEq(troveManager.getTroveLastDebtUpdateTime(addressToTroveId(A)), 0);
    assertEq(troveManager.getTroveLastDebtUpdateTime(addressToTroveId(B)), 0);
    uint256 ATroveId = openTroveNoHints100pct(A, 2 ether, 2000e18, MIN_ANNUAL_INTEREST_RATE);
    assertEq(troveManager.getTroveLastDebtUpdateTime(ATroveId), block.timestamp);
    vm.warp(block.timestamp + 1000);
    uint256 BTroveId = openTroveNoHints100pct(B, 2 ether, 2000e18, MIN_ANNUAL_INTEREST_RATE);
    assertEq(troveManager.getTroveLastDebtUpdateTime(BTroveId), block.timestamp);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### addressToTroveId(address)

- **Kind**: internal
- **Source**: 449:123:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveId(address)`

```solidity
function addressToTroveId(address _owner) public pure returns (uint256) {
    return addressToTroveId(_owner, 0);
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

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManagerTester::getTroveLastDebtUpdateTime(uint256)**
- **Vm::warp(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateBasic.testOpenTroveSetsTroveLastDebtUpdateTimeToNow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [troveManager.getTroveLastDebtUpdateTime(addressToTroveId(A)), 0]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address) (NodeID: 2)
  │     💬 Args: [A]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 3)
  │       💬 Args: [_owner, 0]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 4)
  │         💬 Args: [_owner, _owner, _ownerIndex]
  │         👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [troveManager.getTroveLastDebtUpdateTime(addressToTroveId(B)), 0]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address) (NodeID: 6)
  │     💬 Args: [B]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 7)
  │       💬 Args: [_owner, 0]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 8)
  │         💬 Args: [_owner, _owner, _ownerIndex]
  │         👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 9)
  │   💬 Args: [A, 2 ether, 2000e18, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 10)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 11)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
  │   💬 Args: [troveManager.getTroveLastDebtUpdateTime(ATroveId), block.timestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest.openTroveNoHints100pct(address,uint256,uint256,uint256) (NodeID: 13)
  │   💬 Args: [B, 2 ether, 2000e18, MIN_ANNUAL_INTEREST_RATE]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BaseTest.openTroveHelper(address,uint256,uint256,uint256,uint256) (NodeID: 14)
  │     💬 Args: [_account, 0, _coll, _boldAmount, _annualInterestRate]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 15)
  │       💬 Args: [_boldAmount, _annualInterestRate]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
      💬 Args: [troveManager.getTroveLastDebtUpdateTime(BTroveId), block.timestamp]
      👁️  Def: internal
```
