# Function: calcBatchAccruedManagementFee(address)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `calcBatchAccruedManagementFee(address)`
- **Visibility**: public
- **Source Range**: 13134:345:282

## Implementation

```solidity
function calcBatchAccruedManagementFee(address _batchAddress) public view returns (uint256) {
    Batch memory batch = batches[_batchAddress];
    return _calcInterest(batch.debt * batch.annualManagementFee, block.timestamp - batch.lastDebtUpdateTime);
}
```

## Related Implementations

### _calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 2244:173:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_calcInterest(uint256,uint256)`

```solidity
function _calcInterest(uint256 _weightedDebt, uint256 _period) internal pure returns (uint256) {
    return ((_weightedDebt * _period) / ONE_YEAR) / DECIMAL_PRECISION;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.calcBatchAccruedManagementFee(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 1)
      💬 Args: [batch.debt * batch.annualManagementFee, block.timestamp - batch.lastDebtUpdateTime]
      👁️  Def: internal
```
