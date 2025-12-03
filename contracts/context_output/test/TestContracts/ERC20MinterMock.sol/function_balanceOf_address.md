# Function: balanceOf(address)

**Contract**: [test/TestContracts/ERC20MinterMock.sol/contract_ERC20MinterMock.md]

## Metadata

- **Contract**: ERC20MinterMock
- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 3419:125:78
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev See {IERC20-balanceOf}.
function balanceOf(address account) virtual override public view returns (uint256) {
    return _balances[account];
}
```

## State Variable Reads

- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC20-balanceOf}.

### Interface Documentation

 @dev Returns the amount of tokens owned by `account`.
