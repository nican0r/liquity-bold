# Function: calcTroveAccruedBatchManagementFee(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `calcTroveAccruedBatchManagementFee(uint256)`
- **Visibility**: external
- **Source Range**: 12424:704:282

## Implementation

```solidity
function calcTroveAccruedBatchManagementFee(uint256 _troveId) external view returns (uint256) {
    Trove memory trove = Troves[_troveId];
    address batchAddress = _getBatchManager(_troveId);
    if (batchAddress == address(0)) return 0;
    Batch memory batch = batches[batchAddress];
    if (batch.totalDebtShares == 0) return 0;
    uint256 batchAccruedManagementFee = calcBatchAccruedManagementFee(batchAddress);
    return (batchAccruedManagementFee * trove.batchDebtShares) / batch.totalDebtShares;
}
```

## Related Implementations

### _getBatchManager(uint256)

- **Kind**: internal
- **Source**: 47563:137:188
- **Link**: `src/TroveManager.sol:TroveManager:_getBatchManager(uint256)`

```solidity
function _getBatchManager(uint256 _troveId) internal view returns (address) {
    return Troves[_troveId].interestBatchManager;
}
```

### calcBatchAccruedManagementFee(address)

- **Kind**: internal
- **Source**: 13134:345:282
- **Link**: `test/TestContracts/TroveManagerTester.t.sol:TroveManagerTester:calcBatchAccruedManagementFee(address)`

```solidity
function calcBatchAccruedManagementFee(address _batchAddress) public view returns (uint256) {
    Batch memory batch = batches[_batchAddress];
    return _calcInterest(batch.debt * batch.annualManagementFee, block.timestamp - batch.lastDebtUpdateTime);
}
```

### _calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 2244:173:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_calcInterest(uint256,uint256)`

```solidity
function _calcInterest(uint256 _weightedDebt, uint256 _period) internal pure returns (uint256) {
    return ((_weightedDebt * _period) / ONE_YEAR) / DECIMAL_PRECISION;
}
```

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.calcTroveAccruedBatchManagementFee(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 1)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManagerTester.calcBatchAccruedManagementFee(address) (NodeID: 2)
      💬 Args: [batchAddress]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 3)
        💬 Args: [batch.debt * batch.annualManagementFee, block.timestamp - batch.lastDebtUpdateTime]
        👁️  Def: internal
```
