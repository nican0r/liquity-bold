# Function: testGetCurrentICRReturnsInfinityForNonExistentTrove()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `testGetCurrentICRReturnsInfinityForNonExistentTrove()`
- **Visibility**: public
- **Source Range**: 75370:243:306

## Implementation

```solidity
function testGetCurrentICRReturnsInfinityForNonExistentTrove() public {
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 ICR = troveManager.getCurrentICR(addressToTroveId(A), price);
    assertEq(ICR, MAX_UINT256);
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **IPriceFeedTestnet::fetchPrice()**
- **ITroveManagerTester::getCurrentICR(uint256,uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InterestRateAggregate.testGetCurrentICRReturnsInfinityForNonExistentTrove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TroveId.addressToTroveId(address) (NodeID: 1)
  │   💬 Args: [A]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 2)
  │     💬 Args: [_owner, 0]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 3)
  │       💬 Args: [_owner, _owner, _ownerIndex]
  │       👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [ICR, MAX_UINT256]
      👁️  Def: internal
```
