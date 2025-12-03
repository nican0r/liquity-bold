# Function: calcTroveAccruedInterest(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `calcTroveAccruedInterest(uint256)`
- **Visibility**: external
- **Source Range**: 11066:868:282

## Implementation

```solidity
function calcTroveAccruedInterest(uint256 _troveId) external view returns (uint256) {
    Trove memory trove = Troves[_troveId];
    address batchAddress = _getBatchManager(_troveId);
    if (batchAddress != address(0)) {
        uint256 batchAccruedInterest = calcBatchAccruedInterest(batchAddress);
        return (batchAccruedInterest * trove.batchDebtShares) / batches[batchAddress].totalDebtShares;
    }
    uint256 recordedDebt = trove.debt;
    uint256 annualInterestRate = trove.annualInterestRate;
    uint256 period = _getInterestPeriod(trove.lastDebtUpdateTime);
    return _calcInterest(recordedDebt * annualInterestRate, period);
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

### calcBatchAccruedInterest(address)

- **Kind**: internal
- **Source**: 11940:478:282
- **Link**: `test/TestContracts/TroveManagerTester.t.sol:TroveManagerTester:calcBatchAccruedInterest(address)`

```solidity
function calcBatchAccruedInterest(address _batchAddress) public view returns (uint256) {
    Batch memory batch = batches[_batchAddress];
    uint256 recordedDebt = batch.debt;
    uint256 annualInterestRate = batch.annualInterestRate;
    uint256 period = _getInterestPeriod(batch.lastDebtUpdateTime);
    return _calcInterest(recordedDebt * annualInterestRate, period);
}
```

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

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **shutdownTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.calcTroveAccruedInterest(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 1)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManagerTester.calcBatchAccruedInterest(address) (NodeID: 2)
  │   💬 Args: [batchAddress]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 3)
  │ │   💬 Args: [batch.lastDebtUpdateTime]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 4)
  │     💬 Args: [recordedDebt * annualInterestRate, period]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 5)
  │   💬 Args: [trove.lastDebtUpdateTime]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 6)
      💬 Args: [recordedDebt * annualInterestRate, period]
      👁️  Def: internal
```
