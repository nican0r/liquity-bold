# Contract: CryticToFoundry

## Metadata

- **Name**: CryticToFoundry
- **Type**: Contract
- **Path**: test/recon/CryticToFoundry.sol

## State Variables

### _actor (inherited from ActorManager)

```solidity
/// @notice The current actor being used
address private _actor
```

### _actors (inherited from ActorManager)

```solidity
/// @notice The list of all actors being used
EnumerableSet.AddressSet private _actors
```

### __asset (inherited from AssetManager)

```solidity
/// @notice The current target for this set of variables
address private __asset
```

### _assets (inherited from AssetManager)

```solidity
/// @notice The list of all assets being used
EnumerableSet.AddressSet private _assets
```

### DECIMALS (inherited from Setup)

```solidity
uint256 internal constant DECIMALS = 18
```

### CCR (inherited from Setup)

```solidity
uint256 internal constant CCR = 150e16
```

### MCR (inherited from Setup)

```solidity
uint256 internal constant MCR = 110e16
```

### BCR (inherited from Setup)

```solidity
uint256 internal constant BCR = 10e16
```

### SCR (inherited from Setup)

```solidity
uint256 internal constant SCR = 110e16
```

### LIQUIDATION_PENALTY_SP (inherited from Setup)

```solidity
uint256 internal constant LIQUIDATION_PENALTY_SP = 5e16
```

### LIQUIDATION_PENALTY_REDISTRIBUTION (inherited from Setup)

```solidity
uint256 internal constant LIQUIDATION_PENALTY_REDISTRIBUTION = 10e16
```

### addressesRegistry (inherited from Setup)

```solidity
AddressesRegistry internal addressesRegistry
```

**AddressesRegistry**: [src/AddressesRegistry.sol/contract_AddressesRegistry.md]

### activePool (inherited from Setup)

```solidity
ActivePool internal activePool
```

**ActivePool**: [src/ActivePool.sol/contract_ActivePool.md]

### boldToken (inherited from Setup)

```solidity
BoldToken internal boldToken
```

**BoldToken**: [src/BoldToken.sol/contract_BoldToken.md]

### borrowerOperations (inherited from Setup)

```solidity
BorrowerOperationsTester internal borrowerOperations
```

**BorrowerOperationsTester**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

### collSurplusPool (inherited from Setup)

```solidity
CollSurplusPool internal collSurplusPool
```

**CollSurplusPool**: [src/CollSurplusPool.sol/contract_CollSurplusPool.md]

### collateralRegistry (inherited from Setup)

```solidity
CollateralRegistry internal collateralRegistry
```

**CollateralRegistry**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

### defaultPool (inherited from Setup)

```solidity
DefaultPool internal defaultPool
```

**DefaultPool**: [src/DefaultPool.sol/contract_DefaultPool.md]

### gasPool (inherited from Setup)

```solidity
GasPool internal gasPool
```

**GasPool**: [src/GasPool.sol/contract_GasPool.md]

### sortedTroves (inherited from Setup)

```solidity
SortedTroves internal sortedTroves
```

**SortedTroves**: [src/SortedTroves.sol/contract_SortedTroves.md]

### stabilityPool (inherited from Setup)

```solidity
StabilityPool internal stabilityPool
```

**StabilityPool**: [src/StabilityPool.sol/contract_StabilityPool.md]

### troveManager (inherited from Setup)

```solidity
TroveManagerTester internal troveManager
```

**TroveManagerTester**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

### troveNFT (inherited from Setup)

```solidity
TroveNFT internal troveNFT
```

**TroveNFT**: [src/TroveNFT.sol/contract_TroveNFT.md]

### metadataNFT (inherited from Setup)

```solidity
MetadataNFT internal metadataNFT
```

**MetadataNFT**: [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]

### hintHelpers (inherited from Setup)

```solidity
HintHelpers internal hintHelpers
```

**HintHelpers**: [src/HintHelpers.sol/contract_HintHelpers.md]

### multiTroveGetter (inherited from Setup)

```solidity
MultiTroveGetter internal multiTroveGetter
```

**MultiTroveGetter**: [src/MultiTroveGetter.sol/contract_MultiTroveGetter.md]

### priceFeed (inherited from Setup)

```solidity
PriceFeedTestnet internal priceFeed
```

**PriceFeedTestnet**: [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]

### interestRouter (inherited from Setup)

```solidity
MockInterestRouter internal interestRouter
```

**MockInterestRouter**: [test/TestContracts/MockInterestRouter.sol/contract_MockInterestRouter.md]

### collToken (inherited from Setup)

```solidity
WETHTester internal collToken
```

**WETHTester**: [test/TestContracts/WETHTester.sol/contract_WETHTester.md]

### _before (inherited from BeforeAfter)

```solidity
Vars internal _before
```

### _after (inherited from BeforeAfter)

```solidity
Vars internal _after
```

### VM_ADDRESS (inherited from CommonBase)

```solidity
address internal constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))))
```

### CONSOLE (inherited from CommonBase)

```solidity
address internal constant CONSOLE = 0x000000000000000000636F6e736F6c652e6c6f67
```

### CREATE2_FACTORY (inherited from CommonBase)

```solidity
address internal constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### DEFAULT_SENDER (inherited from CommonBase)

```solidity
address internal constant DEFAULT_SENDER = address(uint160(uint256(keccak256("foundry default caller"))))
```

### DEFAULT_TEST_CONTRACT (inherited from CommonBase)

```solidity
address internal constant DEFAULT_TEST_CONTRACT = 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
```

### MULTICALL3_ADDRESS (inherited from CommonBase)

```solidity
address internal constant MULTICALL3_ADDRESS = 0xcA11bde05977b3631167028862bE2a173976CA11
```

### SECP256K1_ORDER (inherited from CommonBase)

```solidity
uint256 internal constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from CommonBase)

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### vm (inherited from CommonBase)

```solidity
Vm internal constant vm = Vm(VM_ADDRESS)
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### stdstore (inherited from CommonBase)

```solidity
StdStorage internal stdstore
```

### vm (inherited from StdAssertions)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### _failed (inherited from StdAssertions)

```solidity
bool private _failed
```

### vm (inherited from StdChains)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### stdChainsInitialized (inherited from StdChains)

```solidity
bool private stdChainsInitialized
```

### chains (inherited from StdChains)

```solidity
mapping(string => Chain) private chains
```

### defaultRpcUrls (inherited from StdChains)

```solidity
mapping(string => string) private defaultRpcUrls
```

### idToAlias (inherited from StdChains)

```solidity
mapping(uint256 => string) private idToAlias
```

### fallbackToDefaultRpcUrls (inherited from StdChains)

```solidity
bool private fallbackToDefaultRpcUrls = true
```

### vm (inherited from StdCheatsSafe)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### UINT256_MAX (inherited from StdCheatsSafe)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### gasMeteringOff (inherited from StdCheatsSafe)

```solidity
bool private gasMeteringOff
```

### stdstore (inherited from StdCheats)

```solidity
StdStorage private stdstore
```

### vm (inherited from StdCheats)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### CONSOLE2_ADDRESS (inherited from StdCheats)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### _excludedContracts (inherited from StdInvariant)

```solidity
address[] private _excludedContracts
```

### _excludedSenders (inherited from StdInvariant)

```solidity
address[] private _excludedSenders
```

### _targetedContracts (inherited from StdInvariant)

```solidity
address[] private _targetedContracts
```

### _targetedSenders (inherited from StdInvariant)

```solidity
address[] private _targetedSenders
```

### _excludedArtifacts (inherited from StdInvariant)

```solidity
string[] private _excludedArtifacts
```

### _targetedArtifacts (inherited from StdInvariant)

```solidity
string[] private _targetedArtifacts
```

### _targetedArtifactSelectors (inherited from StdInvariant)

```solidity
FuzzArtifactSelector[] private _targetedArtifactSelectors
```

### _excludedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _excludedSelectors
```

### _targetedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _targetedSelectors
```

### _targetedInterfaces (inherited from StdInvariant)

```solidity
FuzzInterface[] private _targetedInterfaces
```

### multicall (inherited from StdUtils)

```solidity
IMulticall3 private constant multicall = IMulticall3(0xcA11bde05977b3631167028862bE2a173976CA11)
```

**IMulticall3**: [lib/forge-std/src/interfaces/IMulticall3.sol/interface_IMulticall3.md]

### vm (inherited from StdUtils)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### CONSOLE2_ADDRESS (inherited from StdUtils)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### INT256_MIN_ABS (inherited from StdUtils)

```solidity
uint256 private constant INT256_MIN_ABS = 57896044618658097711785492504343953926634992332820282019728792003956564819968
```

### SECP256K1_ORDER (inherited from StdUtils)

```solidity
uint256 private constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from StdUtils)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### CREATE2_FACTORY (inherited from StdUtils)

```solidity
address private constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### IS_TEST (inherited from Test)

```solidity
bool public IS_TEST = true
```

## Structs

### Vars (inherited from BeforeAfter)

```solidity
struct Vars {
    uint256 __ignore__;
}
```

### ChainData (inherited from StdChains)

```solidity
struct ChainData {
    string name;
    uint256 chainId;
    string rpcUrl;
}
```

### Chain (inherited from StdChains)

```solidity
struct Chain {
    string name;
    uint256 chainId;
    string chainAlias;
    string rpcUrl;
}
```

### RawTx1559 (inherited from StdCheatsSafe)

```solidity
struct RawTx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    RawTx1559Detail txDetail;
    string opcode;
}
```

### RawTx1559Detail (inherited from StdCheatsSafe)

```solidity
struct RawTx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    bytes gas;
    bytes nonce;
    address to;
    bytes txType;
    bytes value;
}
```

### Tx1559 (inherited from StdCheatsSafe)

```solidity
struct Tx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    Tx1559Detail txDetail;
    string opcode;
}
```

### Tx1559Detail (inherited from StdCheatsSafe)

```solidity
struct Tx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    uint256 gas;
    uint256 nonce;
    address to;
    uint256 txType;
    uint256 value;
}
```

### TxLegacy (inherited from StdCheatsSafe)

```solidity
struct TxLegacy {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    string hash;
    string opcode;
    TxDetailLegacy transaction;
}
```

### TxDetailLegacy (inherited from StdCheatsSafe)

```solidity
struct TxDetailLegacy {
    AccessList[] accessList;
    uint256 chainId;
    bytes data;
    address from;
    uint256 gas;
    uint256 gasPrice;
    bytes32 hash;
    uint256 nonce;
    bytes1 opcode;
    bytes32 r;
    bytes32 s;
    uint256 txType;
    address to;
    uint8 v;
    uint256 value;
}
```

### AccessList (inherited from StdCheatsSafe)

```solidity
struct AccessList {
    address accessAddress;
    bytes32[] storageKeys;
}
```

### RawReceipt (inherited from StdCheatsSafe)

```solidity
struct RawReceipt {
    bytes32 blockHash;
    bytes blockNumber;
    address contractAddress;
    bytes cumulativeGasUsed;
    bytes effectiveGasPrice;
    address from;
    bytes gasUsed;
    RawReceiptLog[] logs;
    bytes logsBloom;
    bytes status;
    address to;
    bytes32 transactionHash;
    bytes transactionIndex;
}
```

### Receipt (inherited from StdCheatsSafe)

```solidity
struct Receipt {
    bytes32 blockHash;
    uint256 blockNumber;
    address contractAddress;
    uint256 cumulativeGasUsed;
    uint256 effectiveGasPrice;
    address from;
    uint256 gasUsed;
    ReceiptLog[] logs;
    bytes logsBloom;
    uint256 status;
    address to;
    bytes32 transactionHash;
    uint256 transactionIndex;
}
```

### EIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct EIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    Receipt[] receipts;
    uint256 timestamp;
    Tx1559[] transactions;
    TxReturn[] txReturns;
}
```

### RawEIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct RawEIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    RawReceipt[] receipts;
    TxReturn[] txReturns;
    uint256 timestamp;
    RawTx1559[] transactions;
}
```

### RawReceiptLog (inherited from StdCheatsSafe)

```solidity
struct RawReceiptLog {
    address logAddress;
    bytes32 blockHash;
    bytes blockNumber;
    bytes data;
    bytes logIndex;
    bool removed;
    bytes32[] topics;
    bytes32 transactionHash;
    bytes transactionIndex;
    bytes transactionLogIndex;
}
```

### ReceiptLog (inherited from StdCheatsSafe)

```solidity
struct ReceiptLog {
    address logAddress;
    bytes32 blockHash;
    uint256 blockNumber;
    bytes data;
    uint256 logIndex;
    bytes32[] topics;
    uint256 transactionIndex;
    uint256 transactionLogIndex;
    bool removed;
}
```

### TxReturn (inherited from StdCheatsSafe)

```solidity
struct TxReturn {
    string internalType;
    string value;
}
```

### Account (inherited from StdCheatsSafe)

```solidity
struct Account {
    address addr;
    uint256 key;
}
```

### FuzzSelector (inherited from StdInvariant)

```solidity
struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

### FuzzArtifactSelector (inherited from StdInvariant)

```solidity
struct FuzzArtifactSelector {
    string artifact;
    bytes4[] selectors;
}
```

### FuzzInterface (inherited from StdInvariant)

```solidity
struct FuzzInterface {
    address addr;
    string[] artifacts;
}
```

## Errors

### ActorNotSetup (inherited from ActorManager)

```solidity
error ActorNotSetup();
```

### ActorExists (inherited from ActorManager)

```solidity
error ActorExists();
```

### ActorNotAdded (inherited from ActorManager)

```solidity
error ActorNotAdded();
```

### DefaultActor (inherited from ActorManager)

```solidity
error DefaultActor();
```

### NotSetup (inherited from AssetManager)

```solidity
error NotSetup();
```

### Exists (inherited from AssetManager)

```solidity
error Exists();
```

### NotAdded (inherited from AssetManager)

```solidity
error NotAdded();
```

## Events

### log (inherited from StdAssertions)

```solidity
event log(string);
```

### logs (inherited from StdAssertions)

```solidity
event logs(bytes);
```

### log_address (inherited from StdAssertions)

```solidity
event log_address(address);
```

### log_bytes32 (inherited from StdAssertions)

```solidity
event log_bytes32(bytes32);
```

### log_int (inherited from StdAssertions)

```solidity
event log_int(int256);
```

### log_uint (inherited from StdAssertions)

```solidity
event log_uint(uint256);
```

### log_bytes (inherited from StdAssertions)

```solidity
event log_bytes(bytes);
```

### log_string (inherited from StdAssertions)

```solidity
event log_string(string);
```

### log_named_address (inherited from StdAssertions)

```solidity
event log_named_address(string key, address val);
```

### log_named_bytes32 (inherited from StdAssertions)

```solidity
event log_named_bytes32(string key, bytes32 val);
```

### log_named_decimal_int (inherited from StdAssertions)

```solidity
event log_named_decimal_int(string key, int256 val, uint256 decimals);
```

### log_named_decimal_uint (inherited from StdAssertions)

```solidity
event log_named_decimal_uint(string key, uint256 val, uint256 decimals);
```

### log_named_int (inherited from StdAssertions)

```solidity
event log_named_int(string key, int256 val);
```

### log_named_uint (inherited from StdAssertions)

```solidity
event log_named_uint(string key, uint256 val);
```

### log_named_bytes (inherited from StdAssertions)

```solidity
event log_named_bytes(string key, bytes val);
```

### log_named_string (inherited from StdAssertions)

```solidity
event log_named_string(string key, string val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(uint256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(int256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(address[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, uint256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, int256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, address[] val);
```

## Enums

### AddressType (inherited from StdCheatsSafe)

```solidity
enum AddressType {
    Payable,
    NonPayable,
    ZeroAddress,
    Precompile,
    ForgeAddress
}
```

## Public/External Functions

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 561:88:315
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### test_crytic()

- **Signature**: `test_crytic()`
- **Visibility**: public
- **Source Range**: 703:100:315
- **Details**: [function_test_crytic.md](./function_test_crytic.md)

**Signature:**
```solidity
function test_crytic() public;
```

### test_activePool_accountForReceivedColl()

- **Signature**: `test_activePool_accountForReceivedColl()`
- **Visibility**: public
- **Source Range**: 863:113:315
- **Details**: [function_test_activePool_accountForReceivedColl.md](./function_test_activePool_accountForReceivedColl.md)

**Signature:**
```solidity
function test_activePool_accountForReceivedColl() public;
```

### test_activePool_mintAggInterest()

- **Signature**: `test_activePool_mintAggInterest()`
- **Visibility**: public
- **Source Range**: 982:95:315
- **Details**: [function_test_activePool_mintAggInterest.md](./function_test_activePool_mintAggInterest.md)

**Signature:**
```solidity
function test_activePool_mintAggInterest() public;
```

### test_activePool_mintAggInterestAndAccountForTroveChange()

- **Signature**: `test_activePool_mintAggInterestAndAccountForTroveChange()`
- **Visibility**: public
- **Source Range**: 1083:700:315
- **Details**: [function_test_activePool_mintAggInterestAndAccountForTroveChange.md](./function_test_activePool_mintAggInterestAndAccountForTroveChange.md)

**Signature:**
```solidity
function test_activePool_mintAggInterestAndAccountForTroveChange() public;
```

### test_activePool_mintBatchManagementFeeAndAccountForChange()

- **Signature**: `test_activePool_mintBatchManagementFeeAndAccountForChange()`
- **Visibility**: public
- **Source Range**: 1789:838:315
- **Details**: [function_test_activePool_mintBatchManagementFeeAndAccountForChange.md](./function_test_activePool_mintBatchManagementFeeAndAccountForChange.md)

**Signature:**
```solidity
function test_activePool_mintBatchManagementFeeAndAccountForChange() public;
```

### test_activePool_receiveColl()

- **Signature**: `test_activePool_receiveColl()`
- **Visibility**: public
- **Source Range**: 2633:91:315
- **Details**: [function_test_activePool_receiveColl.md](./function_test_activePool_receiveColl.md)

**Signature:**
```solidity
function test_activePool_receiveColl() public;
```

### test_activePool_sendColl()

- **Signature**: `test_activePool_sendColl()`
- **Visibility**: public
- **Source Range**: 2730:98:315
- **Details**: [function_test_activePool_sendColl.md](./function_test_activePool_sendColl.md)

**Signature:**
```solidity
function test_activePool_sendColl() public;
```

### test_activePool_sendCollToDefaultPool()

- **Signature**: `test_activePool_sendCollToDefaultPool()`
- **Visibility**: public
- **Source Range**: 2834:111:315
- **Details**: [function_test_activePool_sendCollToDefaultPool.md](./function_test_activePool_sendCollToDefaultPool.md)

**Signature:**
```solidity
function test_activePool_sendCollToDefaultPool() public;
```

### test_activePool_setShutdownFlag()

- **Signature**: `test_activePool_setShutdownFlag()`
- **Visibility**: public
- **Source Range**: 2951:95:315
- **Details**: [function_test_activePool_setShutdownFlag.md](./function_test_activePool_setShutdownFlag.md)

**Signature:**
```solidity
function test_activePool_setShutdownFlag() public;
```

### test_boldToken_approve()

- **Signature**: `test_boldToken_approve()`
- **Visibility**: public
- **Source Range**: 3105:101:315
- **Details**: [function_test_boldToken_approve.md](./function_test_boldToken_approve.md)

**Signature:**
```solidity
function test_boldToken_approve() public;
```

### test_boldToken_burn()

- **Signature**: `test_boldToken_burn()`
- **Visibility**: public
- **Source Range**: 3212:205:315
- **Details**: [function_test_boldToken_burn.md](./function_test_boldToken_burn.md)

**Signature:**
```solidity
function test_boldToken_burn() public;
```

### test_boldToken_decreaseAllowance()

- **Signature**: `test_boldToken_decreaseAllowance()`
- **Visibility**: public
- **Source Range**: 3423:232:315
- **Details**: [function_test_boldToken_decreaseAllowance.md](./function_test_boldToken_decreaseAllowance.md)

**Signature:**
```solidity
function test_boldToken_decreaseAllowance() public;
```

### test_boldToken_increaseAllowance()

- **Signature**: `test_boldToken_increaseAllowance()`
- **Visibility**: public
- **Source Range**: 3661:121:315
- **Details**: [function_test_boldToken_increaseAllowance.md](./function_test_boldToken_increaseAllowance.md)

**Signature:**
```solidity
function test_boldToken_increaseAllowance() public;
```

### test_boldToken_mint()

- **Signature**: `test_boldToken_mint()`
- **Visibility**: public
- **Source Range**: 3788:91:315
- **Details**: [function_test_boldToken_mint.md](./function_test_boldToken_mint.md)

**Signature:**
```solidity
function test_boldToken_mint() public;
```

### test_boldToken_permit()

- **Signature**: `test_boldToken_permit()`
- **Visibility**: public
- **Source Range**: 3885:129:315
- **Details**: [function_test_boldToken_permit.md](./function_test_boldToken_permit.md)

**Signature:**
```solidity
function test_boldToken_permit() public;
```

### test_boldToken_returnFromPool()

- **Signature**: `test_boldToken_returnFromPool()`
- **Visibility**: public
- **Source Range**: 4020:282:315
- **Details**: [function_test_boldToken_returnFromPool.md](./function_test_boldToken_returnFromPool.md)

**Signature:**
```solidity
function test_boldToken_returnFromPool() public;
```

### test_boldToken_sendToPool()

- **Signature**: `test_boldToken_sendToPool()`
- **Visibility**: public
- **Source Range**: 4308:127:315
- **Details**: [function_test_boldToken_sendToPool.md](./function_test_boldToken_sendToPool.md)

