# Function: calcBatchAccruedInterest(address)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `calcBatchAccruedInterest(address)`
- **Visibility**: public
- **Source Range**: 11940:478:282

## Implementation

```solidity
function calcBatchAccruedInterest(address _batchAddress) public view returns (uint256) {
    Batch memory batch = batches[_batchAddress];
    uint256 recordedDebt = batch.debt;
    uint256 annualInterestRate = batch.annualInterestRate;
    uint256 period = _getInterestPeriod(batch.lastDebtUpdateTime);
    return _calcInterest(recordedDebt * annualInterestRate, period);
}
```

## Related Implementations

### _getInterestPeriod(uint256)

- **Kind**: internal
- **Source**: 54014:755:188
- **Link**: `src/TroveManager.sol:TroveManager:_getInterestPeriod(uint256)`

```solidity
function _getInterestPeriod(uint256 _lastDebtUpdateTime) internal view returns (uint256) {
    if (shutdownTime == 0) {
        return block.timestamp - _lastDebtUpdateTime;
    } else if ((shutdownTime > 0) && (_lastDebtUpdateTime < shutdownTime)) {
        return shutdownTime - _lastDebtUpdateTime;
    } else {
        return 0;
    }
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

- **shutdownTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.calcBatchAccruedInterest(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 1)
  │   💬 Args: [batch.lastDebtUpdateTime]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 2)
      💬 Args: [recordedDebt * annualInterestRate, period]
      👁️  Def: internal
```
