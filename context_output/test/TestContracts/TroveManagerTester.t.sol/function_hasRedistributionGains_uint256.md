# Function: hasRedistributionGains(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `hasRedistributionGains(uint256)`
- **Visibility**: external
- **Source Range**: 6624:486:282

## Implementation

```solidity
function hasRedistributionGains(uint256 _troveId) override external view returns (bool) {
    if (!checkTroveIsOpen(_troveId)) return false;
    return (rewardSnapshots[_troveId].coll < L_coll);
}
```

## Related Implementations

### checkTroveIsOpen(uint256)

- **Kind**: internal
- **Source**: 6070:194:282
- **Link**: `test/TestContracts/TroveManagerTester.t.sol:TroveManagerTester:checkTroveIsOpen(uint256)`

```solidity
function checkTroveIsOpen(uint256 _troveId) public view returns (bool) {
    Status status = Troves[_troveId].status;
    return (status == Status.active) || (status == Status.zombie);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.hasRedistributionGains(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManagerTester.checkTroveIsOpen(uint256) (NodeID: 1)
      💬 Args: [_troveId]
      👁️  Def: public
```