**Signature:**
```solidity
function test_boldToken_sendToPool() public;
```

### test_boldToken_setBranchAddresses()

- **Signature**: `test_boldToken_setBranchAddresses()`
- **Visibility**: public
- **Source Range**: 4441:252:315
- **Details**: [function_test_boldToken_setBranchAddresses.md](./function_test_boldToken_setBranchAddresses.md)

**Signature:**
```solidity
function test_boldToken_setBranchAddresses() public;
```

### test_boldToken_setCollateralRegistry()

- **Signature**: `test_boldToken_setCollateralRegistry()`
- **Visibility**: public
- **Source Range**: 4699:132:315
- **Details**: [function_test_boldToken_setCollateralRegistry.md](./function_test_boldToken_setCollateralRegistry.md)

**Signature:**
```solidity
function test_boldToken_setCollateralRegistry() public;
```

### test_boldToken_transfer()

- **Signature**: `test_boldToken_transfer()`
- **Visibility**: public
- **Source Range**: 4837:102:315
- **Details**: [function_test_boldToken_transfer.md](./function_test_boldToken_transfer.md)

**Signature:**
```solidity
function test_boldToken_transfer() public;
```

### test_boldToken_transferFrom()

- **Signature**: `test_boldToken_transferFrom()`
- **Visibility**: public
- **Source Range**: 4945:235:315
- **Details**: [function_test_boldToken_transferFrom.md](./function_test_boldToken_transferFrom.md)

**Signature:**
```solidity
function test_boldToken_transferFrom() public;
```

### test_borrowerOperations_addColl()

- **Signature**: `test_borrowerOperations_addColl()`
- **Visibility**: public
- **Source Range**: 5248:441:315
- **Details**: [function_test_borrowerOperations_addColl.md](./function_test_borrowerOperations_addColl.md)

**Signature:**
```solidity
function test_borrowerOperations_addColl() public;
```

### test_borrowerOperations_adjustTrove()

- **Signature**: `test_borrowerOperations_adjustTrove()`
- **Visibility**: public
- **Source Range**: 5695:472:315
- **Details**: [function_test_borrowerOperations_adjustTrove.md](./function_test_borrowerOperations_adjustTrove.md)

**Signature:**
```solidity
function test_borrowerOperations_adjustTrove() public;
```

### test_borrowerOperations_adjustTroveInterestRate()

- **Signature**: `test_borrowerOperations_adjustTroveInterestRate()`
- **Visibility**: public
- **Source Range**: 6173:493:315
- **Details**: [function_test_borrowerOperations_adjustTroveInterestRate.md](./function_test_borrowerOperations_adjustTroveInterestRate.md)

**Signature:**
```solidity
function test_borrowerOperations_adjustTroveInterestRate() public;
```

### test_borrowerOperations_adjustZombieTrove()

- **Signature**: `test_borrowerOperations_adjustZombieTrove()`
- **Visibility**: public
- **Source Range**: 6672:495:315
- **Details**: [function_test_borrowerOperations_adjustZombieTrove.md](./function_test_borrowerOperations_adjustZombieTrove.md)

**Signature:**
```solidity
function test_borrowerOperations_adjustZombieTrove() public;
```

### test_borrowerOperations_applyPendingDebt()

- **Signature**: `test_borrowerOperations_applyPendingDebt()`
- **Visibility**: public
- **Source Range**: 7173:458:315
- **Details**: [function_test_borrowerOperations_applyPendingDebt.md](./function_test_borrowerOperations_applyPendingDebt.md)

**Signature:**
```solidity
function test_borrowerOperations_applyPendingDebt() public;
```

### test_borrowerOperations_claimCollateral()

- **Signature**: `test_borrowerOperations_claimCollateral()`
- **Visibility**: public
- **Source Range**: 7637:111:315
- **Details**: [function_test_borrowerOperations_claimCollateral.md](./function_test_borrowerOperations_claimCollateral.md)

**Signature:**
```solidity
function test_borrowerOperations_claimCollateral() public;
```

### test_borrowerOperations_closeTrove()

- **Signature**: `test_borrowerOperations_closeTrove()`
- **Visibility**: public
- **Source Range**: 7754:437:315
- **Details**: [function_test_borrowerOperations_closeTrove.md](./function_test_borrowerOperations_closeTrove.md)

**Signature:**
```solidity
function test_borrowerOperations_closeTrove() public;
```

### test_borrowerOperations_kickFromBatch()

- **Signature**: `test_borrowerOperations_kickFromBatch()`
- **Visibility**: public
- **Source Range**: 8197:1038:315
- **Details**: [function_test_borrowerOperations_kickFromBatch.md](./function_test_borrowerOperations_kickFromBatch.md)

**Signature:**
```solidity
function test_borrowerOperations_kickFromBatch() public;
```

### test_borrowerOperations_lowerBatchManagementFee()

- **Signature**: `test_borrowerOperations_lowerBatchManagementFee()`
- **Visibility**: public
- **Source Range**: 9241:289:315
- **Details**: [function_test_borrowerOperations_lowerBatchManagementFee.md](./function_test_borrowerOperations_lowerBatchManagementFee.md)

**Signature:**
```solidity
function test_borrowerOperations_lowerBatchManagementFee() public;
```

### test_borrowerOperations_onLiquidateTrove()

- **Signature**: `test_borrowerOperations_onLiquidateTrove()`
- **Visibility**: public
- **Source Range**: 9536:463:315
- **Details**: [function_test_borrowerOperations_onLiquidateTrove.md](./function_test_borrowerOperations_onLiquidateTrove.md)

**Signature:**
```solidity
function test_borrowerOperations_onLiquidateTrove() public;
```

### test_borrowerOperations_openTrove()

- **Signature**: `test_borrowerOperations_openTrove()`
- **Visibility**: public
- **Source Range**: 10005:328:315
- **Details**: [function_test_borrowerOperations_openTrove.md](./function_test_borrowerOperations_openTrove.md)

**Signature:**
```solidity
function test_borrowerOperations_openTrove() public;
```

### test_borrowerOperations_openTroveAndJoinInterestBatchManager()

- **Signature**: `test_borrowerOperations_openTroveAndJoinInterestBatchManager()`
- **Visibility**: public
- **Source Range**: 10339:937:315
- **Details**: [function_test_borrowerOperations_openTroveAndJoinInterestBatchManager.md](./function_test_borrowerOperations_openTroveAndJoinInterestBatchManager.md)

**Signature:**
```solidity
function test_borrowerOperations_openTroveAndJoinInterestBatchManager() public;
```

### test_borrowerOperations_registerBatchManager()

- **Signature**: `test_borrowerOperations_registerBatchManager()`
- **Visibility**: public
- **Source Range**: 11282:152:315
- **Details**: [function_test_borrowerOperations_registerBatchManager.md](./function_test_borrowerOperations_registerBatchManager.md)

**Signature:**
```solidity
function test_borrowerOperations_registerBatchManager() public;
```

### test_borrowerOperations_removeFromBatch()

- **Signature**: `test_borrowerOperations_removeFromBatch()`
- **Visibility**: public
- **Source Range**: 11440:1058:315
- **Details**: [function_test_borrowerOperations_removeFromBatch.md](./function_test_borrowerOperations_removeFromBatch.md)

**Signature:**
```solidity
function test_borrowerOperations_removeFromBatch() public;
```

### test_borrowerOperations_removeInterestIndividualDelegate()

- **Signature**: `test_borrowerOperations_removeInterestIndividualDelegate()`
- **Visibility**: public
- **Source Range**: 12504:751:315
- **Details**: [function_test_borrowerOperations_removeInterestIndividualDelegate.md](./function_test_borrowerOperations_removeInterestIndividualDelegate.md)

**Signature:**
```solidity
function test_borrowerOperations_removeInterestIndividualDelegate() public;
```

### test_borrowerOperations_repayBold()

- **Signature**: `test_borrowerOperations_repayBold()`
- **Visibility**: public
- **Source Range**: 13261:529:315
- **Details**: [function_test_borrowerOperations_repayBold.md](./function_test_borrowerOperations_repayBold.md)

**Signature:**
```solidity
function test_borrowerOperations_repayBold() public;
```

### test_borrowerOperations_setAddManager()

- **Signature**: `test_borrowerOperations_setAddManager()`
- **Visibility**: public
- **Source Range**: 13796:460:315
- **Details**: [function_test_borrowerOperations_setAddManager.md](./function_test_borrowerOperations_setAddManager.md)

**Signature:**
```solidity
function test_borrowerOperations_setAddManager() public;
```

### test_borrowerOperations_setBatchManagerAnnualInterestRate()

- **Signature**: `test_borrowerOperations_setBatchManagerAnnualInterestRate()`
- **Visibility**: public
- **Source Range**: 14262:331:315
- **Details**: [function_test_borrowerOperations_setBatchManagerAnnualInterestRate.md](./function_test_borrowerOperations_setBatchManagerAnnualInterestRate.md)

**Signature:**
```solidity
function test_borrowerOperations_setBatchManagerAnnualInterestRate() public;
```

### test_borrowerOperations_setInterestBatchManager()

- **Signature**: `test_borrowerOperations_setInterestBatchManager()`
- **Visibility**: public
- **Source Range**: 14599:728:315
- **Details**: [function_test_borrowerOperations_setInterestBatchManager.md](./function_test_borrowerOperations_setInterestBatchManager.md)

**Signature:**
```solidity
function test_borrowerOperations_setInterestBatchManager() public;
```

### test_borrowerOperations_setInterestIndividualDelegate()

- **Signature**: `test_borrowerOperations_setInterestIndividualDelegate()`
- **Visibility**: public
- **Source Range**: 15333:648:315
- **Details**: [function_test_borrowerOperations_setInterestIndividualDelegate.md](./function_test_borrowerOperations_setInterestIndividualDelegate.md)

**Signature:**
```solidity
function test_borrowerOperations_setInterestIndividualDelegate() public;
```

### test_borrowerOperations_setRemoveManager()

- **Signature**: `test_borrowerOperations_setRemoveManager()`
- **Visibility**: public
- **Source Range**: 15987:469:315
- **Details**: [function_test_borrowerOperations_setRemoveManager.md](./function_test_borrowerOperations_setRemoveManager.md)

**Signature:**
```solidity
function test_borrowerOperations_setRemoveManager() public;
```

### test_borrowerOperations_setRemoveManagerWithReceiver()

- **Signature**: `test_borrowerOperations_setRemoveManagerWithReceiver()`
- **Visibility**: public
- **Source Range**: 16462:524:315
- **Details**: [function_test_borrowerOperations_setRemoveManagerWithReceiver.md](./function_test_borrowerOperations_setRemoveManagerWithReceiver.md)

**Signature:**
```solidity
function test_borrowerOperations_setRemoveManagerWithReceiver() public;
```

### test_borrowerOperations_shutdown()

