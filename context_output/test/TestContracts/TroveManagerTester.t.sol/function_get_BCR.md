# Function: get_BCR()

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `get_BCR()`
- **Visibility**: external
- **Source Range**: 1228:78:282

## Implementation

```solidity
function get_BCR() external view returns (uint256) {
    return BCR;
}
```

## State Variable Reads

- **BCR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.get_BCR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
