# Function: sweepTrove(contract ITroveNFT,uint256)

**Contract**: [script/OpenTroves.s.sol/contract_Proxy.md]

## Metadata

- **Contract**: Proxy
- **Signature**: `sweepTrove(contract ITroveNFT,uint256)`
- **Visibility**: external
- **Source Range**: 1230:130:120

## Implementation

```solidity
function sweepTrove(ITroveNFT nft, uint256 troveId) external {
    nft.transferFrom(address(this), msg.sender, troveId);
}
```

## External Calls

- **ITroveNFT::transferFrom(address,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Proxy.sweepTrove(contract ITroveNFT,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