- **Signature**: `test_borrowerOperations_shutdown()`
- **Visibility**: public
- **Source Range**: 16992:97:315
- **Details**: [function_test_borrowerOperations_shutdown.md](./function_test_borrowerOperations_shutdown.md)

**Signature:**
```solidity
function test_borrowerOperations_shutdown() public;
```

### test_borrowerOperations_shutdownFromOracleFailure()

- **Signature**: `test_borrowerOperations_shutdownFromOracleFailure()`
- **Visibility**: public
- **Source Range**: 17095:131:315
- **Details**: [function_test_borrowerOperations_shutdownFromOracleFailure.md](./function_test_borrowerOperations_shutdownFromOracleFailure.md)

**Signature:**
```solidity
function test_borrowerOperations_shutdownFromOracleFailure() public;
```

### test_borrowerOperations_switchBatchManager()

- **Signature**: `test_borrowerOperations_switchBatchManager()`
- **Visibility**: public
- **Source Range**: 17232:1304:315
- **Details**: [function_test_borrowerOperations_switchBatchManager.md](./function_test_borrowerOperations_switchBatchManager.md)

**Signature:**
```solidity
function test_borrowerOperations_switchBatchManager() public;
```

### test_borrowerOperations_withdrawBold()

- **Signature**: `test_borrowerOperations_withdrawBold()`
- **Visibility**: public
- **Source Range**: 18542:455:315
- **Details**: [function_test_borrowerOperations_withdrawBold.md](./function_test_borrowerOperations_withdrawBold.md)

**Signature:**
```solidity
function test_borrowerOperations_withdrawBold() public;
```

### test_borrowerOperations_withdrawColl()

- **Signature**: `test_borrowerOperations_withdrawColl()`
- **Visibility**: public
- **Source Range**: 19003:451:315
- **Details**: [function_test_borrowerOperations_withdrawColl.md](./function_test_borrowerOperations_withdrawColl.md)

**Signature:**
```solidity
function test_borrowerOperations_withdrawColl() public;
```

### test_collSurplusPool_accountSurplus()

- **Signature**: `test_collSurplusPool_accountSurplus()`
- **Visibility**: public
- **Source Range**: 19519:120:315
- **Details**: [function_test_collSurplusPool_accountSurplus.md](./function_test_collSurplusPool_accountSurplus.md)

**Signature:**
```solidity
function test_collSurplusPool_accountSurplus() public;
```

### test_collSurplusPool_claimColl()

- **Signature**: `test_collSurplusPool_claimColl()`
- **Visibility**: public
- **Source Range**: 19645:227:315
- **Details**: [function_test_collSurplusPool_claimColl.md](./function_test_collSurplusPool_claimColl.md)

**Signature:**
```solidity
function test_collSurplusPool_claimColl() public;
```

### test_collateralRegistry_redeemCollateral()

- **Signature**: `test_collateralRegistry_redeemCollateral()`
- **Visibility**: public
- **Source Range**: 19940:466:315
- **Details**: [function_test_collateralRegistry_redeemCollateral.md](./function_test_collateralRegistry_redeemCollateral.md)

**Signature:**
```solidity
function test_collateralRegistry_redeemCollateral() public;
```

### test_defaultPool_decreaseBoldDebt()

- **Signature**: `test_defaultPool_decreaseBoldDebt()`
- **Visibility**: public
- **Source Range**: 20467:220:315
- **Details**: [function_test_defaultPool_decreaseBoldDebt.md](./function_test_defaultPool_decreaseBoldDebt.md)

**Signature:**
```solidity
function test_defaultPool_decreaseBoldDebt() public;
```

### test_defaultPool_increaseBoldDebt()

- **Signature**: `test_defaultPool_increaseBoldDebt()`
- **Visibility**: public
- **Source Range**: 20693:106:315
- **Details**: [function_test_defaultPool_increaseBoldDebt.md](./function_test_defaultPool_increaseBoldDebt.md)

**Signature:**
```solidity
function test_defaultPool_increaseBoldDebt() public;
```

### test_defaultPool_receiveColl()

- **Signature**: `test_defaultPool_receiveColl()`
- **Visibility**: public
- **Source Range**: 20805:93:315
- **Details**: [function_test_defaultPool_receiveColl.md](./function_test_defaultPool_receiveColl.md)

**Signature:**
```solidity
function test_defaultPool_receiveColl() public;
```

### test_defaultPool_sendCollToActivePool()

- **Signature**: `test_defaultPool_sendCollToActivePool()`
- **Visibility**: public
- **Source Range**: 20904:221:315
- **Details**: [function_test_defaultPool_sendCollToActivePool.md](./function_test_defaultPool_sendCollToActivePool.md)

**Signature:**
```solidity
function test_defaultPool_sendCollToActivePool() public;
```

### test_sortedTroves_insert()

- **Signature**: `test_sortedTroves_insert()`
- **Visibility**: public
- **Source Range**: 21187:94:315
- **Details**: [function_test_sortedTroves_insert.md](./function_test_sortedTroves_insert.md)

**Signature:**
```solidity
function test_sortedTroves_insert() public;
```

### test_sortedTroves_insertIntoBatch()

- **Signature**: `test_sortedTroves_insertIntoBatch()`
- **Visibility**: public
- **Source Range**: 21287:372:315
- **Details**: [function_test_sortedTroves_insertIntoBatch.md](./function_test_sortedTroves_insertIntoBatch.md)

**Signature:**
```solidity
function test_sortedTroves_insertIntoBatch() public;
```

### test_sortedTroves_reInsert()

- **Signature**: `test_sortedTroves_reInsert()`
- **Visibility**: public
- **Source Range**: 21665:214:315
- **Details**: [function_test_sortedTroves_reInsert.md](./function_test_sortedTroves_reInsert.md)

**Signature:**
```solidity
function test_sortedTroves_reInsert() public;
```

### test_sortedTroves_reInsertBatch()

- **Signature**: `test_sortedTroves_reInsertBatch()`
- **Visibility**: public
- **Source Range**: 21885:376:315
- **Details**: [function_test_sortedTroves_reInsertBatch.md](./function_test_sortedTroves_reInsertBatch.md)

**Signature:**
```solidity
function test_sortedTroves_reInsertBatch() public;
```

### test_sortedTroves_remove()

- **Signature**: `test_sortedTroves_remove()`
- **Visibility**: public
- **Source Range**: 22267:182:315
- **Details**: [function_test_sortedTroves_remove.md](./function_test_sortedTroves_remove.md)

**Signature:**
```solidity
function test_sortedTroves_remove() public;
```

### test_sortedTroves_removeFromBatch()

- **Signature**: `test_sortedTroves_removeFromBatch()`
- **Visibility**: public
- **Source Range**: 22455:404:315
- **Details**: [function_test_sortedTroves_removeFromBatch.md](./function_test_sortedTroves_removeFromBatch.md)

**Signature:**
```solidity
function test_sortedTroves_removeFromBatch() public;
```

### test_stabilityPool_claimAllCollGains()

- **Signature**: `test_stabilityPool_claimAllCollGains()`
- **Visibility**: public
- **Source Range**: 22922:219:315
- **Details**: [function_test_stabilityPool_claimAllCollGains.md](./function_test_stabilityPool_claimAllCollGains.md)

**Signature:**
```solidity
function test_stabilityPool_claimAllCollGains() public;
```

### test_stabilityPool_offset()

- **Signature**: `test_stabilityPool_offset()`
- **Visibility**: public
- **Source Range**: 23147:204:315
- **Details**: [function_test_stabilityPool_offset.md](./function_test_stabilityPool_offset.md)

**Signature:**
```solidity
function test_stabilityPool_offset() public;
```

### test_stabilityPool_provideToSP()

- **Signature**: `test_stabilityPool_provideToSP()`
- **Visibility**: public
- **Source Range**: 23357:107:315
- **Details**: [function_test_stabilityPool_provideToSP.md](./function_test_stabilityPool_provideToSP.md)

**Signature:**
```solidity
function test_stabilityPool_provideToSP() public;
```

### test_stabilityPool_triggerBoldRewards()

- **Signature**: `test_stabilityPool_triggerBoldRewards()`
- **Visibility**: public
- **Source Range**: 23470:113:315
- **Details**: [function_test_stabilityPool_triggerBoldRewards.md](./function_test_stabilityPool_triggerBoldRewards.md)

**Signature:**
```solidity
function test_stabilityPool_triggerBoldRewards() public;
```

### test_stabilityPool_withdrawFromSP()

- **Signature**: `test_stabilityPool_withdrawFromSP()`
- **Visibility**: public
- **Source Range**: 23589:228:315
- **Details**: [function_test_stabilityPool_withdrawFromSP.md](./function_test_stabilityPool_withdrawFromSP.md)

**Signature:**
```solidity
function test_stabilityPool_withdrawFromSP() public;
```

### test_troveManager_batchLiquidateTroves()

- **Signature**: `test_troveManager_batchLiquidateTroves()`
- **Visibility**: public
- **Source Range**: 23879:578:315
- **Details**: [function_test_troveManager_batchLiquidateTroves.md](./function_test_troveManager_batchLiquidateTroves.md)

**Signature:**
```solidity
function test_troveManager_batchLiquidateTroves() public;
```

### test_troveManager_getUnbackedPortionPriceAndRedeemability()

