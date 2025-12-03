# Contract: CryticTester

## Metadata

- **Name**: CryticTester
- **Type**: Contract
- **Path**: test/recon/CryticTester.sol

## State Variables

### _actor (inherited from ActorManager)

```solidity
/// @notice The current actor being used
address private _actor
```

### _actors (inherited from ActorManager)

```solidity
/// @notice The list of all actors being used
EnumerableSet.AddressSet private _actors
```

### __asset (inherited from AssetManager)

```solidity
/// @notice The current target for this set of variables
address private __asset
```

### _assets (inherited from AssetManager)

```solidity
/// @notice The list of all assets being used
EnumerableSet.AddressSet private _assets
```

### DECIMALS (inherited from Setup)

```solidity
uint256 internal constant DECIMALS = 18
```

### CCR (inherited from Setup)

```solidity
uint256 internal constant CCR = 150e16
```

### MCR (inherited from Setup)

```solidity
uint256 internal constant MCR = 110e16
```

### BCR (inherited from Setup)

```solidity
uint256 internal constant BCR = 10e16
```

### SCR (inherited from Setup)

```solidity
uint256 internal constant SCR = 110e16
```

### LIQUIDATION_PENALTY_SP (inherited from Setup)

```solidity
uint256 internal constant LIQUIDATION_PENALTY_SP = 5e16
```

### LIQUIDATION_PENALTY_REDISTRIBUTION (inherited from Setup)

```solidity
uint256 internal constant LIQUIDATION_PENALTY_REDISTRIBUTION = 10e16
```

### addressesRegistry (inherited from Setup)

```solidity
AddressesRegistry internal addressesRegistry
```

**AddressesRegistry**: [src/AddressesRegistry.sol/contract_AddressesRegistry.md]

### activePool (inherited from Setup)

```solidity
ActivePool internal activePool
```

**ActivePool**: [src/ActivePool.sol/contract_ActivePool.md]

### boldToken (inherited from Setup)

```solidity
BoldToken internal boldToken
```

**BoldToken**: [src/BoldToken.sol/contract_BoldToken.md]

### borrowerOperations (inherited from Setup)

```solidity
BorrowerOperationsTester internal borrowerOperations
```

**BorrowerOperationsTester**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

### collSurplusPool (inherited from Setup)

```solidity
CollSurplusPool internal collSurplusPool
```

**CollSurplusPool**: [src/CollSurplusPool.sol/contract_CollSurplusPool.md]

### collateralRegistry (inherited from Setup)

```solidity
CollateralRegistry internal collateralRegistry
```

**CollateralRegistry**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

### defaultPool (inherited from Setup)

```solidity
DefaultPool internal defaultPool
```

**DefaultPool**: [src/DefaultPool.sol/contract_DefaultPool.md]

### gasPool (inherited from Setup)

```solidity
GasPool internal gasPool
```

**GasPool**: [src/GasPool.sol/contract_GasPool.md]

### sortedTroves (inherited from Setup)

```solidity
SortedTroves internal sortedTroves
```

**SortedTroves**: [src/SortedTroves.sol/contract_SortedTroves.md]

### stabilityPool (inherited from Setup)

```solidity
StabilityPool internal stabilityPool
```

**StabilityPool**: [src/StabilityPool.sol/contract_StabilityPool.md]

### troveManager (inherited from Setup)

```solidity
TroveManagerTester internal troveManager
```

**TroveManagerTester**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

### troveNFT (inherited from Setup)

```solidity
TroveNFT internal troveNFT
```

**TroveNFT**: [src/TroveNFT.sol/contract_TroveNFT.md]

### metadataNFT (inherited from Setup)

```solidity
MetadataNFT internal metadataNFT
```

**MetadataNFT**: [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]

### hintHelpers (inherited from Setup)

```solidity
HintHelpers internal hintHelpers
```

**HintHelpers**: [src/HintHelpers.sol/contract_HintHelpers.md]

### multiTroveGetter (inherited from Setup)

```solidity
MultiTroveGetter internal multiTroveGetter
```

**MultiTroveGetter**: [src/MultiTroveGetter.sol/contract_MultiTroveGetter.md]

### priceFeed (inherited from Setup)

```solidity
PriceFeedTestnet internal priceFeed
```

**PriceFeedTestnet**: [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]

### interestRouter (inherited from Setup)

```solidity
MockInterestRouter internal interestRouter
```

**MockInterestRouter**: [test/TestContracts/MockInterestRouter.sol/contract_MockInterestRouter.md]

### collToken (inherited from Setup)

```solidity
WETHTester internal collToken
```

**WETHTester**: [test/TestContracts/WETHTester.sol/contract_WETHTester.md]

### _before (inherited from BeforeAfter)

```solidity
Vars internal _before
```

### _after (inherited from BeforeAfter)

```solidity
Vars internal _after
```

## Structs

