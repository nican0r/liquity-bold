# Function: test_OpenTroveEmitsTroveUpdated()

**Contract**: [test/events.t.sol/contract_TroveEventsTest.md]

## Metadata

- **Contract**: TroveEventsTest
- **Signature**: `test_OpenTroveEmitsTroveUpdated()`
- **Visibility**: external
- **Source Range**: 2397:893:303

## Implementation

```solidity
function test_OpenTroveEmitsTroveUpdated() external {
    address owner = A;
    uint256 ownerIndex = 0;
    uint256 coll = 100 ether;
    uint256 borrow = 10_000 ether;
    uint256 interestRate = 0.01 ether;
    uint256 troveId = addressToTroveId(owner, ownerIndex);
    uint256 upfrontFee = predictOpenTroveUpfrontFee(borrow, interestRate);
    uint256 debt = borrow + upfrontFee;
    uint256 stake = coll;
    vm.expectEmit();
    emit TroveUpdated(troveId, debt, coll, stake, interestRate, 0, 0);
    vm.prank(owner);
    borrowerOperations.openTrove(owner, ownerIndex, coll, borrow, 0, 0, interestRate, upfrontFee, address(0), address(0), address(0));
}
```

## Related Implementations

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

- **Vm::expectEmit()**
- **Vm::prank(address)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**

## State Variable Reads

- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveEventsTest.test_OpenTroveEmitsTroveUpdated() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 1)
  │   💬 Args: [owner, ownerIndex]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 2)
  │     💬 Args: [_owner, _owner, _ownerIndex]
  │     👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 3)
      💬 Args: [borrow, interestRate]
      👁️  Def: internal
```
