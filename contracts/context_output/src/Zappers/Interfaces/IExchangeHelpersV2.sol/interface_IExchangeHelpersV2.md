# Interface: IExchangeHelpersV2

## Metadata

- **Name**: IExchangeHelpersV2
- **Type**: Interface
- **Path**: src/Zappers/Interfaces/IExchangeHelpersV2.sol

## Public/External Functions

### quoteExactInput(uint256,bool,address)

- **Signature**: `quoteExactInput(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 93:141:199

**Signature:**
```solidity
function quoteExactInput(uint256 _inputAmount, bool _collToBold, address _collToken) external returns (uint256 outputAmount);;
```

### quoteExactOutput(uint256,bool,address)

- **Signature**: `quoteExactOutput(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 240:142:199

**Signature:**
```solidity
function quoteExactOutput(uint256 _outputAmount, bool _collToBold, address _collToken) external returns (uint256 inputAmount);;
```
