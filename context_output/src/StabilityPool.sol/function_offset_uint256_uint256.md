# Function: offset(uint256,uint256)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `offset(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 16893:1875:187

## Implementation

```solidity
function offset(uint256 _debtToOffset, uint256 _collToAdd) override external {
    _requireCallerIsTroveManager();
    scaleToS[currentScale] += (P * _collToAdd) / totalBoldDeposits;
    emit S_Updated(scaleToS[currentScale], currentScale);
    uint256 numerator = P * (totalBoldDeposits - _debtToOffset);
    uint256 newP = numerator / totalBoldDeposits;
    require(newP > 0, "P must never decrease to 0");
    while (newP < (P_PRECISION / SCALE_FACTOR)) {
        numerator *= SCALE_FACTOR;
        newP = numerator / totalBoldDeposits;
        currentScale += 1;
        emit ScaleUpdated(currentScale);
    }
    emit P_Updated(newP);
    P = newP;
    _moveOffsetCollAndDebt(_collToAdd, _debtToOffset);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 25957:160:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == address(troveManager), "StabilityPool: Caller is not TroveManager");
}
```

### _moveOffsetCollAndDebt(uint256,uint256)

- **Kind**: internal
- **Source**: 18774:635:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_moveOffsetCollAndDebt(uint256,uint256)`

```solidity
function _moveOffsetCollAndDebt(uint256 _collToAdd, uint256 _debtToOffset) internal {
    _updateTotalBoldDeposits(0, _debtToOffset);
    boldToken.burn(address(this), _debtToOffset);
    uint256 newCollBalance = collBalance + _collToAdd;
    collBalance = newCollBalance;
    activePool.sendColl(address(this), _collToAdd);
    emit StabilityPoolCollBalanceUpdated(newCollBalance);
}
```

### _updateTotalBoldDeposits(uint256,uint256)

- **Kind**: internal
- **Source**: 19415:458:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateTotalBoldDeposits(uint256,uint256)`

```solidity
function _updateTotalBoldDeposits(uint256 _depositIncrease, uint256 _depositDecrease) internal returns (uint256) {
    if ((_depositIncrease == 0) && (_depositDecrease == 0)) return totalBoldDeposits;
    uint256 newTotalBoldDeposits = (totalBoldDeposits + _depositIncrease) - _depositDecrease;
    totalBoldDeposits = newTotalBoldDeposits;
    emit StabilityPoolBoldBalanceUpdated(newTotalBoldDeposits);
    return newTotalBoldDeposits;
}
```

## State Variable Reads

- **currentScale** (`uint256`)
- **P** (`uint256`)
- **totalBoldDeposits** (`uint256`)
- **scaleToS** (`mapping(uint256 => uint256)`)
- **P_PRECISION** (`uint256`)
- **SCALE_FACTOR** (`uint256`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **collBalance** (`uint256`)

## State Variable Writes

- **scaleToS** (`mapping(uint256 => uint256)`)
- **currentScale** (`uint256`)
- **P** (`uint256`)
- **collBalance** (`uint256`)
- **totalBoldDeposits** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.offset(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireCallerIsTroveManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StabilityPool._moveOffsetCollAndDebt(uint256,uint256) (NodeID: 2)
      💬 Args: [_collToAdd, _debtToOffset]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StabilityPool._updateTotalBoldDeposits(uint256,uint256) (NodeID: 3)
        💬 Args: [0, _debtToOffset]
        👁️  Def: internal
```