- **Signature**: `test_troveManager_getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: public
- **Source Range**: 24463:147:315
- **Details**: [function_test_troveManager_getUnbackedPortionPriceAndRedeemability.md](./function_test_troveManager_getUnbackedPortionPriceAndRedeemability.md)

**Signature:**
```solidity
function test_troveManager_getUnbackedPortionPriceAndRedeemability() public;
```

### test_troveManager_onAdjustTrove()

- **Signature**: `test_troveManager_onAdjustTrove()`
- **Visibility**: public
- **Source Range**: 24616:659:315
- **Details**: [function_test_troveManager_onAdjustTrove.md](./function_test_troveManager_onAdjustTrove.md)

**Signature:**
```solidity
function test_troveManager_onAdjustTrove() public;
```

### test_troveManager_onAdjustTroveInsideBatch()

- **Signature**: `test_troveManager_onAdjustTroveInsideBatch()`
- **Visibility**: public
- **Source Range**: 25281:710:315
- **Details**: [function_test_troveManager_onAdjustTroveInsideBatch.md](./function_test_troveManager_onAdjustTroveInsideBatch.md)

**Signature:**
```solidity
function test_troveManager_onAdjustTroveInsideBatch() public;
```

### test_troveManager_onAdjustTroveInterestRate()

- **Signature**: `test_troveManager_onAdjustTroveInterestRate()`
- **Visibility**: public
- **Source Range**: 25997:686:315
- **Details**: [function_test_troveManager_onAdjustTroveInterestRate.md](./function_test_troveManager_onAdjustTroveInterestRate.md)

**Signature:**
```solidity
function test_troveManager_onAdjustTroveInterestRate() public;
```

### test_troveManager_onApplyTroveInterest()

- **Signature**: `test_troveManager_onApplyTroveInterest()`
- **Visibility**: public
- **Source Range**: 26689:693:315
- **Details**: [function_test_troveManager_onApplyTroveInterest.md](./function_test_troveManager_onApplyTroveInterest.md)

**Signature:**
```solidity
function test_troveManager_onApplyTroveInterest() public;
```

### test_troveManager_onCloseTrove()

- **Signature**: `test_troveManager_onCloseTrove()`
- **Visibility**: public
- **Source Range**: 27388:660:315
- **Details**: [function_test_troveManager_onCloseTrove.md](./function_test_troveManager_onCloseTrove.md)

**Signature:**
```solidity
function test_troveManager_onCloseTrove() public;
```

### test_troveManager_onLowerBatchManagerAnnualFee()

- **Signature**: `test_troveManager_onLowerBatchManagerAnnualFee()`
- **Visibility**: public
- **Source Range**: 28054:158:315
- **Details**: [function_test_troveManager_onLowerBatchManagerAnnualFee.md](./function_test_troveManager_onLowerBatchManagerAnnualFee.md)

**Signature:**
```solidity
function test_troveManager_onLowerBatchManagerAnnualFee() public;
```

### test_troveManager_onOpenTrove()

- **Signature**: `test_troveManager_onOpenTrove()`
- **Visibility**: public
- **Source Range**: 28218:659:315
- **Details**: [function_test_troveManager_onOpenTrove.md](./function_test_troveManager_onOpenTrove.md)

**Signature:**
```solidity
function test_troveManager_onOpenTrove() public;
```

### test_troveManager_onOpenTroveAndJoinBatch()

- **Signature**: `test_troveManager_onOpenTroveAndJoinBatch()`
- **Visibility**: public
- **Source Range**: 28883:706:315
- **Details**: [function_test_troveManager_onOpenTroveAndJoinBatch.md](./function_test_troveManager_onOpenTroveAndJoinBatch.md)

**Signature:**
```solidity
function test_troveManager_onOpenTroveAndJoinBatch() public;
```

### test_troveManager_onRegisterBatchManager()

- **Signature**: `test_troveManager_onRegisterBatchManager()`
- **Visibility**: public
- **Source Range**: 29595:136:315
- **Details**: [function_test_troveManager_onRegisterBatchManager.md](./function_test_troveManager_onRegisterBatchManager.md)

**Signature:**
```solidity
function test_troveManager_onRegisterBatchManager() public;
```

### test_troveManager_onRemoveFromBatch()

- **Signature**: `test_troveManager_onRemoveFromBatch()`
- **Visibility**: public
- **Source Range**: 29737:689:315
- **Details**: [function_test_troveManager_onRemoveFromBatch.md](./function_test_troveManager_onRemoveFromBatch.md)

**Signature:**
```solidity
function test_troveManager_onRemoveFromBatch() public;
```

### test_troveManager_onSetBatchManagerAnnualInterestRate()

- **Signature**: `test_troveManager_onSetBatchManagerAnnualInterestRate()`
- **Visibility**: public
- **Source Range**: 30432:179:315
- **Details**: [function_test_troveManager_onSetBatchManagerAnnualInterestRate.md](./function_test_troveManager_onSetBatchManagerAnnualInterestRate.md)

**Signature:**
```solidity
function test_troveManager_onSetBatchManagerAnnualInterestRate() public;
```

### test_troveManager_onSetInterestBatchManager()

- **Signature**: `test_troveManager_onSetInterestBatchManager()`
- **Visibility**: public
- **Source Range**: 30617:1017:315
- **Details**: [function_test_troveManager_onSetInterestBatchManager.md](./function_test_troveManager_onSetInterestBatchManager.md)

**Signature:**
```solidity
function test_troveManager_onSetInterestBatchManager() public;
```

### test_troveManager_redeemCollateral()

- **Signature**: `test_troveManager_redeemCollateral()`
- **Visibility**: public
- **Source Range**: 31640:139:315
- **Details**: [function_test_troveManager_redeemCollateral.md](./function_test_troveManager_redeemCollateral.md)

**Signature:**
```solidity
function test_troveManager_redeemCollateral() public;
```

### test_troveManager_setTroveStatusToActive()

- **Signature**: `test_troveManager_setTroveStatusToActive()`
- **Visibility**: public
- **Source Range**: 31785:114:315
- **Details**: [function_test_troveManager_setTroveStatusToActive.md](./function_test_troveManager_setTroveStatusToActive.md)

**Signature:**
```solidity
function test_troveManager_setTroveStatusToActive() public;
```

### test_troveManager_shutdown()

- **Signature**: `test_troveManager_shutdown()`
- **Visibility**: public
- **Source Range**: 31905:85:315
- **Details**: [function_test_troveManager_shutdown.md](./function_test_troveManager_shutdown.md)

**Signature:**
```solidity
function test_troveManager_shutdown() public;
```

### test_troveManager_urgentRedemption()

- **Signature**: `test_troveManager_urgentRedemption()`
- **Visibility**: public
- **Source Range**: 31996:654:315
- **Details**: [function_test_troveManager_urgentRedemption.md](./function_test_troveManager_urgentRedemption.md)

**Signature:**
```solidity
function test_troveManager_urgentRedemption() public;
```

### test_troveNFT_approve()

- **Signature**: `test_troveNFT_approve()`
- **Visibility**: public
- **Source Range**: 32708:189:315
- **Details**: [function_test_troveNFT_approve.md](./function_test_troveNFT_approve.md)

**Signature:**
```solidity
function test_troveNFT_approve() public;
```

### test_troveNFT_burn()

- **Signature**: `test_troveNFT_burn()`
- **Visibility**: public
- **Source Range**: 32903:166:315
- **Details**: [function_test_troveNFT_burn.md](./function_test_troveNFT_burn.md)

**Signature:**
```solidity
function test_troveNFT_burn() public;
```

### test_troveNFT_mint()

- **Signature**: `test_troveNFT_mint()`
- **Visibility**: public
- **Source Range**: 33075:83:315
- **Details**: [function_test_troveNFT_mint.md](./function_test_troveNFT_mint.md)

**Signature:**
```solidity
function test_troveNFT_mint() public;
```

### test_troveNFT_safeTransferFrom()

- **Signature**: `test_troveNFT_safeTransferFrom()`
- **Visibility**: public
- **Source Range**: 33164:224:315
- **Details**: [function_test_troveNFT_safeTransferFrom.md](./function_test_troveNFT_safeTransferFrom.md)

**Signature:**
```solidity
function test_troveNFT_safeTransferFrom() public;
```

### test_troveNFT_setApprovalForAll()

- **Signature**: `test_troveNFT_setApprovalForAll()`
- **Visibility**: public
- **Source Range**: 33394:116:315
- **Details**: [function_test_troveNFT_setApprovalForAll.md](./function_test_troveNFT_setApprovalForAll.md)

**Signature:**
```solidity
function test_troveNFT_setApprovalForAll() public;
```

### test_troveNFT_transferFrom()

- **Signature**: `test_troveNFT_transferFrom()`
- **Visibility**: public
- **Source Range**: 33516:216:315
- **Details**: [function_test_troveNFT_transferFrom.md](./function_test_troveNFT_transferFrom.md)

**Signature:**
```solidity
function test_troveNFT_transferFrom() public;
```

### failed() (inherited from StdAssertions)

- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1243:204:48
- **Details**: [function_failed.md](./function_failed.md)

**Signature:**
```solidity
function failed() public view returns (bool);
```

### excludeArtifacts() (inherited from StdInvariant)

- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2459:141:52
- **Details**: [function_excludeArtifacts.md](./function_excludeArtifacts.md)

**Signature:**
```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_);
```

### excludeContracts() (inherited from StdInvariant)

- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:52
- **Details**: [function_excludeContracts.md](./function_excludeContracts.md)

**Signature:**
```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_);
```

### excludeSelectors() (inherited from StdInvariant)

- **Signature**: `excludeSelectors()`
- **Visibility**: public
- **Source Range**: 2754:147:52
- **Details**: [function_excludeSelectors.md](./function_excludeSelectors.md)

**Signature:**
```solidity
function excludeSelectors() public view returns (FuzzSelector[] memory excludedSelectors_);
```

### excludeSenders() (inherited from StdInvariant)

- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2907:134:52
- **Details**: [function_excludeSenders.md](./function_excludeSenders.md)

**Signature:**
```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_);
```

### targetArtifacts() (inherited from StdInvariant)

- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 3047:140:52
- **Details**: [function_targetArtifacts.md](./function_targetArtifacts.md)

**Signature:**
```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_);
```

### targetArtifactSelectors() (inherited from StdInvariant)

- **Signature**: `targetArtifactSelectors()`
- **Visibility**: public
- **Source Range**: 3193:186:52
- **Details**: [function_targetArtifactSelectors.md](./function_targetArtifactSelectors.md)

**Signature:**
```solidity
function targetArtifactSelectors() public view returns (FuzzArtifactSelector[] memory targetedArtifactSelectors_);
```

### targetContracts() (inherited from StdInvariant)

- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 3385:141:52
- **Details**: [function_targetContracts.md](./function_targetContracts.md)

**Signature:**
```solidity
function targetContracts() public view returns (address[] memory targetedContracts_);
```

### targetSelectors() (inherited from StdInvariant)

- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3532:146:52
- **Details**: [function_targetSelectors.md](./function_targetSelectors.md)

**Signature:**
```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_);
```

### targetSenders() (inherited from StdInvariant)

- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3684:133:52
- **Details**: [function_targetSenders.md](./function_targetSenders.md)

**Signature:**
```solidity
function targetSenders() public view returns (address[] memory targetedSenders_);
```

### targetInterfaces() (inherited from StdInvariant)

- **Signature**: `targetInterfaces()`
- **Visibility**: public
- **Source Range**: 3823:151:52
- **Details**: [function_targetInterfaces.md](./function_targetInterfaces.md)

**Signature:**
```solidity
function targetInterfaces() public view returns (FuzzInterface[] memory targetedInterfaces_);
```

### activePool_accountForReceivedColl(uint256) (inherited from AdminTargets)

- **Signature**: `activePool_accountForReceivedColl(uint256)`
- **Visibility**: public
- **Source Range**: 796:134:320
- **Details**: [function_activePool_accountForReceivedColl_uint256.md](./function_activePool_accountForReceivedColl_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function activePool_accountForReceivedColl(uint256 _amount) public asAdmin();
```

### activePool_mintAggInterest() (inherited from AdminTargets)

- **Signature**: `activePool_mintAggInterest()`
- **Visibility**: public
- **Source Range**: 936:98:320
- **Details**: [function_activePool_mintAggInterest.md](./function_activePool_mintAggInterest.md)

**Signature:**
```solidity
function activePool_mintAggInterest() public asAdmin();
```

### activePool_mintAggInterestAndAccountForTroveChange(struct TroveChange,address) (inherited from AdminTargets)

