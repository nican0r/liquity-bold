# Contract: BorrowerOperations

## Metadata

- **Name**: BorrowerOperations
- **Type**: Contract
- **Path**: src/BorrowerOperations.sol

## Implements Interfaces

- **IBorrowerOperations** [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **IAddRemoveManagers** [src/Interfaces/IAddRemoveManagers.sol/interface_IAddRemoveManagers.md]
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

### troveNFT (inherited from AddRemoveManagers)

```solidity
ITroveNFT internal immutable troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### addManagerOf (inherited from AddRemoveManagers)

```solidity
mapping(uint256 => address) public addManagerOf
```

### removeManagerReceiverOf (inherited from AddRemoveManagers)

```solidity
mapping(uint256 => RemoveManagerReceiver) public removeManagerReceiverOf
```

### collToken

```solidity
IERC20 internal immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### troveManager

```solidity
ITroveManager internal troveManager
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### gasPoolAddress

```solidity
address internal gasPoolAddress
```

### collSurplusPool

```solidity
ICollSurplusPool internal collSurplusPool
```

**ICollSurplusPool**: [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]

### boldToken

```solidity
IBoldToken internal boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### sortedTroves

```solidity
ISortedTroves internal sortedTroves
```

**ISortedTroves**: [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

### WETH

```solidity
IWETH internal immutable WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### CCR

```solidity
uint256 public immutable CCR
```

### SCR

```solidity
uint256 public immutable SCR
```

### hasBeenShutDown

```solidity
bool public hasBeenShutDown
```

### MCR

```solidity
uint256 public immutable MCR
```

### BCR

```solidity
uint256 public immutable BCR
```

### interestIndividualDelegateOf

```solidity
mapping(uint256 => InterestIndividualDelegate) private interestIndividualDelegateOf
```

### interestBatchManagerOf

```solidity
mapping(uint256 => address) public interestBatchManagerOf
```

### interestBatchManagers

```solidity
mapping(address => InterestBatchManager) private interestBatchManagers
```

## Structs

### RemoveManagerReceiver (inherited from AddRemoveManagers)

```solidity
struct RemoveManagerReceiver {
    address manager;
    address receiver;
}
```

### OpenTroveAndJoinInterestBatchManagerParams (inherited from IBorrowerOperations)

```solidity
struct OpenTroveAndJoinInterestBatchManagerParams {
    address owner;
    uint256 ownerIndex;
    uint256 collAmount;
    uint256 boldAmount;
    uint256 upperHint;
    uint256 lowerHint;
    address interestBatchManager;
    uint256 maxUpfrontFee;
    address addManager;
    address removeManager;
    address receiver;
}
```

### InterestIndividualDelegate (inherited from IBorrowerOperations)

```solidity
struct InterestIndividualDelegate {
    address account;
    uint128 minInterestRate;
    uint128 maxInterestRate;
    uint256 minInterestRateChangePeriod;
}
```

### InterestBatchManager (inherited from IBorrowerOperations)

```solidity
struct InterestBatchManager {
    uint128 minInterestRate;
    uint128 maxInterestRate;
    uint256 minInterestRateChangePeriod;
}
```

### OpenTroveVars

```solidity
struct OpenTroveVars {
    ITroveManager troveManager;
    uint256 troveId;
    TroveChange change;
    LatestBatchData batch;
}
```

### LocalVariables_openTrove

```solidity
struct LocalVariables_openTrove {
    ITroveManager troveManager;
    IActivePool activePool;
    IBoldToken boldToken;
    uint256 troveId;
    uint256 price;
    uint256 avgInterestRate;
    uint256 entireDebt;
    uint256 ICR;
    uint256 newTCR;
    bool newOracleFailureDetected;
}
```

### LocalVariables_adjustTrove

```solidity
struct LocalVariables_adjustTrove {
    IActivePool activePool;
    IBoldToken boldToken;
    LatestTroveData trove;
    uint256 price;
    bool isBelowCriticalThreshold;
    uint256 newICR;
    uint256 newDebt;
    uint256 newColl;
    bool newOracleFailureDetected;
}
```

### LocalVariables_setInterestBatchManager

```solidity
struct LocalVariables_setInterestBatchManager {
    ITroveManager troveManager;
    IActivePool activePool;
    ISortedTroves sortedTroves;
    address oldBatchManager;
    LatestTroveData trove;
    LatestBatchData oldBatch;
    LatestBatchData newBatch;
}
```

### LocalVariables_removeFromBatch

```solidity
struct LocalVariables_removeFromBatch {
    ITroveManager troveManager;
    ISortedTroves sortedTroves;
    address batchManager;
    LatestTroveData trove;
    LatestBatchData batch;
    uint256 batchFutureDebt;
    TroveChange batchChange;
}
```

## Errors

### EmptyManager (inherited from AddRemoveManagers)

```solidity
error EmptyManager();
```

### NotBorrower (inherited from AddRemoveManagers)

```solidity
error NotBorrower();
```

### NotOwnerNorAddManager (inherited from AddRemoveManagers)

```solidity
error NotOwnerNorAddManager();
```

### NotOwnerNorRemoveManager (inherited from AddRemoveManagers)

```solidity
error NotOwnerNorRemoveManager();
```

### IsShutDown

```solidity
error IsShutDown();
```

### TCRNotBelowSCR

```solidity
error TCRNotBelowSCR();
```

### ZeroAdjustment

```solidity
error ZeroAdjustment();
```

### NotOwnerNorInterestManager

```solidity
error NotOwnerNorInterestManager();
```

### TroveInBatch

```solidity
error TroveInBatch();
```

### TroveNotInBatch

```solidity
error TroveNotInBatch();
```

### InterestNotInRange

```solidity
error InterestNotInRange();
```

### BatchInterestRateChangePeriodNotPassed

```solidity
error BatchInterestRateChangePeriodNotPassed();
```

### DelegateInterestRateChangePeriodNotPassed

```solidity
error DelegateInterestRateChangePeriodNotPassed();
```

### TroveExists

```solidity
error TroveExists();
```

### TroveNotOpen

```solidity
error TroveNotOpen();
```

### TroveNotActive

```solidity
error TroveNotActive();
```

### TroveNotZombie

```solidity
error TroveNotZombie();
```

### TroveWithZeroDebt

```solidity
error TroveWithZeroDebt();
```

### UpfrontFeeTooHigh

```solidity
error UpfrontFeeTooHigh();
```

### ICRBelowMCR

```solidity
error ICRBelowMCR();
```

### ICRBelowMCRPlusBCR

```solidity
error ICRBelowMCRPlusBCR();
```

### RepaymentNotMatchingCollWithdrawal

```solidity
error RepaymentNotMatchingCollWithdrawal();
```

### TCRBelowCCR

```solidity
error TCRBelowCCR();
```

### DebtBelowMin

```solidity
error DebtBelowMin();
```

### CollWithdrawalTooHigh

```solidity
error CollWithdrawalTooHigh();
```

### NotEnoughBoldBalance

```solidity
error NotEnoughBoldBalance();
```

### InterestRateTooLow

```solidity
error InterestRateTooLow();
```

### InterestRateTooHigh

```solidity
error InterestRateTooHigh();
```

### InterestRateNotNew

```solidity
error InterestRateNotNew();
```

### InvalidInterestBatchManager

```solidity
error InvalidInterestBatchManager();
```

### BatchManagerExists

```solidity
error BatchManagerExists();
```

### BatchManagerNotNew

```solidity
error BatchManagerNotNew();
```

### NewFeeNotLower

```solidity
error NewFeeNotLower();
```

### CallerNotTroveManager

```solidity
error CallerNotTroveManager();
```

### CallerNotPriceFeed

```solidity
error CallerNotPriceFeed();
```

### MinGeMax

```solidity
error MinGeMax();
```

### AnnualManagementFeeTooHigh

```solidity
error AnnualManagementFeeTooHigh();
```

### MinInterestRateChangePeriodTooLow

```solidity
error MinInterestRateChangePeriodTooLow();
```

### NewOracleFailureDetected

```solidity
error NewOracleFailureDetected();
```

### BatchSharesRatioTooLow

```solidity
error BatchSharesRatioTooLow();
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

### TroveNFTAddressChanged (inherited from AddRemoveManagers)

```solidity
event TroveNFTAddressChanged(address _newTroveNFTAddress);
```

### AddManagerUpdated (inherited from AddRemoveManagers)

```solidity
event AddManagerUpdated(uint256 indexed _troveId, address _newAddManager);
```

### RemoveManagerAndReceiverUpdated (inherited from AddRemoveManagers)

```solidity
event RemoveManagerAndReceiverUpdated(uint256 indexed _troveId, address _newRemoveManager, address _newReceiver);
```

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _newTroveManagerAddress);
```

### GasPoolAddressChanged

```solidity
event GasPoolAddressChanged(address _gasPoolAddress);
```

### CollSurplusPoolAddressChanged

```solidity
event CollSurplusPoolAddressChanged(address _collSurplusPoolAddress);
```

### SortedTrovesAddressChanged

```solidity
event SortedTrovesAddressChanged(address _sortedTrovesAddress);
```

### BoldTokenAddressChanged

```solidity
event BoldTokenAddressChanged(address _boldTokenAddress);
```

### ShutDown

```solidity
event ShutDown(uint256 _tcr);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 5819:1240:128
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry) AddRemoveManagers(_addressesRegistry) LiquityBase(_addressesRegistry);
```

### openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)

- **Signature**: `openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)`
- **Visibility**: external
- **Source Range**: 7107:1117:128
- **Details**: [function_openTrove_address_uint256_uint256_uint256_uint256_uint256_uint256_uint256_address_address_address.md](./function_openTrove_address_uint256_uint256_uint256_uint256_uint256_uint256_uint256_address_address_address.md)

**Signature:**
```solidity
function openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) override external returns (uint256);
```

### openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)

- **Signature**: `openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)`
- **Visibility**: external
- **Source Range**: 8230:2028:128
- **Details**: [function_openTroveAndJoinInterestBatchManager_struct_IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams.md](./function_openTroveAndJoinInterestBatchManager_struct_IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams.md)

**Signature:**
```solidity
function openTroveAndJoinInterestBatchManager(OpenTroveAndJoinInterestBatchManagerParams calldata _params) override external returns (uint256);
```

### addColl(uint256,uint256)

- **Signature**: `addColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 13793:433:128
- **Details**: [function_addColl_uint256_uint256.md](./function_addColl_uint256_uint256.md)

