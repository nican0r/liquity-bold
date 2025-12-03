# Function: getPendingInterest(uint256)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getPendingInterest(uint256)`
- **Visibility**: external
- **Source Range**: 16094:158:270

## Implementation

```solidity
function getPendingInterest(uint256 i) external view returns (uint256) {
    return Math.ceilDiv(_pendingInterest[i], ONE_YEAR * DECIMAL_PRECISION);
}
```

## Related Implementations

### ceilDiv(uint256,uint256)

- **Kind**: internal
- **Source**: 1157:194:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ceilDiv(uint256,uint256)`

```solidity
///  @dev Returns the ceiling of the division of two numbers.
///  This differs from standard division with `/` in that it rounds up instead
///  of rounding down.
function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a == 0) ? 0 : (((a - 1) / b) + 1);
}
```

## State Variable Reads

- **_pendingInterest** (`mapping(uint256 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getPendingInterest(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 1)
      💬 Args: [_pendingInterest[i], ONE_YEAR * DECIMAL_PRECISION]
      👁️  Def: internal
```
