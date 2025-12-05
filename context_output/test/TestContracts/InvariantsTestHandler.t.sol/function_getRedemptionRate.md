# Function: getRedemptionRate()

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getRedemptionRate()`
- **Visibility**: external
- **Source Range**: 15841:119:270

## Implementation

```solidity
function getRedemptionRate() external view returns (uint256) {
    return _getRedemptionRate(_getBaseRate());
}
```

## Related Implementations

### _getRedemptionRate(uint256)

- **Kind**: internal
- **Source**: 106678:152:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getRedemptionRate(uint256)`

```solidity
function _getRedemptionRate(uint256 baseRate) internal pure returns (uint256) {
    return Math.min(REDEMPTION_FEE_FLOOR + baseRate, _100pct);
}
```

### _getBaseRate()

- **Kind**: internal
- **Source**: 106135:327:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_getBaseRate()`

```solidity
function _getBaseRate() internal view returns (uint256) {
    uint256 minutesSinceLastRedemption = _timeSinceLastRedemption / ONE_MINUTE;
    uint256 decaySinceLastRedemption = REDEMPTION_MINUTE_DECAY_FACTOR.pow(minutesSinceLastRedemption);
    return (_baseRate * decaySinceLastRedemption) / DECIMAL_PRECISION;
}
```

### pow(uint256,uint256)

- **Kind**: free-function
- **Source**: 346:416:290
- **Link**: `test/Utils/Math.sol:pow(uint256,uint256)`

```solidity
function pow(uint256 decimalBase, uint256 intExponent) pure returns (uint256) {
    if (intExponent == 0) return DECIMAL_PRECISION;
    if (intExponent == 1) return decimalBase;
    uint256 x = decimalBase;
    uint256 y = DECIMAL_PRECISION;
    for (; intExponent > 1; intExponent >>= 1) {
        if ((intExponent & 1) == 1) y = roundedMul(x, y);
        x = roundedMul(x, x);
    }
    return roundedMul(x, y);
}
```

### roundedMul(uint256,uint256)

- **Kind**: free-function
- **Source**: 124:132:290
- **Link**: `test/Utils/Math.sol:roundedMul(uint256,uint256)`

```solidity
function roundedMul(uint256 x, uint256 y) pure returns (uint256) {
    return ((x * y) + (DECIMAL_PRECISION / 2)) / DECIMAL_PRECISION;
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

## State Variable Reads

- **_timeSinceLastRedemption** (`uint256`)
- **_baseRate** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getRedemptionRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._getRedemptionRate(uint256) (NodeID: 1)
      💬 Args: [_getBaseRate()]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: InvariantsTestHandler._getBaseRate() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.pow(uint256,uint256) (NodeID: 4)
    │     💬 Args: [REDEMPTION_MINUTE_DECAY_FACTOR, minutesSinceLastRedemption]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Unknown.roundedMul(uint256,uint256) (NodeID: 5)
    │   │   💬 Args: [x, y]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Unknown.roundedMul(uint256,uint256) (NodeID: 6)
    │   │   💬 Args: [x, x]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Unknown.roundedMul(uint256,uint256) (NodeID: 7)
    │       💬 Args: [x, y]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 2)
        💬 Args: [REDEMPTION_FEE_FLOOR + baseRate, _100pct]
        👁️  Def: internal
```
