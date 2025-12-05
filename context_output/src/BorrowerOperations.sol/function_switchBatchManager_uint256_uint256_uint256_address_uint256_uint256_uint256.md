# Function: switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 47698:724:128

## Implementation

```solidity
function switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) override external {
    address oldBatchManager = _requireIsInBatch(_troveId);
    _requireNewInterestBatchManager(oldBatchManager, _newBatchManager);
    LatestBatchData memory oldBatch = troveManager.getLatestBatchData(oldBatchManager);
    removeFromBatch(_troveId, oldBatch.annualInterestRate, _removeUpperHint, _removeLowerHint, 0);
    setInterestBatchManager(_troveId, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
}
```

## Related Implementations

### _requireIsInBatch(uint256)

- **Kind**: internal
- **Source**: 55792:269:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireIsInBatch(uint256)`

```solidity
function _requireIsInBatch(uint256 _troveId) internal view returns (address) {
    address batchManager = interestBatchManagerOf[_troveId];
    if (batchManager == address(0)) {
        revert TroveNotInBatch();
    }
    return batchManager;
}
```

### _requireNewInterestBatchManager(address,address)

- **Kind**: internal
- **Source**: 63423:265:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNewInterestBatchManager(address,address)`

```solidity
function _requireNewInterestBatchManager(address _oldBatchManagerAddress, address _newBatchManagerAddress) internal pure {
    if (_oldBatchManagerAddress == _newBatchManagerAddress) {
        revert BatchManagerNotNew();
    }
}
```

### removeFromBatch(uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 43607:480:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:removeFromBatch(uint256,uint256,uint256,uint256,uint256)`

```solidity
function removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) override public {
    _removeFromBatch({_troveId: _troveId, _newAnnualInterestRate: _newAnnualInterestRate, _upperHint: _upperHint, _lowerHint: _lowerHint, _maxUpfrontFee: _maxUpfrontFee, _kick: false});
}
```

### _removeFromBatch(uint256,uint256,uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 44093:3599:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_removeFromBatch(uint256,uint256,uint256,uint256,uint256,bool)`

```solidity
function _removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, bool _kick) internal {
    _requireIsNotShutDown();
    LocalVariables_removeFromBatch memory vars;
    vars.troveManager = troveManager;
    vars.sortedTroves = sortedTroves;
    if (_kick) {
        _requireTroveIsOpen(vars.troveManager, _troveId);
    } else {
        _requireTroveIsActive(vars.troveManager, _troveId);
        _requireCallerIsBorrower(_troveId);
        _requireValidAnnualInterestRate(_newAnnualInterestRate);
    }
    vars.batchManager = _requireIsInBatch(_troveId);
    vars.trove = vars.troveManager.getLatestTroveData(_troveId);
    vars.batch = vars.troveManager.getLatestBatchData(vars.batchManager);
    if (_kick) {
        if ((vars.batch.totalDebtShares * MAX_BATCH_SHARES_RATIO) >= vars.batch.entireDebtWithoutRedistribution) {
            revert BatchSharesRatioTooLow();
        }
        _newAnnualInterestRate = vars.batch.annualInterestRate;
    }
    delete interestBatchManagerOf[_troveId];
    if (!_checkTroveIsZombie(vars.troveManager, _troveId)) {
        vars.sortedTroves.removeFromBatch(_troveId);
        vars.sortedTroves.insert(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint);
    }
    vars.batchFutureDebt = vars.batch.entireDebtWithoutRedistribution - (vars.trove.entireDebt - vars.trove.redistBoldDebtGain);
    vars.batchChange.appliedRedistBoldDebtGain = vars.trove.redistBoldDebtGain;
    vars.batchChange.appliedRedistCollGain = vars.trove.redistCollGain;
    vars.batchChange.batchAccruedManagementFee = vars.batch.accruedManagementFee;
    vars.batchChange.oldWeightedRecordedDebt = vars.batch.weightedRecordedDebt;
    vars.batchChange.newWeightedRecordedDebt = (vars.batchFutureDebt * vars.batch.annualInterestRate) + (vars.trove.entireDebt * _newAnnualInterestRate);
    if ((vars.batch.annualInterestRate != _newAnnualInterestRate) && (block.timestamp < (vars.trove.lastInterestRateAdjTime + INTEREST_RATE_ADJ_COOLDOWN))) {
        vars.trove.entireDebt = _applyUpfrontFee(vars.trove.entireColl, vars.trove.entireDebt, vars.batchChange, _maxUpfrontFee, false);
    }
    vars.batchChange.newWeightedRecordedDebt = (vars.batchFutureDebt * vars.batch.annualInterestRate) + (vars.trove.entireDebt * _newAnnualInterestRate);
    vars.batchChange.oldWeightedRecordedBatchManagementFee = vars.batch.weightedRecordedBatchManagementFee;
    vars.batchChange.newWeightedRecordedBatchManagementFee = vars.batchFutureDebt * vars.batch.annualManagementFee;
    activePool.mintAggInterestAndAccountForTroveChange(vars.batchChange, vars.batchManager);
    vars.troveManager.onRemoveFromBatch(_troveId, vars.trove.entireColl, vars.trove.entireDebt, vars.batchChange, vars.batchManager, vars.batch.entireCollWithoutRedistribution, vars.batch.entireDebtWithoutRedistribution, _newAnnualInterestRate);
}
```

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

