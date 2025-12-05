# Contract: ActivePool

## Metadata

- **Name**: ActivePool
- **Type**: Contract
- **Path**: src/ActivePool.sol

## Implements Interfaces

- **IActivePool** [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

## State Variables

### NAME

```solidity
string public constant NAME = "ActivePool"
```

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### borrowerOperationsAddress

```solidity
address public immutable borrowerOperationsAddress
```

### troveManagerAddress

```solidity
address public immutable troveManagerAddress
```

### defaultPoolAddress

```solidity
address public immutable defaultPoolAddress
```

### boldToken

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### interestRouter

```solidity
IInterestRouter public immutable interestRouter
```

**IInterestRouter**: [src/Interfaces/IInterestRouter.sol/interface_IInterestRouter.md]

### stabilityPool

```solidity
IBoldRewardsReceiver public immutable stabilityPool
```

**IBoldRewardsReceiver**: [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]

### collBalance

```solidity
uint256 internal collBalance
```

### aggRecordedDebt

```solidity
uint256 public aggRecordedDebt
```

### aggWeightedDebtSum

```solidity
uint256 public aggWeightedDebtSum
```

### lastAggUpdateTime

```solidity
uint256 public lastAggUpdateTime
```

### shutdownTime

```solidity
uint256 public shutdownTime
```

### aggBatchManagementFees

```solidity
uint256 public aggBatchManagementFees
```

### aggWeightedBatchManagementFeeSum

```solidity
uint256 public aggWeightedBatchManagementFeeSum
```

### lastAggBatchManagementFeesUpdateTime

```solidity
uint256 public lastAggBatchManagementFeesUpdateTime
```

## Events

### CollTokenAddressChanged

```solidity
event CollTokenAddressChanged(address _newCollTokenAddress);
```

### BorrowerOperationsAddressChanged

```solidity
event BorrowerOperationsAddressChanged(address _newBorrowerOperationsAddress);
```

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _newTroveManagerAddress);
```

### DefaultPoolAddressChanged

```solidity
event DefaultPoolAddressChanged(address _newDefaultPoolAddress);
```

### StabilityPoolAddressChanged

```solidity
event StabilityPoolAddressChanged(address _newStabilityPoolAddress);
```

### ActivePoolBoldDebtUpdated

```solidity
event ActivePoolBoldDebtUpdated(uint256 _recordedDebtSum);
```

### ActivePoolCollBalanceUpdated

```solidity
event ActivePoolCollBalanceUpdated(uint256 _collBalance);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 2867:985:125
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 4096:102:125
- **Details**: [function_getCollBalance.md](./function_getCollBalance.md)

**Signature:**
```solidity
function getCollBalance() override external view returns (uint256);
```

### calcPendingAggInterest()

