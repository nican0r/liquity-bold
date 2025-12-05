# Function: getTroveStake(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveStake(uint256)`
- **Visibility**: external
- **Source Range**: 8862:128:282

## Implementation

```solidity
function getTroveStake(uint256 _troveId) override external view returns (uint256) {
    return Troves[_troveId].stake;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getTroveStake(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
