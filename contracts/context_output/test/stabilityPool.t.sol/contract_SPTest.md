# Contract: SPTest

## Metadata

- **Name**: SPTest
- **Type**: Contract
- **Path**: test/stabilityPool.t.sol

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

### ExpectedShareOfReward

```solidity
struct ExpectedShareOfReward {
    uint256 _1_A;
    uint256 _1_B;
    uint256 _2_A;
    uint256 _2_B;
    uint256 _2_C;
    uint256 _2_D;
    uint256 _3_A;
    uint256 _3_B;
    uint256 _3_C;
    uint256 _3_D;
}
```

### PendingAggInterest

```solidity
struct PendingAggInterest {
    uint256 _1;
    uint256 _2;
    uint256 _3;
}
```

### ExpectedSPYield

```solidity
struct ExpectedSPYield {
    uint256 _1;
    uint256 _2;
    uint256 _3;
}
```

### PTestVars

```solidity
struct PTestVars {
    uint256 storedVal;
    uint256 deposit1_A;
    uint256 deposit2_A;
    uint256 deposit1_B;
    uint256 deposit2_B;
    uint256 scale1;
    uint256 scale2;
    uint256 expectedSpYield1;
    uint256 expectedDeposit1_A;
    uint256 expectedDeposit2_A;
    uint256 expectedDeposit1_B;
    uint256 expectedDeposit2_B;
    uint256 expectedShareOfYield1_A;
    uint256 expectedShareOfYield1_B;
    uint256 expectedShareOfYield1_C;
    uint256 expectedShareOfYield1_D;
    uint256 troveDebt_C;
    uint256 troveDebt_D;
    uint256 totalSPBeforeLiq_C;
    uint256 totalSPBeforeLiq_D;
    uint256 expectedShareOfColl1_A;
    uint256 expectedShareOfColl1_B;
    uint256 expectedShareOfColl2_A;
    uint256 expectedShareOfColl2_B;
    uint256 boldGainA;
    uint256 boldGainB;
    uint256 boldGainC;
    uint256 boldGainD;
    uint256 spEthGain1;
    uint256 spEthGain2;
    uint256 ethGainA;
    uint256 ethGainB;
    uint256 ethGainC;
    uint256 ethGainD;
    uint256 expectedShareOfColl;
    uint256 spEthGain;
    uint256 totalDepositsBefore;
    uint256 spEthBal1;
    uint256 spEthBal2;
    uint256 initialBoldGainA;
    uint256 initialBoldGainB;
}
```

### LiqTestVars

```solidity
struct LiqTestVars {
    uint256 debtABefore;
    uint256 collABefore;
    uint256 debtBBefore;
    uint256 collBBefore;
    uint256 collCBefore;
    uint256 collGasComp;
    uint256 spCollBalBefore;
    uint256 spCollBalAfter;
    uint256 collToGiveToSP;
    uint256 collToRedist;
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

### testProvideToSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor()

- **Signature**: `testProvideToSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor()`
- **Visibility**: public
- **Source Range**: 3297:558:334
- **Details**: [function_testProvideToSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor.md](./function_testProvideToSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor() public;
```

### testProvideToSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain()

