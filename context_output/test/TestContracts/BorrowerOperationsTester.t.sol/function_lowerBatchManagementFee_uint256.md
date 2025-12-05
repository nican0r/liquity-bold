# Function: lowerBatchManagementFee(uint256)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `lowerBatchManagementFee(uint256)`
- **Visibility**: external
- **Source Range**: 35219:1354:128
- **Inherited From**: BorrowerOperations

## Implementation

```solidity
function lowerBatchManagementFee(uint256 _newAnnualManagementFee) external {
    _requireIsNotShutDown();
    _requireValidInterestBatchManager(msg.sender);
    ITroveManager troveManagerCached = troveManager;
    LatestBatchData memory batch = troveManagerCached.getLatestBatchData(msg.sender);
    if (_newAnnualManagementFee >= batch.annualManagementFee) {
        revert NewFeeNotLower();
    }
    troveManagerCached.onLowerBatchManagerAnnualFee(msg.sender, batch.entireCollWithoutRedistribution, batch.entireDebtWithoutRedistribution, _newAnnualManagementFee);
    TroveChange memory batchChange;
    batchChange.batchAccruedManagementFee = batch.accruedManagementFee;
    batchChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
    batchChange.newWeightedRecordedDebt = batch.entireDebtWithoutRedistribution * batch.annualInterestRate;
    batchChange.oldWeightedRecordedBatchManagementFee = batch.weightedRecordedBatchManagementFee;
    batchChange.newWeightedRecordedBatchManagementFee = batch.entireDebtWithoutRedistribution * _newAnnualManagementFee;
    activePool.mintAggInterestAndAccountForTroveChange(batchChange, msg.sender);
}
```

## Related Implementations

### _requireIsNotShutDown()

- **Kind**: internal
- **Source**: 54030:128:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireIsNotShutDown()`

```solidity
function _requireIsNotShutDown() internal view {
    if (hasBeenShutDown) {
        revert IsShutDown();
    }
}
```

### _requireValidInterestBatchManager(address)

- **Kind**: internal
- **Source**: 62915:250:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireValidInterestBatchManager(address)`

```solidity
function _requireValidInterestBatchManager(address _interestBatchManagerAddress) internal view {
    if (interestBatchManagers[_interestBatchManagerAddress].maxInterestRate == 0) {
        revert InvalidInterestBatchManager();
    }
}
```

## External Calls

- **ITroveManager::getLatestBatchData(address)**
- **ITroveManager::onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **hasBeenShutDown** (`bool`)
- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.lowerBatchManagementFee(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidInterestBatchManager(address) (NodeID: 2)
      💬 Args: [msg.sender]
      👁️  Def: internal
```
