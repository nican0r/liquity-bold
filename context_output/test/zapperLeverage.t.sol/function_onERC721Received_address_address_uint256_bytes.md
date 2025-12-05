# Function: onERC721Received(address,address,uint256,bytes)

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `onERC721Received(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 11933:154:338

## Implementation

```solidity
function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
    return this.onERC721Received.selector;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.onERC721Received(address,address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
