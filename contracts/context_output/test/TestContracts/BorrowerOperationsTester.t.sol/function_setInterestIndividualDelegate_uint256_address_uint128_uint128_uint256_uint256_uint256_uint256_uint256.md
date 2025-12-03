# Function: setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 32260:1331:128
- **Inherited From**: BorrowerOperations

## Implementation

```solidity
function setInterestIndividualDelegate(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) external {
    _requireIsNotShutDown();
    _requireTroveIsActive(troveManager, _troveId);
    _requireCallerIsBorrower(_troveId);
    _requireValidAnnualInterestRate(_minInterestRate);
    _requireValidAnnualInterestRate(_maxInterestRate);
    _requireOrderedRange(_minInterestRate, _maxInterestRate);
    interestIndividualDelegateOf[_troveId] = InterestIndividualDelegate(_delegate, _minInterestRate, _maxInterestRate, _minInterestRateChangePeriod);
    if (interestBatchManagerOf[_troveId] != address(0)) {
        removeFromBatch(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }
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

### _requireOrderedRange(uint256,uint256)

- **Kind**: internal
- **Source**: 61169:172:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireOrderedRange(uint256,uint256)`

```solidity
function _requireOrderedRange(uint256 _minInterestRate, uint256 _maxInterestRate) internal pure {
    if (_minInterestRate >= _maxInterestRate) revert MinGeMax();
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

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **hasBeenShutDown** (`bool`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **MCR** (`uint256`)
- **BCR** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)

## State Variable Writes

- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)
- **interestBatchManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 2)
  │   💬 Args: [troveManager, _troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 3)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 4)
  │   💬 Args: [_minInterestRate]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 5)
  │   💬 Args: [_maxInterestRate]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireOrderedRange(uint256,uint256) (NodeID: 6)
  │   💬 Args: [_minInterestRate, _maxInterestRate]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations.removeFromBatch(uint256,uint256,uint256,uint256,uint256) (NodeID: 7)
      💬 Args: [_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: BorrowerOperations._removeFromBatch(uint256,uint256,uint256,uint256,uint256,bool) (NodeID: 8)
        💬 Args: [_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee, false]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 9)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsOpen(contract ITroveManager,uint256) (NodeID: 10)
      │   💬 Args: [vars.troveManager, _troveId]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 11)
      │   💬 Args: [vars.troveManager, _troveId]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 12)
      │   💬 Args: [_troveId]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 13)
      │   💬 Args: [_newAnnualInterestRate]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireIsInBatch(uint256) (NodeID: 14)
      │   💬 Args: [_troveId]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._checkTroveIsZombie(contract ITroveManager,uint256) (NodeID: 15)
      │   💬 Args: [vars.troveManager, _troveId]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BorrowerOperations._applyUpfrontFee(uint256,uint256,struct TroveChange,uint256,bool) (NodeID: 16)
          💬 Args: [vars.trove.entireColl, vars.trove.entireDebt, vars.batchChange, _maxUpfrontFee, false]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 17)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 18)
        │   💬 Args: [_troveEntireDebt, avgInterestRate]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 19)
        │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 20)
        │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 21)
        │   💬 Args: [_troveEntireColl, _troveEntireDebt, price]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCRPlusBCR(uint256) (NodeID: 22)
        │   💬 Args: [newICR]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 23)
        │   💬 Args: [newICR]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 24)
        │   💬 Args: [_troveChange, price]
        │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 25)
        │ │   💬 Args: [no args]
        │ │   👁️  Def: public
        │ ├─ [5] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 26)
        │ │   💬 Args: [no args]
        │ │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 27)
        │     💬 Args: [totalColl, totalDebt, _price]
        │     👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 28)
            💬 Args: [newTCR]
            👁️  Def: internal
```
