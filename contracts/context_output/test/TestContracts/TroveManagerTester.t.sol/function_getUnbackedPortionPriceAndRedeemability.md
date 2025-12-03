# Function: getUnbackedPortionPriceAndRedeemability()

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: external
- **Source Range**: 56017:626:188
- **Inherited From**: TroveManager

## Implementation

```solidity
function getUnbackedPortionPriceAndRedeemability() external returns (uint256, uint256, bool) {
    uint256 totalDebt = getEntireBranchDebt();
    uint256 spSize = stabilityPool.getTotalBoldDeposits();
    uint256 unbackedPortion = (totalDebt > spSize) ? (totalDebt - spSize) : 0;
    (uint256 price, ) = priceFeed.fetchPrice();
    bool redeemable = (_getTCR(price) >= SCR) && (shutdownTime == 0);
    return (unbackedPortion, price, redeemable);
}
```

## Related Implementations

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

### _getTCR(uint256)

- **Kind**: internal
- **Source**: 1765:296:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_getTCR(uint256)`

```solidity
function _getTCR(uint256 _price) internal view returns (uint256 TCR) {
    uint256 entireSystemColl = getEntireBranchColl();
    uint256 entireSystemDebt = getEntireBranchDebt();
    TCR = LiquityMath._computeCR(entireSystemColl, entireSystemDebt, _price);
    return TCR;
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

## External Calls

- **IStabilityPool::getTotalBoldDeposits()**
- **IPriceFeed::fetchPrice()**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **SCR** (`uint256`)
- **shutdownTime** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getUnbackedPortionPriceAndRedeemability() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: LiquityBase._getTCR(uint256) (NodeID: 2)
      💬 Args: [price]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireBranchDebt() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 5)
        💬 Args: [entireSystemColl, entireSystemDebt, _price]
        👁️  Def: internal
```