### Vars (inherited from BeforeAfter)

```solidity
struct Vars {
    uint256 __ignore__;
}
```

## Errors

### ActorNotSetup (inherited from ActorManager)

```solidity
error ActorNotSetup();
```

### ActorExists (inherited from ActorManager)

```solidity
error ActorExists();
```

### ActorNotAdded (inherited from ActorManager)

```solidity
error ActorNotAdded();
```

### DefaultActor (inherited from ActorManager)

```solidity
error DefaultActor();
```

### NotSetup (inherited from AssetManager)

```solidity
error NotSetup();
```

### Exists (inherited from AssetManager)

```solidity
error Exists();
```

### NotAdded (inherited from AssetManager)

```solidity
error NotAdded();
```

## Events

### Log (inherited from CryticAsserts)

```solidity
event Log(string);
```

## Public/External Functions

### constructor()

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 360:46:314
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
constructor() payable;
```

### activePool_accountForReceivedColl(uint256) (inherited from AdminTargets)

- **Signature**: `activePool_accountForReceivedColl(uint256)`
- **Visibility**: public
- **Source Range**: 796:134:320
- **Details**: [function_activePool_accountForReceivedColl_uint256.md](./function_activePool_accountForReceivedColl_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function activePool_accountForReceivedColl(uint256 _amount) public asAdmin();
```

### activePool_mintAggInterest() (inherited from AdminTargets)

- **Signature**: `activePool_mintAggInterest()`
- **Visibility**: public
- **Source Range**: 936:98:320
- **Details**: [function_activePool_mintAggInterest.md](./function_activePool_mintAggInterest.md)

**Signature:**
```solidity
function activePool_mintAggInterest() public asAdmin();
```

### activePool_mintAggInterestAndAccountForTroveChange(struct TroveChange,address) (inherited from AdminTargets)

- **Signature**: `activePool_mintAggInterestAndAccountForTroveChange(struct TroveChange,address)`
- **Visibility**: public
- **Source Range**: 1040:227:320
- **Details**: [function_activePool_mintAggInterestAndAccountForTroveChange_struct_TroveChange_address.md](./function_activePool_mintAggInterestAndAccountForTroveChange_struct_TroveChange_address.md)

**Signature:**
```solidity
function activePool_mintAggInterestAndAccountForTroveChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin();
```

### activePool_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address) (inherited from AdminTargets)

- **Signature**: `activePool_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)`
- **Visibility**: public
- **Source Range**: 1273:231:320
- **Details**: [function_activePool_mintBatchManagementFeeAndAccountForChange_struct_TroveChange_address.md](./function_activePool_mintBatchManagementFeeAndAccountForChange_struct_TroveChange_address.md)

**Signature:**
```solidity
function activePool_mintBatchManagementFeeAndAccountForChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin();
```

### activePool_receiveColl(uint256) (inherited from AdminTargets)

- **Signature**: `activePool_receiveColl(uint256)`
- **Visibility**: public
- **Source Range**: 1510:112:320
- **Details**: [function_activePool_receiveColl_uint256.md](./function_activePool_receiveColl_uint256.md)

**Signature:**
```solidity
function activePool_receiveColl(uint256 _amount) public asAdmin();
```

### activePool_sendColl(address,uint256) (inherited from AdminTargets)

- **Signature**: `activePool_sendColl(address,uint256)`
- **Visibility**: public
- **Source Range**: 1628:134:320
- **Details**: [function_activePool_sendColl_address_uint256.md](./function_activePool_sendColl_address_uint256.md)

**Signature:**
```solidity
function activePool_sendColl(address _account, uint256 _amount) public asAdmin();
```

### activePool_sendCollToDefaultPool(uint256) (inherited from AdminTargets)

- **Signature**: `activePool_sendCollToDefaultPool(uint256)`
- **Visibility**: public
- **Source Range**: 1768:132:320
- **Details**: [function_activePool_sendCollToDefaultPool_uint256.md](./function_activePool_sendCollToDefaultPool_uint256.md)

**Signature:**
```solidity
function activePool_sendCollToDefaultPool(uint256 _amount) public asAdmin();
```

### activePool_setShutdownFlag() (inherited from AdminTargets)

- **Signature**: `activePool_setShutdownFlag()`
- **Visibility**: public
- **Source Range**: 1906:98:320
- **Details**: [function_activePool_setShutdownFlag.md](./function_activePool_setShutdownFlag.md)

**Signature:**
```solidity
function activePool_setShutdownFlag() public asAdmin();
```

### boldToken_burn(address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_burn(address,uint256)`
- **Visibility**: public
- **Source Range**: 2043:124:320
- **Details**: [function_boldToken_burn_address_uint256.md](./function_boldToken_burn_address_uint256.md)

**Signature:**
```solidity
function boldToken_burn(address _account, uint256 _amount) public asAdmin();
```

