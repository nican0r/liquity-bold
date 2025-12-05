# Function: callDecPow(uint256,uint256)

**Contract**: [test/TestContracts/LiquityMathTester.sol/contract_LiquityMathTester.md]

## Metadata

- **Contract**: LiquityMathTester
- **Signature**: `callDecPow(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 588:133:273

## Implementation

```solidity
function callDecPow(uint256 _base, uint256 _n) external pure returns (uint256) {
    return LiquityMath._decPow(_base, _n);
}
```

## Related Implementations

### _decPow(uint256,uint256)

- **Kind**: internal
- **Source**: 1800:686:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_decPow(uint256,uint256)`

```solidity
function _decPow(uint256 _base, uint256 _minutes) internal pure returns (uint256) {
    if (_minutes > 525600000) _minutes = 525600000;
    if (_minutes == 0) return DECIMAL_PRECISION;
    uint256 y = DECIMAL_PRECISION;
    uint256 x = _base;
    uint256 n = _minutes;
    while (n > 1) {
        if ((n % 2) == 0) {
            x = decMul(x, x);
            n = n / 2;
        } else {
            y = decMul(x, y);
            x = decMul(x, x);
            n = (n - 1) / 2;
        }
    }
    return decMul(x, y);
}
```

### decMul(uint256,uint256)

- **Kind**: internal
- **Source**: 752:192:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:decMul(uint256,uint256)`

```solidity
function decMul(uint256 x, uint256 y) internal pure returns (uint256 decProd) {
    uint256 prod_xy = x * y;
    decProd = (prod_xy + (DECIMAL_PRECISION / 2)) / DECIMAL_PRECISION;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquityMathTester.callDecPow(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: LiquityMath._decPow(uint256,uint256) (NodeID: 1)
      💬 Args: [_base, _n]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 2)
    │   💬 Args: [x, x]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 3)
    │   💬 Args: [x, y]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 4)
    │   💬 Args: [x, x]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 5)
        💬 Args: [x, y]
        👁️  Def: internal
```
