# Function: adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 18177:1975:128

## Implementation

```solidity
function adjustTroveInterestRate(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external {
    _requireIsNotShutDown();
    ITroveManager troveManagerCached = troveManager;
    _requireValidAnnualInterestRate(_newAnnualInterestRate);
    _requireIsNotInBatch(_troveId);
    _requireSenderIsOwnerOrInterestManager(_troveId);
    _requireTroveIsActive(troveManagerCached, _troveId);
    LatestTroveData memory trove = troveManagerCached.getLatestTroveData(_troveId);
    _requireValidDelegateAdjustment(_troveId, trove.lastInterestRateAdjTime, _newAnnualInterestRate);
    _requireAnnualInterestRateIsNew(trove.annualInterestRate, _newAnnualInterestRate);
    uint256 newDebt = trove.entireDebt;
    TroveChange memory troveChange;
    troveChange.appliedRedistBoldDebtGain = trove.redistBoldDebtGain;
    troveChange.appliedRedistCollGain = trove.redistCollGain;
    troveChange.newWeightedRecordedDebt = newDebt * _newAnnualInterestRate;
    troveChange.oldWeightedRecordedDebt = trove.weightedRecordedDebt;
    if (block.timestamp < (trove.lastInterestRateAdjTime + INTEREST_RATE_ADJ_COOLDOWN)) {
        newDebt = _applyUpfrontFee(trove.entireColl, newDebt, troveChange, _maxUpfrontFee, false);
    }
    troveChange.newWeightedRecordedDebt = newDebt * _newAnnualInterestRate;
    activePool.mintAggInterestAndAccountForTroveChange(troveChange, address(0));
    sortedTroves.reInsert(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint);
    troveManagerCached.onAdjustTroveInterestRate(_troveId, trove.entireColl, newDebt, _newAnnualInterestRate, troveChange);
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

### _requireSenderIsOwnerOrInterestManager(uint256)

- **Kind**: internal
- **Source**: 54492:297:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireSenderIsOwnerOrInterestManager(uint256)`

```solidity
function _requireSenderIsOwnerOrInterestManager(uint256 _troveId) internal view {
    address owner = troveNFT.ownerOf(_troveId);
    if ((msg.sender != owner) && (msg.sender != interestIndividualDelegateOf[_troveId].account)) {
        revert NotOwnerNorInterestManager();
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

### _requireValidDelegateAdjustment(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 54795:809:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireValidDelegateAdjustment(uint256,uint256,uint256)`

```solidity
function _requireValidDelegateAdjustment(uint256 _troveId, uint256 _lastInterestRateAdjTime, uint256 _annualInterestRate) internal view {
    InterestIndividualDelegate memory individualDelegate = interestIndividualDelegateOf[_troveId];
    if (individualDelegate.account == msg.sender) {
        _requireInterestRateInRange(_annualInterestRate, individualDelegate.minInterestRate, individualDelegate.maxInterestRate);
        _requireDelegateInterestRateChangePeriodPassed(_lastInterestRateAdjTime, individualDelegate.minInterestRateChangePeriod);
    }
}
```

### _requireInterestRateInRange(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 61778:316:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireInterestRateInRange(uint256,uint256,uint256)`

```solidity
function _requireInterestRateInRange(uint256 _annualInterestRate, uint256 _minInterestRate, uint256 _maxInterestRate) internal pure {
    if ((_minInterestRate > _annualInterestRate) || (_annualInterestRate > _maxInterestRate)) {
        revert InterestNotInRange();
    }
}
```

### _requireDelegateInterestRateChangePeriodPassed(uint256,uint256)

- **Kind**: internal
- **Source**: 62575:334:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireDelegateInterestRateChangePeriodPassed(uint256,uint256)`

```solidity
function _requireDelegateInterestRateChangePeriodPassed(uint256 _lastInterestRateAdjTime, uint256 _minInterestRateChangePeriod) internal view {
    if (block.timestamp < (_lastInterestRateAdjTime + _minInterestRateChangePeriod)) {
        revert DelegateInterestRateChangePeriodNotPassed();
    }
}
```

### _requireAnnualInterestRateIsNew(uint256,uint256)

- **Kind**: internal
- **Source**: 60902:261:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireAnnualInterestRateIsNew(uint256,uint256)`

```solidity
function _requireAnnualInterestRateIsNew(uint256 _oldAnnualInterestRate, uint256 _newAnnualInterestRate) internal pure {
    if (_oldAnnualInterestRate == _newAnnualInterestRate) {
        revert InterestRateNotNew();
    }
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

## External Calls

- **ITroveManager::getLatestTroveData(uint256)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **ISortedTroves::reInsert(uint256,uint256,uint256,uint256)**
- **ITroveManager::onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **hasBeenShutDown** (`bool`)
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)
- **MCR** (`uint256`)
- **BCR** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 2)
  │   💬 Args: [_newAnnualInterestRate]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotInBatch(uint256) (NodeID: 3)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireSenderIsOwnerOrInterestManager(uint256) (NodeID: 4)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 5)
  │   💬 Args: [troveManagerCached, _troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidDelegateAdjustment(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [_troveId, trove.lastInterestRateAdjTime, _newAnnualInterestRate]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireInterestRateInRange(uint256,uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [_annualInterestRate, individualDelegate.minInterestRate, individualDelegate.maxInterestRate]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BorrowerOperations._requireDelegateInterestRateChangePeriodPassed(uint256,uint256) (NodeID: 8)
  │     💬 Args: [_lastInterestRateAdjTime, individualDelegate.minInterestRateChangePeriod]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireAnnualInterestRateIsNew(uint256,uint256) (NodeID: 9)
  │   💬 Args: [trove.annualInterestRate, _newAnnualInterestRate]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._applyUpfrontFee(uint256,uint256,struct TroveChange,uint256,bool) (NodeID: 10)
      💬 Args: [trove.entireColl, newDebt, troveChange, _maxUpfrontFee, false]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 11)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 12)
    │   💬 Args: [_troveEntireDebt, avgInterestRate]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 13)
    │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 14)
    │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 15)
    │   💬 Args: [_troveEntireColl, _troveEntireDebt, price]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCRPlusBCR(uint256) (NodeID: 16)
    │   💬 Args: [newICR]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 17)
    │   💬 Args: [newICR]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 18)
    │   💬 Args: [_troveChange, price]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 19)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 20)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 21)
    │     💬 Args: [totalColl, totalDebt, _price]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 22)
        💬 Args: [newTCR]
        👁️  Def: internal
```
