# Function: predictOpenTroveUpfrontFee(uint256,uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `predictOpenTroveUpfrontFee(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4698:465:282

## Implementation

```solidity
function predictOpenTroveUpfrontFee(uint256 borrowedAmount, uint256 interestRate) external view returns (uint256) {
    TroveChange memory openTrove;
    openTrove.debtIncrease = borrowedAmount;
    openTrove.newWeightedRecordedDebt = openTrove.debtIncrease * interestRate;
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(openTrove);
    return _calcUpfrontFee(openTrove.debtIncrease, avgInterestRate);
}
```

## Related Implementations

### _calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 5169:186:282
- **Link**: `test/TestContracts/TroveManagerTester.t.sol:TroveManagerTester:_calcUpfrontFee(uint256,uint256)`

```solidity
function _calcUpfrontFee(uint256 _debt, uint256 _avgInterestRate) internal pure returns (uint256) {
    return _calcInterest(_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD);
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

## External Calls

- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.predictOpenTroveUpfrontFee(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManagerTester._calcUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [openTrove.debtIncrease, avgInterestRate]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 2)
        💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
        👁️  Def: internal
```