### _requireTroveIsOpen(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 56356:314:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireTroveIsOpen(contract ITroveManager,uint256)`

```solidity
function _requireTroveIsOpen(ITroveManager _troveManager, uint256 _troveId) internal view {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    if ((status != ITroveManager.Status.active) && (status != ITroveManager.Status.zombie)) {
        revert TroveNotOpen();
    }
}
```

### _requireTroveIsActive(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 56676:277:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireTroveIsActive(contract ITroveManager,uint256)`

```solidity
function _requireTroveIsActive(ITroveManager _troveManager, uint256 _troveId) internal view {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    if (status != ITroveManager.Status.active) {
        revert TroveNotActive();
    }
}
```

### _requireCallerIsBorrower(uint256)

- **Kind**: internal
- **Source**: 3796:173:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireCallerIsBorrower(uint256)`

```solidity
function _requireCallerIsBorrower(uint256 _troveId) internal view {
    if (msg.sender != troveNFT.ownerOf(_troveId)) {
        revert NotBorrower();
    }
}
```

### _requireValidAnnualInterestRate(uint256)

- **Kind**: internal
- **Source**: 60578:318:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireValidAnnualInterestRate(uint256)`

```solidity
function _requireValidAnnualInterestRate(uint256 _annualInterestRate) internal pure {
    if (_annualInterestRate < MIN_ANNUAL_INTEREST_RATE) {
        revert InterestRateTooLow();
    }
    if (_annualInterestRate > MAX_ANNUAL_INTEREST_RATE) {
        revert InterestRateTooHigh();
    }
}
```

### _checkTroveIsZombie(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 57172:244:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_checkTroveIsZombie(contract ITroveManager,uint256)`

```solidity
function _checkTroveIsZombie(ITroveManager _troveManager, uint256 _troveId) internal view returns (bool) {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    return status == ITroveManager.Status.zombie;
}
```

### _applyUpfrontFee(uint256,uint256,struct TroveChange,uint256,bool)