- **Signature**: `activePool_mintAggInterestAndAccountForTroveChange(struct TroveChange,address)`
- **Visibility**: public
- **Source Range**: 1040:227:320
- **Details**: [function_activePool_mintAggInterestAndAccountForTroveChange_struct_TroveChange_address.md](./function_activePool_mintAggInterestAndAccountForTroveChange_struct_TroveChange_address.md)

**Signature:**
```solidity
function activePool_mintAggInterestAndAccountForTroveChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin();
```

### activePool_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address) (inherited from AdminTargets)

- **Signature**: `activePool_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)`
- **Visibility**: public
- **Source Range**: 1273:231:320
- **Details**: [function_activePool_mintBatchManagementFeeAndAccountForChange_struct_TroveChange_address.md](./function_activePool_mintBatchManagementFeeAndAccountForChange_struct_TroveChange_address.md)

**Signature:**
```solidity
function activePool_mintBatchManagementFeeAndAccountForChange(TroveChange memory _troveChange, address _batchAddress) public asAdmin();
```

### activePool_receiveColl(uint256) (inherited from AdminTargets)

- **Signature**: `activePool_receiveColl(uint256)`
- **Visibility**: public
- **Source Range**: 1510:112:320
- **Details**: [function_activePool_receiveColl_uint256.md](./function_activePool_receiveColl_uint256.md)

**Signature:**
```solidity
function activePool_receiveColl(uint256 _amount) public asAdmin();
```

### activePool_sendColl(address,uint256) (inherited from AdminTargets)

- **Signature**: `activePool_sendColl(address,uint256)`
- **Visibility**: public
- **Source Range**: 1628:134:320
- **Details**: [function_activePool_sendColl_address_uint256.md](./function_activePool_sendColl_address_uint256.md)

**Signature:**
```solidity
function activePool_sendColl(address _account, uint256 _amount) public asAdmin();
```

### activePool_sendCollToDefaultPool(uint256) (inherited from AdminTargets)

- **Signature**: `activePool_sendCollToDefaultPool(uint256)`
- **Visibility**: public
- **Source Range**: 1768:132:320
- **Details**: [function_activePool_sendCollToDefaultPool_uint256.md](./function_activePool_sendCollToDefaultPool_uint256.md)

**Signature:**
```solidity
function activePool_sendCollToDefaultPool(uint256 _amount) public asAdmin();
```

### activePool_setShutdownFlag() (inherited from AdminTargets)

- **Signature**: `activePool_setShutdownFlag()`
- **Visibility**: public
- **Source Range**: 1906:98:320
- **Details**: [function_activePool_setShutdownFlag.md](./function_activePool_setShutdownFlag.md)

**Signature:**
```solidity
function activePool_setShutdownFlag() public asAdmin();
```

### boldToken_burn(address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_burn(address,uint256)`
- **Visibility**: public
- **Source Range**: 2043:124:320
- **Details**: [function_boldToken_burn_address_uint256.md](./function_boldToken_burn_address_uint256.md)

**Signature:**
```solidity
function boldToken_burn(address _account, uint256 _amount) public asAdmin();
```

### boldToken_mint(address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 2173:124:320
- **Details**: [function_boldToken_mint_address_uint256.md](./function_boldToken_mint_address_uint256.md)

**Signature:**
```solidity
function boldToken_mint(address _account, uint256 _amount) public asAdmin();
```

### boldToken_returnFromPool(address,address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_returnFromPool(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2303:182:320
- **Details**: [function_boldToken_returnFromPool_address_address_uint256.md](./function_boldToken_returnFromPool_address_address_uint256.md)

**Signature:**
```solidity
function boldToken_returnFromPool(address _poolAddress, address _receiver, uint256 _amount) public asAdmin();
```

### boldToken_sendToPool(address,address,uint256) (inherited from AdminTargets)

- **Signature**: `boldToken_sendToPool(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2491:170:320
- **Details**: [function_boldToken_sendToPool_address_address_uint256.md](./function_boldToken_sendToPool_address_address_uint256.md)

**Signature:**
```solidity
function boldToken_sendToPool(address _sender, address _poolAddress, uint256 _amount) public asAdmin();
```

### boldToken_setBranchAddresses(address,address,address,address) (inherited from AdminTargets)

- **Signature**: `boldToken_setBranchAddresses(address,address,address,address)`
- **Visibility**: public
- **Source Range**: 2667:316:320
- **Details**: [function_boldToken_setBranchAddresses_address_address_address_address.md](./function_boldToken_setBranchAddresses_address_address_address_address.md)

**Signature:**
```solidity
function boldToken_setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) public asAdmin();
```

### boldToken_setCollateralRegistry(address) (inherited from AdminTargets)

- **Signature**: `boldToken_setCollateralRegistry(address)`
- **Visibility**: public
- **Source Range**: 2989:168:320
- **Details**: [function_boldToken_setCollateralRegistry_address.md](./function_boldToken_setCollateralRegistry_address.md)

**Signature:**
```solidity
function boldToken_setCollateralRegistry(address _collateralRegistryAddress) public asAdmin();
```

### borrowerOperations_onLiquidateTrove(uint256) (inherited from AdminTargets)

- **Signature**: `borrowerOperations_onLiquidateTrove(uint256)`
- **Visibility**: public
- **Source Range**: 3205:140:320
- **Details**: [function_borrowerOperations_onLiquidateTrove_uint256.md](./function_borrowerOperations_onLiquidateTrove_uint256.md)

**Signature:**
```solidity
function borrowerOperations_onLiquidateTrove(uint256 _troveId) public asAdmin();
```

### borrowerOperations_shutdown() (inherited from AdminTargets)

- **Signature**: `borrowerOperations_shutdown()`
- **Visibility**: public
- **Source Range**: 3351:100:320
- **Details**: [function_borrowerOperations_shutdown.md](./function_borrowerOperations_shutdown.md)

**Signature:**
```solidity
function borrowerOperations_shutdown() public asAdmin();
```

### borrowerOperations_shutdownFromOracleFailure() (inherited from AdminTargets)

- **Signature**: `borrowerOperations_shutdownFromOracleFailure()`
- **Visibility**: public
- **Source Range**: 3457:134:320
- **Details**: [function_borrowerOperations_shutdownFromOracleFailure.md](./function_borrowerOperations_shutdownFromOracleFailure.md)

**Signature:**
```solidity
function borrowerOperations_shutdownFromOracleFailure() public asAdmin();
```

### collSurplusPool_accountSurplus(address,uint256) (inherited from AdminTargets)

- **Signature**: `collSurplusPool_accountSurplus(address,uint256)`
- **Visibility**: public
- **Source Range**: 3636:156:320
- **Details**: [function_collSurplusPool_accountSurplus_address_uint256.md](./function_collSurplusPool_accountSurplus_address_uint256.md)

**Signature:**
```solidity
function collSurplusPool_accountSurplus(address _account, uint256 _amount) public asAdmin();
```

### defaultPool_decreaseBoldDebt(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_decreaseBoldDebt(uint256)`
- **Visibility**: public
- **Source Range**: 3833:124:320
- **Details**: [function_defaultPool_decreaseBoldDebt_uint256.md](./function_defaultPool_decreaseBoldDebt_uint256.md)

**Signature:**
```solidity
function defaultPool_decreaseBoldDebt(uint256 _amount) public asAdmin();
```

### defaultPool_increaseBoldDebt(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_increaseBoldDebt(uint256)`
- **Visibility**: public
- **Source Range**: 3963:124:320
- **Details**: [function_defaultPool_increaseBoldDebt_uint256.md](./function_defaultPool_increaseBoldDebt_uint256.md)

**Signature:**
```solidity
function defaultPool_increaseBoldDebt(uint256 _amount) public asAdmin();
```

### defaultPool_receiveColl(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_receiveColl(uint256)`
- **Visibility**: public
- **Source Range**: 4093:114:320
- **Details**: [function_defaultPool_receiveColl_uint256.md](./function_defaultPool_receiveColl_uint256.md)

**Signature:**
```solidity
function defaultPool_receiveColl(uint256 _amount) public asAdmin();
```

### defaultPool_sendCollToActivePool(uint256) (inherited from AdminTargets)

- **Signature**: `defaultPool_sendCollToActivePool(uint256)`
- **Visibility**: public
- **Source Range**: 4213:132:320
- **Details**: [function_defaultPool_sendCollToActivePool_uint256.md](./function_defaultPool_sendCollToActivePool_uint256.md)

**Signature:**
```solidity
function defaultPool_sendCollToActivePool(uint256 _amount) public asAdmin();
```

