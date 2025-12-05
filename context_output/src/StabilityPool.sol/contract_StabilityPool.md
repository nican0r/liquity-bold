# Contract: StabilityPool

## Metadata

- **Name**: StabilityPool
- **Type**: Contract
- **Path**: src/StabilityPool.sol

## Implements Interfaces

- **IStabilityPoolEvents** [src/Interfaces/IStabilityPoolEvents.sol/interface_IStabilityPoolEvents.md]
- **IStabilityPool** [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **IBoldRewardsReceiver** [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## State Variables

### activePool (inherited from LiquityBase)

```solidity
IActivePool public activePool
```

**IActivePool**: [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

### defaultPool (inherited from LiquityBase)

```solidity
IDefaultPool internal defaultPool
```

**IDefaultPool**: [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

### priceFeed (inherited from LiquityBase)

```solidity
IPriceFeed internal priceFeed
```

**IPriceFeed**: [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

### NAME

```solidity
string public constant NAME = "StabilityPool"
```

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### troveManager

```solidity
ITroveManager public immutable troveManager
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### boldToken

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### collBalance

```solidity
uint256 internal collBalance
```

### totalBoldDeposits

```solidity
uint256 internal totalBoldDeposits
```

### yieldGainsOwed

```solidity
uint256 internal yieldGainsOwed
```

### yieldGainsPending

```solidity
uint256 internal yieldGainsPending
```

### deposits

```solidity
mapping(address => Deposit) public deposits
```

### depositSnapshots

```solidity
mapping(address => Snapshots) public depositSnapshots
```

### stashedColl

```solidity
mapping(address => uint256) public stashedColl
```

### P

```solidity
uint256 public P = P_PRECISION
```

### P_PRECISION

```solidity
uint256 public constant P_PRECISION = 1e36
```

### SCALE_FACTOR

```solidity
uint256 public constant SCALE_FACTOR = 1e9
```

### MAX_SCALE_FACTOR_EXPONENT

```solidity
uint256 public constant MAX_SCALE_FACTOR_EXPONENT = 8
```

### SCALE_SPAN

```solidity
uint256 public constant SCALE_SPAN = 2
```

### currentScale

```solidity
uint256 public currentScale
```

### scaleToS

```solidity
mapping(uint256 => uint256) public scaleToS
```

### scaleToB

```solidity
mapping(uint256 => uint256) public scaleToB
```

## Structs

### Deposit

```solidity
struct Deposit {
    uint256 initialValue;
}
```

### Snapshots

```solidity
struct Snapshots {
    uint256 S;
    uint256 P;
    uint256 B;
    uint256 scale;
}
```

## Events

### ActivePoolAddressChanged (inherited from LiquityBase)

```solidity
event ActivePoolAddressChanged(address _newActivePoolAddress);
```

### DefaultPoolAddressChanged (inherited from LiquityBase)

```solidity
event DefaultPoolAddressChanged(address _newDefaultPoolAddress);
```

### PriceFeedAddressChanged (inherited from LiquityBase)

```solidity
event PriceFeedAddressChanged(address _newPriceFeedAddress);
```

### StabilityPoolCollBalanceUpdated (inherited from IStabilityPoolEvents)

```solidity
event StabilityPoolCollBalanceUpdated(uint256 _newBalance);
```

### StabilityPoolBoldBalanceUpdated (inherited from IStabilityPoolEvents)

```solidity
event StabilityPoolBoldBalanceUpdated(uint256 _newBalance);
```

### P_Updated (inherited from IStabilityPoolEvents)

```solidity
event P_Updated(uint256 _P);
```

### S_Updated (inherited from IStabilityPoolEvents)

```solidity
event S_Updated(uint256 _S, uint256 _scale);
```

### B_Updated (inherited from IStabilityPoolEvents)

```solidity
event B_Updated(uint256 _B, uint256 _scale);
```

### ScaleUpdated (inherited from IStabilityPoolEvents)

```solidity
event ScaleUpdated(uint256 _currentScale);
```

### DepositUpdated (inherited from IStabilityPoolEvents)

```solidity
event DepositUpdated(address indexed _depositor, uint256 _newDeposit, uint256 _stashedColl, uint256 _snapshotP, uint256 _snapshotS, uint256 _snapshotB, uint256 _snapshotScale);
```

### DepositOperation (inherited from IStabilityPoolEvents)

```solidity
event DepositOperation(address indexed _depositor, Operation _operation, uint256 _depositLossSinceLastOperation, int256 _topUpOrWithdrawal, uint256 _yieldGainSinceLastOperation, uint256 _yieldGainClaimed, uint256 _ethGainSinceLastOperation, uint256 _ethGainClaimed);
```

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _newTroveManagerAddress);
```

### BoldTokenAddressChanged

```solidity
event BoldTokenAddressChanged(address _newBoldTokenAddress);
```

## Enums

### Operation (inherited from IStabilityPoolEvents)

```solidity
enum Operation {
    provideToSP,
    withdrawFromSP,
    claimAllCollGains
}
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 9375:375:187
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry) LiquityBase(_addressesRegistry);
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 9830:102:187
- **Details**: [function_getCollBalance.md](./function_getCollBalance.md)

**Signature:**
```solidity
function getCollBalance() override external view returns (uint256);
```

### getTotalBoldDeposits()

- **Signature**: `getTotalBoldDeposits()`
- **Visibility**: external
- **Source Range**: 9938:114:187
- **Details**: [function_getTotalBoldDeposits.md](./function_getTotalBoldDeposits.md)

**Signature:**
```solidity
function getTotalBoldDeposits() override external view returns (uint256);
```

### getYieldGainsOwed()

- **Signature**: `getYieldGainsOwed()`
- **Visibility**: external
- **Source Range**: 10058:108:187
- **Details**: [function_getYieldGainsOwed.md](./function_getYieldGainsOwed.md)

**Signature:**
```solidity
function getYieldGainsOwed() override external view returns (uint256);
```

### getYieldGainsPending()

- **Signature**: `getYieldGainsPending()`
- **Visibility**: external
- **Source Range**: 10172:114:187
- **Details**: [function_getYieldGainsPending.md](./function_getYieldGainsPending.md)

**Signature:**
```solidity
function getYieldGainsPending() override external view returns (uint256);
```

### provideToSP(uint256,bool)

- **Signature**: `provideToSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 10587:1582:187
- **Details**: [function_provideToSP_uint256_bool.md](./function_provideToSP_uint256_bool.md)

**Signature:**
```solidity
function provideToSP(uint256 _topUp, bool _doClaim) override external;
```

### withdrawFromSP(uint256,bool)

- **Signature**: `withdrawFromSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 12958:1640:187
- **Details**: [function_withdrawFromSP_uint256_bool.md](./function_withdrawFromSP_uint256_bool.md)

**Signature:**
```solidity
function withdrawFromSP(uint256 _amount, bool _doClaim) override external;
```

### claimAllCollGains()

- **Signature**: `claimAllCollGains()`
- **Visibility**: external
- **Source Range**: 15181:471:187
- **Details**: [function_claimAllCollGains.md](./function_claimAllCollGains.md)

**Signature:**
```solidity
function claimAllCollGains() external;
```

### triggerBoldRewards(uint256)

- **Signature**: `triggerBoldRewards(uint256)`
- **Visibility**: external
- **Source Range**: 15696:146:187
- **Details**: [function_triggerBoldRewards_uint256.md](./function_triggerBoldRewards_uint256.md)

**Signature:**
```solidity
function triggerBoldRewards(uint256 _boldYield) external;
```

### offset(uint256,uint256)

- **Signature**: `offset(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 16893:1875:187
- **Details**: [function_offset_uint256_uint256.md](./function_offset_uint256_uint256.md)

**Signature:**
```solidity
function offset(uint256 _debtToOffset, uint256 _collToAdd) override external;
```

### getDepositorCollGain(address)

- **Signature**: `getDepositorCollGain(address)`
- **Visibility**: public
- **Source Range**: 20149:796:187
- **Details**: [function_getDepositorCollGain_address.md](./function_getDepositorCollGain_address.md)

**Signature:**
```solidity
function getDepositorCollGain(address _depositor) override public view returns (uint256);
```

### getDepositorYieldGain(address)

- **Signature**: `getDepositorYieldGain(address)`
- **Visibility**: public
- **Source Range**: 20951:802:187
- **Details**: [function_getDepositorYieldGain_address.md](./function_getDepositorYieldGain_address.md)

**Signature:**
```solidity
function getDepositorYieldGain(address _depositor) override public view returns (uint256);
```

### getDepositorYieldGainWithPending(address)

- **Signature**: `getDepositorYieldGainWithPending(address)`
- **Visibility**: external
- **Source Range**: 21759:1259:187
- **Details**: [function_getDepositorYieldGainWithPending_address.md](./function_getDepositorYieldGainWithPending_address.md)

**Signature:**
```solidity
function getDepositorYieldGainWithPending(address _depositor) override external view returns (uint256);
```

### getCompoundedBoldDeposit(address)

- **Signature**: `getCompoundedBoldDeposit(address)`
- **Visibility**: public
- **Source Range**: 23059:899:187
- **Details**: [function_getCompoundedBoldDeposit_address.md](./function_getCompoundedBoldDeposit_address.md)

**Signature:**
```solidity
function getCompoundedBoldDeposit(address _depositor) override public view returns (uint256 compoundedDeposit);
```

### getEntireBranchColl() (inherited from LiquityBase)

- **Signature**: `getEntireBranchColl()`
- **Visibility**: public
- **Source Range**: 1265:251:136
- **Details**: [function_getEntireBranchColl.md](./function_getEntireBranchColl.md)

**Signature:**
```solidity
function getEntireBranchColl() public view returns (uint256 entireSystemColl);
```

### getEntireBranchDebt() (inherited from LiquityBase)

- **Signature**: `getEntireBranchDebt()`
- **Visibility**: public
- **Source Range**: 1522:237:136
- **Details**: [function_getEntireBranchDebt.md](./function_getEntireBranchDebt.md)

**Signature:**
```solidity
function getEntireBranchDebt() public view returns (uint256 entireSystemDebt);
```
