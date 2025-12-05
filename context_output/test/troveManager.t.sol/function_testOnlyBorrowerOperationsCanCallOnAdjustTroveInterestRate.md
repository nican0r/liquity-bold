# Function: testOnlyBorrowerOperationsCanCallOnAdjustTroveInterestRate()

**Contract**: [test/troveManager.t.sol/contract_TroveManagerTest.md]

## Metadata

- **Contract**: TroveManagerTest
- **Signature**: `testOnlyBorrowerOperationsCanCallOnAdjustTroveInterestRate()`
- **Visibility**: public
- **Source Range**: 1601:357:335

## Implementation

```solidity
function testOnlyBorrowerOperationsCanCallOnAdjustTroveInterestRate() public {
    vm.startPrank(A);
    vm.expectRevert(TroveManager.CallerNotBorrowerOperations.selector);
    TroveChange memory troveChange;
    troveManager.onAdjustTroveInterestRate(addressToTroveId(A), 10000e18, 5000e18, 6e16, troveChange);
    vm.stopPrank();
}
```

## Related Implementations

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

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **ITroveManagerTester::onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTest.testOnlyBorrowerOperationsCanCallOnAdjustTroveInterestRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: TroveId.addressToTroveId(address) (NodeID: 1)
      💬 Args: [A]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 2)
        💬 Args: [_owner, 0]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 3)
          💬 Args: [_owner, _owner, _ownerIndex]
          👁️  Def: public
```
