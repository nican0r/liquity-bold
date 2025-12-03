# Function: allowance(address,address)

**Contract**: [test/TestContracts/BoldTokenTester.sol/contract_BoldTokenTester.md]

## Metadata

- **Contract**: BoldTokenTester
- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 3987:149:78
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev See {IERC20-allowance}.
function allowance(address owner, address spender) virtual override public view returns (uint256) {
    return _allowances[owner][spender];
}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC20-allowance}.

### Interface Documentation

 @dev Returns the remaining number of tokens that `spender` will be
 allowed to spend on behalf of `owner` through {transferFrom}. This is
 zero by default.
 This value changes when {approve} or {transferFrom} are called.
