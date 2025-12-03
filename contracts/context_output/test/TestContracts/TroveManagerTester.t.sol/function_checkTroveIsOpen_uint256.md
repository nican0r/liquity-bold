# Function: checkTroveIsOpen(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `checkTroveIsOpen(uint256)`
- **Visibility**: public
- **Source Range**: 6070:194:282

## Implementation

```solidity
function checkTroveIsOpen(uint256 _troveId) public view returns (bool) {
    Status status = Troves[_troveId].status;
    return (status == Status.active) || (status == Status.zombie);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.checkTroveIsOpen(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
