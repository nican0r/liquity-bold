# Function: getTroveAnnualInterestRate(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveAnnualInterestRate(uint256)`
- **Visibility**: external
- **Source Range**: 47207:350:188
- **Inherited From**: TroveManager

## Implementation

```solidity
function getTroveAnnualInterestRate(uint256 _troveId) external view returns (uint256) {
    Trove memory trove = Troves[_troveId];
    address batchAddress = _getBatchManager(trove);
    if (batchAddress != address(0)) {
        return batches[batchAddress].annualInterestRate;
    }
    return trove.annualInterestRate;
}
```

## Related Implementations

### _getBatchManager(struct TroveManager.Trove)

- **Kind**: internal
- **Source**: 47706:128:188
- **Link**: `src/TroveManager.sol:TroveManager:_getBatchManager(struct TroveManager.Trove)`

```solidity
function _getBatchManager(Trove memory trove) internal pure returns (address) {
    return trove.interestBatchManager;
}
```

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getTroveAnnualInterestRate(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._getBatchManager(struct TroveManager.Trove) (NodeID: 1)
      💬 Args: [trove]
      👁️  Def: internal
```
