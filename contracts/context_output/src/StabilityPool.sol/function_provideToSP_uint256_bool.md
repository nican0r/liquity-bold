# Function: provideToSP(uint256,bool)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `provideToSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 10587:1582:187

## Implementation

```solidity
function provideToSP(uint256 _topUp, bool _doClaim) override external {
    _requireNonZeroAmount(_topUp);
    activePool.mintAggInterest();
    uint256 initialDeposit = deposits[msg.sender].initialValue;
    uint256 currentCollGain = getDepositorCollGain(msg.sender);
    uint256 currentYieldGain = getDepositorYieldGain(msg.sender);
    uint256 compoundedBoldDeposit = getCompoundedBoldDeposit(msg.sender);
    (uint256 keptYieldGain, uint256 yieldGainToSend) = _getYieldToKeepOrSend(currentYieldGain, _doClaim);
    uint256 newDeposit = (compoundedBoldDeposit + _topUp) + keptYieldGain;
    (uint256 newStashedColl, uint256 collToSend) = _getNewStashedCollAndCollToSend(msg.sender, currentCollGain, _doClaim);
    emit DepositOperation(msg.sender, Operation.provideToSP, initialDeposit - compoundedBoldDeposit, int256(_topUp), currentYieldGain, yieldGainToSend, currentCollGain, collToSend);
    _updateDepositAndSnapshots(msg.sender, newDeposit, newStashedColl);
    boldToken.sendToPool(msg.sender, address(this), _topUp);
    _updateTotalBoldDeposits(_topUp + keptYieldGain, 0);
    _decreaseYieldGainsOwed(currentYieldGain);
    _sendBoldtoDepositor(msg.sender, yieldGainToSend);
    _sendCollGainToDepositor(collToSend);
    _updateYieldRewardsSum(0);
}
```

## Related Implementations

### _requireNonZeroAmount(uint256)

- **Kind**: internal
- **Source**: 26524:141:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireNonZeroAmount(uint256)`

```solidity
function _requireNonZeroAmount(uint256 _amount) internal pure {
    require(_amount > 0, "StabilityPool: Amount must be non-zero");
}
```

### getDepositorCollGain(address)

- **Kind**: internal
- **Source**: 20149:796:187
- **Link**: `src/StabilityPool.sol:StabilityPool:getDepositorCollGain(address)`

```solidity
function getDepositorCollGain(address _depositor) override public view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots storage snapshots = depositSnapshots[_depositor];
    uint256 normalizedGains = scaleToS[snapshots.scale] - snapshots.S;
    for (uint256 i = 1; i <= SCALE_SPAN; ++i) {
        normalizedGains += scaleToS[snapshots.scale + i] / (SCALE_FACTOR ** i);
    }
    return LiquityMath._min((initialDeposit * normalizedGains) / snapshots.P, collBalance);
}
```

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

### getDepositorYieldGain(address)

- **Kind**: internal
- **Source**: 20951:802:187
- **Link**: `src/StabilityPool.sol:StabilityPool:getDepositorYieldGain(address)`

```solidity
function getDepositorYieldGain(address _depositor) override public view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots storage snapshots = depositSnapshots[_depositor];
    uint256 normalizedGains = scaleToB[snapshots.scale] - snapshots.B;
    for (uint256 i = 1; i <= SCALE_SPAN; ++i) {
        normalizedGains += scaleToB[snapshots.scale + i] / (SCALE_FACTOR ** i);
    }
    return LiquityMath._min((initialDeposit * normalizedGains) / snapshots.P, yieldGainsOwed);
}
```

### getCompoundedBoldDeposit(address)

- **Kind**: internal
- **Source**: 23059:899:187
- **Link**: `src/StabilityPool.sol:StabilityPool:getCompoundedBoldDeposit(address)`

```solidity
function getCompoundedBoldDeposit(address _depositor) override public view returns (uint256 compoundedDeposit) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots storage snapshots = depositSnapshots[_depositor];
    uint256 scaleDiff = currentScale - snapshots.scale;
    if (scaleDiff <= MAX_SCALE_FACTOR_EXPONENT) {
        compoundedDeposit = ((initialDeposit * P) / snapshots.P) / (SCALE_FACTOR ** scaleDiff);
    } else {
        compoundedDeposit = 0;
    }
}
```

### _getYieldToKeepOrSend(uint256,bool)

- **Kind**: internal
- **Source**: 12175:423:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_getYieldToKeepOrSend(uint256,bool)`

