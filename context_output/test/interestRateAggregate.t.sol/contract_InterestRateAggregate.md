# Contract: InterestRateAggregate

## Metadata

- **Name**: InterestRateAggregate
- **Type**: Contract
- **Path**: test/interestRateAggregate.t.sol

## State Variables

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

### accounts (inherited from TestAccounts)

```solidity
Accounts internal accounts
```

**Accounts**: [test/TestContracts/Accounts.sol/contract_Accounts.md]

### accountsList (inherited from TestAccounts)

```solidity
address[] internal accountsList
```

### A (inherited from TestAccounts)

```solidity
address public A
```

### B (inherited from TestAccounts)

```solidity
address public B
```

### C (inherited from TestAccounts)

```solidity
address public C
```

### D (inherited from TestAccounts)

```solidity
address public D
```

### E (inherited from TestAccounts)

```solidity
address public E
```

### F (inherited from TestAccounts)

```solidity
address public F
```

### G (inherited from TestAccounts)

```solidity
address public G
```

### STALE_TROVE_DURATION (inherited from BaseTest)

```solidity
uint256 internal constant STALE_TROVE_DURATION = 90 days
```

### CCR (inherited from BaseTest)

```solidity
uint256 internal CCR
```

### MCR (inherited from BaseTest)

```solidity
uint256 internal MCR
```

### BCR (inherited from BaseTest)

```solidity
uint256 internal BCR
```

### SCR (inherited from BaseTest)

```solidity
uint256 internal SCR
```

### LIQUIDATION_PENALTY_SP (inherited from BaseTest)

```solidity
uint256 internal LIQUIDATION_PENALTY_SP
```

### LIQUIDATION_PENALTY_REDISTRIBUTION (inherited from BaseTest)

```solidity
uint256 internal LIQUIDATION_PENALTY_REDISTRIBUTION
```

### addressesRegistry (inherited from BaseTest)

```solidity
IAddressesRegistry internal addressesRegistry
```

**IAddressesRegistry**: [src/Interfaces/IAddressesRegistry.sol/interface_IAddressesRegistry.md]

### activePool (inherited from BaseTest)

```solidity
IActivePool internal activePool
```

