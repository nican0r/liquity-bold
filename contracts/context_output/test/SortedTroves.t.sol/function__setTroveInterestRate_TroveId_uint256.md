# Function: _setTroveInterestRate(TroveId,uint256)

**Contract**: [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Metadata

- **Contract**: MockTroveManager
- **Signature**: `_setTroveInterestRate(TroveId,uint256)`
- **Visibility**: external
- **Source Range**: 2299:154:247

## Implementation

```solidity
function _setTroveInterestRate(TroveId id, uint256 newAnnualInterestRate) external {
    _troves[id].annualInterestRate = newAnnualInterestRate;
}
```

## State Variable Writes

- **_troves** (`mapping(TroveId => struct MockTroveManager.Trove)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTroveManager._setTroveInterestRate(TroveId,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
