# Function: callMax(uint256,uint256)

**Contract**: [test/TestContracts/LiquityMathTester.sol/contract_LiquityMathTester.md]

## Metadata

- **Contract**: LiquityMathTester
- **Signature**: `callMax(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 234:121:273

## Implementation

```solidity
function callMax(uint256 _a, uint256 _b) external pure returns (uint256) {
    return LiquityMath._max(_a, _b);
}
```

## Related Implementations

### _max(uint256,uint256)

- **Kind**: internal
- **Source**: 255:114:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_max(uint256,uint256)`

```solidity
function _max(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? _a : _b;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquityMathTester.callMax(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 1)
      💬 Args: [_a, _b]
      👁️  Def: internal
```
