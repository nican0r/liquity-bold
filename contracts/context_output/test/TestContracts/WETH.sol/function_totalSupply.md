# Function: totalSupply()

**Contract**: [test/TestContracts/WETH.sol/contract_WETH9.md]

## Metadata

- **Contract**: WETH9
- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 1794:98:283

## Implementation

```solidity
function totalSupply() public view returns (uint256) {
    return address(this).balance;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETH9.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the amount of tokens in existence.
