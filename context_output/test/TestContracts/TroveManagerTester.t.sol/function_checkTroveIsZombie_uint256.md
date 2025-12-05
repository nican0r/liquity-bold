# Function: checkTroveIsZombie(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `checkTroveIsZombie(uint256)`
- **Visibility**: external
- **Source Range**: 6447:171:282

## Implementation

```solidity
function checkTroveIsZombie(uint256 _troveId) external view returns (bool) {
    Status status = Troves[_troveId].status;
    return status == Status.zombie;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.checkTroveIsZombie(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
