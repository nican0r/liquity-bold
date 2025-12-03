# Interface: ITroveManagerV1

## Metadata

- **Name**: ITroveManagerV1
- **Type**: Interface
- **Path**: test/Interfaces/LiquityV1/ITroveManagerV1.sol

## Public/External Functions

### getCurrentICR(address,uint256)

- **Signature**: `getCurrentICR(address,uint256)`
- **Visibility**: external
- **Source Range**: 89:90:242

**Signature:**
```solidity
function getCurrentICR(address _borrower, uint256 _price) external view returns (uint256);;
```

### getBorrowingRateWithDecay()

- **Signature**: `getBorrowingRateWithDecay()`
- **Visibility**: external
- **Source Range**: 184:69:242

**Signature:**
```solidity
function getBorrowingRateWithDecay() external view returns (uint256);;
```

### getEntireDebtAndColl(address)

- **Signature**: `getEntireDebtAndColl(address)`
- **Visibility**: external
- **Source Range**: 259:181:242

**Signature:**
```solidity
function getEntireDebtAndColl(address _borrower) external view returns (uint256 debt, uint256 coll, uint256 pendingLUSDDebtReward, uint256 pendingETHReward);;
```

### redeemCollateral(uint256,address,address,address,uint256,uint256,uint256)

- **Signature**: `redeemCollateral(uint256,address,address,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 446:309:242

**Signature:**
```solidity
function redeemCollateral(uint256 _LUSDamount, address _firstRedemptionHint, address _upperPartialRedemptionHint, address _lowerPartialRedemptionHint, uint256 _partialRedemptionHintNICR, uint256 _maxIterations, uint256 _maxFeePercentage) external;;
```

### liquidateTroves(uint256)

- **Signature**: `liquidateTroves(uint256)`
- **Visibility**: external
- **Source Range**: 761:46:242

**Signature:**
```solidity
function liquidateTroves(uint256 _n) external;;
```