```solidity
function _getYieldToKeepOrSend(uint256 _currentYieldGain, bool _doClaim) internal pure returns (uint256, uint256) {
    uint256 yieldToKeep;
    uint256 yieldToSend;
    if (_doClaim) {
        yieldToKeep = 0;
        yieldToSend = _currentYieldGain;
    } else {
        yieldToKeep = _currentYieldGain;
        yieldToSend = 0;
    }
    return (yieldToKeep, yieldToSend);
}
```

### _getNewStashedCollAndCollToSend(address,uint256,bool)

- **Kind**: internal
- **Source**: 14604:457:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_getNewStashedCollAndCollToSend(address,uint256,bool)`

```solidity
function _getNewStashedCollAndCollToSend(address _depositor, uint256 _currentCollGain, bool _doClaim) internal view returns (uint256 newStashedColl, uint256 collToSend) {
    if (_doClaim) {
        newStashedColl = 0;
        collToSend = stashedColl[_depositor] + _currentCollGain;
    } else {
        newStashedColl = stashedColl[_depositor] + _currentCollGain;
        collToSend = 0;
    }
}
```

### _updateDepositAndSnapshots(address,uint256,uint256)

- **Kind**: internal
- **Source**: 24671:1084:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateDepositAndSnapshots(address,uint256,uint256)`

```solidity
function _updateDepositAndSnapshots(address _depositor, uint256 _newDeposit, uint256 _newStashedColl) internal {
    deposits[_depositor].initialValue = _newDeposit;
    stashedColl[_depositor] = _newStashedColl;
    if (_newDeposit == 0) {
        delete depositSnapshots[_depositor];
        emit DepositUpdated(_depositor, 0, _newStashedColl, 0, 0, 0, 0);
        return;
    }
    uint256 currentScaleCached = currentScale;
    uint256 currentP = P;
    uint256 currentS = scaleToS[currentScaleCached];
    uint256 currentB = scaleToB[currentScaleCached];
    depositSnapshots[_depositor].P = currentP;
    depositSnapshots[_depositor].S = currentS;
    depositSnapshots[_depositor].B = currentB;
    depositSnapshots[_depositor].scale = currentScaleCached;
    emit DepositUpdated(_depositor, _newDeposit, _newStashedColl, currentP, currentS, currentB, currentScaleCached);
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

### _decreaseYieldGainsOwed(uint256)

- **Kind**: internal
- **Source**: 19879:206:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_decreaseYieldGainsOwed(uint256)`

```solidity
function _decreaseYieldGainsOwed(uint256 _amount) internal {
    if (_amount == 0) return;
    uint256 newYieldGainsOwed = yieldGainsOwed - _amount;
    yieldGainsOwed = newYieldGainsOwed;
}
```

### _sendBoldtoDepositor(address,uint256)

- **Kind**: internal
- **Source**: 24413:199:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_sendBoldtoDepositor(address,uint256)`

```solidity
function _sendBoldtoDepositor(address _depositor, uint256 _boldToSend) internal {
    if (_boldToSend == 0) return;
    boldToken.returnFromPool(address(this), _depositor, _boldToSend);
}
```

### _sendCollGainToDepositor(uint256)

- **Kind**: internal
- **Source**: 24029:327:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_sendCollGainToDepositor(uint256)`