- **Kind**: internal
- **Source**: 48428:1235:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_applyUpfrontFee(uint256,uint256,struct TroveChange,uint256,bool)`

```solidity
function _applyUpfrontFee(uint256 _troveEntireColl, uint256 _troveEntireDebt, TroveChange memory _troveChange, uint256 _maxUpfrontFee, bool _isTroveInBatch) internal returns (uint256) {
    uint256 price = _requireOraclesLive();
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(_troveChange);
    _troveChange.upfrontFee = _calcUpfrontFee(_troveEntireDebt, avgInterestRate);
    _requireUserAcceptsUpfrontFee(_troveChange.upfrontFee, _maxUpfrontFee);
    _troveEntireDebt += _troveChange.upfrontFee;
    uint256 newICR = LiquityMath._computeCR(_troveEntireColl, _troveEntireDebt, price);
    if (_isTroveInBatch) {
        _requireICRisAboveMCRPlusBCR(newICR);
    } else {
        _requireICRisAboveMCR(newICR);
    }
    uint256 newTCR = _getNewTCRFromTroveChange(_troveChange, price);
    _requireNewTCRisAboveCCR(newTCR);
    return _troveEntireDebt;
}
```

### _requireOraclesLive()

- **Kind**: internal
- **Source**: 64029:266:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireOraclesLive()`

```solidity
function _requireOraclesLive() internal returns (uint256) {
    (uint256 price, bool newOracleFailureDetected) = priceFeed.fetchPrice();
    if (newOracleFailureDetected) {
        revert NewOracleFailureDetected();
    }
    return price;
}
```

### _calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 49669:186:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_calcUpfrontFee(uint256,uint256)`

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

### _requireUserAcceptsUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 57579:171:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireUserAcceptsUpfrontFee(uint256,uint256)`

```solidity
function _requireUserAcceptsUpfrontFee(uint256 _fee, uint256 _maxFee) internal pure {
    if (_fee > _maxFee) {
        revert UpfrontFeeTooHigh();
    }
}
```

### _computeCR(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2640:414:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_computeCR(uint256,uint256,uint256)`

```solidity
function _computeCR(uint256 _coll, uint256 _debt, uint256 _price) internal pure returns (uint256) {
    if (_debt > 0) {
        uint256 newCollRatio = (_coll * _price) / _debt;
        return newCollRatio;
    } else {
        return (2 ** 256) - 1;
    }
}
```

### _requireICRisAboveMCRPlusBCR(uint256)

- **Kind**: internal
- **Source**: 59126:162:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireICRisAboveMCRPlusBCR(uint256)`

```solidity
function _requireICRisAboveMCRPlusBCR(uint256 _newICR) internal view {
    if (_newICR < (MCR + BCR)) {
        revert ICRBelowMCRPlusBCR();
    }
}
```

### _requireICRisAboveMCR(uint256)

- **Kind**: internal
- **Source**: 58978:142:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireICRisAboveMCR(uint256)`

```solidity
function _requireICRisAboveMCR(uint256 _newICR) internal view {
    if (_newICR < MCR) {
        revert ICRBelowMCR();
    }
}
```

### _getNewTCRFromTroveChange(struct TroveChange,uint256)

- **Kind**: internal
- **Source**: 64337:571:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_getNewTCRFromTroveChange(struct TroveChange,uint256)`

```solidity
function _getNewTCRFromTroveChange(TroveChange memory _troveChange, uint256 _price) internal view returns (uint256 newTCR) {
    uint256 totalColl = getEntireBranchColl();
    totalColl += _troveChange.collIncrease;
    totalColl -= _troveChange.collDecrease;
    uint256 totalDebt = getEntireBranchDebt();
    totalDebt += _troveChange.debtIncrease;
    totalDebt += _troveChange.upfrontFee;
    totalDebt -= _troveChange.debtDecrease;
    newTCR = LiquityMath._computeCR(totalColl, totalDebt, _price);
}
```

### getEntireBranchColl()

- **Kind**: internal
- **Source**: 1265:251:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:getEntireBranchColl()`

```solidity
function getEntireBranchColl() public view returns (uint256 entireSystemColl) {
    uint256 activeColl = activePool.getCollBalance();
    uint256 liquidatedColl = defaultPool.getCollBalance();
    return activeColl + liquidatedColl;
}
```

### getEntireBranchDebt()

