# Function: abs(uint256,uint256)

**Contract**: [test/interestRateBasic.t.sol/contract_InterestRateBasic.md]

## Metadata

- **Contract**: InterestRateBasic
- **Signature**: `abs(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 19906:110:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function abs(uint256 x, uint256 y) public pure returns (uint256) {
    return (x > y) ? (x - y) : (y - x);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.abs(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