### boldToken_mint(address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 2173:124:320
- **Details**: [function_boldToken_mint_address_uint256.md](./function_boldToken_mint_address_uint256.md)

**Signature:**
```solidity
function boldToken_mint(address _account, uint256 _amount) public asAdmin();
```

### boldToken_returnFromPool(address,address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_returnFromPool(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2303:182:320
- **Details**: [function_boldToken_returnFromPool_address_address_uint256.md](./function_boldToken_returnFromPool_address_address_uint256.md)

**Signature:**
```solidity
function boldToken_returnFromPool(address _poolAddress, address _receiver, uint256 _amount) public asAdmin();
```

### boldToken_sendToPool(address,address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_sendToPool(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2491:170:320
- **Details**: [function_boldToken_sendToPool_address_address_uint256.md](./function_boldToken_sendToPool_address_address_uint256.md)

**Signature:**
```solidity
function boldToken_sendToPool(address _sender, address _poolAddress, uint256 _amount) public asAdmin();
```

### boldToken_setBranchAddresses(address,address,address,address) (inherited from AdminTargets)

- **Signature**: `boldToken_setBranchAddresses(address,address,address,address)`
- **Visibility**: public
- **Source Range**: 2667:316:320
- **Details**: [function_boldToken_setBranchAddresses_address_address_address_address.md](./function_boldToken_setBranchAddresses_address_address_address_address.md)

**Signature:**
```solidity
function boldToken_setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) public asAdmin();
```

### boldToken_setCollateralRegistry(address) (inherited from AdminTargets)

- **Signature**: `boldToken_setCollateralRegistry(address)`
- **Visibility**: public
- **Source Range**: 2989:168:320
- **Details**: [function_boldToken_setCollateralRegistry_address.md](./function_boldToken_setCollateralRegistry_address.md)

**Signature:**
```solidity
function boldToken_setCollateralRegistry(address _collateralRegistryAddress) public asAdmin();
```

### borrowerOperations_onLiquidateTrove(uint256) (inherited from AdminTargets)

- **Signature**: `borrowerOperations_onLiquidateTrove(uint256)`
- **Visibility**: public
- **Source Range**: 3205:140:320
- **Details**: [function_borrowerOperations_onLiquidateTrove_uint256.md](./function_borrowerOperations_onLiquidateTrove_uint256.md)

**Signature:**
```solidity
function borrowerOperations_onLiquidateTrove(uint256 _troveId) public asAdmin();
```

### borrowerOperations_shutdown() (inherited from AdminTargets)

- **Signature**: `borrowerOperations_shutdown()`
- **Visibility**: public
- **Source Range**: 3351:100:320
- **Details**: [function_borrowerOperations_shutdown.md](./function_borrowerOperations_shutdown.md)

**Signature:**
```solidity
function borrowerOperations_shutdown() public asAdmin();
```

### borrowerOperations_shutdownFromOracleFailure() (inherited from AdminTargets)

- **Signature**: `borrowerOperations_shutdownFromOracleFailure()`
- **Visibility**: public
- **Source Range**: 3457:134:320
- **Details**: [function_borrowerOperations_shutdownFromOracleFailure.md](./function_borrowerOperations_shutdownFromOracleFailure.md)

**Signature:**
```solidity
function borrowerOperations_shutdownFromOracleFailure() public asAdmin();
```

### collSurplusPool_accountSurplus(address,uint256) (inherited from AdminTargets)

- **Signature**: `collSurplusPool_accountSurplus(address,uint256)`
- **Visibility**: public
- **Source Range**: 3636:156:320
- **Details**: [function_collSurplusPool_accountSurplus_address_uint256.md](./function_collSurplusPool_accountSurplus_address_uint256.md)

**Signature:**
```solidity
function collSurplusPool_accountSurplus(address _account, uint256 _amount) public asAdmin();
```

### defaultPool_decreaseBoldDebt(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_decreaseBoldDebt(uint256)`
- **Visibility**: public
- **Source Range**: 3833:124:320
- **Details**: [function_defaultPool_decreaseBoldDebt_uint256.md](./function_defaultPool_decreaseBoldDebt_uint256.md)

**Signature:**
```solidity
function defaultPool_decreaseBoldDebt(uint256 _amount) public asAdmin();
```

### defaultPool_increaseBoldDebt(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_increaseBoldDebt(uint256)`
- **Visibility**: public
- **Source Range**: 3963:124:320
- **Details**: [function_defaultPool_increaseBoldDebt_uint256.md](./function_defaultPool_increaseBoldDebt_uint256.md)

**Signature:**
```solidity
function defaultPool_increaseBoldDebt(uint256 _amount) public asAdmin();
```

### defaultPool_receiveColl(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_receiveColl(uint256)`
- **Visibility**: public
- **Source Range**: 4093:114:320
- **Details**: [function_defaultPool_receiveColl_uint256.md](./function_defaultPool_receiveColl_uint256.md)

