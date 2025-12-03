# Function: addressToTroveIdThroughZapper(address,address,uint256)

**Contract**: [test/liquidationCosts.t.sol/contract_LiquidationCostsTest.md]

## Metadata

- **Contract**: LiquidationCostsTest
- **Signature**: `addressToTroveIdThroughZapper(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 908:242:294
- **Inherited From**: TroveId

## Implementation

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    return addressToTroveIdThroughZapper(_zapper, _owner, _owner, _ownerIndex);
}
```

## Related Implementations

### addressToTroveIdThroughZapper(address,address,address,uint256)

- **Kind**: internal
- **Source**: 578:324:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveIdThroughZapper(address,address,address,uint256)`

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    uint256 index = uint256(keccak256(abi.encode(_sender, _ownerIndex)));
    return uint256(keccak256(abi.encode(_zapper, _owner, index)));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 1)
      💬 Args: [_zapper, _owner, _owner, _ownerIndex]
      👁️  Def: public
```