- **Kind**: internal
- **Source**: 1522:237:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:getEntireBranchDebt()`

```solidity
function getEntireBranchDebt() public view returns (uint256 entireSystemDebt) {
    uint256 activeDebt = activePool.getBoldDebt();
    uint256 closedDebt = defaultPool.getBoldDebt();
    return activeDebt + closedDebt;
}
```

### _requireNewTCRisAboveCCR(uint256)

- **Kind**: internal
- **Source**: 59796:145:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNewTCRisAboveCCR(uint256)`

```solidity
function _requireNewTCRisAboveCCR(uint256 _newTCR) internal view {
    if (_newTCR < CCR) {
        revert TCRBelowCCR();
    }
}
```

### setInterestBatchManager(uint256,address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 39676:3494:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:setInterestBatchManager(uint256,address,uint256,uint256,uint256)`

```solidity
function setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) override public {
    _requireIsNotShutDown();
    LocalVariables_setInterestBatchManager memory vars;
    vars.troveManager = troveManager;
    vars.activePool = activePool;
    vars.sortedTroves = sortedTroves;
    _requireTroveIsActive(vars.troveManager, _troveId);
    _requireCallerIsBorrower(_troveId);
    _requireValidInterestBatchManager(_newBatchManager);
    _requireIsNotInBatch(_troveId);
    interestBatchManagerOf[_troveId] = _newBatchManager;
    if (interestIndividualDelegateOf[_troveId].account != address(0)) delete interestIndividualDelegateOf[_troveId];
    vars.trove = vars.troveManager.getLatestTroveData(_troveId);
    vars.newBatch = vars.troveManager.getLatestBatchData(_newBatchManager);
    TroveChange memory newBatchTroveChange;
    newBatchTroveChange.appliedRedistBoldDebtGain = vars.trove.redistBoldDebtGain;
    newBatchTroveChange.appliedRedistCollGain = vars.trove.redistCollGain;
    newBatchTroveChange.batchAccruedManagementFee = vars.newBatch.accruedManagementFee;
    newBatchTroveChange.oldWeightedRecordedDebt = vars.newBatch.weightedRecordedDebt + vars.trove.weightedRecordedDebt;
    newBatchTroveChange.newWeightedRecordedDebt = (vars.newBatch.entireDebtWithoutRedistribution + vars.trove.entireDebt) * vars.newBatch.annualInterestRate;
    vars.trove.entireDebt = _applyUpfrontFee(vars.trove.entireColl, vars.trove.entireDebt, newBatchTroveChange, _maxUpfrontFee, true);
    newBatchTroveChange.newWeightedRecordedDebt = (vars.newBatch.entireDebtWithoutRedistribution + vars.trove.entireDebt) * vars.newBatch.annualInterestRate;
    newBatchTroveChange.oldWeightedRecordedBatchManagementFee = vars.newBatch.weightedRecordedBatchManagementFee;
    newBatchTroveChange.newWeightedRecordedBatchManagementFee = (vars.newBatch.entireDebtWithoutRedistribution + vars.trove.entireDebt) * vars.newBatch.annualManagementFee;
    vars.activePool.mintAggInterestAndAccountForTroveChange(newBatchTroveChange, _newBatchManager);
    vars.troveManager.onSetInterestBatchManager(ITroveManager.OnSetInterestBatchManagerParams({troveId: _troveId, troveColl: vars.trove.entireColl, troveDebt: vars.trove.entireDebt, troveChange: newBatchTroveChange, newBatchAddress: _newBatchManager, newBatchColl: vars.newBatch.entireCollWithoutRedistribution, newBatchDebt: vars.newBatch.entireDebtWithoutRedistribution}));
    vars.sortedTroves.remove(_troveId);
    vars.sortedTroves.insertIntoBatch(_troveId, BatchId.wrap(_newBatchManager), vars.newBatch.annualInterestRate, _upperHint, _lowerHint);
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

### _requireIsNotInBatch(uint256)

- **Kind**: internal
- **Source**: 55610:176:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireIsNotInBatch(uint256)`

