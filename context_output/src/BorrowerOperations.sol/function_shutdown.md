# Function: shutdown()

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 50529:640:128

## Implementation

```solidity
function shutdown() external {
    if (hasBeenShutDown) revert IsShutDown();
    uint256 totalColl = getEntireBranchColl();
    uint256 totalDebt = getEntireBranchDebt();
    (uint256 price, bool newOracleFailureDetected) = priceFeed.fetchPrice();
    if (newOracleFailureDetected) return;
    uint256 TCR = LiquityMath._computeCR(totalColl, totalDebt, price);
    if (TCR >= SCR) revert TCRNotBelowSCR();
    _applyShutdown();
    emit ShutDown(TCR);
}
```

## Related Implementations

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

### _applyShutdown()

- **Kind**: internal
- **Source**: 51594:145:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_applyShutdown()`

```solidity
function _applyShutdown() internal {
    activePool.mintAggInterest();
    hasBeenShutDown = true;
    troveManager.shutdown();
}
```

## External Calls

- **IPriceFeed::fetchPrice()**

## State Variable Reads

- **hasBeenShutDown** (`bool`)
- **SCR** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

## State Variable Writes

- **hasBeenShutDown** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.shutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [totalColl, totalDebt, price]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._applyShutdown() (NodeID: 4)
      💬 Args: [no args]
      👁️  Def: internal
```
