# Function: addressToTroveIdThroughZapper(address,address,address,uint256)

**Contract**: [test/Utils/E2EHelpers.sol/contract_E2EHelpers.md]

## Metadata

- **Contract**: E2EHelpers
- **Signature**: `addressToTroveIdThroughZapper(address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 578:324:294
- **Inherited From**: TroveId

## Implementation

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    uint256 index = uint256(keccak256(abi.encode(_sender, _ownerIndex)));
    return uint256(keccak256(abi.encode(_zapper, _owner, index)));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