```solidity
function _sendCollGainToDepositor(uint256 _collAmount) internal {
    if (_collAmount == 0) return;
    uint256 newCollBalance = collBalance - _collAmount;
    collBalance = newCollBalance;
    emit StabilityPoolCollBalanceUpdated(newCollBalance);
    collToken.safeTransfer(msg.sender, _collAmount);
}
```

### _updateYieldRewardsSum(uint256)

- **Kind**: internal
- **Source**: 15848:734:187
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateYieldRewardsSum(uint256)`

```solidity
function _updateYieldRewardsSum(uint256 _newYield) internal {
    uint256 accumulatedYieldGains = yieldGainsPending + _newYield;
    if (accumulatedYieldGains == 0) return;
    if (totalBoldDeposits < MIN_BOLD_IN_SP) {
        yieldGainsPending = accumulatedYieldGains;
        return;
    }
    yieldGainsOwed += accumulatedYieldGains;
    yieldGainsPending = 0;
    scaleToB[currentScale] += (P * accumulatedYieldGains) / totalBoldDeposits;
    emit B_Updated(scaleToB[currentScale], currentScale);
}
```

## External Calls

- **IActivePool::mintAggInterest()**
- **IBoldToken::sendToPool(address,address,uint256)**

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **scaleToS** (`mapping(uint256 => uint256)`)
- **SCALE_SPAN** (`uint256`)
- **SCALE_FACTOR** (`uint256`)
- **collBalance** (`uint256`)
- **scaleToB** (`mapping(uint256 => uint256)`)
- **yieldGainsOwed** (`uint256`)
- **currentScale** (`uint256`)
- **MAX_SCALE_FACTOR_EXPONENT** (`uint256`)
- **P** (`uint256`)
- **stashedColl** (`mapping(address => uint256)`)
- **totalBoldDeposits** (`uint256`)
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **yieldGainsPending** (`uint256`)

## State Variable Writes

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **stashedColl** (`mapping(address => uint256)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **totalBoldDeposits** (`uint256`)
- **yieldGainsOwed** (`uint256`)
- **collBalance** (`uint256`)
- **yieldGainsPending** (`uint256`)
- **scaleToB** (`mapping(uint256 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.provideToSP(uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireNonZeroAmount(uint256) (NodeID: 1)
  │   💬 Args: [_topUp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool.getDepositorCollGain(address) (NodeID: 2)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 3)
  │     💬 Args: [(initialDeposit * normalizedGains) / snapshots.P, collBalance]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool.getDepositorYieldGain(address) (NodeID: 4)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 5)
  │     💬 Args: [(initialDeposit * normalizedGains) / snapshots.P, yieldGainsOwed]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool.getCompoundedBoldDeposit(address) (NodeID: 6)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StabilityPool._getYieldToKeepOrSend(uint256,bool) (NodeID: 7)
  │   💬 Args: [currentYieldGain, _doClaim]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._getNewStashedCollAndCollToSend(address,uint256,bool) (NodeID: 8)
  │   💬 Args: [msg.sender, currentCollGain, _doClaim]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._updateDepositAndSnapshots(address,uint256,uint256) (NodeID: 9)
  │   💬 Args: [msg.sender, newDeposit, newStashedColl]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._updateTotalBoldDeposits(uint256,uint256) (NodeID: 10)
  │   💬 Args: [_topUp + keptYieldGain, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._decreaseYieldGainsOwed(uint256) (NodeID: 11)
  │   💬 Args: [currentYieldGain]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._sendBoldtoDepositor(address,uint256) (NodeID: 12)
  │   💬 Args: [msg.sender, yieldGainToSend]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._sendCollGainToDepositor(uint256) (NodeID: 13)
  │   💬 Args: [collToSend]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StabilityPool._updateYieldRewardsSum(uint256) (NodeID: 14)
      💬 Args: [0]
      👁️  Def: internal
```
