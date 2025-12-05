# Interface: ITroveManager

## Metadata

- **Name**: ITroveManager
- **Type**: Interface
- **Path**: src/Interfaces/ITroveManager.sol

## Implements Interfaces

- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## Structs

### OnSetInterestBatchManagerParams

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

### Status

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

### shutdownTime()

- **Signature**: `shutdownTime()`
- **Visibility**: external
- **Source Range**: 534:56:167

**Signature:**
```solidity
function shutdownTime() external view returns (uint256);;
```

### troveNFT()

- **Signature**: `troveNFT()`
- **Visibility**: external
- **Source Range**: 596:54:167

**Signature:**
```solidity
function troveNFT() external view returns (ITroveNFT);;
```

### stabilityPool()

- **Signature**: `stabilityPool()`
- **Visibility**: external
- **Source Range**: 655:64:167

**Signature:**
```solidity
function stabilityPool() external view returns (IStabilityPool);;
```

### sortedTroves()

- **Signature**: `sortedTroves()`
- **Visibility**: external
- **Source Range**: 787:62:167

**Signature:**
```solidity
function sortedTroves() external view returns (ISortedTroves);;
```

### borrowerOperations()

- **Signature**: `borrowerOperations()`
- **Visibility**: external
- **Source Range**: 854:74:167

**Signature:**
```solidity
function borrowerOperations() external view returns (IBorrowerOperations);;
```

### Troves(uint256)

- **Signature**: `Troves(uint256)`
- **Visibility**: external
- **Source Range**: 934:425:167

**Signature:**
```solidity
function Troves(uint256 _id) external view returns (uint256 debt, uint256 coll, uint256 stake, Status status, uint64 arrayIndex, uint64 lastDebtUpdateTime, uint64 lastInterestRateAdjTime, uint256 annualInterestRate, address interestBatchManager, uint256 batchDebtShares);;
```

### rewardSnapshots(uint256)

- **Signature**: `rewardSnapshots(uint256)`
- **Visibility**: external
- **Source Range**: 1365:93:167

**Signature:**
```solidity
function rewardSnapshots(uint256 _id) external view returns (uint256 coll, uint256 boldDebt);;
```

### getTroveIdsCount()

- **Signature**: `getTroveIdsCount()`
- **Visibility**: external
- **Source Range**: 1464:60:167

**Signature:**
```solidity
function getTroveIdsCount() external view returns (uint256);;
```

### getTroveFromTroveIdsArray(uint256)

- **Signature**: `getTroveFromTroveIdsArray(uint256)`
- **Visibility**: external
- **Source Range**: 1530:83:167

**Signature:**
```solidity
function getTroveFromTroveIdsArray(uint256 _index) external view returns (uint256);;
```

### getCurrentICR(uint256,uint256)

- **Signature**: `getCurrentICR(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1619:89:167

**Signature:**
```solidity
function getCurrentICR(uint256 _troveId, uint256 _price) external view returns (uint256);;
```

### lastZombieTroveId()

- **Signature**: `lastZombieTroveId()`
- **Visibility**: external
- **Source Range**: 1714:61:167

**Signature:**
```solidity
function lastZombieTroveId() external view returns (uint256);;
```

### batchLiquidateTroves(uint256[])

- **Signature**: `batchLiquidateTroves(uint256[])`
- **Visibility**: external
- **Source Range**: 1781:71:167

**Signature:**
```solidity
function batchLiquidateTroves(uint256[] calldata _troveArray) external;;
```

### redeemCollateral(address,uint256,uint256,uint256,uint256)

- **Signature**: `redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1858:218:167

**Signature:**
```solidity
function redeemCollateral(address _sender, uint256 _boldAmount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) external returns (uint256 _redemeedAmount);;
```

### shutdown()

- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 2082:29:167

**Signature:**
```solidity
function shutdown() external;;
```

### urgentRedemption(uint256,uint256[],uint256)

- **Signature**: `urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 2116:110:167

**Signature:**
```solidity
function urgentRedemption(uint256 _boldAmount, uint256[] calldata _troveIds, uint256 _minCollateral) external;;
```

### getUnbackedPortionPriceAndRedeemability()

- **Signature**: `getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: external
- **Source Range**: 2232:93:167

**Signature:**
```solidity
function getUnbackedPortionPriceAndRedeemability() external returns (uint256, uint256, bool);;
```

### getLatestTroveData(uint256)

- **Signature**: `getLatestTroveData(uint256)`
- **Visibility**: external
- **Source Range**: 2331:93:167

**Signature:**
```solidity
function getLatestTroveData(uint256 _troveId) external view returns (LatestTroveData memory);;
```

### getTroveAnnualInterestRate(uint256)

- **Signature**: `getTroveAnnualInterestRate(uint256)`
- **Visibility**: external
- **Source Range**: 2429:86:167

**Signature:**
```solidity
function getTroveAnnualInterestRate(uint256 _troveId) external view returns (uint256);;
```

### getTroveStatus(uint256)

- **Signature**: `getTroveStatus(uint256)`
- **Visibility**: external
- **Source Range**: 2521:73:167

**Signature:**
```solidity
function getTroveStatus(uint256 _troveId) external view returns (Status);;
```

### getLatestBatchData(address)

- **Signature**: `getLatestBatchData(address)`
- **Visibility**: external
- **Source Range**: 2600:98:167

**Signature:**
```solidity
function getLatestBatchData(address _batchAddress) external view returns (LatestBatchData memory);;
```

### onOpenTrove(address,uint256,struct TroveChange,uint256)

- **Signature**: `onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: external
- **Source Range**: 2767:134:167

**Signature:**
```solidity
function onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) external;;
```

### onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2906:226:167

**Signature:**
```solidity
function onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) external;;
```

### setTroveStatusToActive(uint256)

- **Signature**: `setTroveStatusToActive(uint256)`
- **Visibility**: external
- **Source Range**: 3179:59:167

**Signature:**
```solidity
function setTroveStatusToActive(uint256 _troveId) external;;
```

### onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)

- **Signature**: `onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3244:211:167

**Signature:**
```solidity
function onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange calldata _troveChange) external;;
```

### onAdjustTrove(uint256,uint256,uint256,struct TroveChange)

- **Signature**: `onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3461:129:167

**Signature:**
```solidity
function onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange calldata _troveChange) external;;
```

### onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3596:271:167

**Signature:**
```solidity
function onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;;
```

### onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)

- **Signature**: `onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3873:269:167

**Signature:**
```solidity
function onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange calldata _troveChange) external;;
```

### onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4148:306:167

**Signature:**
```solidity
function onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;;
```

### onRegisterBatchManager(address,uint256,uint256)

- **Signature**: `onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4481:113:167

**Signature:**
```solidity
function onRegisterBatchManager(address _batchAddress, uint256 _annualInterestRate, uint256 _annualFee) external;;
```

### onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)

- **Signature**: `onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4599:177:167

**Signature:**
```solidity
function onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) external;;
```

### onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)

- **Signature**: `onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4781:244:167

**Signature:**
```solidity
function onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) external;;
```

### onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)

- **Signature**: `onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`
- **Visibility**: external
- **Source Range**: 5456:94:167

**Signature:**
```solidity
function onSetInterestBatchManager(OnSetInterestBatchManagerParams calldata _params) external;;
```

### onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)

- **Signature**: `onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5555:429:167

**Signature:**
```solidity
function onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) external;;
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
