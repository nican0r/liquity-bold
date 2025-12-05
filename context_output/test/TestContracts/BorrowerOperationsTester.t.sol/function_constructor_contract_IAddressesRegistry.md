# Function: constructor(contract IAddressesRegistry)

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 419:92:256

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) BorrowerOperations(_addressesRegistry) {}
```

## Related Implementations

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 5819:1240:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) AddRemoveManagers(_addressesRegistry) LiquityBase(_addressesRegistry) {
    assert(MIN_DEBT > 0);
    collToken = _addressesRegistry.collToken();
    WETH = _addressesRegistry.WETH();
    CCR = _addressesRegistry.CCR();
    SCR = _addressesRegistry.SCR();
    MCR = _addressesRegistry.MCR();
    BCR = _addressesRegistry.BCR();
    troveManager = _addressesRegistry.troveManager();
    gasPoolAddress = _addressesRegistry.gasPoolAddress();
    collSurplusPool = _addressesRegistry.collSurplusPool();
    sortedTroves = _addressesRegistry.sortedTroves();
    boldToken = _addressesRegistry.boldToken();
    emit TroveManagerAddressChanged(address(troveManager));
    emit GasPoolAddressChanged(gasPoolAddress);
    emit CollSurplusPoolAddressChanged(address(collSurplusPool));
    emit SortedTrovesAddressChanged(address(sortedTroves));
    emit BoldTokenAddressChanged(address(boldToken));
    collToken.approve(address(activePool), type(uint256).max);
}
```

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 816:401:136
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    activePool = _addressesRegistry.activePool();
    defaultPool = _addressesRegistry.defaultPool();
    priceFeed = _addressesRegistry.priceFeed();
    emit ActivePoolAddressChanged(address(activePool));
    emit DefaultPoolAddressChanged(address(defaultPool));
    emit PriceFeedAddressChanged(address(priceFeed));
}
```

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 1988:164:133
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    troveNFT = _addressesRegistry.troveNFT();
    emit TroveNFTAddressChanged(address(troveNFT));
}
```

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **CCR** (`uint256`)
- **SCR** (`uint256`)
- **MCR** (`uint256`)
- **BCR** (`uint256`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BorrowerOperationsTester.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BorrowerOperationsTester
  └─ [1] 🏗️ CONSTRUCTOR: BorrowerOperations.constructor(contract IAddressesRegistry) (NodeID: 1)
      💬 Args: [_addressesRegistry]
      🏗️  Contract: BorrowerOperations
    ├─ [2] 🏗️ CONSTRUCTOR: LiquityBase.constructor(contract IAddressesRegistry) (NodeID: 2)
    │   💬 Args: [_addressesRegistry]
    │   🏗️  Contract: LiquityBase
    └─ [2] 🏗️ CONSTRUCTOR: AddRemoveManagers.constructor(contract IAddressesRegistry) (NodeID: 3)
        💬 Args: [_addressesRegistry]
        🏗️  Contract: AddRemoveManagers
```
