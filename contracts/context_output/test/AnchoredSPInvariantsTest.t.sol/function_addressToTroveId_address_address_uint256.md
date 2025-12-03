# Function: addressToTroveId(address,address,uint256)

**Contract**: [test/AnchoredSPInvariantsTest.t.sol/contract_AnchoredSPInvariantsTest.md]

## Metadata

- **Contract**: AnchoredSPInvariantsTest
- **Signature**: `addressToTroveId(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 81:194:294
- **Inherited From**: TroveId

## Implementation

```solidity
function addressToTroveId(address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    return uint256(keccak256(abi.encode(_sender, _owner, _ownerIndex)));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveId.addressToTroveId(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