**Signature:**
```solidity
function addColl(uint256 _troveId, uint256 _collAmount) override external;
```

### withdrawColl(uint256,uint256)

- **Signature**: `withdrawColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 14272:446:128
- **Details**: [function_withdrawColl_uint256_uint256.md](./function_withdrawColl_uint256_uint256.md)

**Signature:**
```solidity
function withdrawColl(uint256 _troveId, uint256 _collWithdrawal) override external;
```

### withdrawBold(uint256,uint256,uint256)

- **Signature**: `withdrawBold(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 14843:398:128
- **Details**: [function_withdrawBold_uint256_uint256_uint256.md](./function_withdrawBold_uint256_uint256_uint256.md)

**Signature:**
```solidity
function withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) override external;
```

### repayBold(uint256,uint256)

- **Signature**: `repayBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 15353:435:128
- **Details**: [function_repayBold_uint256_uint256.md](./function_repayBold_uint256_uint256.md)

**Signature:**
```solidity
function repayBold(uint256 _troveId, uint256 _boldAmount) override external;
```

### adjustTrove(uint256,uint256,bool,uint256,bool,uint256)

- **Signature**: `adjustTrove(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: external
- **Source Range**: 16341:567:128
- **Details**: [function_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md](./function_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md)

**Signature:**
```solidity
function adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) override external;
```

### adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)

- **Signature**: `adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 16914:1257:128
- **Details**: [function_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md](./function_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md)

**Signature:**
```solidity
function adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) override external;
```

### adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)

- **Signature**: `adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 18177:1975:128
- **Details**: [function_adjustTroveInterestRate_uint256_uint256_uint256_uint256_uint256.md](./function_adjustTroveInterestRate_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function adjustTroveInterestRate(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;
```

### closeTrove(uint256)

- **Signature**: `closeTrove(uint256)`
- **Visibility**: external
- **Source Range**: 26583:3113:128
- **Details**: [function_closeTrove_uint256.md](./function_closeTrove_uint256.md)

**Signature:**
```solidity
function closeTrove(uint256 _troveId) override external;
```

### applyPendingDebt(uint256,uint256,uint256)

- **Signature**: `applyPendingDebt(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 29702:2339:128
- **Details**: [function_applyPendingDebt_uint256_uint256_uint256.md](./function_applyPendingDebt_uint256_uint256_uint256.md)

**Signature:**
```solidity
function applyPendingDebt(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public;
```

### getInterestIndividualDelegateOf(uint256)

- **Signature**: `getInterestIndividualDelegateOf(uint256)`
- **Visibility**: external
- **Source Range**: 32047:207:128
- **Details**: [function_getInterestIndividualDelegateOf_uint256.md](./function_getInterestIndividualDelegateOf_uint256.md)

**Signature:**
```solidity
function getInterestIndividualDelegateOf(uint256 _troveId) external view returns (InterestIndividualDelegate memory);
```

### setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 32260:1331:128
- **Details**: [function_setInterestIndividualDelegate_uint256_address_uint128_uint128_uint256_uint256_uint256_uint256_uint256.md](./function_setInterestIndividualDelegate_uint256_address_uint128_uint128_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function setInterestIndividualDelegate(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) external;
```

### removeInterestIndividualDelegate(uint256)

- **Signature**: `removeInterestIndividualDelegate(uint256)`
- **Visibility**: external
- **Source Range**: 33597:175:128
- **Details**: [function_removeInterestIndividualDelegate_uint256.md](./function_removeInterestIndividualDelegate_uint256.md)

**Signature:**
```solidity
function removeInterestIndividualDelegate(uint256 _troveId) external;
```

### getInterestBatchManager(address)

- **Signature**: `getInterestBatchManager(address)`
- **Visibility**: external
- **Source Range**: 33778:158:128
- **Details**: [function_getInterestBatchManager_address.md](./function_getInterestBatchManager_address.md)

**Signature:**
```solidity
function getInterestBatchManager(address _account) external view returns (InterestBatchManager memory);
```

### registerBatchManager(uint128,uint128,uint128,uint128,uint128)

- **Signature**: `registerBatchManager(uint128,uint128,uint128,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 33942:1271:128
- **Details**: [function_registerBatchManager_uint128_uint128_uint128_uint128_uint128.md](./function_registerBatchManager_uint128_uint128_uint128_uint128_uint128.md)

**Signature:**
```solidity
function registerBatchManager(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) external;
```

### lowerBatchManagementFee(uint256)

- **Signature**: `lowerBatchManagementFee(uint256)`
- **Visibility**: external
- **Source Range**: 35219:1354:128
- **Details**: [function_lowerBatchManagementFee_uint256.md](./function_lowerBatchManagementFee_uint256.md)

**Signature:**
```solidity
function lowerBatchManagementFee(uint256 _newAnnualManagementFee) external;
```

### setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)

- **Signature**: `setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 36579:3091:128
- **Details**: [function_setBatchManagerAnnualInterestRate_uint128_uint256_uint256_uint256.md](./function_setBatchManagerAnnualInterestRate_uint128_uint256_uint256_uint256.md)

**Signature:**
```solidity
function setBatchManagerAnnualInterestRate(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;
```

### setInterestBatchManager(uint256,address,uint256,uint256,uint256)

- **Signature**: `setInterestBatchManager(uint256,address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 39676:3494:128
- **Details**: [function_setInterestBatchManager_uint256_address_uint256_uint256_uint256.md](./function_setInterestBatchManager_uint256_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) override public;
```

### kickFromBatch(uint256,uint256,uint256)

- **Signature**: `kickFromBatch(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 43176:425:128
- **Details**: [function_kickFromBatch_uint256_uint256_uint256.md](./function_kickFromBatch_uint256_uint256_uint256.md)

**Signature:**
```solidity
function kickFromBatch(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) override external;
```

### removeFromBatch(uint256,uint256,uint256,uint256,uint256)

- **Signature**: `removeFromBatch(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 43607:480:128
- **Details**: [function_removeFromBatch_uint256_uint256_uint256_uint256_uint256.md](./function_removeFromBatch_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) override public;
```

### switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)

- **Signature**: `switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 47698:724:128
- **Details**: [function_switchBatchManager_uint256_uint256_uint256_address_uint256_uint256_uint256.md](./function_switchBatchManager_uint256_uint256_uint256_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) override external;
```

### onLiquidateTrove(uint256)

- **Signature**: `onLiquidateTrove(uint256)`
- **Visibility**: external
- **Source Range**: 49901:139:128
- **Details**: [function_onLiquidateTrove_uint256.md](./function_onLiquidateTrove_uint256.md)

**Signature:**
```solidity
function onLiquidateTrove(uint256 _troveId) external;
```

### claimCollateral()

- **Signature**: `claimCollateral()`
- **Visibility**: external
- **Source Range**: 50372:151:128
- **Details**: [function_claimCollateral.md](./function_claimCollateral.md)

**Signature:**
```solidity
///  Claim remaining collateral from a liquidation with ICR exceeding the liquidation penalty
function claimCollateral() override external;
```

### shutdown()

- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 50529:640:128
- **Details**: [function_shutdown.md](./function_shutdown.md)

**Signature:**
```solidity
function shutdown() external;
```

### shutdownFromOracleFailure()

- **Signature**: `shutdownFromOracleFailure()`
- **Visibility**: external
- **Source Range**: 51272:316:128
- **Details**: [function_shutdownFromOracleFailure.md](./function_shutdownFromOracleFailure.md)

**Signature:**
```solidity
function shutdownFromOracleFailure() external;
```

### checkBatchManagerExists(address)

- **Signature**: `checkBatchManagerExists(address)`
- **Visibility**: external
- **Source Range**: 53815:165:128
- **Details**: [function_checkBatchManagerExists_address.md](./function_checkBatchManagerExists_address.md)

**Signature:**
```solidity
function checkBatchManagerExists(address _batchManager) external view returns (bool);
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

### setAddManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2158:163:133
- **Details**: [function_setAddManager_uint256_address.md](./function_setAddManager_uint256_address.md)

**Signature:**
```solidity
function setAddManager(uint256 _troveId, address _manager) external;
```

### setRemoveManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2504:164:133
- **Details**: [function_setRemoveManager_uint256_address.md](./function_setRemoveManager_uint256_address.md)

**Signature:**
```solidity
function setRemoveManager(uint256 _troveId, address _manager) external;
```

### setRemoveManagerWithReceiver(uint256,address,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2674:220:133
- **Details**: [function_setRemoveManagerWithReceiver_uint256_address_address.md](./function_setRemoveManagerWithReceiver_uint256_address_address.md)

**Signature:**
```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public;
```
