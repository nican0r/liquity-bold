# Function: getEntireBranchColl()

**Contract**: [src/Dependencies/LiquityBase.sol/contract_LiquityBase.md]

## Metadata

- **Contract**: LiquityBase
- **Signature**: `getEntireBranchColl()`
- **Visibility**: public
- **Source Range**: 1265:251:136

## Implementation

```solidity
function getEntireBranchColl() public view returns (uint256 entireSystemColl) {
    uint256 activeColl = activePool.getCollBalance();
    uint256 liquidatedColl = defaultPool.getCollBalance();
    return activeColl + liquidatedColl;
}
```

## External Calls

- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**

## State Variable Reads

- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquityBase.getEntireBranchColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
