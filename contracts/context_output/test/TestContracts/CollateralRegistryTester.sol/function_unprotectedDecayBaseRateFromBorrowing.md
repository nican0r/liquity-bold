# Function: unprotectedDecayBaseRateFromBorrowing()

**Contract**: [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]

## Metadata

- **Contract**: CollateralRegistryTester
- **Signature**: `unprotectedDecayBaseRateFromBorrowing()`
- **Visibility**: external
- **Source Range**: 475:248:258

## Implementation

```solidity
function unprotectedDecayBaseRateFromBorrowing() external returns (uint256) {
    baseRate = _calcDecayedBaseRate();
    assert((baseRate >= 0) && (baseRate <= DECIMAL_PRECISION));
    _updateLastFeeOpTime();
    return baseRate;
}
```

## Related Implementations

### _calcDecayedBaseRate()

- **Kind**: internal
- **Source**: 10642:293:130
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_calcDecayedBaseRate()`

```solidity
function _calcDecayedBaseRate() internal view returns (uint256) {
    uint256 minutesPassed = _minutesPassedSinceLastFeeOp();
    uint256 decayFactor = LiquityMath._decPow(REDEMPTION_MINUTE_DECAY_FACTOR, minutesPassed);
    return (baseRate * decayFactor) / DECIMAL_PRECISION;
}
```

### _minutesPassedSinceLastFeeOp()

- **Kind**: internal
- **Source**: 8968:149:130
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_minutesPassedSinceLastFeeOp()`

```solidity
function _minutesPassedSinceLastFeeOp() internal view returns (uint256) {
    return (block.timestamp - lastFeeOperationTime) / ONE_MINUTE;
}
```

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

### _updateLastFeeOpTime()

- **Kind**: internal
- **Source**: 8681:281:130
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_updateLastFeeOpTime()`

```solidity
function _updateLastFeeOpTime() internal {
    uint256 minutesPassed = _minutesPassedSinceLastFeeOp();
    if (minutesPassed > 0) {
        lastFeeOperationTime += ONE_MINUTE * minutesPassed;
        emit LastFeeOpTimeUpdated(lastFeeOperationTime);
    }
}
```

## State Variable Reads

- **baseRate** (`uint256`)
- **lastFeeOperationTime** (`uint256`)

## State Variable Writes

- **lastFeeOperationTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistryTester.unprotectedDecayBaseRateFromBorrowing() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: CollateralRegistry._calcDecayedBaseRate() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CollateralRegistry._minutesPassedSinceLastFeeOp() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._decPow(uint256,uint256) (NodeID: 3)
  │     💬 Args: [REDEMPTION_MINUTE_DECAY_FACTOR, minutesPassed]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 4)
  │   │   💬 Args: [x, x]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 5)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 6)
  │   │   💬 Args: [x, x]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 7)
  │       💬 Args: [x, y]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CollateralRegistry._updateLastFeeOpTime() (NodeID: 8)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: CollateralRegistry._minutesPassedSinceLastFeeOp() (NodeID: 9)
        💬 Args: [no args]
        👁️  Def: internal
```