- **Signature**: `testProvideToSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain()`
- **Visibility**: public
- **Source Range**: 3861:400:334
- **Details**: [function_testProvideToSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain.md](./function_testProvideToSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain() public;
```

### testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor()

- **Signature**: `testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor()`
- **Visibility**: public
- **Source Range**: 4267:782:334
- **Details**: [function_testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor.md](./function_testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor() public;
```

### testProvideToSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance()

- **Signature**: `testProvideToSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance()`
- **Visibility**: public
- **Source Range**: 5055:445:334
- **Details**: [function_testProvideToSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance.md](./function_testProvideToSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance() public;
```

### testProvideToSPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor()

- **Signature**: `testProvideToSPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor()`
- **Visibility**: public
- **Source Range**: 5506:735:334
- **Details**: [function_testProvideToSPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor.md](./function_testProvideToSPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor() public;
```

### testProvideToSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance()

- **Signature**: `testProvideToSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance()`
- **Visibility**: public
- **Source Range**: 6247:601:334
- **Details**: [function_testProvideToSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance.md](./function_testProvideToSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance() public;
```

### testProvideToSPWithClaim_WithOnlyCurrentBOLDGainsSendsTotalBOLDGainToDepositor()

- **Signature**: `testProvideToSPWithClaim_WithOnlyCurrentBOLDGainsSendsTotalBOLDGainToDepositor()`
- **Visibility**: public
- **Source Range**: 6911:659:334
- **Details**: [function_testProvideToSPWithClaim_WithOnlyCurrentBOLDGainsSendsTotalBOLDGainToDepositor.md](./function_testProvideToSPWithClaim_WithOnlyCurrentBOLDGainsSendsTotalBOLDGainToDepositor.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithOnlyCurrentBOLDGainsSendsTotalBOLDGainToDepositor() public;
```

### testProvideToSPWithClaim_WithCurrentBOLDGainsZerosCurrentBOLDGains()

- **Signature**: `testProvideToSPWithClaim_WithCurrentBOLDGainsZerosCurrentBOLDGains()`
- **Visibility**: public
- **Source Range**: 7576:663:334
- **Details**: [function_testProvideToSPWithClaim_WithCurrentBOLDGainsZerosCurrentBOLDGains.md](./function_testProvideToSPWithClaim_WithCurrentBOLDGainsZerosCurrentBOLDGains.md)

**Signature:**
```solidity
function testProvideToSPWithClaim_WithCurrentBOLDGainsZerosCurrentBOLDGains() public;
```

### testProvideToSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance()

- **Signature**: `testProvideToSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance()`
- **Visibility**: public
- **Source Range**: 8303:437:334
- **Details**: [function_testProvideToSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance.md](./function_testProvideToSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance.md)

**Signature:**
```solidity
function testProvideToSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance() public;
```

### testProvideToSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains()

- **Signature**: `testProvideToSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains()`
- **Visibility**: public
- **Source Range**: 8746:478:334
- **Details**: [function_testProvideToSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains.md](./function_testProvideToSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains.md)

**Signature:**
```solidity
function testProvideToSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains() public;
```

### testProvideToSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance()

- **Signature**: `testProvideToSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance()`
- **Visibility**: public
- **Source Range**: 9230:334:334
- **Details**: [function_testProvideToSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance.md](./function_testProvideToSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance.md)

**Signature:**
```solidity
function testProvideToSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance() public;
```

### testProvideToSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedCollGainByCurrentGain()

- **Signature**: `testProvideToSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedCollGainByCurrentGain()`
- **Visibility**: public
- **Source Range**: 9570:613:334
- **Details**: [function_testProvideToSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedCollGainByCurrentGain.md](./function_testProvideToSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedCollGainByCurrentGain.md)

**Signature:**
```solidity
function testProvideToSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedCollGainByCurrentGain() public;
```

### testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeDepositorCollBalance()

- **Signature**: `testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeDepositorCollBalance()`
- **Visibility**: public
- **Source Range**: 10189:653:334
- **Details**: [function_testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeDepositorCollBalance.md](./function_testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeDepositorCollBalance.md)

**Signature:**
```solidity
function testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeDepositorCollBalance() public;
```

### testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain()

- **Signature**: `testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain()`
- **Visibility**: public
- **Source Range**: 10848:574:334
- **Details**: [function_testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain.md](./function_testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain.md)

**Signature:**
```solidity
function testProvideToSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain() public;
```

### testProvideToSPNoClaimAddsBOLDGainsToDeposit()

- **Signature**: `testProvideToSPNoClaimAddsBOLDGainsToDeposit()`
- **Visibility**: public
- **Source Range**: 11486:717:334
- **Details**: [function_testProvideToSPNoClaimAddsBOLDGainsToDeposit.md](./function_testProvideToSPNoClaimAddsBOLDGainsToDeposit.md)

**Signature:**
```solidity
function testProvideToSPNoClaimAddsBOLDGainsToDeposit() public;
```

### testProvideToSPNoClaimAddsBoldGainsToTotalBoldDeposits()

- **Signature**: `testProvideToSPNoClaimAddsBoldGainsToTotalBoldDeposits()`
- **Visibility**: public
- **Source Range**: 12209:733:334
- **Details**: [function_testProvideToSPNoClaimAddsBoldGainsToTotalBoldDeposits.md](./function_testProvideToSPNoClaimAddsBoldGainsToTotalBoldDeposits.md)

**Signature:**
```solidity
function testProvideToSPNoClaimAddsBoldGainsToTotalBoldDeposits() public;
```

### testProvideToSPNoClaimZerosCurrentBoldGains()

- **Signature**: `testProvideToSPNoClaimZerosCurrentBoldGains()`
- **Visibility**: public
- **Source Range**: 12948:552:334
- **Details**: [function_testProvideToSPNoClaimZerosCurrentBoldGains.md](./function_testProvideToSPNoClaimZerosCurrentBoldGains.md)

**Signature:**
```solidity
function testProvideToSPNoClaimZerosCurrentBoldGains() public;
```

### testProvideToSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp()

- **Signature**: `testProvideToSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp()`
- **Visibility**: public
- **Source Range**: 13506:637:334
- **Details**: [function_testProvideToSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp.md](./function_testProvideToSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp.md)

**Signature:**
```solidity
function testProvideToSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp() public;
```

### testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor()

- **Signature**: `testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor()`
- **Visibility**: public
- **Source Range**: 14208:564:334
- **Details**: [function_testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor.md](./function_testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor.md)

**Signature:**
```solidity
function testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsSendsTotalCollGainToDepositor() public;
```

### testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain()

- **Signature**: `testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain()`
- **Visibility**: public
- **Source Range**: 14778:406:334
- **Details**: [function_testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain.md](./function_testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain.md)

**Signature:**
```solidity
function testWithdrawFromSPWithClaim_WithOnlyCurrentCollGainsDoesntChangeStashedCollGain() public;
```

### testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor()

- **Signature**: `testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor()`
- **Visibility**: public
- **Source Range**: 15190:658:334
- **Details**: [function_testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor.md](./function_testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor.md)

**Signature:**
```solidity
function testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsSendsTotalCollGainToDepositor() public;
```

### testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance()

- **Signature**: `testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance()`
- **Visibility**: public
- **Source Range**: 15854:498:334
- **Details**: [function_testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance.md](./function_testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance.md)

**Signature:**
```solidity
function testWithdrawFromSPWithClaim_WithCurrentAndStashedCollGainsZerosStashedCollBalance() public;
```

### testWithdrawFromSPPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor()

- **Signature**: `testWithdrawFromSPPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor()`
- **Visibility**: public
- **Source Range**: 16358:742:334
- **Details**: [function_testWithdrawFromSPPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor.md](./function_testWithdrawFromSPPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor.md)

**Signature:**
```solidity
function testWithdrawFromSPPWithClaim_WithOnlyStashedCollGainsSendsStashedCollGainToDepositor() public;
```

### testWithdrawFromSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance()

- **Signature**: `testWithdrawFromSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance()`
- **Visibility**: public
- **Source Range**: 17106:607:334
- **Details**: [function_testWithdrawFromSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance.md](./function_testWithdrawFromSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance.md)

**Signature:**
```solidity
function testWithdrawFromSPWithClaim_WithOnlyStashedCollGainsZerosStashedCollBalance() public;
```

### testWithdrawFromSPWithClaim_WithCurrentBOLDGainsSendsBOLDGainToDepositor()

- **Signature**: `testWithdrawFromSPWithClaim_WithCurrentBOLDGainsSendsBOLDGainToDepositor()`
- **Visibility**: public
- **Source Range**: 17778:672:334
- **Details**: [function_testWithdrawFromSPWithClaim_WithCurrentBOLDGainsSendsBOLDGainToDepositor.md](./function_testWithdrawFromSPWithClaim_WithCurrentBOLDGainsSendsBOLDGainToDepositor.md)

**Signature:**
```solidity
function testWithdrawFromSPWithClaim_WithCurrentBOLDGainsSendsBOLDGainToDepositor() public;
```

### testWithdrawFromSPWithClaim_WithCurrentBOLDGainsZerosCurrentBoldGains()

- **Signature**: `testWithdrawFromSPWithClaim_WithCurrentBOLDGainsZerosCurrentBoldGains()`
- **Visibility**: public
- **Source Range**: 18456:637:334
- **Details**: [function_testWithdrawFromSPWithClaim_WithCurrentBOLDGainsZerosCurrentBoldGains.md](./function_testWithdrawFromSPWithClaim_WithCurrentBOLDGainsZerosCurrentBoldGains.md)

**Signature:**
```solidity
function testWithdrawFromSPWithClaim_WithCurrentBOLDGainsZerosCurrentBoldGains() public;
```

### testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance()

- **Signature**: `testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance()`
- **Visibility**: public
- **Source Range**: 19160:443:334
- **Details**: [function_testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance.md](./function_testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsDoesntChangeDepositorCollBalance() public;
```

### testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains()

- **Signature**: `testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains()`
- **Visibility**: public
- **Source Range**: 19609:484:334
- **Details**: [function_testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains.md](./function_testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaim_WithOnlyCurrentCollGainsStashesCollGains() public;
```

### testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance()

- **Signature**: `testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance()`
- **Visibility**: public
- **Source Range**: 20099:541:334
- **Details**: [function_testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance.md](./function_testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsDoesntChangeDepositorCollBalance() public;
```

### testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedGainByCurrentCollGain()

- **Signature**: `testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedGainByCurrentCollGain()`
- **Visibility**: public
- **Source Range**: 20646:489:334
- **Details**: [function_testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedGainByCurrentCollGain.md](./function_testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedGainByCurrentCollGain.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaim_WithCurrentAndStashedCollGainsIncreasedStashedGainByCurrentCollGain() public;
```

### testWithdrawFromSPNoClaim_WithOnlyStashedGainDoesntChangeDepositorCollBalance()

- **Signature**: `testWithdrawFromSPNoClaim_WithOnlyStashedGainDoesntChangeDepositorCollBalance()`
- **Visibility**: public
- **Source Range**: 21141:655:334
- **Details**: [function_testWithdrawFromSPNoClaim_WithOnlyStashedGainDoesntChangeDepositorCollBalance.md](./function_testWithdrawFromSPNoClaim_WithOnlyStashedGainDoesntChangeDepositorCollBalance.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaim_WithOnlyStashedGainDoesntChangeDepositorCollBalance() public;
```

### testWithdrawFromSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain()

- **Signature**: `testWithdrawFromSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain()`
- **Visibility**: public
- **Source Range**: 21802:580:334
- **Details**: [function_testWithdrawFromSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain.md](./function_testWithdrawFromSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaim_WithOnlyStashedCollGainDoesntChangeStashedCollGain() public;
```

### testWithdrawFromSPNoClaimAddsBOLDGainsToDeposit()

- **Signature**: `testWithdrawFromSPNoClaimAddsBOLDGainsToDeposit()`
- **Visibility**: public
- **Source Range**: 22449:738:334
- **Details**: [function_testWithdrawFromSPNoClaimAddsBOLDGainsToDeposit.md](./function_testWithdrawFromSPNoClaimAddsBOLDGainsToDeposit.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaimAddsBOLDGainsToDeposit() public;
```

### testWithdrawFromSPNoClaimAddsBoldGainsToTotalBoldDeposits()

- **Signature**: `testWithdrawFromSPNoClaimAddsBoldGainsToTotalBoldDeposits()`
- **Visibility**: public
- **Source Range**: 23193:711:334
- **Details**: [function_testWithdrawFromSPNoClaimAddsBoldGainsToTotalBoldDeposits.md](./function_testWithdrawFromSPNoClaimAddsBoldGainsToTotalBoldDeposits.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaimAddsBoldGainsToTotalBoldDeposits() public;
```

### testWithdrawFromSPNoClaimZerosCurrentBoldGains()

- **Signature**: `testWithdrawFromSPNoClaimZerosCurrentBoldGains()`
- **Visibility**: public
- **Source Range**: 23910:568:334
- **Details**: [function_testWithdrawFromSPNoClaimZerosCurrentBoldGains.md](./function_testWithdrawFromSPNoClaimZerosCurrentBoldGains.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaimZerosCurrentBoldGains() public;
```

### testWithdrawFromSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp()

- **Signature**: `testWithdrawFromSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp()`
- **Visibility**: public
- **Source Range**: 24484:658:334
- **Details**: [function_testWithdrawFromSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp.md](./function_testWithdrawFromSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp.md)

**Signature:**
```solidity
function testWithdrawFromSPNoClaimReducesDepositorBoldBalanceByOnlyTheTopUp() public;
```

### testClaimAllCollGainsRevertsWhenUserHasNoDeposit()

- **Signature**: `testClaimAllCollGainsRevertsWhenUserHasNoDeposit()`
- **Visibility**: public
- **Source Range**: 25182:479:334
- **Details**: [function_testClaimAllCollGainsRevertsWhenUserHasNoDeposit.md](./function_testClaimAllCollGainsRevertsWhenUserHasNoDeposit.md)

**Signature:**
```solidity
function testClaimAllCollGainsRevertsWhenUserHasNoDeposit() public;
```

### testClaimAllCollGainsRevertsWhenUserHasNoCollGains()

- **Signature**: `testClaimAllCollGainsRevertsWhenUserHasNoCollGains()`
- **Visibility**: public
- **Source Range**: 25667:886:334
- **Details**: [function_testClaimAllCollGainsRevertsWhenUserHasNoCollGains.md](./function_testClaimAllCollGainsRevertsWhenUserHasNoCollGains.md)

**Signature:**
```solidity
function testClaimAllCollGainsRevertsWhenUserHasNoCollGains() public;
```

### testClaimAllCollGainsDoesNotChangeCompoundedDeposit()

- **Signature**: `testClaimAllCollGainsDoesNotChangeCompoundedDeposit()`
- **Visibility**: public
- **Source Range**: 26559:583:334
- **Details**: [function_testClaimAllCollGainsDoesNotChangeCompoundedDeposit.md](./function_testClaimAllCollGainsDoesNotChangeCompoundedDeposit.md)

**Signature:**
```solidity
function testClaimAllCollGainsDoesNotChangeCompoundedDeposit() public;
```

### testClaimAllCollGainsDoesntChangeCurrentCollGain()

- **Signature**: `testClaimAllCollGainsDoesntChangeCurrentCollGain()`
- **Visibility**: public
- **Source Range**: 27148:661:334
- **Details**: [function_testClaimAllCollGainsDoesntChangeCurrentCollGain.md](./function_testClaimAllCollGainsDoesntChangeCurrentCollGain.md)

**Signature:**
```solidity
function testClaimAllCollGainsDoesntChangeCurrentCollGain() public;
```

### testClaimAllCollGainsZerosStashedCollGain()

- **Signature**: `testClaimAllCollGainsZerosStashedCollGain()`
- **Visibility**: public
- **Source Range**: 27815:645:334
- **Details**: [function_testClaimAllCollGainsZerosStashedCollGain.md](./function_testClaimAllCollGainsZerosStashedCollGain.md)

**Signature:**
```solidity
function testClaimAllCollGainsZerosStashedCollGain() public;
```

### testClaimAllCollGainsIncreasesUserBalanceByStashedCollGain()

- **Signature**: `testClaimAllCollGainsIncreasesUserBalanceByStashedCollGain()`
- **Visibility**: public
- **Source Range**: 28466:705:334
- **Details**: [function_testClaimAllCollGainsIncreasesUserBalanceByStashedCollGain.md](./function_testClaimAllCollGainsIncreasesUserBalanceByStashedCollGain.md)

**Signature:**
```solidity
function testClaimAllCollGainsIncreasesUserBalanceByStashedCollGain() public;
```

### testBoldRewardsSumDoesntChangeWhenSPIsEmpty()

- **Signature**: `testBoldRewardsSumDoesntChangeWhenSPIsEmpty()`
- **Visibility**: public
- **Source Range**: 29219:691:334
- **Details**: [function_testBoldRewardsSumDoesntChangeWhenSPIsEmpty.md](./function_testBoldRewardsSumDoesntChangeWhenSPIsEmpty.md)

**Signature:**
```solidity
function testBoldRewardsSumDoesntChangeWhenSPIsEmpty() public;
```

### testBoldRewardSumDoesntChangeWhenNoYieldMinted()

- **Signature**: `testBoldRewardSumDoesntChangeWhenNoYieldMinted()`
- **Visibility**: public
- **Source Range**: 29916:662:334
- **Details**: [function_testBoldRewardSumDoesntChangeWhenNoYieldMinted.md](./function_testBoldRewardSumDoesntChangeWhenNoYieldMinted.md)

**Signature:**
```solidity
function testBoldRewardSumDoesntChangeWhenNoYieldMinted() public;
```

### testBoldRewardSumIncreasesWhenTroveOpened()

- **Signature**: `testBoldRewardSumIncreasesWhenTroveOpened()`
- **Visibility**: public
- **Source Range**: 30584:548:334
- **Details**: [function_testBoldRewardSumIncreasesWhenTroveOpened.md](./function_testBoldRewardSumIncreasesWhenTroveOpened.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenTroveOpened() public;
```

### testBoldRewardSumIncreasesWhenTroveInterestRateAdjusted()

- **Signature**: `testBoldRewardSumIncreasesWhenTroveInterestRateAdjusted()`
- **Visibility**: public
- **Source Range**: 31138:584:334
- **Details**: [function_testBoldRewardSumIncreasesWhenTroveInterestRateAdjusted.md](./function_testBoldRewardSumIncreasesWhenTroveInterestRateAdjusted.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenTroveInterestRateAdjusted() public;
```

### testBoldRewardSumIncreasesWhenTroveClosed()

- **Signature**: `testBoldRewardSumIncreasesWhenTroveClosed()`
- **Visibility**: public
- **Source Range**: 31728:871:334
- **Details**: [function_testBoldRewardSumIncreasesWhenTroveClosed.md](./function_testBoldRewardSumIncreasesWhenTroveClosed.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenTroveClosed() public;
```

### testBoldRewardSumIncreasesWhenTroveDebtAndCollAdjusted()

- **Signature**: `testBoldRewardSumIncreasesWhenTroveDebtAndCollAdjusted()`
- **Visibility**: public
- **Source Range**: 32605:586:334
- **Details**: [function_testBoldRewardSumIncreasesWhenTroveDebtAndCollAdjusted.md](./function_testBoldRewardSumIncreasesWhenTroveDebtAndCollAdjusted.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenTroveDebtAndCollAdjusted() public;
```

### testBoldRewardSumIncreasesWhenInterestAppliedPermissionlessly()

- **Signature**: `testBoldRewardSumIncreasesWhenInterestAppliedPermissionlessly()`
- **Visibility**: public
- **Source Range**: 33197:629:334
- **Details**: [function_testBoldRewardSumIncreasesWhenInterestAppliedPermissionlessly.md](./function_testBoldRewardSumIncreasesWhenInterestAppliedPermissionlessly.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenInterestAppliedPermissionlessly() public;
```

### testBoldRewardSumIncreasesWhenTroveLiquidated()

- **Signature**: `testBoldRewardSumIncreasesWhenTroveLiquidated()`
- **Visibility**: public
- **Source Range**: 33832:692:334
- **Details**: [function_testBoldRewardSumIncreasesWhenTroveLiquidated.md](./function_testBoldRewardSumIncreasesWhenTroveLiquidated.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenTroveLiquidated() public;
```

### testBoldRewardSumIncreasesWhenRedemptionOccurs()

- **Signature**: `testBoldRewardSumIncreasesWhenRedemptionOccurs()`
- **Visibility**: public
- **Source Range**: 34530:656:334
- **Details**: [function_testBoldRewardSumIncreasesWhenRedemptionOccurs.md](./function_testBoldRewardSumIncreasesWhenRedemptionOccurs.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenRedemptionOccurs() public;
```

### testBoldRewardSumIncreasesWhenNewDepositIsMade()

- **Signature**: `testBoldRewardSumIncreasesWhenNewDepositIsMade()`
- **Visibility**: public
- **Source Range**: 35192:684:334
- **Details**: [function_testBoldRewardSumIncreasesWhenNewDepositIsMade.md](./function_testBoldRewardSumIncreasesWhenNewDepositIsMade.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenNewDepositIsMade() public;
```

### testBoldRewardSumIncreasesWhenDepositToppedUp()

- **Signature**: `testBoldRewardSumIncreasesWhenDepositToppedUp()`
- **Visibility**: public
- **Source Range**: 35882:685:334
- **Details**: [function_testBoldRewardSumIncreasesWhenDepositToppedUp.md](./function_testBoldRewardSumIncreasesWhenDepositToppedUp.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenDepositToppedUp() public;
```

### testBoldRewardSumIncreasesWhenDepositWithdrawn()

- **Signature**: `testBoldRewardSumIncreasesWhenDepositWithdrawn()`
- **Visibility**: public
- **Source Range**: 36573:696:334
- **Details**: [function_testBoldRewardSumIncreasesWhenDepositWithdrawn.md](./function_testBoldRewardSumIncreasesWhenDepositWithdrawn.md)

**Signature:**
```solidity
function testBoldRewardSumIncreasesWhenDepositWithdrawn() public;
```

### testBoldRewardsOwedDoesntChangeWhenSPIsEmpty()

- **Signature**: `testBoldRewardsOwedDoesntChangeWhenSPIsEmpty()`
- **Visibility**: public
- **Source Range**: 37313:713:334
- **Details**: [function_testBoldRewardsOwedDoesntChangeWhenSPIsEmpty.md](./function_testBoldRewardsOwedDoesntChangeWhenSPIsEmpty.md)

**Signature:**
```solidity
function testBoldRewardsOwedDoesntChangeWhenSPIsEmpty() public;
```

### testBoldRewardsOwedOnlyIcreasesByUpfrontFeeYieldWhenNoInterestMinted()

- **Signature**: `testBoldRewardsOwedOnlyIcreasesByUpfrontFeeYieldWhenNoInterestMinted()`
- **Visibility**: public
- **Source Range**: 38032:936:334
- **Details**: [function_testBoldRewardsOwedOnlyIcreasesByUpfrontFeeYieldWhenNoInterestMinted.md](./function_testBoldRewardsOwedOnlyIcreasesByUpfrontFeeYieldWhenNoInterestMinted.md)

**Signature:**
```solidity
function testBoldRewardsOwedOnlyIcreasesByUpfrontFeeYieldWhenNoInterestMinted() public;
```

### testBoldRewardsOwedIncreasesWhenTroveOpened()

- **Signature**: `testBoldRewardsOwedIncreasesWhenTroveOpened()`
- **Visibility**: public
- **Source Range**: 38974:742:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenTroveOpened.md](./function_testBoldRewardsOwedIncreasesWhenTroveOpened.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenTroveOpened() public;
```

### testBoldRewardsOwedIncreasesWhenTroveInterestRateAdjusted()

- **Signature**: `testBoldRewardsOwedIncreasesWhenTroveInterestRateAdjusted()`
- **Visibility**: public
- **Source Range**: 39722:778:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenTroveInterestRateAdjusted.md](./function_testBoldRewardsOwedIncreasesWhenTroveInterestRateAdjusted.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenTroveInterestRateAdjusted() public;
```

### testBoldRewardsOwedIncreasesWhenTroveClosed()

- **Signature**: `testBoldRewardsOwedIncreasesWhenTroveClosed()`
- **Visibility**: public
- **Source Range**: 40506:1039:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenTroveClosed.md](./function_testBoldRewardsOwedIncreasesWhenTroveClosed.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenTroveClosed() public;
```

### testBoldRewardsOwedIncreasesWhenTroveDebtAndCollAdjusted()

- **Signature**: `testBoldRewardsOwedIncreasesWhenTroveDebtAndCollAdjusted()`
- **Visibility**: public
- **Source Range**: 41551:780:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenTroveDebtAndCollAdjusted.md](./function_testBoldRewardsOwedIncreasesWhenTroveDebtAndCollAdjusted.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenTroveDebtAndCollAdjusted() public;
```

### testBoldRewardsOwedIncreasesWhenInterestAppliedPermissionlessly()

- **Signature**: `testBoldRewardsOwedIncreasesWhenInterestAppliedPermissionlessly()`
- **Visibility**: public
- **Source Range**: 42337:823:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenInterestAppliedPermissionlessly.md](./function_testBoldRewardsOwedIncreasesWhenInterestAppliedPermissionlessly.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenInterestAppliedPermissionlessly() public;
```

### testBoldRewardsOwedIncreasesWhenTroveLiquidated()

- **Signature**: `testBoldRewardsOwedIncreasesWhenTroveLiquidated()`
- **Visibility**: public
- **Source Range**: 43166:886:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenTroveLiquidated.md](./function_testBoldRewardsOwedIncreasesWhenTroveLiquidated.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenTroveLiquidated() public;
```

### testBoldRewardsOwedIncreasesWhenRedemptionOccurs()

- **Signature**: `testBoldRewardsOwedIncreasesWhenRedemptionOccurs()`
- **Visibility**: public
- **Source Range**: 44058:850:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenRedemptionOccurs.md](./function_testBoldRewardsOwedIncreasesWhenRedemptionOccurs.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenRedemptionOccurs() public;
```

### testBoldRewardsOwedIncreasesWhenNewDepositIsMade()

- **Signature**: `testBoldRewardsOwedIncreasesWhenNewDepositIsMade()`
- **Visibility**: public
- **Source Range**: 44914:852:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenNewDepositIsMade.md](./function_testBoldRewardsOwedIncreasesWhenNewDepositIsMade.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenNewDepositIsMade() public;
```

### testBoldRewardsOwedIncreasesWhenDepositToppedUp()

- **Signature**: `testBoldRewardsOwedIncreasesWhenDepositToppedUp()`
- **Visibility**: public
- **Source Range**: 45772:708:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenDepositToppedUp.md](./function_testBoldRewardsOwedIncreasesWhenDepositToppedUp.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenDepositToppedUp() public;
```

### testBoldRewardsOwedIncreasesWhenDepositWithdrawn()

- **Signature**: `testBoldRewardsOwedIncreasesWhenDepositWithdrawn()`
- **Visibility**: public
- **Source Range**: 46486:719:334
- **Details**: [function_testBoldRewardsOwedIncreasesWhenDepositWithdrawn.md](./function_testBoldRewardsOwedIncreasesWhenDepositWithdrawn.md)

**Signature:**
```solidity
function testBoldRewardsOwedIncreasesWhenDepositWithdrawn() public;
```

### testGetDepositorBoldGain_1SPDepositor1RewardEvent_EarnsAllSPYield()

- **Signature**: `testGetDepositorBoldGain_1SPDepositor1RewardEvent_EarnsAllSPYield()`
- **Visibility**: public
- **Source Range**: 47256:996:334
- **Details**: [function_testGetDepositorBoldGain_1SPDepositor1RewardEvent_EarnsAllSPYield.md](./function_testGetDepositorBoldGain_1SPDepositor1RewardEvent_EarnsAllSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_1SPDepositor1RewardEvent_EarnsAllSPYield() public;
```

### testGetDepositorBoldGain_2SPDepositor1RewardEvent_EarnFairShareOfSPYield()

- **Signature**: `testGetDepositorBoldGain_2SPDepositor1RewardEvent_EarnFairShareOfSPYield()`
- **Visibility**: public
- **Source Range**: 48258:1248:334
- **Details**: [function_testGetDepositorBoldGain_2SPDepositor1RewardEvent_EarnFairShareOfSPYield.md](./function_testGetDepositorBoldGain_2SPDepositor1RewardEvent_EarnFairShareOfSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_2SPDepositor1RewardEvent_EarnFairShareOfSPYield() public;
```

### testGetDepositorBoldGain_1SPDepositor2RewardEvent_EarnsAllSPYield()

- **Signature**: `testGetDepositorBoldGain_1SPDepositor2RewardEvent_EarnsAllSPYield()`
- **Visibility**: public
- **Source Range**: 49512:1623:334
- **Details**: [function_testGetDepositorBoldGain_1SPDepositor2RewardEvent_EarnsAllSPYield.md](./function_testGetDepositorBoldGain_1SPDepositor2RewardEvent_EarnsAllSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_1SPDepositor2RewardEvent_EarnsAllSPYield() public;
```

### testGetDepositorBoldGain_2SPDepositor2RewardEvent_EarnFairShareOfSPYield()

- **Signature**: `testGetDepositorBoldGain_2SPDepositor2RewardEvent_EarnFairShareOfSPYield()`
- **Visibility**: public
- **Source Range**: 51141:2278:334
- **Details**: [function_testGetDepositorBoldGain_2SPDepositor2RewardEvent_EarnFairShareOfSPYield.md](./function_testGetDepositorBoldGain_2SPDepositor2RewardEvent_EarnFairShareOfSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_2SPDepositor2RewardEvent_EarnFairShareOfSPYield() public;
```

### testGetDepositorBoldGain_2SPDepositor1Liq1FreshDeposit_EarnFairShareOfSPYield()

- **Signature**: `testGetDepositorBoldGain_2SPDepositor1Liq1FreshDeposit_EarnFairShareOfSPYield()`
- **Visibility**: public
- **Source Range**: 53425:3069:334
- **Details**: [function_testGetDepositorBoldGain_2SPDepositor1Liq1FreshDeposit_EarnFairShareOfSPYield.md](./function_testGetDepositorBoldGain_2SPDepositor1Liq1FreshDeposit_EarnFairShareOfSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_2SPDepositor1Liq1FreshDeposit_EarnFairShareOfSPYield() public;
```

### testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield()

- **Signature**: `testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield()`
- **Visibility**: public
- **Source Range**: 56500:5269:334
- **Details**: [function_testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield.md](./function_testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_2SPDepositor1LiqFreshDeposit_EarnFairShareOfSPYield() public;
```

### testGetDepositorBoldGain_2SPDepositor1LiqScaleChangeFreshDeposit_EarnFairShareOfSPYield()

- **Signature**: `testGetDepositorBoldGain_2SPDepositor1LiqScaleChangeFreshDeposit_EarnFairShareOfSPYield()`
- **Visibility**: public
- **Source Range**: 61775:3924:334
- **Details**: [function_testGetDepositorBoldGain_2SPDepositor1LiqScaleChangeFreshDeposit_EarnFairShareOfSPYield.md](./function_testGetDepositorBoldGain_2SPDepositor1LiqScaleChangeFreshDeposit_EarnFairShareOfSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_2SPDepositor1LiqScaleChangeFreshDeposit_EarnFairShareOfSPYield() public;
```

### testGetDepositorBoldGain_2SPDepositor2LiqScaleChangesFreshDeposit_EarnFairShareOfSPYield()

- **Signature**: `testGetDepositorBoldGain_2SPDepositor2LiqScaleChangesFreshDeposit_EarnFairShareOfSPYield()`
- **Visibility**: public
- **Source Range**: 65705:5960:334
- **Details**: [function_testGetDepositorBoldGain_2SPDepositor2LiqScaleChangesFreshDeposit_EarnFairShareOfSPYield.md](./function_testGetDepositorBoldGain_2SPDepositor2LiqScaleChangesFreshDeposit_EarnFairShareOfSPYield.md)

**Signature:**
```solidity
function testGetDepositorBoldGain_2SPDepositor2LiqScaleChangesFreshDeposit_EarnFairShareOfSPYield() public;
```

### testLiquidationWithLowPDoesNotDecreaseP_Cheat_Fuzz(uint256,uint256)

- **Signature**: `testLiquidationWithLowPDoesNotDecreaseP_Cheat_Fuzz(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 71697:1491:334
- **Details**: [function_testLiquidationWithLowPDoesNotDecreaseP_Cheat_Fuzz_uint256_uint256.md](./function_testLiquidationWithLowPDoesNotDecreaseP_Cheat_Fuzz_uint256_uint256.md)

**Signature:**
```solidity
function testLiquidationWithLowPDoesNotDecreaseP_Cheat_Fuzz(uint256 _cheatP, uint256 _surplus) public;
```

### testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz(uint256,uint256)

- **Signature**: `testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 73194:5267:334
- **Details**: [function_testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz_uint256_uint256.md](./function_testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz_uint256_uint256.md)

**Signature:**
```solidity
function testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fuzz(uint256 _cheatP, uint256 _surplus) public;
```

### testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fixed()

- **Signature**: `testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fixed()`
- **Visibility**: public
- **Source Range**: 78467:271:334
- **Details**: [function_testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fixed.md](./function_testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fixed.md)

**Signature:**
```solidity
function testLiquidationsWithLowPAllowFurtherRewardsForAllFreshDepositors_Cheat_Fixed() public;
```

### test_Issue_ShareOfCollMismatch()

- **Signature**: `test_Issue_ShareOfCollMismatch()`
- **Visibility**: external
- **Source Range**: 78744:172:334
- **Details**: [function_test_Issue_ShareOfCollMismatch.md](./function_test_Issue_ShareOfCollMismatch.md)

**Signature:**
```solidity
function test_Issue_ShareOfCollMismatch() external;
```

### testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors(uint256,uint256)

- **Signature**: `testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 78922:6869:334
- **Details**: [function_testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors_uint256_uint256.md](./function_testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors_uint256_uint256.md)

**Signature:**
```solidity
function testLiquidationsWithLowPAllowFurtherRewardsForExistingDepositors(uint256 _cheatP, uint256 _surplus) public;
```

### testHighFractionLiqWithLowPTriggersTwoScaleChanges_Cheat_Fuzz(uint256,uint256)

- **Signature**: `testHighFractionLiqWithLowPTriggersTwoScaleChanges_Cheat_Fuzz(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 85797:1721:334
- **Details**: [function_testHighFractionLiqWithLowPTriggersTwoScaleChanges_Cheat_Fuzz_uint256_uint256.md](./function_testHighFractionLiqWithLowPTriggersTwoScaleChanges_Cheat_Fuzz_uint256_uint256.md)

**Signature:**
```solidity
function testHighFractionLiqWithLowPTriggersTwoScaleChanges_Cheat_Fuzz(uint256 _cheatP, uint256 _surplus) public;
```

### testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9(uint256,uint256)

- **Signature**: `testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 87524:1515:334
- **Details**: [function_testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9_uint256_uint256.md](./function_testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9_uint256_uint256.md)

**Signature:**
```solidity
function testHighFractionLiqWithLowPDoesNotDecreasePBelow1e9(uint256 _cheatP, uint256 _surplus) public;
```

### testLiqDebtWithin1BOLDOfTotalDepositsLeaves1BOLDinSP_Fuzz(uint256)

- **Signature**: `testLiqDebtWithin1BOLDOfTotalDepositsLeaves1BOLDinSP_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 89174:1754:334
- **Details**: [function_testLiqDebtWithin1BOLDOfTotalDepositsLeaves1BOLDinSP_Fuzz_uint256.md](./function_testLiqDebtWithin1BOLDOfTotalDepositsLeaves1BOLDinSP_Fuzz_uint256.md)

**Signature:**
```solidity
function testLiqDebtWithin1BOLDOfTotalDepositsLeaves1BOLDinSP_Fuzz(uint256 _toRedist) public;
```

### testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz(uint256)

- **Signature**: `testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 90934:1860:334
- **Details**: [function_testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz_uint256.md](./function_testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz_uint256.md)

**Signature:**
```solidity
function testLiqDebtWithin1BOLDOfTotalDepositsRedistributesRemainder_Fuzz(uint256 _toRedist) public;
```

### testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz()

- **Signature**: `testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz()`
- **Visibility**: public
- **Source Range**: 92800:3132:334
- **Details**: [function_testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz.md](./function_testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz.md)

**Signature:**
```solidity
function testLiqDebtWithin1BoldOfTotalDepositsSplitsCollGainsCorrectly_Fuzz() public;
```

### testLiqDebtLessThanSPMinus1BOLDLeavesSurplusInSP_Fuzz(uint256)

- **Signature**: `testLiqDebtLessThanSPMinus1BOLDLeavesSurplusInSP_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 96002:1684:334
- **Details**: [function_testLiqDebtLessThanSPMinus1BOLDLeavesSurplusInSP_Fuzz_uint256.md](./function_testLiqDebtLessThanSPMinus1BOLDLeavesSurplusInSP_Fuzz_uint256.md)

**Signature:**
```solidity
function testLiqDebtLessThanSPMinus1BOLDLeavesSurplusInSP_Fuzz(uint256 _surplusToLeaveInSP) public;
```

### testLiqDebtLessThanSPMinus1BOLDDoesNotRedistribute_Fuzz(uint256)

- **Signature**: `testLiqDebtLessThanSPMinus1BOLDDoesNotRedistribute_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 97692:1472:334
- **Details**: [function_testLiqDebtLessThanSPMinus1BOLDDoesNotRedistribute_Fuzz_uint256.md](./function_testLiqDebtLessThanSPMinus1BOLDDoesNotRedistribute_Fuzz_uint256.md)

**Signature:**
```solidity
function testLiqDebtLessThanSPMinus1BOLDDoesNotRedistribute_Fuzz(uint256 _surplusToLeaveInSP) public;
```

### testLiqDebtGreaterThanTotalSPLeaves1BOLDInSP_Fuzz(uint256)

- **Signature**: `testLiqDebtGreaterThanTotalSPLeaves1BOLDInSP_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 99223:1376:334
- **Details**: [function_testLiqDebtGreaterThanTotalSPLeaves1BOLDInSP_Fuzz_uint256.md](./function_testLiqDebtGreaterThanTotalSPLeaves1BOLDInSP_Fuzz_uint256.md)

**Signature:**
```solidity
function testLiqDebtGreaterThanTotalSPLeaves1BOLDInSP_Fuzz(uint256 _toRedist) public;
```

### testLiqDebtGreaterThanTotalSPRedistributesTheRemainder_Fuzz(uint256)

- **Signature**: `testLiqDebtGreaterThanTotalSPRedistributesTheRemainder_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 100605:1309:334
- **Details**: [function_testLiqDebtGreaterThanTotalSPRedistributesTheRemainder_Fuzz_uint256.md](./function_testLiqDebtGreaterThanTotalSPRedistributesTheRemainder_Fuzz_uint256.md)

**Signature:**
```solidity
function testLiqDebtGreaterThanTotalSPRedistributesTheRemainder_Fuzz(uint256 _toRedist) public;
```

### testLiqDebtGreaterThanTotalSSplitsCollGainsCorrectly_Fuzz(uint256)

- **Signature**: `testLiqDebtGreaterThanTotalSSplitsCollGainsCorrectly_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 101920:3260:334
- **Details**: [function_testLiqDebtGreaterThanTotalSSplitsCollGainsCorrectly_Fuzz_uint256.md](./function_testLiqDebtGreaterThanTotalSSplitsCollGainsCorrectly_Fuzz_uint256.md)

**Signature:**
```solidity
function testLiqDebtGreaterThanTotalSSplitsCollGainsCorrectly_Fuzz(uint256 _toRedist) public;
```

### testSingleDepositorCantWithdrawWhenLeavingLessThan1BoldInPool_Fuzz(uint256)

- **Signature**: `testSingleDepositorCantWithdrawWhenLeavingLessThan1BoldInPool_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 105222:740:334
- **Details**: [function_testSingleDepositorCantWithdrawWhenLeavingLessThan1BoldInPool_Fuzz_uint256.md](./function_testSingleDepositorCantWithdrawWhenLeavingLessThan1BoldInPool_Fuzz_uint256.md)

**Signature:**
```solidity
function testSingleDepositorCantWithdrawWhenLeavingLessThan1BoldInPool_Fuzz(uint256 _withdrawal) public;
```

### testSingleDepositorCanWithdrawWhenLeavingAtLeast1BoldInPool_Fuzz(uint256)

- **Signature**: `testSingleDepositorCanWithdrawWhenLeavingAtLeast1BoldInPool_Fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 105968:1178:334
- **Details**: [function_testSingleDepositorCanWithdrawWhenLeavingAtLeast1BoldInPool_Fuzz_uint256.md](./function_testSingleDepositorCanWithdrawWhenLeavingAtLeast1BoldInPool_Fuzz_uint256.md)

**Signature:**
```solidity
function testSingleDepositorCanWithdrawWhenLeavingAtLeast1BoldInPool_Fuzz(uint256 _withdrawal) public;
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
