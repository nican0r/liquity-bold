# Function: uintToArray(uint256)

**Contract**: [test/criticalThreshold.t.sol/contract_CriticalThresholdTest.md]

## Metadata

- **Contract**: CriticalThresholdTest
- **Signature**: `uintToArray(uint256)`
- **Visibility**: public
- **Source Range**: 20346:153:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function uintToArray(uint256 _value) public pure returns (uint256[] memory result) {
    result = new uint256[](1);
    result[0] = _value;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.uintToArray(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
