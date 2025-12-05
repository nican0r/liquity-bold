# Contract: TroveManagerTester

## Metadata

- **Name**: TroveManagerTester
- **Type**: Contract
- **Path**: test/TestContracts/TroveManagerTester.t.sol

## Implements Interfaces

- **ITroveEvents** [src/Interfaces/ITroveEvents.sol/interface_ITroveEvents.md]
- **ITroveManagerTester** [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]
- **ITroveManager** [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## State Variables

### activePool (inherited from LiquityBase)

```solidity
IActivePool public activePool
```

**IActivePool**: [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

### defaultPool (inherited from LiquityBase)

```solidity
IDefaultPool internal defaultPool
```

**IDefaultPool**: [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

### priceFeed (inherited from LiquityBase)

```solidity
IPriceFeed internal priceFeed
```

**IPriceFeed**: [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

### troveNFT (inherited from TroveManager)

```solidity
ITroveNFT public troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### borrowerOperations (inherited from TroveManager)

```solidity
IBorrowerOperations public borrowerOperations
```

**IBorrowerOperations**: [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

### stabilityPool (inherited from TroveManager)

```solidity
IStabilityPool public stabilityPool
```

**IStabilityPool**: [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

### gasPoolAddress (inherited from TroveManager)

```solidity
address internal gasPoolAddress
```

### collSurplusPool (inherited from TroveManager)

```solidity
ICollSurplusPool internal collSurplusPool
```

**ICollSurplusPool**: [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]

### boldToken (inherited from TroveManager)

```solidity
IBoldToken internal boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### sortedTroves (inherited from TroveManager)

```solidity
ISortedTroves public sortedTroves
```

**ISortedTroves**: [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

### collateralRegistry (inherited from TroveManager)

```solidity
ICollateralRegistry internal collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### WETH (inherited from TroveManager)

```solidity
IWETH internal immutable WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### CCR (inherited from TroveManager)

```solidity
uint256 public immutable CCR
```

### MCR (inherited from TroveManager)

```solidity
uint256 internal immutable MCR
```

### SCR (inherited from TroveManager)

```solidity
uint256 internal immutable SCR
```

### LIQUIDATION_PENALTY_SP (inherited from TroveManager)

```solidity
uint256 internal immutable LIQUIDATION_PENALTY_SP
```

### LIQUIDATION_PENALTY_REDISTRIBUTION (inherited from TroveManager)

```solidity
uint256 internal immutable LIQUIDATION_PENALTY_REDISTRIBUTION
```

### Troves (inherited from TroveManager)

```solidity
mapping(uint256 => Trove) public Troves
```

### batches (inherited from TroveManager)

```solidity
mapping(address => Batch) internal batches
```

### totalStakes (inherited from TroveManager)

```solidity
uint256 internal totalStakes
```

### totalStakesSnapshot (inherited from TroveManager)

```solidity
uint256 internal totalStakesSnapshot
```

### totalCollateralSnapshot (inherited from TroveManager)

```solidity
uint256 internal totalCollateralSnapshot
```

### L_coll (inherited from TroveManager)

```solidity
uint256 internal L_coll
```

### L_boldDebt (inherited from TroveManager)

```solidity
uint256 internal L_boldDebt
```

### rewardSnapshots (inherited from TroveManager)

```solidity
mapping(uint256 => RewardSnapshot) public rewardSnapshots
```

### TroveIds (inherited from TroveManager)

```solidity
uint256[] internal TroveIds
```

### batchIds (inherited from TroveManager)

```solidity
address[] public batchIds
```

### lastZombieTroveId (inherited from TroveManager)

```solidity
uint256 public lastZombieTroveId
```

### lastCollError_Redistribution (inherited from TroveManager)

```solidity
uint256 internal lastCollError_Redistribution
```

### lastBoldDebtError_Redistribution (inherited from TroveManager)

```solidity
uint256 internal lastBoldDebtError_Redistribution
```

### shutdownTime (inherited from TroveManager)

```solidity
uint256 public shutdownTime
```

### STALE_TROVE_DURATION

```solidity
uint256 internal constant STALE_TROVE_DURATION = 90 days
```

### BCR

```solidity
uint256 public immutable BCR
```

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

### Trove (inherited from TroveManager)

```solidity
struct Trove {
    uint256 debt;
    uint256 coll;
    uint256 stake;
    Status status;
    uint64 arrayIndex;
    uint64 lastDebtUpdateTime;
    uint64 lastInterestRateAdjTime;
    uint256 annualInterestRate;
    address interestBatchManager;
    uint256 batchDebtShares;
}
```

### Batch (inherited from TroveManager)

```solidity
struct Batch {
    uint256 debt;
    uint256 coll;
    uint64 arrayIndex;
    uint64 lastDebtUpdateTime;
    uint64 lastInterestRateAdjTime;
    uint256 annualInterestRate;
    uint256 annualManagementFee;
    uint256 totalDebtShares;
}
```

### RewardSnapshot (inherited from TroveManager)

```solidity
struct RewardSnapshot {
    uint256 coll;
    uint256 boldDebt;
}
```

### LiquidationValues (inherited from TroveManager)

```solidity
struct LiquidationValues {
    uint256 collGasCompensation;
    uint256 debtToOffset;
    uint256 collToSendToSP;
    uint256 debtToRedistribute;
    uint256 collToRedistribute;
    uint256 collSurplus;
    uint256 ETHGasCompensation;
    uint256 oldWeightedRecordedDebt;
    uint256 newWeightedRecordedDebt;
}
```

### RedeemCollateralValues (inherited from TroveManager)

```solidity
struct RedeemCollateralValues {
    uint256 totalCollFee;
    uint256 remainingBold;
    address lastBatchUpdatedInterest;
    uint256 nextUserToCheck;
}
```

### SingleRedemptionValues (inherited from TroveManager)

```solidity
struct SingleRedemptionValues {
    uint256 troveId;
    address batchAddress;
    uint256 boldLot;
    uint256 collLot;
    uint256 collFee;
    uint256 appliedRedistBoldDebtGain;
    uint256 oldWeightedRecordedDebt;
    uint256 newWeightedRecordedDebt;
    uint256 newStake;
    bool isZombieTrove;
    LatestTroveData trove;
    LatestBatchData batch;
}
```

## Errors

### EmptyData (inherited from TroveManager)

```solidity
error EmptyData();
```

### NothingToLiquidate (inherited from TroveManager)

```solidity
error NothingToLiquidate();
```

### CallerNotBorrowerOperations (inherited from TroveManager)

```solidity
error CallerNotBorrowerOperations();
```

### CallerNotCollateralRegistry (inherited from TroveManager)

```solidity
error CallerNotCollateralRegistry();
```

### OnlyOneTroveLeft (inherited from TroveManager)

```solidity
error OnlyOneTroveLeft();
```

### NotShutDown (inherited from TroveManager)

```solidity
error NotShutDown();
```

### ZeroAmount (inherited from TroveManager)

```solidity
error ZeroAmount();
```

### NotEnoughBoldBalance (inherited from TroveManager)

```solidity
error NotEnoughBoldBalance();
```

### MinCollNotReached (inherited from TroveManager)

```solidity
error MinCollNotReached(uint256 _coll);
```

### BatchSharesRatioTooHigh (inherited from TroveManager)

```solidity
error BatchSharesRatioTooHigh();
```

## Events

### ActivePoolAddressChanged (inherited from LiquityBase)

```solidity
event ActivePoolAddressChanged(address _newActivePoolAddress);
```

### DefaultPoolAddressChanged (inherited from LiquityBase)

```solidity
event DefaultPoolAddressChanged(address _newDefaultPoolAddress);
```

### PriceFeedAddressChanged (inherited from LiquityBase)

```solidity
event PriceFeedAddressChanged(address _newPriceFeedAddress);
```

### Liquidation (inherited from ITroveEvents)

```solidity
event Liquidation(uint256 _debtOffsetBySP, uint256 _debtRedistributed, uint256 _boldGasCompensation, uint256 _collGasCompensation, uint256 _collSentToSP, uint256 _collRedistributed, uint256 _collSurplus, uint256 _L_ETH, uint256 _L_boldDebt, uint256 _price);
```

### Redemption (inherited from ITroveEvents)

```solidity
event Redemption(uint256 _attemptedBoldAmount, uint256 _actualBoldAmount, uint256 _ETHSent, uint256 _ETHFee, uint256 _price, uint256 _redemptionPrice);
```

### TroveUpdated (inherited from ITroveEvents)

```solidity
event TroveUpdated(uint256 indexed _troveId, uint256 _debt, uint256 _coll, uint256 _stake, uint256 _annualInterestRate, uint256 _snapshotOfTotalCollRedist, uint256 _snapshotOfTotalDebtRedist);
```

### TroveOperation (inherited from ITroveEvents)

```solidity
event TroveOperation(uint256 indexed _troveId, Operation _operation, uint256 _annualInterestRate, uint256 _debtIncreaseFromRedist, uint256 _debtIncreaseFromUpfrontFee, int256 _debtChangeFromOperation, uint256 _collIncreaseFromRedist, int256 _collChangeFromOperation);
```

### RedemptionFeePaidToTrove (inherited from ITroveEvents)

```solidity
event RedemptionFeePaidToTrove(uint256 indexed _troveId, uint256 _ETHFee);
```

### BatchUpdated (inherited from ITroveEvents)

```solidity
event BatchUpdated(address indexed _interestBatchManager, BatchOperation _operation, uint256 _debt, uint256 _coll, uint256 _annualInterestRate, uint256 _annualManagementFee, uint256 _totalDebtShares, uint256 _debtIncreaseFromUpfrontFee);
```

### BatchedTroveUpdated (inherited from ITroveEvents)

```solidity
event BatchedTroveUpdated(uint256 indexed _troveId, address _interestBatchManager, uint256 _batchDebtShares, uint256 _coll, uint256 _stake, uint256 _snapshotOfTotalCollRedist, uint256 _snapshotOfTotalDebtRedist);
```

### TroveNFTAddressChanged (inherited from TroveManager)

```solidity
event TroveNFTAddressChanged(address _newTroveNFTAddress);
```

### BorrowerOperationsAddressChanged (inherited from TroveManager)

```solidity
event BorrowerOperationsAddressChanged(address _newBorrowerOperationsAddress);
```

### BoldTokenAddressChanged (inherited from TroveManager)

```solidity
event BoldTokenAddressChanged(address _newBoldTokenAddress);
```

### StabilityPoolAddressChanged (inherited from TroveManager)

```solidity
event StabilityPoolAddressChanged(address _stabilityPoolAddress);
```

### GasPoolAddressChanged (inherited from TroveManager)

```solidity
event GasPoolAddressChanged(address _gasPoolAddress);
```

### CollSurplusPoolAddressChanged (inherited from TroveManager)

```solidity
event CollSurplusPoolAddressChanged(address _collSurplusPoolAddress);
```

### SortedTrovesAddressChanged (inherited from TroveManager)

```solidity
event SortedTrovesAddressChanged(address _sortedTrovesAddress);
```

### CollateralRegistryAddressChanged (inherited from TroveManager)

```solidity
event CollateralRegistryAddressChanged(address _collateralRegistryAddress);
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

### Operation (inherited from ITroveEvents)

```solidity
enum Operation {
    openTrove,
    closeTrove,
    adjustTrove,
    adjustTroveInterestRate,
    applyPendingDebt,
    liquidate,
    redeemCollateral,
    openTroveAndJoinBatch,
    setInterestBatchManager,
    removeFromBatch
}
```

### BatchOperation (inherited from ITroveEvents)

```solidity
enum BatchOperation {
    registerBatchManager,
    lowerBatchManagerAnnualFee,
    setBatchManagerAnnualInterestRate,
    applyBatchInterestAndFee,
    joinBatch,
    exitBatch,
    troveChange
}
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 627:131:282
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry) TroveManager(_addressesRegistry);
```

### liquidate(uint256)

- **Signature**: `liquidate(uint256)`
- **Visibility**: external
- **Source Range**: 872:182:282
- **Details**: [function_liquidate_uint256.md](./function_liquidate_uint256.md)

**Signature:**
```solidity
function liquidate(uint256 _troveId) override external;
```

### get_CCR()

- **Signature**: `get_CCR()`
- **Visibility**: external
- **Source Range**: 1060:78:282
- **Details**: [function_get_CCR.md](./function_get_CCR.md)

**Signature:**
```solidity
function get_CCR() external view returns (uint256);
```

### get_MCR()

- **Signature**: `get_MCR()`
- **Visibility**: external
- **Source Range**: 1144:78:282
- **Details**: [function_get_MCR.md](./function_get_MCR.md)

**Signature:**
```solidity
function get_MCR() external view returns (uint256);
```

### get_BCR()

- **Signature**: `get_BCR()`
- **Visibility**: external
- **Source Range**: 1228:78:282
- **Details**: [function_get_BCR.md](./function_get_BCR.md)

**Signature:**
```solidity
function get_BCR() external view returns (uint256);
```

### get_SCR()

- **Signature**: `get_SCR()`
- **Visibility**: external
- **Source Range**: 1312:78:282
- **Details**: [function_get_SCR.md](./function_get_SCR.md)

**Signature:**
```solidity
function get_SCR() external view returns (uint256);
```

### get_LIQUIDATION_PENALTY_SP()

- **Signature**: `get_LIQUIDATION_PENALTY_SP()`
- **Visibility**: external
- **Source Range**: 1396:116:282
- **Details**: [function_get_LIQUIDATION_PENALTY_SP.md](./function_get_LIQUIDATION_PENALTY_SP.md)

**Signature:**
```solidity
function get_LIQUIDATION_PENALTY_SP() external view returns (uint256);
```

### get_LIQUIDATION_PENALTY_REDISTRIBUTION()

- **Signature**: `get_LIQUIDATION_PENALTY_REDISTRIBUTION()`
- **Visibility**: external
- **Source Range**: 1518:140:282
- **Details**: [function_get_LIQUIDATION_PENALTY_REDISTRIBUTION.md](./function_get_LIQUIDATION_PENALTY_REDISTRIBUTION.md)

**Signature:**
```solidity
function get_LIQUIDATION_PENALTY_REDISTRIBUTION() external view returns (uint256);
```

### getBoldToken()

- **Signature**: `getBoldToken()`
- **Visibility**: external
- **Source Range**: 1664:92:282
- **Details**: [function_getBoldToken.md](./function_getBoldToken.md)

**Signature:**
```solidity
function getBoldToken() external view returns (IBoldToken);
```

### getBorrowerOperations()

- **Signature**: `getBorrowerOperations()`
- **Visibility**: external
- **Source Range**: 1762:119:282
- **Details**: [function_getBorrowerOperations.md](./function_getBorrowerOperations.md)

**Signature:**
```solidity
function getBorrowerOperations() external view returns (IBorrowerOperations);
```

### get_L_coll()

- **Signature**: `get_L_coll()`
- **Visibility**: external
- **Source Range**: 1887:84:282
- **Details**: [function_get_L_coll.md](./function_get_L_coll.md)

**Signature:**
```solidity
function get_L_coll() external view returns (uint256);
```

### get_L_boldDebt()

- **Signature**: `get_L_boldDebt()`
- **Visibility**: external
- **Source Range**: 1977:92:282
- **Details**: [function_get_L_boldDebt.md](./function_get_L_boldDebt.md)

**Signature:**
```solidity
function get_L_boldDebt() external view returns (uint256);
```

### getTotalStakes()

- **Signature**: `getTotalStakes()`
- **Visibility**: external
- **Source Range**: 2075:93:282
- **Details**: [function_getTotalStakes.md](./function_getTotalStakes.md)

**Signature:**
```solidity
function getTotalStakes() external view returns (uint256);
```

### getTotalStakesSnapshot()

- **Signature**: `getTotalStakesSnapshot()`
- **Visibility**: external
- **Source Range**: 2174:109:282
- **Details**: [function_getTotalStakesSnapshot.md](./function_getTotalStakesSnapshot.md)

**Signature:**
```solidity
function getTotalStakesSnapshot() external view returns (uint256);
```

### getTotalCollateralSnapshot()

- **Signature**: `getTotalCollateralSnapshot()`
- **Visibility**: external
- **Source Range**: 2289:117:282
- **Details**: [function_getTotalCollateralSnapshot.md](./function_getTotalCollateralSnapshot.md)

**Signature:**
```solidity
function getTotalCollateralSnapshot() external view returns (uint256);
```

### get_lastCollError_Redistribution()

- **Signature**: `get_lastCollError_Redistribution()`
- **Visibility**: external
- **Source Range**: 2412:128:282
- **Details**: [function_get_lastCollError_Redistribution.md](./function_get_lastCollError_Redistribution.md)

**Signature:**
```solidity
function get_lastCollError_Redistribution() external view returns (uint256);
```

### get_lastBoldDebtError_Redistribution()

- **Signature**: `get_lastBoldDebtError_Redistribution()`
- **Visibility**: external
- **Source Range**: 2546:136:282
- **Details**: [function_get_lastBoldDebtError_Redistribution.md](./function_get_lastBoldDebtError_Redistribution.md)

**Signature:**
```solidity
function get_lastBoldDebtError_Redistribution() external view returns (uint256);
```

### getTroveId(uint256)

- **Signature**: `getTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 2688:108:282
- **Details**: [function_getTroveId_uint256.md](./function_getTroveId_uint256.md)

**Signature:**
```solidity
function getTroveId(uint256 _index) external view returns (uint256);
```

### getTCR(uint256)

- **Signature**: `getTCR(uint256)`
- **Visibility**: external
- **Source Range**: 2802:112:282
- **Details**: [function_getTCR_uint256.md](./function_getTCR_uint256.md)

**Signature:**
```solidity
function getTCR(uint256 _price) override external view returns (uint256);
```

### checkBelowCriticalThreshold(uint256)

- **Signature**: `checkBelowCriticalThreshold(uint256)`
- **Visibility**: external
- **Source Range**: 2920:156:282
- **Details**: [function_checkBelowCriticalThreshold_uint256.md](./function_checkBelowCriticalThreshold_uint256.md)

**Signature:**
```solidity
function checkBelowCriticalThreshold(uint256 _price) override external view returns (bool);
```

### computeICR(uint256,uint256,uint256)

- **Signature**: `computeICR(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3082:166:282
- **Details**: [function_computeICR_uint256_uint256_uint256.md](./function_computeICR_uint256_uint256_uint256.md)

**Signature:**
```solidity
function computeICR(uint256 _coll, uint256 _debt, uint256 _price) external pure returns (uint256);
```

### getCollGasCompensation(uint256,uint256,uint256)

- **Signature**: `getCollGasCompensation(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3254:451:282
- **Details**: [function_getCollGasCompensation_uint256_uint256_uint256.md](./function_getCollGasCompensation_uint256_uint256_uint256.md)

**Signature:**
```solidity
function getCollGasCompensation(uint256 _entireColl, uint256 _entireDebt, uint256 _boldInSPForOffsets) external pure returns (uint256);
```

### getCollGasCompensation(uint256)

- **Signature**: `getCollGasCompensation(uint256)`
- **Visibility**: external
- **Source Range**: 3711:133:282
- **Details**: [function_getCollGasCompensation_uint256.md](./function_getCollGasCompensation_uint256.md)

**Signature:**
```solidity
function getCollGasCompensation(uint256 _coll) external pure returns (uint256);
```

### getETHGasCompensation()

- **Signature**: `getETHGasCompensation()`
- **Visibility**: external
- **Source Range**: 3850:109:282
- **Details**: [function_getETHGasCompensation.md](./function_getETHGasCompensation.md)

**Signature:**
```solidity
function getETHGasCompensation() external pure returns (uint256);
```

### predictOpenTroveUpfrontFee(uint256,uint256)

- **Signature**: `predictOpenTroveUpfrontFee(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4698:465:282
- **Details**: [function_predictOpenTroveUpfrontFee_uint256_uint256.md](./function_predictOpenTroveUpfrontFee_uint256_uint256.md)

**Signature:**
```solidity
function predictOpenTroveUpfrontFee(uint256 borrowedAmount, uint256 interestRate) external view returns (uint256);
```

### getEffectiveRedemptionFeeInColl(uint256,uint256)

- **Signature**: `getEffectiveRedemptionFeeInColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5361:230:282
- **Details**: [function_getEffectiveRedemptionFeeInColl_uint256_uint256.md](./function_getEffectiveRedemptionFeeInColl_uint256_uint256.md)

**Signature:**
```solidity
function getEffectiveRedemptionFeeInColl(uint256 _redeemAmount, uint256 _price) external view returns (uint256);
```

### callInternalRemoveTroveId(uint256)

- **Signature**: `callInternalRemoveTroveId(uint256)`
- **Visibility**: external
- **Source Range**: 5597:185:282
- **Details**: [function_callInternalRemoveTroveId_uint256.md](./function_callInternalRemoveTroveId_uint256.md)

**Signature:**
```solidity
function callInternalRemoveTroveId(uint256 _troveId) external;
```

### ownerOf(uint256)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: external
- **Source Range**: 5788:117:282
- **Details**: [function_ownerOf_uint256.md](./function_ownerOf_uint256.md)

**Signature:**
```solidity
function ownerOf(uint256 _troveId) external view returns (address);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 5911:121:282
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
function balanceOf(address _account) external view returns (uint256);
```

### checkTroveIsOpen(uint256)

- **Signature**: `checkTroveIsOpen(uint256)`
- **Visibility**: public
- **Source Range**: 6070:194:282
- **Details**: [function_checkTroveIsOpen_uint256.md](./function_checkTroveIsOpen_uint256.md)

**Signature:**
```solidity
function checkTroveIsOpen(uint256 _troveId) public view returns (bool);
```

### checkTroveIsActive(uint256)

- **Signature**: `checkTroveIsActive(uint256)`
- **Visibility**: external
- **Source Range**: 6270:171:282
- **Details**: [function_checkTroveIsActive_uint256.md](./function_checkTroveIsActive_uint256.md)

**Signature:**
```solidity
function checkTroveIsActive(uint256 _troveId) external view returns (bool);
```

### checkTroveIsZombie(uint256)

- **Signature**: `checkTroveIsZombie(uint256)`
- **Visibility**: external
- **Source Range**: 6447:171:282
- **Details**: [function_checkTroveIsZombie_uint256.md](./function_checkTroveIsZombie_uint256.md)

**Signature:**
```solidity
function checkTroveIsZombie(uint256 _troveId) external view returns (bool);
```

### hasRedistributionGains(uint256)

- **Signature**: `hasRedistributionGains(uint256)`
- **Visibility**: external
- **Source Range**: 6624:486:282
- **Details**: [function_hasRedistributionGains_uint256.md](./function_hasRedistributionGains_uint256.md)

**Signature:**
```solidity
function hasRedistributionGains(uint256 _troveId) override external view returns (bool);
```

### getPendingCollReward(uint256)

- **Signature**: `getPendingCollReward(uint256)`
- **Visibility**: external
- **Source Range**: 7197:232:282
- **Details**: [function_getPendingCollReward_uint256.md](./function_getPendingCollReward_uint256.md)

**Signature:**
```solidity
function getPendingCollReward(uint256 _troveId) override external view returns (uint256 redistCollGain);
```

### getPendingBoldDebtReward(uint256)

- **Signature**: `getPendingBoldDebtReward(uint256)`
- **Visibility**: external
- **Source Range**: 7516:244:282
- **Details**: [function_getPendingBoldDebtReward_uint256.md](./function_getPendingBoldDebtReward_uint256.md)

**Signature:**
```solidity
function getPendingBoldDebtReward(uint256 _troveId) override external view returns (uint256 redistBoldDebtGain);
```

### getEntireDebtAndColl(uint256)

- **Signature**: `getEntireDebtAndColl(uint256)`
- **Visibility**: external
- **Source Range**: 7766:525:282
- **Details**: [function_getEntireDebtAndColl_uint256.md](./function_getEntireDebtAndColl_uint256.md)

**Signature:**
```solidity
function getEntireDebtAndColl(uint256 _troveId) external view returns (uint256 entireDebt, uint256 entireColl, uint256 pendingBoldDebtReward, uint256 pendingCollReward, uint256 accruedTroveInterest);
```

### getTroveEntireDebt(uint256)

- **Signature**: `getTroveEntireDebt(uint256)`
- **Visibility**: external
- **Source Range**: 8297:202:282
- **Details**: [function_getTroveEntireDebt_uint256.md](./function_getTroveEntireDebt_uint256.md)

**Signature:**
```solidity
function getTroveEntireDebt(uint256 _troveId) external view returns (uint256);
```

### getTroveEntireColl(uint256)

- **Signature**: `getTroveEntireColl(uint256)`
- **Visibility**: external
- **Source Range**: 8505:202:282
- **Details**: [function_getTroveEntireColl_uint256.md](./function_getTroveEntireColl_uint256.md)

**Signature:**
```solidity
function getTroveEntireColl(uint256 _troveId) external view returns (uint256);
```

### getTroveStake(uint256)

- **Signature**: `getTroveStake(uint256)`
- **Visibility**: external
- **Source Range**: 8862:128:282
- **Details**: [function_getTroveStake_uint256.md](./function_getTroveStake_uint256.md)

**Signature:**
```solidity
function getTroveStake(uint256 _troveId) override external view returns (uint256);
```

### getTroveDebt(uint256)

- **Signature**: `getTroveDebt(uint256)`
- **Visibility**: external
- **Source Range**: 8996:459:282
- **Details**: [function_getTroveDebt_uint256.md](./function_getTroveDebt_uint256.md)

**Signature:**
```solidity
function getTroveDebt(uint256 _troveId) override external view returns (uint256);
```

### getTroveWeightedRecordedDebt(uint256)

- **Signature**: `getTroveWeightedRecordedDebt(uint256)`
- **Visibility**: external
- **Source Range**: 9461:520:282
- **Details**: [function_getTroveWeightedRecordedDebt_uint256.md](./function_getTroveWeightedRecordedDebt_uint256.md)

**Signature:**
```solidity
function getTroveWeightedRecordedDebt(uint256 _troveId) external view returns (uint256);
```

### getTroveColl(uint256)

- **Signature**: `getTroveColl(uint256)`
- **Visibility**: external
- **Source Range**: 9987:162:282
- **Details**: [function_getTroveColl_uint256.md](./function_getTroveColl_uint256.md)

**Signature:**
```solidity
function getTroveColl(uint256 _troveId) override external view returns (uint256);
```

### getTroveLastDebtUpdateTime(uint256)

- **Signature**: `getTroveLastDebtUpdateTime(uint256)`
- **Visibility**: external
- **Source Range**: 10155:350:282
- **Details**: [function_getTroveLastDebtUpdateTime_uint256.md](./function_getTroveLastDebtUpdateTime_uint256.md)

**Signature:**
```solidity
function getTroveLastDebtUpdateTime(uint256 _troveId) external view returns (uint256);
```

### troveIsStale(uint256)

- **Signature**: `troveIsStale(uint256)`
- **Visibility**: external
- **Source Range**: 10511:415:282
- **Details**: [function_troveIsStale_uint256.md](./function_troveIsStale_uint256.md)

**Signature:**
```solidity
function troveIsStale(uint256 _troveId) external view returns (bool);
```

### calcTroveAccruedInterest(uint256)

- **Signature**: `calcTroveAccruedInterest(uint256)`
- **Visibility**: external
- **Source Range**: 11066:868:282
- **Details**: [function_calcTroveAccruedInterest_uint256.md](./function_calcTroveAccruedInterest_uint256.md)

**Signature:**
```solidity
function calcTroveAccruedInterest(uint256 _troveId) external view returns (uint256);
```

### calcBatchAccruedInterest(address)

- **Signature**: `calcBatchAccruedInterest(address)`
- **Visibility**: public
- **Source Range**: 11940:478:282
- **Details**: [function_calcBatchAccruedInterest_address.md](./function_calcBatchAccruedInterest_address.md)

**Signature:**
```solidity
function calcBatchAccruedInterest(address _batchAddress) public view returns (uint256);
```

### calcTroveAccruedBatchManagementFee(uint256)

- **Signature**: `calcTroveAccruedBatchManagementFee(uint256)`
- **Visibility**: external
- **Source Range**: 12424:704:282
- **Details**: [function_calcTroveAccruedBatchManagementFee_uint256.md](./function_calcTroveAccruedBatchManagementFee_uint256.md)

**Signature:**
```solidity
function calcTroveAccruedBatchManagementFee(uint256 _troveId) external view returns (uint256);
```

### calcBatchAccruedManagementFee(address)

- **Signature**: `calcBatchAccruedManagementFee(address)`
- **Visibility**: public
- **Source Range**: 13134:345:282
- **Details**: [function_calcBatchAccruedManagementFee_address.md](./function_calcBatchAccruedManagementFee_address.md)

**Signature:**
```solidity
function calcBatchAccruedManagementFee(address _batchAddress) public view returns (uint256);
```

### getBatchAnnualInterestRate(address)

- **Signature**: `getBatchAnnualInterestRate(address)`
- **Visibility**: external
- **Source Range**: 13485:156:282
- **Details**: [function_getBatchAnnualInterestRate_address.md](./function_getBatchAnnualInterestRate_address.md)

**Signature:**
```solidity
function getBatchAnnualInterestRate(address _batchAddress) external view returns (uint256);
```

### getBatchLastDebtUpdateTime(address)

- **Signature**: `getBatchLastDebtUpdateTime(address)`
- **Visibility**: external
- **Source Range**: 13647:156:282
- **Details**: [function_getBatchLastDebtUpdateTime_address.md](./function_getBatchLastDebtUpdateTime_address.md)

**Signature:**
```solidity
function getBatchLastDebtUpdateTime(address _batchAddress) external view returns (uint256);
```

### getBatch(address)

- **Signature**: `getBatch(address)`
- **Visibility**: external
- **Source Range**: 13809:745:282
- **Details**: [function_getBatch_address.md](./function_getBatch_address.md)

**Signature:**
```solidity
function getBatch(address _batchAddress) external view returns (uint256 debt, uint256 coll, uint64 arrayIndex, uint64 lastDebtUpdateTime, uint64 lastInterestRateAdjTime, uint256 annualInterestRate, uint256 annualManagementFee, uint256 totalDebtShares);
```

### getEntireBranchColl() (inherited from LiquityBase)

- **Signature**: `getEntireBranchColl()`
- **Visibility**: public
- **Source Range**: 1265:251:136
- **Details**: [function_getEntireBranchColl.md](./function_getEntireBranchColl.md)

**Signature:**
```solidity
function getEntireBranchColl() public view returns (uint256 entireSystemColl);
```

### getEntireBranchDebt() (inherited from LiquityBase)

- **Signature**: `getEntireBranchDebt()`
- **Visibility**: public
- **Source Range**: 1522:237:136
- **Details**: [function_getEntireBranchDebt.md](./function_getEntireBranchDebt.md)

**Signature:**
```solidity
function getEntireBranchDebt() public view returns (uint256 entireSystemDebt);
```

### getTroveIdsCount() (inherited from TroveManager)

- **Signature**: `getTroveIdsCount()`
- **Visibility**: external
- **Source Range**: 8366:108:188
- **Details**: [function_getTroveIdsCount.md](./function_getTroveIdsCount.md)

**Signature:**
```solidity
function getTroveIdsCount() override external view returns (uint256);
```

### getTroveFromTroveIdsArray(uint256) (inherited from TroveManager)

- **Signature**: `getTroveFromTroveIdsArray(uint256)`
- **Visibility**: external
- **Source Range**: 8480:132:188
- **Details**: [function_getTroveFromTroveIdsArray_uint256.md](./function_getTroveFromTroveIdsArray_uint256.md)

**Signature:**
```solidity
function getTroveFromTroveIdsArray(uint256 _index) override external view returns (uint256);
```

### batchLiquidateTroves(uint256[]) (inherited from TroveManager)

- **Signature**: `batchLiquidateTroves(uint256[])`
- **Visibility**: public
- **Source Range**: 16919:2461:188
- **Details**: [function_batchLiquidateTroves_uint256[].md](./function_batchLiquidateTroves_uint256[].md)

**Signature:**
```solidity
function batchLiquidateTroves(uint256[] memory _troveArray) override public;
```

### redeemCollateral(address,uint256,uint256,uint256,uint256) (inherited from TroveManager)

- **Signature**: `redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 33442:4703:188
- **Details**: [function_redeemCollateral_address_uint256_uint256_uint256_uint256.md](./function_redeemCollateral_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) override external returns (uint256 _redeemedAmount);
```

### urgentRedemption(uint256,uint256[],uint256) (inherited from TroveManager)

- **Signature**: `urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 39746:3172:188
- **Details**: [function_urgentRedemption_uint256_uint256[]_uint256.md](./function_urgentRedemption_uint256_uint256[]_uint256.md)

**Signature:**
```solidity
function urgentRedemption(uint256 _boldAmount, uint256[] calldata _troveIds, uint256 _minCollateral) external;
```

### shutdown() (inherited from TroveManager)

- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 42924:160:188
- **Details**: [function_shutdown.md](./function_shutdown.md)

**Signature:**
```solidity
function shutdown() external;
```

### getCurrentICR(uint256,uint256) (inherited from TroveManager)

- **Signature**: `getCurrentICR(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 43271:270:188
- **Details**: [function_getCurrentICR_uint256_uint256.md](./function_getCurrentICR_uint256_uint256.md)

**Signature:**
```solidity
function getCurrentICR(uint256 _troveId, uint256 _price) override public view returns (uint256);
```

### getLatestTroveData(uint256) (inherited from TroveManager)

- **Signature**: `getLatestTroveData(uint256)`
- **Visibility**: external
- **Source Range**: 47049:152:188
- **Details**: [function_getLatestTroveData_uint256.md](./function_getLatestTroveData_uint256.md)

**Signature:**
```solidity
function getLatestTroveData(uint256 _troveId) external view returns (LatestTroveData memory trove);
```

### getTroveAnnualInterestRate(uint256) (inherited from TroveManager)

- **Signature**: `getTroveAnnualInterestRate(uint256)`
- **Visibility**: external
- **Source Range**: 47207:350:188
- **Details**: [function_getTroveAnnualInterestRate_uint256.md](./function_getTroveAnnualInterestRate_uint256.md)

**Signature:**
```solidity
function getTroveAnnualInterestRate(uint256 _troveId) external view returns (uint256);
```

### getLatestBatchData(address) (inherited from TroveManager)

- **Signature**: `getLatestBatchData(address)`
- **Visibility**: external
- **Source Range**: 49319:162:188
- **Details**: [function_getLatestBatchData_address.md](./function_getLatestBatchData_address.md)

**Signature:**
```solidity
function getLatestBatchData(address _batchAddress) external view returns (LatestBatchData memory batch);
```

### getTroveStatus(uint256) (inherited from TroveManager)

- **Signature**: `getTroveStatus(uint256)`
- **Visibility**: external
- **Source Range**: 53836:129:188
- **Details**: [function_getTroveStatus_uint256.md](./function_getTroveStatus_uint256.md)

**Signature:**
```solidity
function getTroveStatus(uint256 _troveId) override external view returns (Status);
```

### getUnbackedPortionPriceAndRedeemability() (inherited from TroveManager)

- **Signature**: `getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: external
- **Source Range**: 56017:626:188
- **Details**: [function_getUnbackedPortionPriceAndRedeemability.md](./function_getUnbackedPortionPriceAndRedeemability.md)

**Signature:**
```solidity
function getUnbackedPortionPriceAndRedeemability() external returns (uint256, uint256, bool);
```

### onOpenTrove(address,uint256,struct TroveChange,uint256) (inherited from TroveManager)

- **Signature**: `onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: external
- **Source Range**: 56718:1943:188
- **Details**: [function_onOpenTrove_address_uint256_struct_TroveChange_uint256.md](./function_onOpenTrove_address_uint256_struct_TroveChange_uint256.md)

**Signature:**
```solidity
function onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) external;
```

### onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256) (inherited from TroveManager)

- **Signature**: `onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 58667:2820:188
- **Details**: [function_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md](./function_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) external;
```

### setTroveStatusToActive(uint256) (inherited from TroveManager)

- **Signature**: `setTroveStatusToActive(uint256)`
- **Visibility**: external
- **Source Range**: 61493:251:188
- **Details**: [function_setTroveStatusToActive_uint256.md](./function_setTroveStatusToActive_uint256.md)

**Signature:**
```solidity
function setTroveStatusToActive(uint256 _troveId) external;
```

### onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange) (inherited from TroveManager)

- **Signature**: `onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 61750:1591:188
- **Details**: [function_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md](./function_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange calldata _troveChange) external;
```

### onAdjustTrove(uint256,uint256,uint256,struct TroveChange) (inherited from TroveManager)

- **Signature**: `onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 63347:1578:188
- **Details**: [function_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md](./function_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange calldata _troveChange) external;
```

### onCloseTrove(uint256,struct TroveChange,address,uint256,uint256) (inherited from TroveManager)

- **Signature**: `onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 64931:2085:188
- **Details**: [function_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md](./function_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) override external;
```

### onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (inherited from TroveManager)

- **Signature**: `onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 69154:2698:188
- **Details**: [function_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md](./function_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;
```

### onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange) (inherited from TroveManager)

- **Signature**: `onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 71858:2449:188
- **Details**: [function_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md](./function_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange calldata _troveChange) external;
```

### onRegisterBatchManager(address,uint256,uint256) (inherited from TroveManager)

- **Signature**: `onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 74313:874:188
- **Details**: [function_onRegisterBatchManager_address_uint256_uint256.md](./function_onRegisterBatchManager_address_uint256_uint256.md)

**Signature:**
```solidity
function onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) external;
```

### onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256) (inherited from TroveManager)

- **Signature**: `onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 75193:946:188
- **Details**: [function_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md](./function_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) external;
```

### onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256) (inherited from TroveManager)

- **Signature**: `onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 76145:1078:188
- **Details**: [function_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md](./function_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) external;
```

### onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams) (inherited from TroveManager)

- **Signature**: `onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`
- **Visibility**: external
- **Source Range**: 77229:3070:188
- **Details**: [function_onSetInterestBatchManager_struct_ITroveManager.OnSetInterestBatchManagerParams.md](./function_onSetInterestBatchManager_struct_ITroveManager.OnSetInterestBatchManagerParams.md)

**Signature:**
```solidity
function onSetInterestBatchManager(OnSetInterestBatchManagerParams calldata _params) external;
```

### onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256) (inherited from TroveManager)

- **Signature**: `onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 85301:2770:188
- **Details**: [function_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md](./function_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) external;
```