```solidity
function _requireIsNotInBatch(uint256 _troveId) internal view {
    if (interestBatchManagerOf[_troveId] != address(0)) {
        revert TroveInBatch();
    }
}
```

## External Calls

- **ITroveManager::getLatestBatchData(address)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **hasBeenShutDown** (`bool`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **MCR** (`uint256`)
- **BCR** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)
- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)
- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## State Variable Writes

- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsInBatch(uint256) (NodeID: 1)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireNewInterestBatchManager(address,address) (NodeID: 2)
  │   💬 Args: [oldBatchManager, _newBatchManager]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations.removeFromBatch(uint256,uint256,uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [_troveId, oldBatch.annualInterestRate, _removeUpperHint, _removeLowerHint, 0]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BorrowerOperations._removeFromBatch(uint256,uint256,uint256,uint256,uint256,bool) (NodeID: 4)
  │     💬 Args: [_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 5)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsOpen(contract ITroveManager,uint256) (NodeID: 6)
  │   │   💬 Args: [vars.troveManager, _troveId]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 7)
  │   │   💬 Args: [vars.troveManager, _troveId]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 8)
  │   │   💬 Args: [_troveId]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 9)
  │   │   💬 Args: [_newAnnualInterestRate]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireIsInBatch(uint256) (NodeID: 10)
  │   │   💬 Args: [_troveId]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._checkTroveIsZombie(contract ITroveManager,uint256) (NodeID: 11)
  │   │   💬 Args: [vars.troveManager, _troveId]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BorrowerOperations._applyUpfrontFee(uint256,uint256,struct TroveChange,uint256,bool) (NodeID: 12)
  │       💬 Args: [vars.trove.entireColl, vars.trove.entireDebt, vars.batchChange, _maxUpfrontFee, false]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 13)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 14)
  │     │   💬 Args: [_troveEntireDebt, avgInterestRate]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 15)
  │     │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 16)
  │     │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 17)
  │     │   💬 Args: [_troveEntireColl, _troveEntireDebt, price]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCRPlusBCR(uint256) (NodeID: 18)
  │     │   💬 Args: [newICR]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 19)
  │     │   💬 Args: [newICR]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 20)
  │     │   💬 Args: [_troveChange, price]
  │     │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 21)
  │     │ │   💬 Args: [no args]
  │     │ │   👁️  Def: public
  │     │ ├─ [5] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 22)
  │     │ │   💬 Args: [no args]
  │     │ │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 23)
  │     │     💬 Args: [totalColl, totalDebt, _price]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 24)
  │         💬 Args: [newTCR]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations.setInterestBatchManager(uint256,address,uint256,uint256,uint256) (NodeID: 25)
      💬 Args: [_troveId, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 26)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 27)
    │   💬 Args: [vars.troveManager, _troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 28)
    │   💬 Args: [_troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireValidInterestBatchManager(address) (NodeID: 29)
    │   💬 Args: [_newBatchManager]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsNotInBatch(uint256) (NodeID: 30)
    │   💬 Args: [_troveId]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BorrowerOperations._applyUpfrontFee(uint256,uint256,struct TroveChange,uint256,bool) (NodeID: 31)
        💬 Args: [vars.trove.entireColl, vars.trove.entireDebt, newBatchTroveChange, _maxUpfrontFee, true]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 32)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 33)
      │   💬 Args: [_troveEntireDebt, avgInterestRate]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 34)
      │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 35)
      │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 36)
      │   💬 Args: [_troveEntireColl, _troveEntireDebt, price]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCRPlusBCR(uint256) (NodeID: 37)
      │   💬 Args: [newICR]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 38)
      │   💬 Args: [newICR]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 39)
      │   💬 Args: [_troveChange, price]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 40)
      │ │   💬 Args: [no args]
      │ │   👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 41)
      │ │   💬 Args: [no args]
      │ │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 42)
      │     💬 Args: [totalColl, totalDebt, _price]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 43)
          💬 Args: [newTCR]
          👁️  Def: internal
```
