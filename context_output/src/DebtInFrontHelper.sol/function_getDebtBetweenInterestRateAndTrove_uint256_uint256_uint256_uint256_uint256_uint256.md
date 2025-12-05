# Function: getDebtBetweenInterestRateAndTrove(uint256,uint256,uint256,uint256,uint256,uint256)

**Contract**: [src/DebtInFrontHelper.sol/contract_DebtInFrontHelper.md]

## Metadata

- **Contract**: DebtInFrontHelper
- **Signature**: `getDebtBetweenInterestRateAndTrove(uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3867:472:131

## Implementation

```solidity
function getDebtBetweenInterestRateAndTrove(uint256 _collIndex, uint256 _interestRateLo, uint256 _interestRateHi, uint256 _troveIdToStopAt, uint256 _hintId, uint256 _numTrials) external view returns (uint256 debt, uint256 blockTimestamp) {
    return _getDebtBetween(_collIndex, _interestRateLo, _interestRateHi, _troveIdToStopAt, true, _hintId, _numTrials);
}
```

## Related Implementations

### _getDebtBetween(uint256,uint256,uint256,uint256,bool,uint256,uint256)

- **Kind**: internal
- **Source**: 1635:1766:131
- **Link**: `src/DebtInFrontHelper.sol:DebtInFrontHelper:_getDebtBetween(uint256,uint256,uint256,uint256,bool,uint256,uint256)`

```solidity
function _getDebtBetween(uint256 _collIndex, uint256 _interestRateLo, uint256 _interestRateHi, uint256 _excludedTroveId, bool _stopAfterExludedTrove, uint256 _hintId, uint256 _numTrials) internal view returns (uint256 debt, uint256 blockTimestamp) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    require(address(troveManager) != address(0), "Invalid collateral index");
    ISortedTroves sortedTroves = troveManager.sortedTroves();
    assert(address(sortedTroves) != address(0));
    if (_numTrials > 0) {
        uint256 randomSeed = uint256(keccak256(abi.encode(block.timestamp, _collIndex, _interestRateLo, _interestRateHi, _excludedTroveId, _hintId, _numTrials)));
        _hintId = _findHint(troveManager, _collIndex, _interestRateLo, _hintId, _numTrials, randomSeed);
    }
    (uint256 currId, ) = sortedTroves.findInsertPosition(_interestRateLo, _hintId, _hintId);
    while (currId != 0) {
        LatestTroveData memory trove = troveManager.getLatestTroveData(currId);
        if (trove.annualInterestRate >= _interestRateHi) break;
        if (currId == _excludedTroveId) {
            if (_stopAfterExludedTrove) break;
        } else {
            debt += trove.entireDebt;
        }
        currId = sortedTroves.getPrev(currId);
    }
    blockTimestamp = block.timestamp;
}
```

### _findHint(contract ITroveManager,uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 999:630:131
- **Link**: `src/DebtInFrontHelper.sol:DebtInFrontHelper:_findHint(contract ITroveManager,uint256,uint256,uint256,uint256,uint256)`

```solidity
function _findHint(ITroveManager _troveManager, uint256 _collIndex, uint256 _interestRateLo, uint256 _hintId, uint256 _numTrials, uint256 _randomSeed) internal view returns (uint256 hintId) {
    uint256 diff = (_hintId != 0) ? SignedMath.abs(int256(_troveManager.getTroveAnnualInterestRate(_hintId)) - int256(_interestRateLo)) : type(uint256).max;
    (uint256 newHintId, uint256 newDiff, ) = hintHelpers.getApproxHint(_collIndex, _interestRateLo, _numTrials, _randomSeed);
    return (newDiff < diff) ? newHintId : _hintId;
}
```

### abs(int256)

- **Kind**: internal
- **Source**: 1048:213:13
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol:SignedMath:abs(int256)`

```solidity
///  @dev Returns the absolute unsigned value of a signed value.
function abs(int256 n) internal pure returns (uint256) {
    unchecked {
        return uint256((n >= 0) ? n : (-n));
    }
}
```

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **hintHelpers** (`contract IHintHelpers`) [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DebtInFrontHelper.getDebtBetweenInterestRateAndTrove(uint256,uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DebtInFrontHelper._getDebtBetween(uint256,uint256,uint256,uint256,bool,uint256,uint256) (NodeID: 1)
      💬 Args: [_collIndex, _interestRateLo, _interestRateHi, _troveIdToStopAt, true, _hintId, _numTrials]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: DebtInFrontHelper._findHint(contract ITroveManager,uint256,uint256,uint256,uint256,uint256) (NodeID: 2)
        💬 Args: [troveManager, _collIndex, _interestRateLo, _hintId, _numTrials, randomSeed]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SignedMath.abs(int256) (NodeID: 3)
          💬 Args: [int256(_troveManager.getTroveAnnualInterestRate(_hintId)) - int256(_interestRateLo)]
          👁️  Def: internal
```