**Signature:**
```solidity
function defaultPool_receiveColl(uint256 _amount) public asAdmin();
```

### defaultPool_sendCollToActivePool(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_sendCollToActivePool(uint256)`
- **Visibility**: public
- **Source Range**: 4213:132:320
- **Details**: [function_defaultPool_sendCollToActivePool_uint256.md](./function_defaultPool_sendCollToActivePool_uint256.md)

**Signature:**
```solidity
function defaultPool_sendCollToActivePool(uint256 _amount) public asAdmin();
```

### sortedTroves_insert(uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_insert(uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4387:200:320
- **Details**: [function_sortedTroves_insert_uint256_uint256_uint256_uint256.md](./function_sortedTroves_insert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4593:256:320
- **Details**: [function_sortedTroves_insertIntoBatch_uint256_BatchId_uint256_uint256_uint256.md](./function_sortedTroves_insertIntoBatch_uint256_BatchId_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_reInsert(uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_reInsert(uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4855:210:320
- **Details**: [function_sortedTroves_reInsert_uint256_uint256_uint256_uint256.md](./function_sortedTroves_reInsert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_reInsertBatch(BatchId,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_reInsertBatch(BatchId,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5071:220:320
- **Details**: [function_sortedTroves_reInsertBatch_BatchId_uint256_uint256_uint256.md](./function_sortedTroves_reInsertBatch_BatchId_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_reInsertBatch(BatchId _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_remove(uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_remove(uint256)`
- **Visibility**: public
- **Source Range**: 5297:98:320
- **Details**: [function_sortedTroves_remove_uint256.md](./function_sortedTroves_remove_uint256.md)

**Signature:**
```solidity
function sortedTroves_remove(uint256 _id) public asAdmin();
```

### sortedTroves_removeFromBatch(uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_removeFromBatch(uint256)`
- **Visibility**: public
- **Source Range**: 5401:116:320
- **Details**: [function_sortedTroves_removeFromBatch_uint256.md](./function_sortedTroves_removeFromBatch_uint256.md)

**Signature:**
```solidity
function sortedTroves_removeFromBatch(uint256 _id) public asAdmin();
```

### stabilityPool_offset(uint256,uint256) (inherited from AdminTargets)

- **Signature**: `stabilityPool_offset(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5560:152:320
- **Details**: [function_stabilityPool_offset_uint256_uint256.md](./function_stabilityPool_offset_uint256_uint256.md)

**Signature:**
```solidity
function stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd) public asAdmin();
```

### stabilityPool_triggerBoldRewards(uint256) (inherited from AdminTargets)

- **Signature**: `stabilityPool_triggerBoldRewards(uint256)`
- **Visibility**: public
- **Source Range**: 5718:138:320
- **Details**: [function_stabilityPool_triggerBoldRewards_uint256.md](./function_stabilityPool_triggerBoldRewards_uint256.md)

**Signature:**
```solidity
function stabilityPool_triggerBoldRewards(uint256 _boldYield) public asAdmin();
```

### troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange) (inherited from AdminTargets)

- **Signature**: `troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 5898:225:320
- **Details**: [function_troveManager_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md](./function_troveManager_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function troveManager_onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange memory _troveChange) public asAdmin();
```

### troveManager_onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6129:381:320
- **Details**: [function_troveManager_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md](./function_troveManager_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin();
```

### troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange) (inherited from AdminTargets)

- **Signature**: `troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 6516:305:320
- **Details**: [function_troveManager_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md](./function_troveManager_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function troveManager_onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange memory _troveChange) public asAdmin();
```

### troveManager_onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange) (inherited from AdminTargets)

- **Signature**: `troveManager_onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 6827:373:320
- **Details**: [function_troveManager_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md](./function_troveManager_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function troveManager_onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange memory _troveChange) public asAdmin();
```

### troveManager_onCloseTrove(uint256,struct TroveChange,address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 7206:281:320
- **Details**: [function_troveManager_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md](./function_troveManager_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin();
```

### troveManager_onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 7493:276:320
- **Details**: [function_troveManager_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md](./function_troveManager_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) public asAdmin();
```

### troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: public
- **Source Range**: 7775:239:320
- **Details**: [function_troveManager_onOpenTrove_address_uint256_struct_TroveChange_uint256.md](./function_troveManager_onOpenTrove_address_uint256_struct_TroveChange_uint256.md)

**Signature:**
```solidity
function troveManager_onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) public asAdmin();
```

### troveManager_onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8020:315:320
- **Details**: [function_troveManager_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md](./function_troveManager_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) public asAdmin();
```

### troveManager_onRegisterBatchManager(address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8341:242:320
- **Details**: [function_troveManager_onRegisterBatchManager_address_uint256_uint256.md](./function_troveManager_onRegisterBatchManager_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) public asAdmin();
```

### troveManager_onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8589:423:320
- **Details**: [function_troveManager_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md](./function_troveManager_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) public asAdmin();
```

### troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 9018:322:320
- **Details**: [function_troveManager_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md](./function_troveManager_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) public asAdmin();
```

### troveManager_onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams) (inherited from AdminTargets)

- **Signature**: `troveManager_onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`
- **Visibility**: public
- **Source Range**: 9346:189:320
- **Details**: [function_troveManager_onSetInterestBatchManager_struct_ITroveManager.OnSetInterestBatchManagerParams.md](./function_troveManager_onSetInterestBatchManager_struct_ITroveManager.OnSetInterestBatchManagerParams.md)

**Signature:**
```solidity
function troveManager_onSetInterestBatchManager(ITroveManager.OnSetInterestBatchManagerParams memory _params) public asAdmin();
```

### troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 9541:270:320
- **Details**: [function_troveManager_redeemCollateral_address_uint256_uint256_uint256_uint256.md](./function_troveManager_redeemCollateral_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) public asAdmin();
```

### troveManager_setTroveStatusToActive(uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_setTroveStatusToActive(uint256)`
- **Visibility**: public
- **Source Range**: 9817:140:320
- **Details**: [function_troveManager_setTroveStatusToActive_uint256.md](./function_troveManager_setTroveStatusToActive_uint256.md)

**Signature:**
```solidity
function troveManager_setTroveStatusToActive(uint256 _troveId) public asAdmin();
```

### troveManager_shutdown() (inherited from AdminTargets)

- **Signature**: `troveManager_shutdown()`
- **Visibility**: public
- **Source Range**: 9963:88:320
- **Details**: [function_troveManager_shutdown.md](./function_troveManager_shutdown.md)

**Signature:**
```solidity
function troveManager_shutdown() public asAdmin();
```

### troveNFT_burn(uint256) (inherited from AdminTargets)

- **Signature**: `troveNFT_burn(uint256)`
- **Visibility**: public
- **Source Range**: 10089:96:320
- **Details**: [function_troveNFT_burn_uint256.md](./function_troveNFT_burn_uint256.md)

**Signature:**
```solidity
function troveNFT_burn(uint256 _troveId) public asAdmin();
```

### troveNFT_mint(address,uint256) (inherited from AdminTargets)

- **Signature**: `troveNFT_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 10191:120:320
- **Details**: [function_troveNFT_mint_address_uint256.md](./function_troveNFT_mint_address_uint256.md)

**Signature:**
```solidity
function troveNFT_mint(address _owner, uint256 _troveId) public asAdmin();
```

### boldToken_approve(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 610:126:321
- **Details**: [function_boldToken_approve_address_uint256.md](./function_boldToken_approve_address_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function boldToken_approve(address spender, uint256 amount) public asActor();
```

### boldToken_decreaseAllowance(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_decreaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 742:164:321
- **Details**: [function_boldToken_decreaseAllowance_address_uint256.md](./function_boldToken_decreaseAllowance_address_uint256.md)

**Signature:**
```solidity
function boldToken_decreaseAllowance(address spender, uint256 subtractedValue) public asActor();
```

### boldToken_increaseAllowance(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_increaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 912:154:321
- **Details**: [function_boldToken_increaseAllowance_address_uint256.md](./function_boldToken_increaseAllowance_address_uint256.md)

**Signature:**
```solidity
function boldToken_increaseAllowance(address spender, uint256 addedValue) public asActor();
```

### boldToken_permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 1072:212:321
- **Details**: [function_boldToken_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_boldToken_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
function boldToken_permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public asActor();
```

### boldToken_transfer(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 1290:132:321
- **Details**: [function_boldToken_transfer_address_uint256.md](./function_boldToken_transfer_address_uint256.md)

**Signature:**
```solidity
function boldToken_transfer(address recipient, uint256 amount) public asActor();
```

### boldToken_transferFrom(address,address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1428:164:321
- **Details**: [function_boldToken_transferFrom_address_address_uint256.md](./function_boldToken_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function boldToken_transferFrom(address sender, address recipient, uint256 amount) public asActor();
```

### borrowerOperations_addColl(uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_addColl(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 628:156:322
- **Details**: [function_borrowerOperations_addColl_uint256_uint256.md](./function_borrowerOperations_addColl_uint256_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function borrowerOperations_addColl(uint256 _troveId, uint256 _collAmount) public asActor();
```

### borrowerOperations_adjustTrove(uint256,uint256,bool,uint256,bool,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_adjustTrove(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: public
- **Source Range**: 790:316:322
- **Details**: [function_borrowerOperations_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md](./function_borrowerOperations_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md)

**Signature:**
```solidity
function borrowerOperations_adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1112:314:322
- **Details**: [function_borrowerOperations_adjustTroveInterestRate_uint256_uint256_uint256_uint256_uint256.md](./function_borrowerOperations_adjustTroveInterestRate_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_adjustTroveInterestRate(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1432:392:322
- **Details**: [function_borrowerOperations_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md](./function_borrowerOperations_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_applyPendingDebt(uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_applyPendingDebt(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1830:204:322
- **Details**: [function_borrowerOperations_applyPendingDebt_uint256_uint256_uint256.md](./function_borrowerOperations_applyPendingDebt_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_applyPendingDebt(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public asActor();
```

### borrowerOperations_claimCollateral() (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_claimCollateral()`
- **Visibility**: public
- **Source Range**: 2040:114:322
- **Details**: [function_borrowerOperations_claimCollateral.md](./function_borrowerOperations_claimCollateral.md)

**Signature:**
```solidity
function borrowerOperations_claimCollateral() public asActor();
```

### borrowerOperations_closeTrove(uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_closeTrove(uint256)`
- **Visibility**: public
- **Source Range**: 2160:128:322
- **Details**: [function_borrowerOperations_closeTrove_uint256.md](./function_borrowerOperations_closeTrove_uint256.md)

**Signature:**
```solidity
function borrowerOperations_closeTrove(uint256 _troveId) public asActor();
```

### borrowerOperations_kickFromBatch(uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_kickFromBatch(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2294:198:322
- **Details**: [function_borrowerOperations_kickFromBatch_uint256_uint256_uint256.md](./function_borrowerOperations_kickFromBatch_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_kickFromBatch(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor();
```

### borrowerOperations_lowerBatchManagementFee(uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_lowerBatchManagementFee(uint256)`
- **Visibility**: public
- **Source Range**: 2498:184:322
- **Details**: [function_borrowerOperations_lowerBatchManagementFee_uint256.md](./function_borrowerOperations_lowerBatchManagementFee_uint256.md)

**Signature:**
```solidity
function borrowerOperations_lowerBatchManagementFee(uint256 _newAnnualManagementFee) public asActor();
```

### borrowerOperations_openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)`
- **Visibility**: public
- **Source Range**: 2688:482:322
- **Details**: [function_borrowerOperations_openTrove_address_uint256_uint256_uint256_uint256_uint256_uint256_uint256_address_address_address.md](./function_borrowerOperations_openTrove_address_uint256_uint256_uint256_uint256_uint256_uint256_uint256_address_address_address.md)

**Signature:**
```solidity
function borrowerOperations_openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) public asActor();
```

### borrowerOperations_openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)`
- **Visibility**: public
- **Source Range**: 3176:240:322
- **Details**: [function_borrowerOperations_openTroveAndJoinInterestBatchManager_struct_IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams.md](./function_borrowerOperations_openTroveAndJoinInterestBatchManager_struct_IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams.md)

**Signature:**
```solidity
function borrowerOperations_openTroveAndJoinInterestBatchManager(IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory _params) public asActor();
```

### borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128)`
- **Visibility**: public
- **Source Range**: 3422:380:322
- **Details**: [function_borrowerOperations_registerBatchManager_uint128_uint128_uint128_uint128_uint128.md](./function_borrowerOperations_registerBatchManager_uint128_uint128_uint128_uint128_uint128.md)

**Signature:**
```solidity
function borrowerOperations_registerBatchManager(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) public asActor();
```

### borrowerOperations_removeFromBatch(uint256,uint256,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_removeFromBatch(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3808:298:322
- **Details**: [function_borrowerOperations_removeFromBatch_uint256_uint256_uint256_uint256_uint256.md](./function_borrowerOperations_removeFromBatch_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_removeInterestIndividualDelegate(uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_removeInterestIndividualDelegate(uint256)`
- **Visibility**: public
- **Source Range**: 4112:172:322
- **Details**: [function_borrowerOperations_removeInterestIndividualDelegate_uint256.md](./function_borrowerOperations_removeInterestIndividualDelegate_uint256.md)

**Signature:**
```solidity
function borrowerOperations_removeInterestIndividualDelegate(uint256 _troveId) public asActor();
```

### borrowerOperations_repayBold(uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_repayBold(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4290:160:322
- **Details**: [function_borrowerOperations_repayBold_uint256_uint256.md](./function_borrowerOperations_repayBold_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_repayBold(uint256 _troveId, uint256 _boldAmount) public asActor();
```

### borrowerOperations_setAddManager(uint256,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setAddManager(uint256,address)`
- **Visibility**: public
- **Source Range**: 4456:162:322
- **Details**: [function_borrowerOperations_setAddManager_uint256_address.md](./function_borrowerOperations_setAddManager_uint256_address.md)

**Signature:**
```solidity
function borrowerOperations_setAddManager(uint256 _troveId, address _manager) public asActor();
```

### borrowerOperations_setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4624:306:322
- **Details**: [function_borrowerOperations_setBatchManagerAnnualInterestRate_uint128_uint256_uint256_uint256.md](./function_borrowerOperations_setBatchManagerAnnualInterestRate_uint128_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_setBatchManagerAnnualInterestRate(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_setInterestBatchManager(uint256,address,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setInterestBatchManager(uint256,address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4936:302:322
- **Details**: [function_borrowerOperations_setInterestBatchManager_uint256_address_uint256_uint256_uint256.md](./function_borrowerOperations_setInterestBatchManager_uint256_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5244:512:322
- **Details**: [function_borrowerOperations_setInterestIndividualDelegate_uint256_address_uint128_uint128_uint256_uint256_uint256_uint256_uint256.md](./function_borrowerOperations_setInterestIndividualDelegate_uint256_address_uint128_uint128_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_setInterestIndividualDelegate(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) public asActor();
```

### borrowerOperations_setRemoveManager(uint256,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setRemoveManager(uint256,address)`
- **Visibility**: public
- **Source Range**: 5762:168:322
- **Details**: [function_borrowerOperations_setRemoveManager_uint256_address.md](./function_borrowerOperations_setRemoveManager_uint256_address.md)

**Signature:**
```solidity
function borrowerOperations_setRemoveManager(uint256 _troveId, address _manager) public asActor();
```

### borrowerOperations_setRemoveManagerWithReceiver(uint256,address,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 5936:222:322
- **Details**: [function_borrowerOperations_setRemoveManagerWithReceiver_uint256_address_address.md](./function_borrowerOperations_setRemoveManagerWithReceiver_uint256_address_address.md)

**Signature:**
```solidity
function borrowerOperations_setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public asActor();
```

### borrowerOperations_switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6164:392:322
- **Details**: [function_borrowerOperations_switchBatchManager_uint256_uint256_uint256_address_uint256_uint256_uint256.md](./function_borrowerOperations_switchBatchManager_uint256_uint256_uint256_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_withdrawBold(uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_withdrawBold(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6562:206:322
- **Details**: [function_borrowerOperations_withdrawBold_uint256_uint256_uint256.md](./function_borrowerOperations_withdrawBold_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_withdrawColl(uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_withdrawColl(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6774:174:322
- **Details**: [function_borrowerOperations_withdrawColl_uint256_uint256.md](./function_borrowerOperations_withdrawColl_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_withdrawColl(uint256 _troveId, uint256 _collWithdrawal) public asActor();
```

### collSurplusPool_claimColl(address) (inherited from CollSurplusPoolTargets)

- **Signature**: `collSurplusPool_claimColl(address)`
- **Visibility**: public
- **Source Range**: 622:120:323
- **Details**: [function_collSurplusPool_claimColl_address.md](./function_collSurplusPool_claimColl_address.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function collSurplusPool_claimColl(address _account) public asActor();
```

### collateralRegistry_redeemCollateral(uint256,uint256,uint256) (inherited from CollateralRegistryTargets)

- **Signature**: `collateralRegistry_redeemCollateral(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 628:258:324
- **Details**: [function_collateralRegistry_redeemCollateral_uint256_uint256_uint256.md](./function_collateralRegistry_redeemCollateral_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function collateralRegistry_redeemCollateral(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) public asActor();
```

### switchActor(uint256) (inherited from ManagersTargets)

- **Signature**: `switchActor(uint256)`
- **Visibility**: public
- **Source Range**: 680:83:327
- **Details**: [function_switchActor_uint256.md](./function_switchActor_uint256.md)

**Signature:**
```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public;
```

### switch_asset(uint256) (inherited from ManagersTargets)

- **Signature**: `switch_asset(uint256)`
- **Visibility**: public
- **Source Range**: 808:84:327
- **Details**: [function_switch_asset_uint256.md](./function_switch_asset_uint256.md)

**Signature:**
```solidity
/// @dev Starts using a new asset
function switch_asset(uint256 entropy) public;
```

### add_new_asset(uint8) (inherited from ManagersTargets)

- **Signature**: `add_new_asset(uint8)`
- **Visibility**: public
- **Source Range**: 997:144:327
- **Details**: [function_add_new_asset_uint8.md](./function_add_new_asset_uint8.md)

**Signature:**
```solidity
/// @dev Deploy a new token and add it to the list of assets, then set it as the current asset
function add_new_asset(uint8 decimals) public returns (address);
```

### asset_approve(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_approve(address,uint128)`
- **Visibility**: public
- **Source Range**: 1467:132:327
- **Details**: [function_asset_approve_address_uint128.md](./function_asset_approve_address_uint128.md)

**Signature:**
```solidity
/// @dev Approve to arbitrary address, uses Actor by default
///  NOTE: You're almost always better off setting approvals in `Setup`
function asset_approve(address to, uint128 amt) public updateGhosts() asActor();
```

### asset_mint(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_mint(address,uint128)`
- **Visibility**: public
- **Source Range**: 1704:126:327
- **Details**: [function_asset_mint_address_uint128.md](./function_asset_mint_address_uint128.md)

**Signature:**
```solidity
/// @dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
function asset_mint(address to, uint128 amt) public updateGhosts() asAdmin();
```

### stabilityPool_claimAllCollGains() (inherited from StabilityPoolTargets)

- **Signature**: `stabilityPool_claimAllCollGains()`
- **Visibility**: public
- **Source Range**: 618:108:329
- **Details**: [function_stabilityPool_claimAllCollGains.md](./function_stabilityPool_claimAllCollGains.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function stabilityPool_claimAllCollGains() public asActor();
```

### stabilityPool_provideToSP(uint256,bool) (inherited from StabilityPoolTargets)

- **Signature**: `stabilityPool_provideToSP(uint256,bool)`
- **Visibility**: public
- **Source Range**: 732:141:329
- **Details**: [function_stabilityPool_provideToSP_uint256_bool.md](./function_stabilityPool_provideToSP_uint256_bool.md)

**Signature:**
```solidity
function stabilityPool_provideToSP(uint256 _topUp, bool _doClaim) public asActor();
```

### stabilityPool_withdrawFromSP(uint256,bool) (inherited from StabilityPoolTargets)

- **Signature**: `stabilityPool_withdrawFromSP(uint256,bool)`
- **Visibility**: public
- **Source Range**: 879:149:329
- **Details**: [function_stabilityPool_withdrawFromSP_uint256_bool.md](./function_stabilityPool_withdrawFromSP_uint256_bool.md)

**Signature:**
```solidity
function stabilityPool_withdrawFromSP(uint256 _amount, bool _doClaim) public asActor();
```

### troveManager_batchLiquidateTroves(uint256[]) (inherited from TroveManagerTargets)

- **Signature**: `troveManager_batchLiquidateTroves(uint256[])`
- **Visibility**: public
- **Source Range**: 616:151:330
- **Details**: [function_troveManager_batchLiquidateTroves_uint256[].md](./function_troveManager_batchLiquidateTroves_uint256[].md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function troveManager_batchLiquidateTroves(uint256[] memory _troveArray) public asActor();
```

### troveManager_getUnbackedPortionPriceAndRedeemability() (inherited from TroveManagerTargets)

- **Signature**: `troveManager_getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: public
- **Source Range**: 773:150:330
- **Details**: [function_troveManager_getUnbackedPortionPriceAndRedeemability.md](./function_troveManager_getUnbackedPortionPriceAndRedeemability.md)

**Signature:**
```solidity
function troveManager_getUnbackedPortionPriceAndRedeemability() public asActor();
```

### troveManager_urgentRedemption(uint256,uint256[],uint256) (inherited from TroveManagerTargets)

- **Signature**: `troveManager_urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: public
- **Source Range**: 929:213:330
- **Details**: [function_troveManager_urgentRedemption_uint256_uint256[]_uint256.md](./function_troveManager_urgentRedemption_uint256_uint256[]_uint256.md)

**Signature:**
```solidity
function troveManager_urgentRedemption(uint256 _boldAmount, uint256[] memory _troveIds, uint256 _minCollateral) public asActor();
```

### troveNFT_approve(address,uint256) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 608:116:331
- **Details**: [function_troveNFT_approve_address_uint256.md](./function_troveNFT_approve_address_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function troveNFT_approve(address to, uint256 tokenId) public asActor();
```

### troveNFT_safeTransferFrom(address,address,uint256) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_safeTransferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 730:154:331
- **Details**: [function_troveNFT_safeTransferFrom_address_address_uint256.md](./function_troveNFT_safeTransferFrom_address_address_uint256.md)

**Signature:**
```solidity
function troveNFT_safeTransferFrom(address from, address to, uint256 tokenId) public asActor();
```

### troveNFT_safeTransferFrom(address,address,uint256,bytes) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 890:179:331
- **Details**: [function_troveNFT_safeTransferFrom_address_address_uint256_bytes.md](./function_troveNFT_safeTransferFrom_address_address_uint256_bytes.md)

**Signature:**
```solidity
function troveNFT_safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public asActor();
```

### troveNFT_setApprovalForAll(address,bool) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_setApprovalForAll(address,bool)`
- **Visibility**: public
- **Source Range**: 1075:147:331
- **Details**: [function_troveNFT_setApprovalForAll_address_bool.md](./function_troveNFT_setApprovalForAll_address_bool.md)

**Signature:**
```solidity
function troveNFT_setApprovalForAll(address operator, bool approved) public asActor();
```

### troveNFT_transferFrom(address,address,uint256) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1228:146:331
- **Details**: [function_troveNFT_transferFrom_address_address_uint256.md](./function_troveNFT_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function troveNFT_transferFrom(address from, address to, uint256 tokenId) public asActor();
```
