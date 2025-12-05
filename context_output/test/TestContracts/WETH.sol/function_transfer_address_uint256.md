# Function: transfer(address,uint256)

**Contract**: [test/TestContracts/WETH.sol/contract_WETH9.md]

## Metadata

- **Contract**: WETH9
- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 2084:124:283

## Implementation

```solidity
function transfer(address dst, uint256 wad) public returns (bool) {
    return transferFrom(msg.sender, dst, wad);
}
```

## Related Implementations

### transferFrom(address,address,uint256)

- **Kind**: internal
- **Source**: 2214:452:283
- **Link**: `test/TestContracts/WETH.sol:WETH9:transferFrom(address,address,uint256)`

```solidity
function transferFrom(address src, address dst, uint256 wad) public returns (bool) {
    require(balanceOf[src] >= wad);
    if ((src != msg.sender) && (allowance[src][msg.sender] != type(uint256).max)) {
        require(allowance[src][msg.sender] >= wad);
        allowance[src][msg.sender] -= wad;
    }
    balanceOf[src] -= wad;
    balanceOf[dst] += wad;
    emit Transfer(src, dst, wad);
    return true;
}
```

## State Variable Reads

- **balanceOf** (`mapping(address => uint256)`)
- **allowance** (`mapping(address => mapping(address => uint256))`)

## State Variable Writes

- **allowance** (`mapping(address => mapping(address => uint256))`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETH9.transfer(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: WETH9.transferFrom(address,address,uint256) (NodeID: 1)
      💬 Args: [msg.sender, dst, wad]
      👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Moves `amount` tokens from the caller's account to `to`.
 Returns a boolean value indicating whether the operation succeeded.
 Emits a {Transfer} event.
