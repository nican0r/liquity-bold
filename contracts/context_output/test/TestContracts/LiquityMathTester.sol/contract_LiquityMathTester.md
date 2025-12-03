# Contract: LiquityMathTester

## Metadata

- **Name**: LiquityMathTester
- **Type**: Contract
- **Path**: test/TestContracts/LiquityMathTester.sol

## Events

### AvoidWarning

```solidity
event AvoidWarning(uint256 a);
```

## Public/External Functions

### callMax(uint256,uint256)

- **Signature**: `callMax(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 234:121:273
- **Details**: [function_callMax_uint256_uint256.md](./function_callMax_uint256_uint256.md)

**Signature:**
```solidity
function callMax(uint256 _a, uint256 _b) external pure returns (uint256);
```

### callDecPowTx(uint256,uint256)

- **Signature**: `callDecPowTx(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 398:160:273
- **Details**: [function_callDecPowTx_uint256_uint256.md](./function_callDecPowTx_uint256_uint256.md)

**Signature:**
```solidity
function callDecPowTx(uint256 _base, uint256 _n) external returns (uint256);
```

### callDecPow(uint256,uint256)

- **Signature**: `callDecPow(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 588:133:273
- **Details**: [function_callDecPow_uint256_uint256.md](./function_callDecPow_uint256_uint256.md)

**Signature:**
```solidity
function callDecPow(uint256 _base, uint256 _n) external pure returns (uint256);
```