**IActivePool**: [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

### borrowerOperations (inherited from BaseTest)

```solidity
IBorrowerOperationsTester internal borrowerOperations
```

**IBorrowerOperationsTester**: [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

### collSurplusPool (inherited from BaseTest)

```solidity
ICollSurplusPool internal collSurplusPool
```

**ICollSurplusPool**: [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]

### defaultPool (inherited from BaseTest)

```solidity
IDefaultPool internal defaultPool
```

**IDefaultPool**: [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

### sortedTroves (inherited from BaseTest)

```solidity
ISortedTroves internal sortedTroves
```

**ISortedTroves**: [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

### stabilityPool (inherited from BaseTest)

```solidity
IStabilityPool internal stabilityPool
```

**IStabilityPool**: [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

### troveManager (inherited from BaseTest)

```solidity
ITroveManagerTester internal troveManager
```

**ITroveManagerTester**: [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]

### troveNFT (inherited from BaseTest)

```solidity
ITroveNFT internal troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### metadataNFT (inherited from BaseTest)

```solidity
IMetadataNFT internal metadataNFT
```

**IMetadataNFT**: [src/NFTMetadata/MetadataNFT.sol/interface_IMetadataNFT.md]

### boldToken (inherited from BaseTest)

```solidity
IBoldToken internal boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### collateralRegistry (inherited from BaseTest)

```solidity
ICollateralRegistry internal collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### priceFeed (inherited from BaseTest)

```solidity
IPriceFeedTestnet internal priceFeed
```

**IPriceFeedTestnet**: [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]

### gasPool (inherited from BaseTest)

```solidity
GasPool internal gasPool
```

**GasPool**: [src/GasPool.sol/contract_GasPool.md]

### mockInterestRouter (inherited from BaseTest)

```solidity
IInterestRouter internal mockInterestRouter
```

**IInterestRouter**: [src/Interfaces/IInterestRouter.sol/interface_IInterestRouter.md]

### collToken (inherited from BaseTest)

```solidity
IERC20 internal collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### hintHelpers (inherited from BaseTest)

```solidity
HintHelpers internal hintHelpers
```

**HintHelpers**: [src/HintHelpers.sol/contract_HintHelpers.md]

### WETH (inherited from BaseTest)

```solidity
IWETH internal WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### wethZapper (inherited from BaseTest)

```solidity
WETHZapper internal wethZapper
```

**WETHZapper**: [src/Zappers/WETHZapper.sol/contract_WETHZapper.md]

### gasCompZapper (inherited from BaseTest)

```solidity
GasCompZapper internal gasCompZapper
```

**GasCompZapper**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

### leverageZapperCurve (inherited from BaseTest)

```solidity
ILeverageZapper internal leverageZapperCurve
```

**ILeverageZapper**: [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]

### leverageZapperUniV3 (inherited from BaseTest)

```solidity
ILeverageZapper internal leverageZapperUniV3
```

**ILeverageZapper**: [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]

## Structs

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

### ABCDEF (inherited from BaseTest)

```solidity
struct ABCDEF {
    uint256 A;
    uint256 B;
    uint256 C;
    uint256 D;
    uint256 E;
    uint256 F;
}
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

### testCalcPendingAggInterestReturns0For0TimePassedSinceLastUpdate()

- **Signature**: `testCalcPendingAggInterestReturns0For0TimePassedSinceLastUpdate()`
- **Visibility**: public
- **Source Range**: 273:627:306
- **Details**: [function_testCalcPendingAggInterestReturns0For0TimePassedSinceLastUpdate.md](./function_testCalcPendingAggInterestReturns0For0TimePassedSinceLastUpdate.md)

**Signature:**
```solidity
function testCalcPendingAggInterestReturns0For0TimePassedSinceLastUpdate() public;
```

### testCalcPendingAggInterestReturns0When0AggRecordedDebt()

- **Signature**: `testCalcPendingAggInterestReturns0When0AggRecordedDebt()`
- **Visibility**: public
- **Source Range**: 979:485:306
- **Details**: [function_testCalcPendingAggInterestReturns0When0AggRecordedDebt.md](./function_testCalcPendingAggInterestReturns0When0AggRecordedDebt.md)

**Signature:**
```solidity
function testCalcPendingAggInterestReturns0When0AggRecordedDebt() public;
```

### testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod()

- **Signature**: `testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod()`
- **Visibility**: public
- **Source Range**: 1511:1013:306
- **Details**: [function_testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod.md](./function_testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod.md)

**Signature:**
```solidity
function testCalcPendingAggInterestReturnsCorrectInterestForGivenPeriod() public;
```

### testCalcTroveAccruedInterestReturns0When0AggRecordedDebt()

- **Signature**: `testCalcTroveAccruedInterestReturns0When0AggRecordedDebt()`
- **Visibility**: public
- **Source Range**: 2607:624:306
- **Details**: [function_testCalcTroveAccruedInterestReturns0When0AggRecordedDebt.md](./function_testCalcTroveAccruedInterestReturns0When0AggRecordedDebt.md)

**Signature:**
```solidity
function testCalcTroveAccruedInterestReturns0When0AggRecordedDebt() public;
```

### testCalcTroveAccruedInterestReturns0For0TimePassed()

- **Signature**: `testCalcTroveAccruedInterestReturns0For0TimePassed()`
- **Visibility**: public
- **Source Range**: 3272:457:306
- **Details**: [function_testCalcTroveAccruedInterestReturns0For0TimePassed.md](./function_testCalcTroveAccruedInterestReturns0For0TimePassed.md)

**Signature:**
```solidity
function testCalcTroveAccruedInterestReturns0For0TimePassed() public;
```

### testCalcTroveAccruedInterestReturnsCorrectInterestForGivenPeriod()

- **Signature**: `testCalcTroveAccruedInterestReturnsCorrectInterestForGivenPeriod()`
- **Visibility**: public
- **Source Range**: 3790:1302:306
- **Details**: [function_testCalcTroveAccruedInterestReturnsCorrectInterestForGivenPeriod.md](./function_testCalcTroveAccruedInterestReturnsCorrectInterestForGivenPeriod.md)

**Signature:**
```solidity
function testCalcTroveAccruedInterestReturnsCorrectInterestForGivenPeriod() public;
```

### testMintAggInterestRevertsWhenNotCalledByBOorTM()

- **Signature**: `testMintAggInterestRevertsWhenNotCalledByBOorTM()`
- **Visibility**: public
- **Source Range**: 5130:582:306
- **Details**: [function_testMintAggInterestRevertsWhenNotCalledByBOorTM.md](./function_testMintAggInterestRevertsWhenNotCalledByBOorTM.md)

**Signature:**
```solidity
function testMintAggInterestRevertsWhenNotCalledByBOorTM() public;
```

### testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt()

- **Signature**: `testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt()`
- **Visibility**: public
- **Source Range**: 5834:1470:306
- **Details**: [function_testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt.md](./function_testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt.md)

**Signature:**
```solidity
function testOpenTroveIncreasesRecordedAggDebtByAggPendingInterestPlusTroveDebt() public;
```

### testOpenTroveReducesPendingAggInterestTo0()

- **Signature**: `testOpenTroveReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 7310:601:306
- **Details**: [function_testOpenTroveReducesPendingAggInterestTo0.md](./function_testOpenTroveReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testOpenTroveReducesPendingAggInterestTo0() public;
```

### testOpenTroveUpdatesTheLastAggUpdateTime()

- **Signature**: `testOpenTroveUpdatesTheLastAggUpdateTime()`
- **Visibility**: public
- **Source Range**: 7917:547:306
- **Details**: [function_testOpenTroveUpdatesTheLastAggUpdateTime.md](./function_testOpenTroveUpdatesTheLastAggUpdateTime.md)

**Signature:**
```solidity
function testOpenTroveUpdatesTheLastAggUpdateTime() public;
```

### testOpenTroveMintsInterestToSP()

- **Signature**: `testOpenTroveMintsInterestToSP()`
- **Visibility**: public
- **Source Range**: 8470:1523:306
- **Details**: [function_testOpenTroveMintsInterestToSP.md](./function_testOpenTroveMintsInterestToSP.md)

**Signature:**
```solidity
function testOpenTroveMintsInterestToSP() public;
```

### testOpenTroveIncreasesWeightedSumByCorrectWeightedDebt()

- **Signature**: `testOpenTroveIncreasesWeightedSumByCorrectWeightedDebt()`
- **Visibility**: public
- **Source Range**: 9999:1245:306
- **Details**: [function_testOpenTroveIncreasesWeightedSumByCorrectWeightedDebt.md](./function_testOpenTroveIncreasesWeightedSumByCorrectWeightedDebt.md)

**Signature:**
```solidity
function testOpenTroveIncreasesWeightedSumByCorrectWeightedDebt() public;
```

### testSPDepositReducesPendingAggInterestTo0()

- **Signature**: `testSPDepositReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 11278:660:306
- **Details**: [function_testSPDepositReducesPendingAggInterestTo0.md](./function_testSPDepositReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testSPDepositReducesPendingAggInterestTo0() public;
```

### testSPDepositIncreasesAggRecordedDebtByPendingAggInterest()

- **Signature**: `testSPDepositIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 11944:860:306
- **Details**: [function_testSPDepositIncreasesAggRecordedDebtByPendingAggInterest.md](./function_testSPDepositIncreasesAggRecordedDebtByPendingAggInterest.md)

**Signature:**
```solidity
function testSPDepositIncreasesAggRecordedDebtByPendingAggInterest() public;
```

### testSPDepositUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testSPDepositUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 12810:686:306
- **Details**: [function_testSPDepositUpdatesLastAggUpdateTimeToNow.md](./function_testSPDepositUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testSPDepositUpdatesLastAggUpdateTimeToNow() public;
```

### testSPDepositMintsInterestToSP()

- **Signature**: `testSPDepositMintsInterestToSP()`
- **Visibility**: public
- **Source Range**: 13502:935:306
- **Details**: [function_testSPDepositMintsInterestToSP.md](./function_testSPDepositMintsInterestToSP.md)

**Signature:**
```solidity
function testSPDepositMintsInterestToSP() public;
```

### testSPDepositDoesNotChangeAggWeightedDebtSum()

- **Signature**: `testSPDepositDoesNotChangeAggWeightedDebtSum()`
- **Visibility**: public
- **Source Range**: 14489:765:306
- **Details**: [function_testSPDepositDoesNotChangeAggWeightedDebtSum.md](./function_testSPDepositDoesNotChangeAggWeightedDebtSum.md)

**Signature:**
```solidity
function testSPDepositDoesNotChangeAggWeightedDebtSum() public;
```

### testSPWithdrawalReducesPendingAggInterestTo0()

- **Signature**: `testSPWithdrawalReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 15291:857:306
- **Details**: [function_testSPWithdrawalReducesPendingAggInterestTo0.md](./function_testSPWithdrawalReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testSPWithdrawalReducesPendingAggInterestTo0() public;
```

### testSPWithdrawalIncreasesAggRecordedDebtByPendingAggInterest()

- **Signature**: `testSPWithdrawalIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 16154:1059:306
- **Details**: [function_testSPWithdrawalIncreasesAggRecordedDebtByPendingAggInterest.md](./function_testSPWithdrawalIncreasesAggRecordedDebtByPendingAggInterest.md)

**Signature:**
```solidity
function testSPWithdrawalIncreasesAggRecordedDebtByPendingAggInterest() public;
```

### testSPWithdrawalUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testSPWithdrawalUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 17219:885:306
- **Details**: [function_testSPWithdrawalUpdatesLastAggUpdateTimeToNow.md](./function_testSPWithdrawalUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testSPWithdrawalUpdatesLastAggUpdateTimeToNow() public;
```

### testSPWithdrawalMintsInterestToSP()

- **Signature**: `testSPWithdrawalMintsInterestToSP()`
- **Visibility**: public
- **Source Range**: 18110:1401:306
- **Details**: [function_testSPWithdrawalMintsInterestToSP.md](./function_testSPWithdrawalMintsInterestToSP.md)

**Signature:**
```solidity
function testSPWithdrawalMintsInterestToSP() public;
```

### testSPWithdrawalDoesNotChangeAggWeightedDebtSum()

- **Signature**: `testSPWithdrawalDoesNotChangeAggWeightedDebtSum()`
- **Visibility**: public
- **Source Range**: 19517:1056:306
- **Details**: [function_testSPWithdrawalDoesNotChangeAggWeightedDebtSum.md](./function_testSPWithdrawalDoesNotChangeAggWeightedDebtSum.md)

**Signature:**
```solidity
function testSPWithdrawalDoesNotChangeAggWeightedDebtSum() public;
```

### testCloseTroveReducesPendingAggInterestTo0()

- **Signature**: `testCloseTroveReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 20647:821:306
- **Details**: [function_testCloseTroveReducesPendingAggInterestTo0.md](./function_testCloseTroveReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testCloseTroveReducesPendingAggInterestTo0() public;
```

### testCloseTroveAddsPendingAggInterestAndSubtractsRecordedDebtPlusInterestFromAggRecordedDebt()

- **Signature**: `testCloseTroveAddsPendingAggInterestAndSubtractsRecordedDebtPlusInterestFromAggRecordedDebt()`
- **Visibility**: public
- **Source Range**: 21534:1434:306
- **Details**: [function_testCloseTroveAddsPendingAggInterestAndSubtractsRecordedDebtPlusInterestFromAggRecordedDebt.md](./function_testCloseTroveAddsPendingAggInterestAndSubtractsRecordedDebtPlusInterestFromAggRecordedDebt.md)

**Signature:**
```solidity
function testCloseTroveAddsPendingAggInterestAndSubtractsRecordedDebtPlusInterestFromAggRecordedDebt() public;
```

### testCloseTroveUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testCloseTroveUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 23017:846:306
- **Details**: [function_testCloseTroveUpdatesLastAggUpdateTimeToNow.md](./function_testCloseTroveUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testCloseTroveUpdatesLastAggUpdateTimeToNow() public;
```

### testCloseTroveMintsInterestToSP()

- **Signature**: `testCloseTroveMintsInterestToSP()`
- **Visibility**: public
- **Source Range**: 23910:1092:306
- **Details**: [function_testCloseTroveMintsInterestToSP.md](./function_testCloseTroveMintsInterestToSP.md)

**Signature:**
```solidity
function testCloseTroveMintsInterestToSP() public;
```

### testCloseTroveReducesAggWeightedDebtSumByTrovesWeightedRecordedDebt()

- **Signature**: `testCloseTroveReducesAggWeightedDebtSumByTrovesWeightedRecordedDebt()`
- **Visibility**: public
- **Source Range**: 25071:1166:306
- **Details**: [function_testCloseTroveReducesAggWeightedDebtSumByTrovesWeightedRecordedDebt.md](./function_testCloseTroveReducesAggWeightedDebtSumByTrovesWeightedRecordedDebt.md)

**Signature:**
```solidity
function testCloseTroveReducesAggWeightedDebtSumByTrovesWeightedRecordedDebt() public;
```

### testCloseTroveReducesBorrowerBoldBalByEntireTroveDebtLessGasComp()

- **Signature**: `testCloseTroveReducesBorrowerBoldBalByEntireTroveDebtLessGasComp()`
- **Visibility**: public
- **Source Range**: 26243:920:306
- **Details**: [function_testCloseTroveReducesBorrowerBoldBalByEntireTroveDebtLessGasComp.md](./function_testCloseTroveReducesBorrowerBoldBalByEntireTroveDebtLessGasComp.md)

**Signature:**
```solidity
function testCloseTroveReducesBorrowerBoldBalByEntireTroveDebtLessGasComp() public;
```

### testAdjustTroveInterestRateWithNoPendingDebtGainIncreasesAggRecordedDebtByPendingAggInterest()

- **Signature**: `testAdjustTroveInterestRateWithNoPendingDebtGainIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 27209:830:306
- **Details**: [function_testAdjustTroveInterestRateWithNoPendingDebtGainIncreasesAggRecordedDebtByPendingAggInterest.md](./function_testAdjustTroveInterestRateWithNoPendingDebtGainIncreasesAggRecordedDebtByPendingAggInterest.md)

**Signature:**
```solidity
function testAdjustTroveInterestRateWithNoPendingDebtGainIncreasesAggRecordedDebtByPendingAggInterest() public;
```

### testAdjustTroveInterestRateReducesPendingAggInterestTo0()

- **Signature**: `testAdjustTroveInterestRateReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 28045:493:306
- **Details**: [function_testAdjustTroveInterestRateReducesPendingAggInterestTo0.md](./function_testAdjustTroveInterestRateReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testAdjustTroveInterestRateReducesPendingAggInterestTo0() public;
```

### testAdjustTroveInterestRateUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testAdjustTroveInterestRateUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 28587:684:306
- **Details**: [function_testAdjustTroveInterestRateUpdatesLastAggUpdateTimeToNow.md](./function_testAdjustTroveInterestRateUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testAdjustTroveInterestRateUpdatesLastAggUpdateTimeToNow() public;
```

### testAdjustTroveInterestRateMintsAggInterestToSP()

- **Signature**: `testAdjustTroveInterestRateMintsAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 29309:935:306
- **Details**: [function_testAdjustTroveInterestRateMintsAggInterestToSP.md](./function_testAdjustTroveInterestRateMintsAggInterestToSP.md)

**Signature:**
```solidity
function testAdjustTroveInterestRateMintsAggInterestToSP() public;
```

### testAdjustTroveInterestRateAdjustsWeightedDebtSumCorrectly()

- **Signature**: `testAdjustTroveInterestRateAdjustsWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 30309:1200:306
- **Details**: [function_testAdjustTroveInterestRateAdjustsWeightedDebtSumCorrectly.md](./function_testAdjustTroveInterestRateAdjustsWeightedDebtSumCorrectly.md)

**Signature:**
```solidity
function testAdjustTroveInterestRateAdjustsWeightedDebtSumCorrectly() public;
```

### testWithdrawBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestPlusBorrowerDebtChange()

- **Signature**: `testWithdrawBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestPlusBorrowerDebtChange()`
- **Visibility**: public
- **Source Range**: 31550:984:306
- **Details**: [function_testWithdrawBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestPlusBorrowerDebtChange.md](./function_testWithdrawBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestPlusBorrowerDebtChange.md)

**Signature:**
```solidity
function testWithdrawBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestPlusBorrowerDebtChange() public;
```

### testWithdrawBoldReducesPendingAggInterestTo0()

- **Signature**: `testWithdrawBoldReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 32540:551:306
- **Details**: [function_testWithdrawBoldReducesPendingAggInterestTo0.md](./function_testWithdrawBoldReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testWithdrawBoldReducesPendingAggInterestTo0() public;
```

### testWithdrawBoldMintsAggInterestAndUpfrontFeeToSP()

- **Signature**: `testWithdrawBoldMintsAggInterestAndUpfrontFeeToSP()`
- **Visibility**: public
- **Source Range**: 33097:872:306
- **Details**: [function_testWithdrawBoldMintsAggInterestAndUpfrontFeeToSP.md](./function_testWithdrawBoldMintsAggInterestAndUpfrontFeeToSP.md)

**Signature:**
```solidity
function testWithdrawBoldMintsAggInterestAndUpfrontFeeToSP() public;
```

### testWithdrawBoldUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testWithdrawBoldUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 34018:707:306
- **Details**: [function_testWithdrawBoldUpdatesLastAggUpdateTimeToNow.md](./function_testWithdrawBoldUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testWithdrawBoldUpdatesLastAggUpdateTimeToNow() public;
```

### testWithdrawBoldAdjustsWeightedDebtSumCorrectly()

- **Signature**: `testWithdrawBoldAdjustsWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 34731:1159:306
- **Details**: [function_testWithdrawBoldAdjustsWeightedDebtSumCorrectly.md](./function_testWithdrawBoldAdjustsWeightedDebtSumCorrectly.md)

**Signature:**
```solidity
function testWithdrawBoldAdjustsWeightedDebtSumCorrectly() public;
```

### testRepayBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestMinusBorrowerDebtChange()

- **Signature**: `testRepayBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestMinusBorrowerDebtChange()`
- **Visibility**: public
- **Source Range**: 35928:815:306
- **Details**: [function_testRepayBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestMinusBorrowerDebtChange.md](./function_testRepayBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestMinusBorrowerDebtChange.md)

**Signature:**
```solidity
function testRepayBoldWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterestMinusBorrowerDebtChange() public;
```

### testRepayBoldReducesPendingAggInterestTo0()

- **Signature**: `testRepayBoldReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 36749:535:306
- **Details**: [function_testRepayBoldReducesPendingAggInterestTo0.md](./function_testRepayBoldReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testRepayBoldReducesPendingAggInterestTo0() public;
```

### testRepayBoldMintsAggInterestToSP()

- **Signature**: `testRepayBoldMintsAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 37290:812:306
- **Details**: [function_testRepayBoldMintsAggInterestToSP.md](./function_testRepayBoldMintsAggInterestToSP.md)

**Signature:**
```solidity
function testRepayBoldMintsAggInterestToSP() public;
```

### testRepayBoldUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testRepayBoldUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 38108:691:306
- **Details**: [function_testRepayBoldUpdatesLastAggUpdateTimeToNow.md](./function_testRepayBoldUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testRepayBoldUpdatesLastAggUpdateTimeToNow() public;
```

### testRepayBoldAdjustsWeightedDebtSumCorrectly()

- **Signature**: `testRepayBoldAdjustsWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 38805:1143:306
- **Details**: [function_testRepayBoldAdjustsWeightedDebtSumCorrectly.md](./function_testRepayBoldAdjustsWeightedDebtSumCorrectly.md)

**Signature:**
```solidity
function testRepayBoldAdjustsWeightedDebtSumCorrectly() public;
```

### testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()

- **Signature**: `testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 39985:786:306
- **Details**: [function_testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest.md](./function_testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest.md)

**Signature:**
```solidity
function testAddCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest() public;
```

### testAddCollReducesPendingAggInterestTo0()

- **Signature**: `testAddCollReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 40777:530:306
- **Details**: [function_testAddCollReducesPendingAggInterestTo0.md](./function_testAddCollReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testAddCollReducesPendingAggInterestTo0() public;
```

### testAddCollMintsAggInterestToSP()

- **Signature**: `testAddCollMintsAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 41313:742:306
- **Details**: [function_testAddCollMintsAggInterestToSP.md](./function_testAddCollMintsAggInterestToSP.md)

**Signature:**
```solidity
function testAddCollMintsAggInterestToSP() public;
```

### testAddCollUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testAddCollUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 42061:686:306
- **Details**: [function_testAddCollUpdatesLastAggUpdateTimeToNow.md](./function_testAddCollUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testAddCollUpdatesLastAggUpdateTimeToNow() public;
```

### testAddCollAdjustsWeightedDebtSumCorrectly()

- **Signature**: `testAddCollAdjustsWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 42753:1292:306
- **Details**: [function_testAddCollAdjustsWeightedDebtSumCorrectly.md](./function_testAddCollAdjustsWeightedDebtSumCorrectly.md)

**Signature:**
```solidity
function testAddCollAdjustsWeightedDebtSumCorrectly() public;
```

### testWithdrawCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()

- **Signature**: `testWithdrawCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 44080:801:306
- **Details**: [function_testWithdrawCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest.md](./function_testWithdrawCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest.md)

**Signature:**
```solidity
function testWithdrawCollWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest() public;
```

### testWithdrawCollReducesPendingAggInterestTo0()

- **Signature**: `testWithdrawCollReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 44887:546:306
- **Details**: [function_testWithdrawCollReducesPendingAggInterestTo0.md](./function_testWithdrawCollReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testWithdrawCollReducesPendingAggInterestTo0() public;
```

### testWithdrawCollMintsAggInterestToSP()

- **Signature**: `testWithdrawCollMintsAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 45439:756:306
- **Details**: [function_testWithdrawCollMintsAggInterestToSP.md](./function_testWithdrawCollMintsAggInterestToSP.md)

**Signature:**
```solidity
function testWithdrawCollMintsAggInterestToSP() public;
```

### testWithdrawCollUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testWithdrawCollUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 46201:700:306
- **Details**: [function_testWithdrawCollUpdatesLastAggUpdateTimeToNow.md](./function_testWithdrawCollUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testWithdrawCollUpdatesLastAggUpdateTimeToNow() public;
```

### testWithdrawCollAdjustsWeightedDebtSumCorrectly()

- **Signature**: `testWithdrawCollAdjustsWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 46907:1306:306
- **Details**: [function_testWithdrawCollAdjustsWeightedDebtSumCorrectly.md](./function_testWithdrawCollAdjustsWeightedDebtSumCorrectly.md)

**Signature:**
```solidity
function testWithdrawCollAdjustsWeightedDebtSumCorrectly() public;
```

### testApplyTroveInterestPermissionlessWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()

- **Signature**: `testApplyTroveInterestPermissionlessWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 48252:930:306
- **Details**: [function_testApplyTroveInterestPermissionlessWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest.md](./function_testApplyTroveInterestPermissionlessWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest.md)

**Signature:**
```solidity
function testApplyTroveInterestPermissionlessWithNoRedistGainsIncreasesAggRecordedDebtByPendingAggInterest() public;
```

### testApplyTroveInterestPermissionlessReducesPendingAggInterestTo0()

- **Signature**: `testApplyTroveInterestPermissionlessReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 49188:692:306
- **Details**: [function_testApplyTroveInterestPermissionlessReducesPendingAggInterestTo0.md](./function_testApplyTroveInterestPermissionlessReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testApplyTroveInterestPermissionlessReducesPendingAggInterestTo0() public;
```

### testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP()

- **Signature**: `testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 49886:1003:306
- **Details**: [function_testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP.md](./function_testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP.md)

**Signature:**
```solidity
function testApplyTroveInterestPermissionlessMintsPendingAggInterestToSP() public;
```

### testApplyTroveInterestPermissionlessUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testApplyTroveInterestPermissionlessUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 50895:819:306
- **Details**: [function_testApplyTroveInterestPermissionlessUpdatesLastAggUpdateTimeToNow.md](./function_testApplyTroveInterestPermissionlessUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testApplyTroveInterestPermissionlessUpdatesLastAggUpdateTimeToNow() public;
```

### testApplyTroveInterestPermissionlessAdjustsWeightedDebtSumCorrectly()

- **Signature**: `testApplyTroveInterestPermissionlessAdjustsWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 51720:1425:306
- **Details**: [function_testApplyTroveInterestPermissionlessAdjustsWeightedDebtSumCorrectly.md](./function_testApplyTroveInterestPermissionlessAdjustsWeightedDebtSumCorrectly.md)

**Signature:**
```solidity
function testApplyTroveInterestPermissionlessAdjustsWeightedDebtSumCorrectly() public;
```

### testGetEntireSystemDebtReturns0For0TrovesOpen()

- **Signature**: `testGetEntireSystemDebtReturns0For0TrovesOpen()`
- **Visibility**: public
- **Source Range**: 53192:344:306
- **Details**: [function_testGetEntireSystemDebtReturns0For0TrovesOpen.md](./function_testGetEntireSystemDebtReturns0For0TrovesOpen.md)

**Signature:**
```solidity
function testGetEntireSystemDebtReturns0For0TrovesOpen() public;
```

### testGetEntireSystemDebtWithNoInterestAndNoRedistGainsReturnsSumOfTroveRecordedDebts()

- **Signature**: `testGetEntireSystemDebtWithNoInterestAndNoRedistGainsReturnsSumOfTroveRecordedDebts()`
- **Visibility**: public
- **Source Range**: 53542:1098:306
- **Details**: [function_testGetEntireSystemDebtWithNoInterestAndNoRedistGainsReturnsSumOfTroveRecordedDebts.md](./function_testGetEntireSystemDebtWithNoInterestAndNoRedistGainsReturnsSumOfTroveRecordedDebts.md)

**Signature:**
```solidity
function testGetEntireSystemDebtWithNoInterestAndNoRedistGainsReturnsSumOfTroveRecordedDebts() public;
```

### testGetEntireSystemDebtWithNoRedistGainsReturnsSumOfTroveRecordedDebtsPlusIndividualInterests()

- **Signature**: `testGetEntireSystemDebtWithNoRedistGainsReturnsSumOfTroveRecordedDebtsPlusIndividualInterests()`
- **Visibility**: public
- **Source Range**: 54646:1734:306
- **Details**: [function_testGetEntireSystemDebtWithNoRedistGainsReturnsSumOfTroveRecordedDebtsPlusIndividualInterests.md](./function_testGetEntireSystemDebtWithNoRedistGainsReturnsSumOfTroveRecordedDebtsPlusIndividualInterests.md)

**Signature:**
```solidity
function testGetEntireSystemDebtWithNoRedistGainsReturnsSumOfTroveRecordedDebtsPlusIndividualInterests() public;
```

### testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly()

- **Signature**: `testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly()`
- **Visibility**: public
- **Source Range**: 56488:1906:306
- **Details**: [function_testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly.md](./function_testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureOffsetChangesAggRecordedInterestCorrectly() public;
```

### testBatchLiquidateTrovesPureOffsetReducesAggPendingInterestTo0()

- **Signature**: `testBatchLiquidateTrovesPureOffsetReducesAggPendingInterestTo0()`
- **Visibility**: public
- **Source Range**: 58400:599:306
- **Details**: [function_testBatchLiquidateTrovesPureOffsetReducesAggPendingInterestTo0.md](./function_testBatchLiquidateTrovesPureOffsetReducesAggPendingInterestTo0.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureOffsetReducesAggPendingInterestTo0() public;
```

### testBatchLiquidateTrovesPureOffsetMintsAggInterestToSP()

- **Signature**: `testBatchLiquidateTrovesPureOffsetMintsAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 59033:1173:306
- **Details**: [function_testBatchLiquidateTrovesPureOffsetMintsAggInterestToSP.md](./function_testBatchLiquidateTrovesPureOffsetMintsAggInterestToSP.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureOffsetMintsAggInterestToSP() public;
```

### testBatchLiquidateTrovesPureOffsetUpdatesLastAggInterestUpdateTimeToNow()

- **Signature**: `testBatchLiquidateTrovesPureOffsetUpdatesLastAggInterestUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 60212:734:306
- **Details**: [function_testBatchLiquidateTrovesPureOffsetUpdatesLastAggInterestUpdateTimeToNow.md](./function_testBatchLiquidateTrovesPureOffsetUpdatesLastAggInterestUpdateTimeToNow.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureOffsetUpdatesLastAggInterestUpdateTimeToNow() public;
```

### testBatchLiquidateTrovesPureOffsetRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum()

- **Signature**: `testBatchLiquidateTrovesPureOffsetRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum()`
- **Visibility**: public
- **Source Range**: 61041:1526:306
- **Details**: [function_testBatchLiquidateTrovesPureOffsetRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum.md](./function_testBatchLiquidateTrovesPureOffsetRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureOffsetRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum() public;
```

### testBatchLiquidateTrovesPureRedistChangesAggRecordedInterestCorrectly()

- **Signature**: `testBatchLiquidateTrovesPureRedistChangesAggRecordedInterestCorrectly()`
- **Visibility**: public
- **Source Range**: 62648:2023:306
- **Details**: [function_testBatchLiquidateTrovesPureRedistChangesAggRecordedInterestCorrectly.md](./function_testBatchLiquidateTrovesPureRedistChangesAggRecordedInterestCorrectly.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureRedistChangesAggRecordedInterestCorrectly() public;
```

### testBatchLiquidateTrovesPureRedistReducesAggPendingInterestTo0()

- **Signature**: `testBatchLiquidateTrovesPureRedistReducesAggPendingInterestTo0()`
- **Visibility**: public
- **Source Range**: 64677:716:306
- **Details**: [function_testBatchLiquidateTrovesPureRedistReducesAggPendingInterestTo0.md](./function_testBatchLiquidateTrovesPureRedistReducesAggPendingInterestTo0.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureRedistReducesAggPendingInterestTo0() public;
```

### testBatchLiquidateTrovesPureRedistMintsAggInterestToSP()

- **Signature**: `testBatchLiquidateTrovesPureRedistMintsAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 65427:1060:306
- **Details**: [function_testBatchLiquidateTrovesPureRedistMintsAggInterestToSP.md](./function_testBatchLiquidateTrovesPureRedistMintsAggInterestToSP.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureRedistMintsAggInterestToSP() public;
```

### testBatchLiquidateTrovesPureRedistUpdatesLastAggInterestUpdateTimeToNow()

- **Signature**: `testBatchLiquidateTrovesPureRedistUpdatesLastAggInterestUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 66493:851:306
- **Details**: [function_testBatchLiquidateTrovesPureRedistUpdatesLastAggInterestUpdateTimeToNow.md](./function_testBatchLiquidateTrovesPureRedistUpdatesLastAggInterestUpdateTimeToNow.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureRedistUpdatesLastAggInterestUpdateTimeToNow() public;
```

### testBatchLiquidateTrovesPureRedistRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum()

- **Signature**: `testBatchLiquidateTrovesPureRedistRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum()`
- **Visibility**: public
- **Source Range**: 67439:1643:306
- **Details**: [function_testBatchLiquidateTrovesPureRedistRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum.md](./function_testBatchLiquidateTrovesPureRedistRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureRedistRemovesLiquidatedTrovesWeightedRecordedDebtsFromWeightedRecordedDebtSum() public;
```

### testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum()

- **Signature**: `testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum()`
- **Visibility**: public
- **Source Range**: 69088:1473:306
- **Details**: [function_testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum.md](./function_testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum.md)

**Signature:**
```solidity
function testBatchLiquidateTrovesPureRedistWithNoRedistGainAddsLiquidatedTrovesEntireDebtsToDefaultPoolDebtSum() public;
```

### testGetTCRReturnsMaxUint256ForEmptySystem()

- **Signature**: `testGetTCRReturnsMaxUint256ForEmptySystem()`
- **Visibility**: public
- **Source Range**: 70593:205:306
- **Details**: [function_testGetTCRReturnsMaxUint256ForEmptySystem.md](./function_testGetTCRReturnsMaxUint256ForEmptySystem.md)

**Signature:**
```solidity
function testGetTCRReturnsMaxUint256ForEmptySystem() public;
```

### testGetTCRReturnsICRofTroveForSystemWithOneTrove()

- **Signature**: `testGetTCRReturnsICRofTroveForSystemWithOneTrove()`
- **Visibility**: public
- **Source Range**: 70804:614:306
- **Details**: [function_testGetTCRReturnsICRofTroveForSystemWithOneTrove.md](./function_testGetTCRReturnsICRofTroveForSystemWithOneTrove.md)

**Signature:**
```solidity
function testGetTCRReturnsICRofTroveForSystemWithOneTrove() public;
```

### testGetTCRReturnsSizeWeightedRatioForSystemWithMultipleTroves()

- **Signature**: `testGetTCRReturnsSizeWeightedRatioForSystemWithMultipleTroves()`
- **Visibility**: public
- **Source Range**: 71424:1282:306
- **Details**: [function_testGetTCRReturnsSizeWeightedRatioForSystemWithMultipleTroves.md](./function_testGetTCRReturnsSizeWeightedRatioForSystemWithMultipleTroves.md)

**Signature:**
```solidity
function testGetTCRReturnsSizeWeightedRatioForSystemWithMultipleTroves() public;
```

### testGetTCRIncorporatesTroveInterestForSystemWithSingleTrove()

- **Signature**: `testGetTCRIncorporatesTroveInterestForSystemWithSingleTrove()`
- **Visibility**: public
- **Source Range**: 72712:664:306
- **Details**: [function_testGetTCRIncorporatesTroveInterestForSystemWithSingleTrove.md](./function_testGetTCRIncorporatesTroveInterestForSystemWithSingleTrove.md)

**Signature:**
```solidity
function testGetTCRIncorporatesTroveInterestForSystemWithSingleTrove() public;
```

### testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves()

- **Signature**: `testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves()`
- **Visibility**: public
- **Source Range**: 73382:1921:306
- **Details**: [function_testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves.md](./function_testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves.md)

**Signature:**
```solidity
function testGetTCRIncorporatesAllTroveInterestForSystemWithMultipleTroves() public;
```

### testGetCurrentICRReturnsInfinityForNonExistentTrove()

- **Signature**: `testGetCurrentICRReturnsInfinityForNonExistentTrove()`
- **Visibility**: public
- **Source Range**: 75370:243:306
- **Details**: [function_testGetCurrentICRReturnsInfinityForNonExistentTrove.md](./function_testGetCurrentICRReturnsInfinityForNonExistentTrove.md)

**Signature:**
```solidity
function testGetCurrentICRReturnsInfinityForNonExistentTrove() public;
```

### testGetCurrentICRReturnsCorrectValueForNoInterest()

- **Signature**: `testGetCurrentICRReturnsCorrectValueForNoInterest()`
- **Visibility**: public
- **Source Range**: 75619:556:306
- **Details**: [function_testGetCurrentICRReturnsCorrectValueForNoInterest.md](./function_testGetCurrentICRReturnsCorrectValueForNoInterest.md)

**Signature:**
```solidity
function testGetCurrentICRReturnsCorrectValueForNoInterest() public;
```

### testGetCurrentICRReturnsCorrectValueWithAccruedInterest()

- **Signature**: `testGetCurrentICRReturnsCorrectValueWithAccruedInterest()`
- **Visibility**: public
- **Source Range**: 76181:696:306
- **Details**: [function_testGetCurrentICRReturnsCorrectValueWithAccruedInterest.md](./function_testGetCurrentICRReturnsCorrectValueWithAccruedInterest.md)

**Signature:**
```solidity
function testGetCurrentICRReturnsCorrectValueWithAccruedInterest() public;
```

### testRedemptionWithNoRedistGainsChangesAggRecordedDebtCorrectly()

- **Signature**: `testRedemptionWithNoRedistGainsChangesAggRecordedDebtCorrectly()`
- **Visibility**: public
- **Source Range**: 76917:695:306
- **Details**: [function_testRedemptionWithNoRedistGainsChangesAggRecordedDebtCorrectly.md](./function_testRedemptionWithNoRedistGainsChangesAggRecordedDebtCorrectly.md)

**Signature:**
```solidity
function testRedemptionWithNoRedistGainsChangesAggRecordedDebtCorrectly() public;
```

### testRedemptionReducesPendingAggInterestTo0()

- **Signature**: `testRedemptionReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 77618:563:306
- **Details**: [function_testRedemptionReducesPendingAggInterestTo0.md](./function_testRedemptionReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testRedemptionReducesPendingAggInterestTo0() public;
```

### testRedemptionMintsPendingAggInterestToSP()

- **Signature**: `testRedemptionMintsPendingAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 78187:782:306
- **Details**: [function_testRedemptionMintsPendingAggInterestToSP.md](./function_testRedemptionMintsPendingAggInterestToSP.md)

**Signature:**
```solidity
function testRedemptionMintsPendingAggInterestToSP() public;
```

### testRedemptionUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testRedemptionUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 78975:599:306
- **Details**: [function_testRedemptionUpdatesLastAggUpdateTimeToNow.md](./function_testRedemptionUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testRedemptionUpdatesLastAggUpdateTimeToNow() public;
```

### testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly()

- **Signature**: `testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly()`
- **Visibility**: public
- **Source Range**: 79580:1816:306
- **Details**: [function_testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly.md](./function_testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly.md)

**Signature:**
```solidity
function testRedemptionWithNoRedistGainsChangesWeightedDebtSumCorrectly() public;
```

### testNoDoubleInterestOnPendingRedistribution()

- **Signature**: `testNoDoubleInterestOnPendingRedistribution()`
- **Visibility**: public
- **Source Range**: 81809:1564:306
- **Details**: [function_testNoDoubleInterestOnPendingRedistribution.md](./function_testNoDoubleInterestOnPendingRedistribution.md)

**Signature:**
```solidity
function testNoDoubleInterestOnPendingRedistribution() public;
```

### testClaimAllCollGainsIncreasesAggRecordedDebtByPendingAggInterest()

- **Signature**: `testClaimAllCollGainsIncreasesAggRecordedDebtByPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 83413:849:306
- **Details**: [function_testClaimAllCollGainsIncreasesAggRecordedDebtByPendingAggInterest.md](./function_testClaimAllCollGainsIncreasesAggRecordedDebtByPendingAggInterest.md)

**Signature:**
```solidity
function testClaimAllCollGainsIncreasesAggRecordedDebtByPendingAggInterest() public;
```

### testClaimAllCollGainsReducesPendingAggInterestTo0()

- **Signature**: `testClaimAllCollGainsReducesPendingAggInterestTo0()`
- **Visibility**: public
- **Source Range**: 84268:640:306
- **Details**: [function_testClaimAllCollGainsReducesPendingAggInterestTo0.md](./function_testClaimAllCollGainsReducesPendingAggInterestTo0.md)

**Signature:**
```solidity
function testClaimAllCollGainsReducesPendingAggInterestTo0() public;
```

### testClaimAllCollGainsUpdatesLastAggUpdateTimeToNow()

- **Signature**: `testClaimAllCollGainsUpdatesLastAggUpdateTimeToNow()`
- **Visibility**: public
- **Source Range**: 84960:766:306
- **Details**: [function_testClaimAllCollGainsUpdatesLastAggUpdateTimeToNow.md](./function_testClaimAllCollGainsUpdatesLastAggUpdateTimeToNow.md)

**Signature:**
```solidity
function testClaimAllCollGainsUpdatesLastAggUpdateTimeToNow() public;
```

### testClaimAllCollGainsMintsAggInterestToSP()

- **Signature**: `testClaimAllCollGainsMintsAggInterestToSP()`
- **Visibility**: public
- **Source Range**: 85760:1207:306
- **Details**: [function_testClaimAllCollGainsMintsAggInterestToSP.md](./function_testClaimAllCollGainsMintsAggInterestToSP.md)

**Signature:**
```solidity
function testClaimAllCollGainsMintsAggInterestToSP() public;
```

### testActivePoolCalculatesApproxAvgInterestRate()

- **Signature**: `testActivePoolCalculatesApproxAvgInterestRate()`
- **Visibility**: public
- **Source Range**: 86973:1108:306
- **Details**: [function_testActivePoolCalculatesApproxAvgInterestRate.md](./function_testActivePoolCalculatesApproxAvgInterestRate.md)

**Signature:**
```solidity
function testActivePoolCalculatesApproxAvgInterestRate() public;
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

### createAccounts() (inherited from TestAccounts)

- **Signature**: `createAccounts()`
- **Visibility**: public
- **Source Range**: 1325:270:248
- **Details**: [function_createAccounts.md](./function_createAccounts.md)

**Signature:**
```solidity
function createAccounts() public;
```

### addressToTroveId(address,address,uint256) (inherited from TroveId)

- **Signature**: `addressToTroveId(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 81:194:294
- **Details**: [function_addressToTroveId_address_address_uint256.md](./function_addressToTroveId_address_address_uint256.md)

**Signature:**
```solidity
function addressToTroveId(address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveId(address,uint256) (inherited from TroveId)

- **Signature**: `addressToTroveId(address,uint256)`
- **Visibility**: public
- **Source Range**: 281:162:294
- **Details**: [function_addressToTroveId_address_uint256.md](./function_addressToTroveId_address_uint256.md)

**Signature:**
```solidity
function addressToTroveId(address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveId(address) (inherited from TroveId)

- **Signature**: `addressToTroveId(address)`
- **Visibility**: public
- **Source Range**: 449:123:294
- **Details**: [function_addressToTroveId_address.md](./function_addressToTroveId_address.md)

**Signature:**
```solidity
function addressToTroveId(address _owner) public pure returns (uint256);
```

### addressToTroveIdThroughZapper(address,address,address,uint256) (inherited from TroveId)

- **Signature**: `addressToTroveIdThroughZapper(address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 578:324:294
- **Details**: [function_addressToTroveIdThroughZapper_address_address_address_uint256.md](./function_addressToTroveIdThroughZapper_address_address_address_uint256.md)

**Signature:**
```solidity
function addressToTroveIdThroughZapper(address _zapper, address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveIdThroughZapper(address,address,uint256) (inherited from TroveId)

- **Signature**: `addressToTroveIdThroughZapper(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 908:242:294
- **Details**: [function_addressToTroveIdThroughZapper_address_address_uint256.md](./function_addressToTroveIdThroughZapper_address_address_uint256.md)

**Signature:**
```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner, uint256 _ownerIndex) public pure returns (uint256);
```

### addressToTroveIdThroughZapper(address,address) (inherited from TroveId)

- **Signature**: `addressToTroveIdThroughZapper(address,address)`
- **Visibility**: public
- **Source Range**: 1156:175:294
- **Details**: [function_addressToTroveIdThroughZapper_address_address.md](./function_addressToTroveIdThroughZapper_address_address.md)

**Signature:**
```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner) public pure returns (uint256);
```

### openTroveNoHints100pct(address,uint256,uint256,uint256) (inherited from BaseTest)

- **Signature**: `openTroveNoHints100pct(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6736:267:254
- **Details**: [function_openTroveNoHints100pct_address_uint256_uint256_uint256.md](./function_openTroveNoHints100pct_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function openTroveNoHints100pct(address _account, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId);
```

### openTroveNoHints100pctWithIndex(address,uint256,uint256,uint256,uint256) (inherited from BaseTest)

- **Signature**: `openTroveNoHints100pctWithIndex(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 7009:323:254
- **Details**: [function_openTroveNoHints100pctWithIndex_address_uint256_uint256_uint256_uint256.md](./function_openTroveNoHints100pctWithIndex_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function openTroveNoHints100pctWithIndex(address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId);
```

### openTroveHelper(address,uint256,uint256,uint256,uint256) (inherited from BaseTest)

- **Signature**: `openTroveHelper(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 7338:704:254
- **Details**: [function_openTroveHelper_address_uint256_uint256_uint256_uint256.md](./function_openTroveHelper_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function openTroveHelper(address _account, uint256 _index, uint256 _coll, uint256 _boldAmount, uint256 _annualInterestRate) public returns (uint256 troveId, uint256 upfrontFee);
```

### openTroveWithExactDebt(address,uint256,uint256,uint256,uint256) (inherited from BaseTest)

- **Signature**: `openTroveWithExactDebt(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8048:508:254
- **Details**: [function_openTroveWithExactDebt_address_uint256_uint256_uint256_uint256.md](./function_openTroveWithExactDebt_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function openTroveWithExactDebt(address _account, uint256 _index, uint256 _coll, uint256 _debt, uint256 _interestRate) public returns (uint256 troveId);
```

### openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256) (inherited from BaseTest)

- **Signature**: `openTroveWithExactICRAndDebt(address,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 8562:619:254
- **Details**: [function_openTroveWithExactICRAndDebt_address_uint256_uint256_uint256_uint256.md](./function_openTroveWithExactICRAndDebt_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function openTroveWithExactICRAndDebt(address _account, uint256 _index, uint256 _ICR, uint256 _debt, uint256 _interestRate) public returns (uint256 troveId, uint256 coll);
```

### adjustTrove100pct(address,uint256,uint256,uint256,bool,bool) (inherited from BaseTest)

- **Signature**: `adjustTrove100pct(address,uint256,uint256,uint256,bool,bool)`
- **Visibility**: public
- **Source Range**: 9187:605:254
- **Details**: [function_adjustTrove100pct_address_uint256_uint256_uint256_bool_bool.md](./function_adjustTrove100pct_address_uint256_uint256_uint256_bool_bool.md)

**Signature:**
```solidity
function adjustTrove100pct(address _account, uint256 _troveId, uint256 _collChange, uint256 _boldChange, bool _isCollIncrease, bool _isDebtIncrease) public;
```

### adjustZombieTrove(address,uint256,uint256,bool,uint256,bool) (inherited from BaseTest)

- **Signature**: `adjustZombieTrove(address,uint256,uint256,bool,uint256,bool)`
- **Visibility**: public
- **Source Range**: 9798:669:254
- **Details**: [function_adjustZombieTrove_address_uint256_uint256_bool_uint256_bool.md](./function_adjustZombieTrove_address_uint256_uint256_bool_uint256_bool.md)

**Signature:**
```solidity
function adjustZombieTrove(address _account, uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease) public;
```

### changeInterestRateNoHints(address,uint256,uint256) (inherited from BaseTest)

- **Signature**: `changeInterestRateNoHints(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 10473:420:254
- **Details**: [function_changeInterestRateNoHints_address_uint256_uint256.md](./function_changeInterestRateNoHints_address_uint256_uint256.md)

**Signature:**
```solidity
function changeInterestRateNoHints(address _account, uint256 _troveId, uint256 _newAnnualInterestRate) public returns (uint256 upfrontFee);
```

### checkBelowCriticalThreshold(bool) (inherited from BaseTest)

- **Signature**: `checkBelowCriticalThreshold(bool)`
- **Visibility**: public
- **Source Range**: 10899:250:254
- **Details**: [function_checkBelowCriticalThreshold_bool.md](./function_checkBelowCriticalThreshold_bool.md)

**Signature:**
```solidity
function checkBelowCriticalThreshold(bool _true) public view;
```

### makeSPDepositAndClaim(address,uint256) (inherited from BaseTest)

- **Signature**: `makeSPDepositAndClaim(address,uint256)`
- **Visibility**: public
- **Source Range**: 11155:187:254
- **Details**: [function_makeSPDepositAndClaim_address_uint256.md](./function_makeSPDepositAndClaim_address_uint256.md)

**Signature:**
```solidity
function makeSPDepositAndClaim(address _account, uint256 _amount) public;
```

### makeSPDepositNoClaim(address,uint256) (inherited from BaseTest)

- **Signature**: `makeSPDepositNoClaim(address,uint256)`
- **Visibility**: public
- **Source Range**: 11348:187:254
- **Details**: [function_makeSPDepositNoClaim_address_uint256.md](./function_makeSPDepositNoClaim_address_uint256.md)

**Signature:**
```solidity
function makeSPDepositNoClaim(address _account, uint256 _amount) public;
```

### makeSPWithdrawalAndClaim(address,uint256) (inherited from BaseTest)

- **Signature**: `makeSPWithdrawalAndClaim(address,uint256)`
- **Visibility**: public
- **Source Range**: 11541:193:254
- **Details**: [function_makeSPWithdrawalAndClaim_address_uint256.md](./function_makeSPWithdrawalAndClaim_address_uint256.md)

**Signature:**
```solidity
function makeSPWithdrawalAndClaim(address _account, uint256 _amount) public;
```

### makeSPWithdrawalNoClaim(address,uint256) (inherited from BaseTest)

- **Signature**: `makeSPWithdrawalNoClaim(address,uint256)`
- **Visibility**: public
- **Source Range**: 11740:193:254
- **Details**: [function_makeSPWithdrawalNoClaim_address_uint256.md](./function_makeSPWithdrawalNoClaim_address_uint256.md)

**Signature:**
```solidity
function makeSPWithdrawalNoClaim(address _account, uint256 _amount) public;
```

### claimAllCollGains(address) (inherited from BaseTest)

- **Signature**: `claimAllCollGains(address)`
- **Visibility**: public
- **Source Range**: 11939:159:254
- **Details**: [function_claimAllCollGains_address.md](./function_claimAllCollGains_address.md)

**Signature:**
```solidity
function claimAllCollGains(address _account) public;
```

### closeTrove(address,uint256) (inherited from BaseTest)

- **Signature**: `closeTrove(address,uint256)`
- **Visibility**: public
- **Source Range**: 12104:176:254
- **Details**: [function_closeTrove_address_uint256.md](./function_closeTrove_address_uint256.md)

**Signature:**
```solidity
function closeTrove(address _account, uint256 _troveId) public;
```

### withdrawBold100pct(address,uint256,uint256) (inherited from BaseTest)

- **Signature**: `withdrawBold100pct(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 12286:279:254
- **Details**: [function_withdrawBold100pct_address_uint256_uint256.md](./function_withdrawBold100pct_address_uint256_uint256.md)

**Signature:**
```solidity
function withdrawBold100pct(address _account, uint256 _troveId, uint256 _debtIncrease) public;
```

### repayBold(address,uint256,uint256) (inherited from BaseTest)

- **Signature**: `repayBold(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 12571:212:254
- **Details**: [function_repayBold_address_uint256_uint256.md](./function_repayBold_address_uint256_uint256.md)

**Signature:**
```solidity
function repayBold(address _account, uint256 _troveId, uint256 _debtDecrease) public;
```

### addColl(address,uint256,uint256) (inherited from BaseTest)

- **Signature**: `addColl(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 12789:208:254
- **Details**: [function_addColl_address_uint256_uint256.md](./function_addColl_address_uint256_uint256.md)

**Signature:**
```solidity
function addColl(address _account, uint256 _troveId, uint256 _collIncrease) public;
```

### withdrawColl(address,uint256,uint256) (inherited from BaseTest)

- **Signature**: `withdrawColl(address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 13003:218:254
- **Details**: [function_withdrawColl_address_uint256_uint256.md](./function_withdrawColl_address_uint256_uint256.md)

**Signature:**
```solidity
function withdrawColl(address _account, uint256 _troveId, uint256 _collDecrease) public;
```

### applyPendingDebt(address,uint256) (inherited from BaseTest)

- **Signature**: `applyPendingDebt(address,uint256)`
- **Visibility**: public
- **Source Range**: 13227:182:254
- **Details**: [function_applyPendingDebt_address_uint256.md](./function_applyPendingDebt_address_uint256.md)

**Signature:**
```solidity
function applyPendingDebt(address _from, uint256 _troveId) public;
```

### transferBold(address,address,uint256) (inherited from BaseTest)

- **Signature**: `transferBold(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 13415:177:254
- **Details**: [function_transferBold_address_address_uint256.md](./function_transferBold_address_address_uint256.md)

**Signature:**
```solidity
function transferBold(address _from, address _to, uint256 _amount) public;
```

### liquidate(address,uint256) (inherited from BaseTest)

- **Signature**: `liquidate(address,uint256)`
- **Visibility**: public
- **Source Range**: 13598:162:254
- **Details**: [function_liquidate_address_uint256.md](./function_liquidate_address_uint256.md)

**Signature:**
```solidity
function liquidate(address _from, uint256 _troveId) public;
```

### batchLiquidateTroves(address,uint256[]) (inherited from BaseTest)

- **Signature**: `batchLiquidateTroves(address,uint256[])`
- **Visibility**: public
- **Source Range**: 13766:199:254
- **Details**: [function_batchLiquidateTroves_address_uint256[].md](./function_batchLiquidateTroves_address_uint256[].md)

**Signature:**
```solidity
function batchLiquidateTroves(address _from, uint256[] memory _trovesList) public;
```

### redeem(address,uint256) (inherited from BaseTest)

- **Signature**: `redeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 13971:197:254
- **Details**: [function_redeem_address_uint256.md](./function_redeem_address_uint256.md)

**Signature:**
```solidity
function redeem(address _from, uint256 _boldAmount) public;
```

### getShareofSPReward(address,uint256) (inherited from BaseTest)

- **Signature**: `getShareofSPReward(address,uint256)`
- **Visibility**: public
- **Source Range**: 14174:218:254
- **Details**: [function_getShareofSPReward_address_uint256.md](./function_getShareofSPReward_address_uint256.md)

**Signature:**
```solidity
function getShareofSPReward(address _depositor, uint256 _reward) public view returns (uint256);
```

### logContractAddresses() (inherited from BaseTest)

- **Signature**: `logContractAddresses()`
- **Visibility**: public
- **Source Range**: 19255:645:254
- **Details**: [function_logContractAddresses.md](./function_logContractAddresses.md)

**Signature:**
```solidity
function logContractAddresses() public view;
```

### abs(uint256,uint256) (inherited from BaseTest)

- **Signature**: `abs(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 19906:110:254
- **Details**: [function_abs_uint256_uint256.md](./function_abs_uint256_uint256.md)

**Signature:**
```solidity
function abs(uint256 x, uint256 y) public pure returns (uint256);
```

### assertApproximatelyEqual(uint256,uint256,uint256) (inherited from BaseTest)

- **Signature**: `assertApproximatelyEqual(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 20022:142:254
- **Details**: [function_assertApproximatelyEqual_uint256_uint256_uint256.md](./function_assertApproximatelyEqual_uint256_uint256_uint256.md)

**Signature:**
```solidity
function assertApproximatelyEqual(uint256 _x, uint256 _y, uint256 _margin) public pure;
```

### assertApproximatelyEqual(uint256,uint256,uint256,string) (inherited from BaseTest)

- **Signature**: `assertApproximatelyEqual(uint256,uint256,uint256,string)`
- **Visibility**: public
- **Source Range**: 20170:170:254
- **Details**: [function_assertApproximatelyEqual_uint256_uint256_uint256_string.md](./function_assertApproximatelyEqual_uint256_uint256_uint256_string.md)

**Signature:**
```solidity
function assertApproximatelyEqual(uint256 _x, uint256 _y, uint256 _margin, string memory _reason) public pure;
```

### uintToArray(uint256) (inherited from BaseTest)

- **Signature**: `uintToArray(uint256)`
- **Visibility**: public
- **Source Range**: 20346:153:254
- **Details**: [function_uintToArray_uint256.md](./function_uintToArray_uint256.md)

**Signature:**
```solidity
function uintToArray(uint256 _value) public pure returns (uint256[] memory result);
```

### giveAndApproveColl(address,uint256) (inherited from DevTestSetup)

- **Signature**: `giveAndApproveColl(address,uint256)`
- **Visibility**: public
- **Source Range**: 176:177:261
- **Details**: [function_giveAndApproveColl_address_uint256.md](./function_giveAndApproveColl_address_uint256.md)

**Signature:**
```solidity
function giveAndApproveColl(address _account, uint256 _amount) public;
```

### giveAndApproveCollateral(contract IERC20,address,uint256,address) (inherited from DevTestSetup)

- **Signature**: `giveAndApproveCollateral(contract IERC20,address,uint256,address)`
- **Visibility**: public
- **Source Range**: 359:640:261
- **Details**: [function_giveAndApproveCollateral_contract_IERC20_address_uint256_address.md](./function_giveAndApproveCollateral_contract_IERC20_address_uint256_address.md)

**Signature:**
```solidity
function giveAndApproveCollateral(IERC20 _token, address _account, uint256 _amount, address _borrowerOperationsAddress) public;
```

### setUp() (inherited from DevTestSetup)

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1005:2175:261
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() virtual public;
```
