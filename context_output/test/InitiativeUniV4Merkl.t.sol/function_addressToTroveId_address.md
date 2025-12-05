# Function: addressToTroveId(address)

**Contract**: [test/InitiativeUniV4Merkl.t.sol/contract_InitiativeUniV4Merkl.md]

## Metadata

- **Contract**: InitiativeUniV4Merkl
- **Signature**: `addressToTroveId(address)`
- **Visibility**: public
- **Source Range**: 449:123:294
- **Inherited From**: TroveId

## Implementation

```solidity
function addressToTroveId(address _owner) public pure returns (uint256) {
    return addressToTroveId(_owner, 0);
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveId.addressToTroveId(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: TroveId.addressToTroveId(address,uint256) (NodeID: 1)
      💬 Args: [_owner, 0]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 2)
        💬 Args: [_owner, _owner, _ownerIndex]
        👁️  Def: public
```