### sortedTroves_insert(uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_insert(uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4387:200:320
- **Details**: [function_sortedTroves_insert_uint256_uint256_uint256_uint256.md](./function_sortedTroves_insert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4593:256:320
- **Details**: [function_sortedTroves_insertIntoBatch_uint256_BatchId_uint256_uint256_uint256.md](./function_sortedTroves_insertIntoBatch_uint256_BatchId_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_reInsert(uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_reInsert(uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4855:210:320
- **Details**: [function_sortedTroves_reInsert_uint256_uint256_uint256_uint256.md](./function_sortedTroves_reInsert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_reInsertBatch(BatchId,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_reInsertBatch(BatchId,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5071:220:320
- **Details**: [function_sortedTroves_reInsertBatch_BatchId_uint256_uint256_uint256.md](./function_sortedTroves_reInsertBatch_BatchId_uint256_uint256_uint256.md)

**Signature:**
```solidity
function sortedTroves_reInsertBatch(BatchId _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) public asAdmin();
```

### sortedTroves_remove(uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_remove(uint256)`
- **Visibility**: public
- **Source Range**: 5297:98:320
- **Details**: [function_sortedTroves_remove_uint256.md](./function_sortedTroves_remove_uint256.md)

**Signature:**
```solidity
function sortedTroves_remove(uint256 _id) public asAdmin();
```

### sortedTroves_removeFromBatch(uint256) (inherited from AdminTargets)

- **Signature**: `sortedTroves_removeFromBatch(uint256)`
- **Visibility**: public
- **Source Range**: 5401:116:320
- **Details**: [function_sortedTroves_removeFromBatch_uint256.md](./function_sortedTroves_removeFromBatch_uint256.md)

**Signature:**
```solidity
function sortedTroves_removeFromBatch(uint256 _id) public asAdmin();
```

### stabilityPool_offset(uint256,uint256) (inherited from AdminTargets)

- **Signature**: `stabilityPool_offset(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5560:152:320
- **Details**: [function_stabilityPool_offset_uint256_uint256.md](./function_stabilityPool_offset_uint256_uint256.md)

**Signature:**
```solidity
function stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd) public asAdmin();
```

### stabilityPool_triggerBoldRewards(uint256) (inherited from AdminTargets)

- **Signature**: `stabilityPool_triggerBoldRewards(uint256)`
- **Visibility**: public
- **Source Range**: 5718:138:320
- **Details**: [function_stabilityPool_triggerBoldRewards_uint256.md](./function_stabilityPool_triggerBoldRewards_uint256.md)

**Signature:**
```solidity
function stabilityPool_triggerBoldRewards(uint256 _boldYield) public asAdmin();
```

### troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange) (inherited from AdminTargets)

- **Signature**: `troveManager_onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 5898:225:320
- **Details**: [function_troveManager_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md](./function_troveManager_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function troveManager_onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange memory _troveChange) public asAdmin();
```

### troveManager_onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6129:381:320
- **Details**: [function_troveManager_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md](./function_troveManager_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin();
```

### troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange) (inherited from AdminTargets)

- **Signature**: `troveManager_onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 6516:305:320
- **Details**: [function_troveManager_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md](./function_troveManager_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function troveManager_onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange memory _troveChange) public asAdmin();
```

### troveManager_onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange) (inherited from AdminTargets)

- **Signature**: `troveManager_onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: public
- **Source Range**: 6827:373:320
- **Details**: [function_troveManager_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md](./function_troveManager_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function troveManager_onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange memory _troveChange) public asAdmin();
```

### troveManager_onCloseTrove(uint256,struct TroveChange,address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 7206:281:320
- **Details**: [function_troveManager_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md](./function_troveManager_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public asAdmin();
```

### troveManager_onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 7493:276:320
- **Details**: [function_troveManager_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md](./function_troveManager_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) public asAdmin();
```

### troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: public
- **Source Range**: 7775:239:320
- **Details**: [function_troveManager_onOpenTrove_address_uint256_struct_TroveChange_uint256.md](./function_troveManager_onOpenTrove_address_uint256_struct_TroveChange_uint256.md)

**Signature:**
```solidity
function troveManager_onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) public asAdmin();
```

### troveManager_onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8020:315:320
- **Details**: [function_troveManager_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md](./function_troveManager_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) public asAdmin();
```

### troveManager_onRegisterBatchManager(address,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8341:242:320
- **Details**: [function_troveManager_onRegisterBatchManager_address_uint256_uint256.md](./function_troveManager_onRegisterBatchManager_address_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) public asAdmin();
```

### troveManager_onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8589:423:320
- **Details**: [function_troveManager_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md](./function_troveManager_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) public asAdmin();
```

### troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 9018:322:320
- **Details**: [function_troveManager_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md](./function_troveManager_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) public asAdmin();
```

### troveManager_onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams) (inherited from AdminTargets)

- **Signature**: `troveManager_onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`
- **Visibility**: public
- **Source Range**: 9346:189:320
- **Details**: [function_troveManager_onSetInterestBatchManager_struct_ITroveManager.OnSetInterestBatchManagerParams.md](./function_troveManager_onSetInterestBatchManager_struct_ITroveManager.OnSetInterestBatchManagerParams.md)

**Signature:**
```solidity
function troveManager_onSetInterestBatchManager(ITroveManager.OnSetInterestBatchManagerParams memory _params) public asAdmin();
```

### troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 9541:270:320
- **Details**: [function_troveManager_redeemCollateral_address_uint256_uint256_uint256_uint256.md](./function_troveManager_redeemCollateral_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function troveManager_redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) public asAdmin();
```

### troveManager_setTroveStatusToActive(uint256) (inherited from AdminTargets)

- **Signature**: `troveManager_setTroveStatusToActive(uint256)`
- **Visibility**: public
- **Source Range**: 9817:140:320
- **Details**: [function_troveManager_setTroveStatusToActive_uint256.md](./function_troveManager_setTroveStatusToActive_uint256.md)

**Signature:**
```solidity
function troveManager_setTroveStatusToActive(uint256 _troveId) public asAdmin();
```

### troveManager_shutdown() (inherited from AdminTargets)

- **Signature**: `troveManager_shutdown()`
- **Visibility**: public
- **Source Range**: 9963:88:320
- **Details**: [function_troveManager_shutdown.md](./function_troveManager_shutdown.md)

**Signature:**
```solidity
function troveManager_shutdown() public asAdmin();
```

### troveNFT_burn(uint256) (inherited from AdminTargets)

- **Signature**: `troveNFT_burn(uint256)`
- **Visibility**: public
- **Source Range**: 10089:96:320
- **Details**: [function_troveNFT_burn_uint256.md](./function_troveNFT_burn_uint256.md)

**Signature:**
```solidity
function troveNFT_burn(uint256 _troveId) public asAdmin();
```

### troveNFT_mint(address,uint256) (inherited from AdminTargets)

- **Signature**: `troveNFT_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 10191:120:320
- **Details**: [function_troveNFT_mint_address_uint256.md](./function_troveNFT_mint_address_uint256.md)

**Signature:**
```solidity
function troveNFT_mint(address _owner, uint256 _troveId) public asAdmin();
```

### boldToken_approve(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 610:126:321
- **Details**: [function_boldToken_approve_address_uint256.md](./function_boldToken_approve_address_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function boldToken_approve(address spender, uint256 amount) public asActor();
```

### boldToken_decreaseAllowance(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_decreaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 742:164:321
- **Details**: [function_boldToken_decreaseAllowance_address_uint256.md](./function_boldToken_decreaseAllowance_address_uint256.md)

**Signature:**
```solidity
function boldToken_decreaseAllowance(address spender, uint256 subtractedValue) public asActor();
```

### boldToken_increaseAllowance(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_increaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 912:154:321
- **Details**: [function_boldToken_increaseAllowance_address_uint256.md](./function_boldToken_increaseAllowance_address_uint256.md)

**Signature:**
```solidity
function boldToken_increaseAllowance(address spender, uint256 addedValue) public asActor();
```

### boldToken_permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 1072:212:321
- **Details**: [function_boldToken_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_boldToken_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
function boldToken_permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public asActor();
```

### boldToken_transfer(address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 1290:132:321
- **Details**: [function_boldToken_transfer_address_uint256.md](./function_boldToken_transfer_address_uint256.md)

**Signature:**
```solidity
function boldToken_transfer(address recipient, uint256 amount) public asActor();
```

### boldToken_transferFrom(address,address,uint256) (inherited from BoldTokenTargets)

- **Signature**: `boldToken_transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1428:164:321
- **Details**: [function_boldToken_transferFrom_address_address_uint256.md](./function_boldToken_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function boldToken_transferFrom(address sender, address recipient, uint256 amount) public asActor();
```

### borrowerOperations_addColl(uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_addColl(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 628:156:322
- **Details**: [function_borrowerOperations_addColl_uint256_uint256.md](./function_borrowerOperations_addColl_uint256_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function borrowerOperations_addColl(uint256 _troveId, uint256 _collAmount) public asActor();
```

### borrowerOperations_adjustTrove(uint256,uint256,bool,uint256,bool,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_adjustTrove(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: public
- **Source Range**: 790:316:322
- **Details**: [function_borrowerOperations_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md](./function_borrowerOperations_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md)

**Signature:**
```solidity
function borrowerOperations_adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1112:314:322
- **Details**: [function_borrowerOperations_adjustTroveInterestRate_uint256_uint256_uint256_uint256_uint256.md](./function_borrowerOperations_adjustTroveInterestRate_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_adjustTroveInterestRate(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1432:392:322
- **Details**: [function_borrowerOperations_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md](./function_borrowerOperations_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_applyPendingDebt(uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_applyPendingDebt(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1830:204:322
- **Details**: [function_borrowerOperations_applyPendingDebt_uint256_uint256_uint256.md](./function_borrowerOperations_applyPendingDebt_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_applyPendingDebt(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public asActor();
```

### borrowerOperations_claimCollateral() (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_claimCollateral()`
- **Visibility**: public
- **Source Range**: 2040:114:322
- **Details**: [function_borrowerOperations_claimCollateral.md](./function_borrowerOperations_claimCollateral.md)

**Signature:**
```solidity
function borrowerOperations_claimCollateral() public asActor();
```

### borrowerOperations_closeTrove(uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_closeTrove(uint256)`
- **Visibility**: public
- **Source Range**: 2160:128:322
- **Details**: [function_borrowerOperations_closeTrove_uint256.md](./function_borrowerOperations_closeTrove_uint256.md)

**Signature:**
```solidity
function borrowerOperations_closeTrove(uint256 _troveId) public asActor();
```

### borrowerOperations_kickFromBatch(uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_kickFromBatch(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2294:198:322
- **Details**: [function_borrowerOperations_kickFromBatch_uint256_uint256_uint256.md](./function_borrowerOperations_kickFromBatch_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_kickFromBatch(uint256 _troveId, uint256 _upperHint, uint256 _lowerHint) public asActor();
```

### borrowerOperations_lowerBatchManagementFee(uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_lowerBatchManagementFee(uint256)`
- **Visibility**: public
- **Source Range**: 2498:184:322
- **Details**: [function_borrowerOperations_lowerBatchManagementFee_uint256.md](./function_borrowerOperations_lowerBatchManagementFee_uint256.md)

**Signature:**
```solidity
function borrowerOperations_lowerBatchManagementFee(uint256 _newAnnualManagementFee) public asActor();
```

### borrowerOperations_openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)`
- **Visibility**: public
- **Source Range**: 2688:482:322
- **Details**: [function_borrowerOperations_openTrove_address_uint256_uint256_uint256_uint256_uint256_uint256_uint256_address_address_address.md](./function_borrowerOperations_openTrove_address_uint256_uint256_uint256_uint256_uint256_uint256_uint256_address_address_address.md)

**Signature:**
```solidity
function borrowerOperations_openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) public asActor();
```

### borrowerOperations_openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)`
- **Visibility**: public
- **Source Range**: 3176:240:322
- **Details**: [function_borrowerOperations_openTroveAndJoinInterestBatchManager_struct_IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams.md](./function_borrowerOperations_openTroveAndJoinInterestBatchManager_struct_IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams.md)

**Signature:**
```solidity
function borrowerOperations_openTroveAndJoinInterestBatchManager(IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory _params) public asActor();
```

### borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_registerBatchManager(uint128,uint128,uint128,uint128,uint128)`
- **Visibility**: public
- **Source Range**: 3422:380:322
- **Details**: [function_borrowerOperations_registerBatchManager_uint128_uint128_uint128_uint128_uint128.md](./function_borrowerOperations_registerBatchManager_uint128_uint128_uint128_uint128_uint128.md)

**Signature:**
```solidity
function borrowerOperations_registerBatchManager(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) public asActor();
```

### borrowerOperations_removeFromBatch(uint256,uint256,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_removeFromBatch(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3808:298:322
- **Details**: [function_borrowerOperations_removeFromBatch_uint256_uint256_uint256_uint256_uint256.md](./function_borrowerOperations_removeFromBatch_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_removeInterestIndividualDelegate(uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_removeInterestIndividualDelegate(uint256)`
- **Visibility**: public
- **Source Range**: 4112:172:322
- **Details**: [function_borrowerOperations_removeInterestIndividualDelegate_uint256.md](./function_borrowerOperations_removeInterestIndividualDelegate_uint256.md)

**Signature:**
```solidity
function borrowerOperations_removeInterestIndividualDelegate(uint256 _troveId) public asActor();
```

### borrowerOperations_repayBold(uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_repayBold(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4290:160:322
- **Details**: [function_borrowerOperations_repayBold_uint256_uint256.md](./function_borrowerOperations_repayBold_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_repayBold(uint256 _troveId, uint256 _boldAmount) public asActor();
```

### borrowerOperations_setAddManager(uint256,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setAddManager(uint256,address)`
- **Visibility**: public
- **Source Range**: 4456:162:322
- **Details**: [function_borrowerOperations_setAddManager_uint256_address.md](./function_borrowerOperations_setAddManager_uint256_address.md)

**Signature:**
```solidity
function borrowerOperations_setAddManager(uint256 _troveId, address _manager) public asActor();
```

### borrowerOperations_setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4624:306:322
- **Details**: [function_borrowerOperations_setBatchManagerAnnualInterestRate_uint128_uint256_uint256_uint256.md](./function_borrowerOperations_setBatchManagerAnnualInterestRate_uint128_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_setBatchManagerAnnualInterestRate(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_setInterestBatchManager(uint256,address,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setInterestBatchManager(uint256,address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4936:302:322
- **Details**: [function_borrowerOperations_setInterestBatchManager_uint256_address_uint256_uint256_uint256.md](./function_borrowerOperations_setInterestBatchManager_uint256_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5244:512:322
- **Details**: [function_borrowerOperations_setInterestIndividualDelegate_uint256_address_uint128_uint128_uint256_uint256_uint256_uint256_uint256.md](./function_borrowerOperations_setInterestIndividualDelegate_uint256_address_uint128_uint128_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_setInterestIndividualDelegate(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) public asActor();
```

### borrowerOperations_setRemoveManager(uint256,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setRemoveManager(uint256,address)`
- **Visibility**: public
- **Source Range**: 5762:168:322
- **Details**: [function_borrowerOperations_setRemoveManager_uint256_address.md](./function_borrowerOperations_setRemoveManager_uint256_address.md)

**Signature:**
```solidity
function borrowerOperations_setRemoveManager(uint256 _troveId, address _manager) public asActor();
```

### borrowerOperations_setRemoveManagerWithReceiver(uint256,address,address) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 5936:222:322
- **Details**: [function_borrowerOperations_setRemoveManagerWithReceiver_uint256_address_address.md](./function_borrowerOperations_setRemoveManagerWithReceiver_uint256_address_address.md)

**Signature:**
```solidity
function borrowerOperations_setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public asActor();
```

### borrowerOperations_switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6164:392:322
- **Details**: [function_borrowerOperations_switchBatchManager_uint256_uint256_uint256_address_uint256_uint256_uint256.md](./function_borrowerOperations_switchBatchManager_uint256_uint256_uint256_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_withdrawBold(uint256,uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_withdrawBold(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6562:206:322
- **Details**: [function_borrowerOperations_withdrawBold_uint256_uint256_uint256.md](./function_borrowerOperations_withdrawBold_uint256_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) public asActor();
```

### borrowerOperations_withdrawColl(uint256,uint256) (inherited from BorrowerOperationsTargets)

- **Signature**: `borrowerOperations_withdrawColl(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6774:174:322
- **Details**: [function_borrowerOperations_withdrawColl_uint256_uint256.md](./function_borrowerOperations_withdrawColl_uint256_uint256.md)

**Signature:**
```solidity
function borrowerOperations_withdrawColl(uint256 _troveId, uint256 _collWithdrawal) public asActor();
```

### collSurplusPool_claimColl(address) (inherited from CollSurplusPoolTargets)

- **Signature**: `collSurplusPool_claimColl(address)`
- **Visibility**: public
- **Source Range**: 622:120:323
- **Details**: [function_collSurplusPool_claimColl_address.md](./function_collSurplusPool_claimColl_address.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function collSurplusPool_claimColl(address _account) public asActor();
```

### collateralRegistry_redeemCollateral(uint256,uint256,uint256) (inherited from CollateralRegistryTargets)

- **Signature**: `collateralRegistry_redeemCollateral(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 628:258:324
- **Details**: [function_collateralRegistry_redeemCollateral_uint256_uint256_uint256.md](./function_collateralRegistry_redeemCollateral_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function collateralRegistry_redeemCollateral(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) public asActor();
```

### switchActor(uint256) (inherited from ManagersTargets)

- **Signature**: `switchActor(uint256)`
- **Visibility**: public
- **Source Range**: 680:83:327
- **Details**: [function_switchActor_uint256.md](./function_switchActor_uint256.md)

**Signature:**
```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public;
```

### switch_asset(uint256) (inherited from ManagersTargets)

- **Signature**: `switch_asset(uint256)`
- **Visibility**: public
- **Source Range**: 808:84:327
- **Details**: [function_switch_asset_uint256.md](./function_switch_asset_uint256.md)

**Signature:**
```solidity
/// @dev Starts using a new asset
function switch_asset(uint256 entropy) public;
```

### add_new_asset(uint8) (inherited from ManagersTargets)

- **Signature**: `add_new_asset(uint8)`
- **Visibility**: public
- **Source Range**: 997:144:327
- **Details**: [function_add_new_asset_uint8.md](./function_add_new_asset_uint8.md)

**Signature:**
```solidity
/// @dev Deploy a new token and add it to the list of assets, then set it as the current asset
function add_new_asset(uint8 decimals) public returns (address);
```

### asset_approve(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_approve(address,uint128)`
- **Visibility**: public
- **Source Range**: 1467:132:327
- **Details**: [function_asset_approve_address_uint128.md](./function_asset_approve_address_uint128.md)

**Signature:**
```solidity
/// @dev Approve to arbitrary address, uses Actor by default
///  NOTE: You're almost always better off setting approvals in `Setup`
function asset_approve(address to, uint128 amt) public updateGhosts() asActor();
```

### asset_mint(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_mint(address,uint128)`
- **Visibility**: public
- **Source Range**: 1704:126:327
- **Details**: [function_asset_mint_address_uint128.md](./function_asset_mint_address_uint128.md)

**Signature:**
```solidity
/// @dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
function asset_mint(address to, uint128 amt) public updateGhosts() asAdmin();
```

### stabilityPool_claimAllCollGains() (inherited from StabilityPoolTargets)

- **Signature**: `stabilityPool_claimAllCollGains()`
- **Visibility**: public
- **Source Range**: 618:108:329
- **Details**: [function_stabilityPool_claimAllCollGains.md](./function_stabilityPool_claimAllCollGains.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function stabilityPool_claimAllCollGains() public asActor();
```

### stabilityPool_provideToSP(uint256,bool) (inherited from StabilityPoolTargets)

- **Signature**: `stabilityPool_provideToSP(uint256,bool)`
- **Visibility**: public
- **Source Range**: 732:141:329
- **Details**: [function_stabilityPool_provideToSP_uint256_bool.md](./function_stabilityPool_provideToSP_uint256_bool.md)

**Signature:**
```solidity
function stabilityPool_provideToSP(uint256 _topUp, bool _doClaim) public asActor();
```

### stabilityPool_withdrawFromSP(uint256,bool) (inherited from StabilityPoolTargets)

- **Signature**: `stabilityPool_withdrawFromSP(uint256,bool)`
- **Visibility**: public
- **Source Range**: 879:149:329
- **Details**: [function_stabilityPool_withdrawFromSP_uint256_bool.md](./function_stabilityPool_withdrawFromSP_uint256_bool.md)

**Signature:**
```solidity
function stabilityPool_withdrawFromSP(uint256 _amount, bool _doClaim) public asActor();
```

### troveManager_batchLiquidateTroves(uint256[]) (inherited from TroveManagerTargets)

- **Signature**: `troveManager_batchLiquidateTroves(uint256[])`
- **Visibility**: public
- **Source Range**: 616:151:330
- **Details**: [function_troveManager_batchLiquidateTroves_uint256[].md](./function_troveManager_batchLiquidateTroves_uint256[].md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function troveManager_batchLiquidateTroves(uint256[] memory _troveArray) public asActor();
```

### troveManager_getUnbackedPortionPriceAndRedeemability() (inherited from TroveManagerTargets)

- **Signature**: `troveManager_getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: public
- **Source Range**: 773:150:330
- **Details**: [function_troveManager_getUnbackedPortionPriceAndRedeemability.md](./function_troveManager_getUnbackedPortionPriceAndRedeemability.md)

**Signature:**
```solidity
function troveManager_getUnbackedPortionPriceAndRedeemability() public asActor();
```

### troveManager_urgentRedemption(uint256,uint256[],uint256) (inherited from TroveManagerTargets)

- **Signature**: `troveManager_urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: public
- **Source Range**: 929:213:330
- **Details**: [function_troveManager_urgentRedemption_uint256_uint256[]_uint256.md](./function_troveManager_urgentRedemption_uint256_uint256[]_uint256.md)

**Signature:**
```solidity
function troveManager_urgentRedemption(uint256 _boldAmount, uint256[] memory _troveIds, uint256 _minCollateral) public asActor();
```

### troveNFT_approve(address,uint256) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 608:116:331
- **Details**: [function_troveNFT_approve_address_uint256.md](./function_troveNFT_approve_address_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function troveNFT_approve(address to, uint256 tokenId) public asActor();
```

### troveNFT_safeTransferFrom(address,address,uint256) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_safeTransferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 730:154:331
- **Details**: [function_troveNFT_safeTransferFrom_address_address_uint256.md](./function_troveNFT_safeTransferFrom_address_address_uint256.md)

**Signature:**
```solidity
function troveNFT_safeTransferFrom(address from, address to, uint256 tokenId) public asActor();
```

### troveNFT_safeTransferFrom(address,address,uint256,bytes) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 890:179:331
- **Details**: [function_troveNFT_safeTransferFrom_address_address_uint256_bytes.md](./function_troveNFT_safeTransferFrom_address_address_uint256_bytes.md)

**Signature:**
```solidity
function troveNFT_safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public asActor();
```

### troveNFT_setApprovalForAll(address,bool) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_setApprovalForAll(address,bool)`
- **Visibility**: public
- **Source Range**: 1075:147:331
- **Details**: [function_troveNFT_setApprovalForAll_address_bool.md](./function_troveNFT_setApprovalForAll_address_bool.md)

**Signature:**
```solidity
function troveNFT_setApprovalForAll(address operator, bool approved) public asActor();
```

### troveNFT_transferFrom(address,address,uint256) (inherited from TroveNFTTargets)

- **Signature**: `troveNFT_transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1228:146:331
- **Details**: [function_troveNFT_transferFrom_address_address_uint256.md](./function_troveNFT_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function troveNFT_transferFrom(address from, address to, uint256 tokenId) public asActor();
```
