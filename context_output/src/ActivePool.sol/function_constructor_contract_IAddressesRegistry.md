# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 2867:985:125

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    collToken = _addressesRegistry.collToken();
    borrowerOperationsAddress = address(_addressesRegistry.borrowerOperations());
    troveManagerAddress = address(_addressesRegistry.troveManager());
    stabilityPool = IBoldRewardsReceiver(_addressesRegistry.stabilityPool());
    defaultPoolAddress = address(_addressesRegistry.defaultPool());
    interestRouter = _addressesRegistry.interestRouter();
    boldToken = _addressesRegistry.boldToken();
    emit CollTokenAddressChanged(address(collToken));
    emit BorrowerOperationsAddressChanged(borrowerOperationsAddress);
    emit TroveManagerAddressChanged(troveManagerAddress);
    emit StabilityPoolAddressChanged(address(stabilityPool));
    emit DefaultPoolAddressChanged(defaultPoolAddress);
    collToken.approve(defaultPoolAddress, type(uint256).max);
}
```

## External Calls

- **IAddressesRegistry::collToken()**
- **IAddressesRegistry::borrowerOperations()**
- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::stabilityPool()**
- **IAddressesRegistry::defaultPool()**
- **IAddressesRegistry::interestRouter()**
- **IAddressesRegistry::boldToken()**
- **IERC20::approve(address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **borrowerOperationsAddress** (`address`)
- **troveManagerAddress** (`address`)
- **stabilityPool** (`contract IBoldRewardsReceiver`) [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
- **defaultPoolAddress** (`address`)

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **borrowerOperationsAddress** (`address`)
- **troveManagerAddress** (`address`)
- **stabilityPool** (`contract IBoldRewardsReceiver`) [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
- **defaultPoolAddress** (`address`)
- **interestRouter** (`contract IInterestRouter`) [src/Interfaces/IInterestRouter.sol/interface_IInterestRouter.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ActivePool.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ActivePool
```
