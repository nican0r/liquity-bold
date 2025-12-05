# Interface: IMultiTroveGetter

## Metadata

- **Name**: IMultiTroveGetter
- **Type**: Interface
- **Path**: src/Interfaces/IMultiTroveGetter.sol

## Structs

### CombinedTroveData

```solidity
struct CombinedTroveData {
    uint256 id;
    uint256 entireDebt;
    uint256 entireColl;
    uint256 redistBoldDebtGain;
    uint256 redistCollGain;
    uint256 accruedInterest;
    uint256 recordedDebt;
    uint256 annualInterestRate;
    uint256 accruedBatchManagementFee;
    uint256 lastInterestRateAdjTime;
    uint256 stake;
    uint256 lastDebtUpdateTime;
    address interestBatchManager;
    uint256 batchDebtShares;
    uint256 snapshotETH;
    uint256 snapshotBoldDebt;
}
```

### DebtPerInterestRate

```solidity
struct DebtPerInterestRate {
    address interestBatchManager;
    uint256 interestRate;
    uint256 debt;
}
```

## Public/External Functions

### getMultipleSortedTroves(uint256,int256,uint256)

- **Signature**: `getMultipleSortedTroves(uint256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 780:170:158

**Signature:**
```solidity
function getMultipleSortedTroves(uint256 _collIndex, int256 _startIdx, uint256 _count) external view returns (CombinedTroveData[] memory _troves);;
```

### getDebtPerInterestRateAscending(uint256,uint256,uint256)

- **Signature**: `getDebtPerInterestRateAscending(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 956:196:158

**Signature:**
```solidity
function getDebtPerInterestRateAscending(uint256 _collIndex, uint256 _startId, uint256 _maxIterations) external view returns (DebtPerInterestRate[] memory, uint256 currId);;
```
