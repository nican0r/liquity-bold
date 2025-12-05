# Function: getTroveColl(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveColl(uint256)`
- **Visibility**: external
- **Source Range**: 9987:162:282

## Implementation

```solidity
function getTroveColl(uint256 _troveId) override external view returns (uint256) {
    Trove memory trove = Troves[_troveId];
    return trove.coll;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getTroveColl(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
