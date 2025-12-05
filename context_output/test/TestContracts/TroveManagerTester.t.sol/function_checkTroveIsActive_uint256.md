# Function: checkTroveIsActive(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `checkTroveIsActive(uint256)`
- **Visibility**: external
- **Source Range**: 6270:171:282

## Implementation

```solidity
function checkTroveIsActive(uint256 _troveId) external view returns (bool) {
    Status status = Troves[_troveId].status;
    return status == Status.active;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.checkTroveIsActive(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