- **Signature**: `calcPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 4204:684:125
- **Details**: [function_calcPendingAggInterest.md](./function_calcPendingAggInterest.md)

**Signature:**
```solidity
function calcPendingAggInterest() public view returns (uint256);
```

### calcPendingSPYield()

- **Signature**: `calcPendingSPYield()`
- **Visibility**: external
- **Source Range**: 4894:147:125
- **Details**: [function_calcPendingSPYield.md](./function_calcPendingSPYield.md)

**Signature:**
```solidity
function calcPendingSPYield() external view returns (uint256);
```

### calcPendingAggBatchManagementFee()

- **Signature**: `calcPendingAggBatchManagementFee()`
- **Visibility**: public
- **Source Range**: 5047:372:125
- **Details**: [function_calcPendingAggBatchManagementFee.md](./function_calcPendingAggBatchManagementFee.md)

**Signature:**
```solidity
function calcPendingAggBatchManagementFee() public view returns (uint256);
```

### getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)

- **Signature**: `getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)`
- **Visibility**: external
- **Source Range**: 5425:1444:125
- **Details**: [function_getNewApproxAvgInterestRateFromTroveChange_struct_TroveChange.md](./function_getNewApproxAvgInterestRateFromTroveChange_struct_TroveChange.md)

**Signature:**
```solidity
function getNewApproxAvgInterestRateFromTroveChange(TroveChange calldata _troveChange) external view returns (uint256);
```

### getBoldDebt()

- **Signature**: `getBoldDebt()`
- **Visibility**: external
- **Source Range**: 6975:183:125
- **Details**: [function_getBoldDebt.md](./function_getBoldDebt.md)

**Signature:**
```solidity
function getBoldDebt() external view returns (uint256);
```

### sendColl(address,uint256)

- **Signature**: `sendColl(address,uint256)`
- **Visibility**: external
- **Source Range**: 7199:211:125
- **Details**: [function_sendColl_address_uint256.md](./function_sendColl_address_uint256.md)

**Signature:**
```solidity
function sendColl(address _account, uint256 _amount) override external;
```

### sendCollToDefaultPool(uint256)

- **Signature**: `sendCollToDefaultPool(uint256)`
- **Visibility**: external
- **Source Range**: 7416:216:125
- **Details**: [function_sendCollToDefaultPool_uint256.md](./function_sendCollToDefaultPool_uint256.md)

**Signature:**
```solidity
function sendCollToDefaultPool(uint256 _amount) override external;
```

### receiveColl(uint256)

- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 7859:269:125
- **Details**: [function_receiveColl_uint256.md](./function_receiveColl_uint256.md)

**Signature:**
```solidity
function receiveColl(uint256 _amount) external;
```

### accountForReceivedColl(uint256)

- **Signature**: `accountForReceivedColl(uint256)`
- **Visibility**: public
- **Source Range**: 8134:165:125
- **Details**: [function_accountForReceivedColl_uint256.md](./function_accountForReceivedColl_uint256.md)

**Signature:**
```solidity
function accountForReceivedColl(uint256 _amount) public;
```

### mintAggInterestAndAccountForTroveChange(struct TroveChange,address)

- **Signature**: `mintAggInterestAndAccountForTroveChange(struct TroveChange,address)`
- **Visibility**: external
- **Source Range**: 9498:1417:125
- **Details**: [function_mintAggInterestAndAccountForTroveChange_struct_TroveChange_address.md](./function_mintAggInterestAndAccountForTroveChange_struct_TroveChange_address.md)

**Signature:**
```solidity
function mintAggInterestAndAccountForTroveChange(TroveChange calldata _troveChange, address _batchAddress) external;
```

### mintAggInterest()

- **Signature**: `mintAggInterest()`
- **Visibility**: external
- **Source Range**: 10921:134:125
- **Details**: [function_mintAggInterest.md](./function_mintAggInterest.md)

**Signature:**
```solidity
function mintAggInterest() override external;
```

### mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)

- **Signature**: `mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)`
- **Visibility**: external
- **Source Range**: 11779:275:125
- **Details**: [function_mintBatchManagementFeeAndAccountForChange_struct_TroveChange_address.md](./function_mintBatchManagementFeeAndAccountForChange_struct_TroveChange_address.md)

**Signature:**
```solidity
function mintBatchManagementFeeAndAccountForChange(TroveChange calldata _troveChange, address _batchAddress) override external;
```

### setShutdownFlag()

- **Signature**: `setShutdownFlag()`
- **Visibility**: external
- **Source Range**: 13404:123:125
- **Details**: [function_setShutdownFlag.md](./function_setShutdownFlag.md)

**Signature:**
```solidity
function setShutdownFlag() external;
```

### hasBeenShutDown()

- **Signature**: `hasBeenShutDown()`
- **Visibility**: external
- **Source Range**: 13533:97:125
- **Details**: [function_hasBeenShutDown.md](./function_hasBeenShutDown.md)

**Signature:**
```solidity
function hasBeenShutDown() external view returns (bool);
```
