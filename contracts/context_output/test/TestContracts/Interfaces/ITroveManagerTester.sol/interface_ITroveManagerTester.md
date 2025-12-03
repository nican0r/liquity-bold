# Interface: ITroveManagerTester

## Metadata

- **Name**: ITroveManagerTester
- **Type**: Interface
- **Path**: test/TestContracts/Interfaces/ITroveManagerTester.sol

## Implements Interfaces

- **ITroveManager** [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## Structs

### OnSetInterestBatchManagerParams (inherited from ITroveManager)

```solidity
struct OnSetInterestBatchManagerParams {
    uint256 troveId;
    uint256 troveColl;
    uint256 troveDebt;
    TroveChange troveChange;
    address newBatchAddress;
    uint256 newBatchColl;
    uint256 newBatchDebt;
}
```

## Enums

### Status (inherited from ITroveManager)

```solidity
enum Status {
    nonExistent,
    active,
    closedByOwner,
    closedByLiquidation,
    zombie
}
```

## Public/External Functions

### liquidate(uint256)

- **Signature**: `liquidate(uint256)`
- **Visibility**: external
- **Source Range**: 155:46:269

**Signature:**
```solidity
function liquidate(uint256 _troveId) external;;
```

### get_CCR()

- **Signature**: `get_CCR()`
- **Visibility**: external
- **Source Range**: 207:51:269

**Signature:**
```solidity
function get_CCR() external view returns (uint256);;
```

### get_MCR()

- **Signature**: `get_MCR()`
- **Visibility**: external
- **Source Range**: 263:51:269

**Signature:**
```solidity
function get_MCR() external view returns (uint256);;
```

### get_BCR()

- **Signature**: `get_BCR()`
- **Visibility**: external
- **Source Range**: 319:51:269

**Signature:**
```solidity
function get_BCR() external view returns (uint256);;
```

### get_SCR()

- **Signature**: `get_SCR()`
- **Visibility**: external
- **Source Range**: 375:51:269

**Signature:**
```solidity
function get_SCR() external view returns (uint256);;
```

### get_LIQUIDATION_PENALTY_SP()

- **Signature**: `get_LIQUIDATION_PENALTY_SP()`
- **Visibility**: external
- **Source Range**: 431:70:269

**Signature:**
```solidity
function get_LIQUIDATION_PENALTY_SP() external view returns (uint256);;
```

### get_LIQUIDATION_PENALTY_REDISTRIBUTION()

- **Signature**: `get_LIQUIDATION_PENALTY_REDISTRIBUTION()`
- **Visibility**: external
- **Source Range**: 506:82:269

**Signature:**
```solidity
function get_LIQUIDATION_PENALTY_REDISTRIBUTION() external view returns (uint256);;
```

### getBoldToken()

- **Signature**: `getBoldToken()`
- **Visibility**: external
- **Source Range**: 594:59:269

**Signature:**
```solidity
function getBoldToken() external view returns (IBoldToken);;
```

### getBorrowerOperations()

- **Signature**: `getBorrowerOperations()`
- **Visibility**: external
- **Source Range**: 658:77:269

**Signature:**
```solidity
function getBorrowerOperations() external view returns (IBorrowerOperations);;
```

### get_L_coll()

- **Signature**: `get_L_coll()`
- **Visibility**: external
- **Source Range**: 741:54:269

**Signature:**
```solidity
function get_L_coll() external view returns (uint256);;
```

### get_L_boldDebt()

- **Signature**: `get_L_boldDebt()`
- **Visibility**: external
- **Source Range**: 800:58:269

**Signature:**
```solidity
function get_L_boldDebt() external view returns (uint256);;
```

### getTotalStakes()

- **Signature**: `getTotalStakes()`
- **Visibility**: external
- **Source Range**: 863:58:269

**Signature:**
```solidity
function getTotalStakes() external view returns (uint256);;
```

### getTotalStakesSnapshot()

- **Signature**: `getTotalStakesSnapshot()`
- **Visibility**: external
- **Source Range**: 926:66:269

**Signature:**
```solidity
function getTotalStakesSnapshot() external view returns (uint256);;
```

### getTotalCollateralSnapshot()

- **Signature**: `getTotalCollateralSnapshot()`
- **Visibility**: external
- **Source Range**: 997:70:269

**Signature:**
```solidity
function getTotalCollateralSnapshot() external view returns (uint256);;
```

### get_lastCollError_Redistribution()

- **Signature**: `get_lastCollError_Redistribution()`
- **Visibility**: external
- **Source Range**: 1072:76:269

**Signature:**
```solidity
function get_lastCollError_Redistribution() external view returns (uint256);;
```

### get_lastBoldDebtError_Redistribution()

- **Signature**: `get_lastBoldDebtError_Redistribution()`
- **Visibility**: external
- **Source Range**: 1153:80:269

**Signature:**
```solidity
function get_lastBoldDebtError_Redistribution() external view returns (uint256);;
```

### getTroveId(uint256)

- **Signature**: `getTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 1238:68:269

**Signature:**
```solidity
function getTroveId(uint256 _index) external view returns (uint256);;
```

### getTCR(uint256)

- **Signature**: `getTCR(uint256)`
- **Visibility**: external
- **Source Range**: 1312:64:269

**Signature:**
```solidity
function getTCR(uint256 _price) external view returns (uint256);;
```

### checkBelowCriticalThreshold(uint256)

- **Signature**: `checkBelowCriticalThreshold(uint256)`
- **Visibility**: external
- **Source Range**: 1382:82:269

**Signature:**
```solidity
function checkBelowCriticalThreshold(uint256 _price) external view returns (bool);;
```

### computeICR(uint256,uint256,uint256)

- **Signature**: `computeICR(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1470:98:269

**Signature:**
```solidity
function computeICR(uint256 _coll, uint256 _debt, uint256 _price) external pure returns (uint256);;
```

### getCollGasCompensation(uint256)

- **Signature**: `getCollGasCompensation(uint256)`
- **Visibility**: external
- **Source Range**: 1573:79:269

**Signature:**
```solidity
function getCollGasCompensation(uint256 _coll) external pure returns (uint256);;
```

### getCollGasCompensation(uint256,uint256,uint256)

- **Signature**: `getCollGasCompensation(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1657:147:269

**Signature:**
```solidity
function getCollGasCompensation(uint256 _coll, uint256 _debt, uint256 _boldInSPForOffsets) external pure returns (uint256);;
```

### getEffectiveRedemptionFeeInColl(uint256,uint256)

- **Signature**: `getEffectiveRedemptionFeeInColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1810:112:269

**Signature:**
```solidity
function getEffectiveRedemptionFeeInColl(uint256 _redeemAmount, uint256 _price) external view returns (uint256);;
```

### callInternalRemoveTroveId(uint256)

- **Signature**: `callInternalRemoveTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 1928:62:269

**Signature:**
```solidity
function callInternalRemoveTroveId(uint256 _troveId) external;;
```

### ownerOf(uint256)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: external
- **Source Range**: 1996:67:269

**Signature:**
```solidity
function ownerOf(uint256 _troveId) external view returns (address);;
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 2068:69:269

**Signature:**
```solidity
function balanceOf(address _account) external view returns (uint256);;
```

### checkTroveIsActive(uint256)

- **Signature**: `checkTroveIsActive(uint256)`
- **Visibility**: external
- **Source Range**: 2174:75:269

**Signature:**
```solidity
function checkTroveIsActive(uint256 _troveId) external view returns (bool);;
```

### checkTroveIsOpen(uint256)

- **Signature**: `checkTroveIsOpen(uint256)`
- **Visibility**: external
- **Source Range**: 2254:73:269

**Signature:**
```solidity
function checkTroveIsOpen(uint256 _troveId) external view returns (bool);;
```

### checkTroveIsZombie(uint256)

- **Signature**: `checkTroveIsZombie(uint256)`
- **Visibility**: external
- **Source Range**: 2332:75:269

**Signature:**
```solidity
function checkTroveIsZombie(uint256 _troveId) external view returns (bool);;
```

### hasRedistributionGains(uint256)

- **Signature**: `hasRedistributionGains(uint256)`
- **Visibility**: external
- **Source Range**: 2413:79:269

**Signature:**
```solidity
function hasRedistributionGains(uint256 _troveId) external view returns (bool);;
```

### getPendingCollReward(uint256)

- **Signature**: `getPendingCollReward(uint256)`
- **Visibility**: external
- **Source Range**: 2498:80:269

**Signature:**
```solidity
function getPendingCollReward(uint256 _troveId) external view returns (uint256);;
```

### getPendingBoldDebtReward(uint256)

- **Signature**: `getPendingBoldDebtReward(uint256)`
- **Visibility**: external
- **Source Range**: 2584:84:269

**Signature:**
```solidity
function getPendingBoldDebtReward(uint256 _troveId) external view returns (uint256);;
```

### getEntireDebtAndColl(uint256)

- **Signature**: `getEntireDebtAndColl(uint256)`
- **Visibility**: external
- **Source Range**: 2674:293:269

**Signature:**
```solidity
function getEntireDebtAndColl(uint256 _troveId) external view returns (uint256 entireDebt, uint256 entireColl, uint256 pendingBoldDebtReward, uint256 pendingCollReward, uint256 accruedTroveInterest);;
```

### getTroveEntireDebt(uint256)

- **Signature**: `getTroveEntireDebt(uint256)`
- **Visibility**: external
- **Source Range**: 2973:78:269

**Signature:**
```solidity
function getTroveEntireDebt(uint256 _troveId) external view returns (uint256);;
```

### getTroveEntireColl(uint256)

- **Signature**: `getTroveEntireColl(uint256)`
- **Visibility**: external
- **Source Range**: 3057:78:269

**Signature:**
```solidity
function getTroveEntireColl(uint256 _troveId) external view returns (uint256);;
```

### getTroveStake(uint256)

- **Signature**: `getTroveStake(uint256)`
- **Visibility**: external
- **Source Range**: 3222:73:269

**Signature:**
```solidity
function getTroveStake(uint256 _troveId) external view returns (uint256);;
```

### getTroveDebt(uint256)

- **Signature**: `getTroveDebt(uint256)`
- **Visibility**: external
- **Source Range**: 3301:72:269

**Signature:**
```solidity
function getTroveDebt(uint256 _troveId) external view returns (uint256);;
```

### getTroveWeightedRecordedDebt(uint256)

- **Signature**: `getTroveWeightedRecordedDebt(uint256)`
- **Visibility**: external
- **Source Range**: 3379:83:269

**Signature:**
```solidity
function getTroveWeightedRecordedDebt(uint256 _troveId) external returns (uint256);;
```

### getTroveColl(uint256)

- **Signature**: `getTroveColl(uint256)`
- **Visibility**: external
- **Source Range**: 3468:72:269

**Signature:**
```solidity
function getTroveColl(uint256 _troveId) external view returns (uint256);;
```

### getTroveLastDebtUpdateTime(uint256)

- **Signature**: `getTroveLastDebtUpdateTime(uint256)`
- **Visibility**: external
- **Source Range**: 3546:86:269

**Signature:**
```solidity
function getTroveLastDebtUpdateTime(uint256 _troveId) external view returns (uint256);;
```

### troveIsStale(uint256)

- **Signature**: `troveIsStale(uint256)`
- **Visibility**: external
- **Source Range**: 3638:69:269

**Signature:**
```solidity
function troveIsStale(uint256 _troveId) external view returns (bool);;
```

### calcTroveAccruedInterest(uint256)

- **Signature**: `calcTroveAccruedInterest(uint256)`
- **Visibility**: external
- **Source Range**: 3713:84:269

**Signature:**
```solidity
function calcTroveAccruedInterest(uint256 _troveId) external view returns (uint256);;
```

### calcTroveAccruedBatchManagementFee(uint256)

- **Signature**: `calcTroveAccruedBatchManagementFee(uint256)`
- **Visibility**: external
- **Source Range**: 3802:94:269

**Signature:**
```solidity
function calcTroveAccruedBatchManagementFee(uint256 _troveId) external view returns (uint256);;
```

### calcBatchAccruedInterest(address)

- **Signature**: `calcBatchAccruedInterest(address)`
- **Visibility**: external
- **Source Range**: 3901:89:269

**Signature:**
```solidity
function calcBatchAccruedInterest(address _batchAddress) external view returns (uint256);;
```

### calcBatchAccruedManagementFee(address)

- **Signature**: `calcBatchAccruedManagementFee(address)`
- **Visibility**: external
- **Source Range**: 3995:94:269

**Signature:**
```solidity
function calcBatchAccruedManagementFee(address _batchAddress) external view returns (uint256);;
```

### getBatchAnnualInterestRate(address)

- **Signature**: `getBatchAnnualInterestRate(address)`
- **Visibility**: external
- **Source Range**: 4095:91:269

**Signature:**
```solidity
function getBatchAnnualInterestRate(address _batchAddress) external view returns (uint256);;
```

### getBatchLastDebtUpdateTime(address)

- **Signature**: `getBatchLastDebtUpdateTime(address)`
- **Visibility**: external
- **Source Range**: 4191:91:269

**Signature:**
```solidity
function getBatchLastDebtUpdateTime(address _batchAddress) external view returns (uint256);;
```

### getBatch(address)

- **Signature**: `getBatch(address)`
- **Visibility**: external
- **Source Range**: 4287:382:269

**Signature:**
```solidity
function getBatch(address _batchAddress) external view returns (uint256 debt, uint256 coll, uint64 arrayIndex, uint64 lastDebtUpdateTime, uint64 lastInterestRateAdjTime, uint256 annualInterestRate, uint256 annualManagementFee, uint256 totalDebtShares);;
```

### activePool() (inherited from ILiquityBase)

- **Signature**: `activePool()`
- **Visibility**: external
- **Source Range**: 172:58:156

**Signature:**
```solidity
function activePool() external view returns (IActivePool);;
```

### getEntireBranchDebt() (inherited from ILiquityBase)

- **Signature**: `getEntireBranchDebt()`
- **Visibility**: external
- **Source Range**: 235:63:156

**Signature:**
```solidity
function getEntireBranchDebt() external view returns (uint256);;
```

### getEntireBranchColl() (inherited from ILiquityBase)

- **Signature**: `getEntireBranchColl()`
- **Visibility**: external
- **Source Range**: 303:63:156

**Signature:**
```solidity
function getEntireBranchColl() external view returns (uint256);;
```

### shutdownTime() (inherited from ITroveManager)

- **Signature**: `shutdownTime()`
- **Visibility**: external
- **Source Range**: 534:56:167

**Signature:**
```solidity
function shutdownTime() external view returns (uint256);;
```

### troveNFT() (inherited from ITroveManager)

- **Signature**: `troveNFT()`
- **Visibility**: external
- **Source Range**: 596:54:167

**Signature:**
```solidity
function troveNFT() external view returns (ITroveNFT);;
```

### stabilityPool() (inherited from ITroveManager)

- **Signature**: `stabilityPool()`
- **Visibility**: external
- **Source Range**: 655:64:167

**Signature:**
```solidity
function stabilityPool() external view returns (IStabilityPool);;
```

### sortedTroves() (inherited from ITroveManager)

- **Signature**: `sortedTroves()`
- **Visibility**: external
- **Source Range**: 787:62:167

**Signature:**
```solidity
function sortedTroves() external view returns (ISortedTroves);;
```

### borrowerOperations() (inherited from ITroveManager)

- **Signature**: `borrowerOperations()`
- **Visibility**: external
- **Source Range**: 854:74:167

**Signature:**
```solidity
function borrowerOperations() external view returns (IBorrowerOperations);;
```

### Troves(uint256) (inherited from ITroveManager)

- **Signature**: `Troves(uint256)`
- **Visibility**: external
- **Source Range**: 934:425:167

**Signature:**
```solidity
function Troves(uint256 _id) external view returns (uint256 debt, uint256 coll, uint256 stake, Status status, uint64 arrayIndex, uint64 lastDebtUpdateTime, uint64 lastInterestRateAdjTime, uint256 annualInterestRate, address interestBatchManager, uint256 batchDebtShares);;
```

### rewardSnapshots(uint256) (inherited from ITroveManager)

- **Signature**: `rewardSnapshots(uint256)`
- **Visibility**: external
- **Source Range**: 1365:93:167

**Signature:**
```solidity
function rewardSnapshots(uint256 _id) external view returns (uint256 coll, uint256 boldDebt);;
```

### getTroveIdsCount() (inherited from ITroveManager)

- **Signature**: `getTroveIdsCount()`
- **Visibility**: external
- **Source Range**: 1464:60:167

**Signature:**
```solidity
function getTroveIdsCount() external view returns (uint256);;
```

### getTroveFromTroveIdsArray(uint256) (inherited from ITroveManager)

- **Signature**: `getTroveFromTroveIdsArray(uint256)`
- **Visibility**: external
- **Source Range**: 1530:83:167

**Signature:**
```solidity
function getTroveFromTroveIdsArray(uint256 _index) external view returns (uint256);;
```

### getCurrentICR(uint256,uint256) (inherited from ITroveManager)

- **Signature**: `getCurrentICR(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1619:89:167

**Signature:**
```solidity
function getCurrentICR(uint256 _troveId, uint256 _price) external view returns (uint256);;
```

### lastZombieTroveId() (inherited from ITroveManager)

- **Signature**: `lastZombieTroveId()`
- **Visibility**: external
- **Source Range**: 1714:61:167

**Signature:**
```solidity
function lastZombieTroveId() external view returns (uint256);;
```

### batchLiquidateTroves(uint256[]) (inherited from ITroveManager)

- **Signature**: `batchLiquidateTroves(uint256[])`
- **Visibility**: external
- **Source Range**: 1781:71:167

**Signature:**
```solidity
function batchLiquidateTroves(uint256[] calldata _troveArray) external;;
```

### redeemCollateral(address,uint256,uint256,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1858:218:167

**Signature:**
```solidity
function redeemCollateral(address _sender, uint256 _boldAmount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) external returns (uint256 _redemeedAmount);;
```

### shutdown() (inherited from ITroveManager)

- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 2082:29:167

**Signature:**
```solidity
function shutdown() external;;
```

### urgentRedemption(uint256,uint256[],uint256) (inherited from ITroveManager)

- **Signature**: `urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 2116:110:167

**Signature:**
```solidity
function urgentRedemption(uint256 _boldAmount, uint256[] calldata _troveIds, uint256 _minCollateral) external;;
```

### getUnbackedPortionPriceAndRedeemability() (inherited from ITroveManager)

- **Signature**: `getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: external
- **Source Range**: 2232:93:167

**Signature:**
```solidity
function getUnbackedPortionPriceAndRedeemability() external returns (uint256, uint256, bool);;
```

### getLatestTroveData(uint256) (inherited from ITroveManager)

- **Signature**: `getLatestTroveData(uint256)`
- **Visibility**: external
- **Source Range**: 2331:93:167

**Signature:**
```solidity
function getLatestTroveData(uint256 _troveId) external view returns (LatestTroveData memory);;
```

### getTroveAnnualInterestRate(uint256) (inherited from ITroveManager)

- **Signature**: `getTroveAnnualInterestRate(uint256)`
- **Visibility**: external
- **Source Range**: 2429:86:167

**Signature:**
```solidity
function getTroveAnnualInterestRate(uint256 _troveId) external view returns (uint256);;
```

### getTroveStatus(uint256) (inherited from ITroveManager)

- **Signature**: `getTroveStatus(uint256)`
- **Visibility**: external
- **Source Range**: 2521:73:167

**Signature:**
```solidity
function getTroveStatus(uint256 _troveId) external view returns (Status);;
```

### getLatestBatchData(address) (inherited from ITroveManager)

- **Signature**: `getLatestBatchData(address)`
- **Visibility**: external
- **Source Range**: 2600:98:167

**Signature:**
```solidity
function getLatestBatchData(address _batchAddress) external view returns (LatestBatchData memory);;
```

### onOpenTrove(address,uint256,struct TroveChange,uint256) (inherited from ITroveManager)

- **Signature**: `onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: external
- **Source Range**: 2767:134:167

**Signature:**
```solidity
function onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) external;;
```

### onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2906:226:167

**Signature:**
```solidity
function onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) external;;
```

### setTroveStatusToActive(uint256) (inherited from ITroveManager)

- **Signature**: `setTroveStatusToActive(uint256)`
- **Visibility**: external
- **Source Range**: 3179:59:167

**Signature:**
```solidity
function setTroveStatusToActive(uint256 _troveId) external;;
```

### onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange) (inherited from ITroveManager)

- **Signature**: `onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3244:211:167

**Signature:**
```solidity
function onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange calldata _troveChange) external;;
```

### onAdjustTrove(uint256,uint256,uint256,struct TroveChange) (inherited from ITroveManager)

- **Signature**: `onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3461:129:167

**Signature:**
```solidity
function onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange calldata _troveChange) external;;
```

### onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3596:271:167

**Signature:**
```solidity
function onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;;
```

### onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange) (inherited from ITroveManager)

- **Signature**: `onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3873:269:167

**Signature:**
```solidity
function onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange calldata _troveChange) external;;
```

### onCloseTrove(uint256,struct TroveChange,address,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4148:306:167

**Signature:**
```solidity
function onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;;
```

### onRegisterBatchManager(address,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4481:113:167

**Signature:**
```solidity
function onRegisterBatchManager(address _batchAddress, uint256 _annualInterestRate, uint256 _annualFee) external;;
```

### onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4599:177:167

**Signature:**
```solidity
function onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) external;;
```

### onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4781:244:167

**Signature:**
```solidity
function onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) external;;
```

### onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams) (inherited from ITroveManager)

- **Signature**: `onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`
- **Visibility**: external
- **Source Range**: 5456:94:167

**Signature:**
```solidity
function onSetInterestBatchManager(OnSetInterestBatchManagerParams calldata _params) external;;
```

### onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256) (inherited from ITroveManager)

- **Signature**: `onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5555:429:167

**Signature:**
```solidity
function onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) external;;
```
