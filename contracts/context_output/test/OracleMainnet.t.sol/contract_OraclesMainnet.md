# Contract: OraclesMainnet

## Metadata

- **Name**: OraclesMainnet
- **Type**: Contract
- **Path**: test/OracleMainnet.t.sol

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

### ethOracle

```solidity
AggregatorV3Interface internal ethOracle
```

**AggregatorV3Interface**: [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

### stethOracle

```solidity
AggregatorV3Interface internal stethOracle
```

**AggregatorV3Interface**: [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

### rethOracle

```solidity
AggregatorV3Interface internal rethOracle
```

**AggregatorV3Interface**: [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

### mockOracle

```solidity
ChainlinkOracleMock internal mockOracle
```

**ChainlinkOracleMock**: [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]

### gasGuzzlerToken

```solidity
GasGuzzlerToken internal gasGuzzlerToken
```

**GasGuzzlerToken**: [test/TestContracts/GasGuzzlerToken.sol/contract_GasGuzzlerToken.md]

### gasGuzzlerOracle

```solidity
GasGuzzlerOracle internal gasGuzzlerOracle
```

**GasGuzzlerOracle**: [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]

### wethPriceFeed

```solidity
IMainnetPriceFeed internal wethPriceFeed
```

**IMainnetPriceFeed**: [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]

### rethPriceFeed

```solidity
IRETHPriceFeed internal rethPriceFeed
```

**IRETHPriceFeed**: [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]

### wstethPriceFeed

```solidity
IWSTETHPriceFeed internal wstethPriceFeed
```

**IWSTETHPriceFeed**: [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]

### rethToken

```solidity
IRETHToken internal rethToken
```

**IRETHToken**: [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]

### wstETH

```solidity
IWSTETH internal wstETH
```

**IWSTETH**: [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]

### mockRethToken

```solidity
RETHTokenMock internal mockRethToken
```

**RETHTokenMock**: [test/TestContracts/RETHTokenMock.sol/contract_RETHTokenMock.md]

### mockWstethToken

```solidity
WSTETHTokenMock internal mockWstethToken
```

**WSTETHTokenMock**: [test/TestContracts/WSTETHTokenMock.sol/contract_WSTETHTokenMock.md]

### contractsArray

```solidity
TestDeployer.LiquityContracts[] internal contractsArray
```

### collateralRegistry

```solidity
CollateralRegistryTester internal collateralRegistry
```

**CollateralRegistryTester**: [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]

### boldToken

```solidity
IBoldToken internal boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

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

### StoredOracle

```solidity
struct StoredOracle {
    AggregatorV3Interface aggregator;
    uint256 stalenessThreshold;
    uint256 decimals;
}
```

### Vars

```solidity
struct Vars {
    uint256 numCollaterals;
    uint256 initialColl;
    uint256 price;
    uint256 coll;
    uint256 debtRequest;
    uint256 debt_B;
    uint256 debt_C;
    uint256 debt_D;
    uint256 ICR_A;
    uint256 ICR_B;
    uint256 ICR_C;
    uint256 ICR_D;
    uint256 redemptionICR_A;
    uint256 redemptionICR_B;
    uint256 redemptionICR_C;
    uint256 redemptionICR_D;
    uint256 troveId_A;
    uint256 troveId_B;
    uint256 troveId_C;
    uint256 troveId_D;
    int256 newEthPrice;
    uint256 systemPrice;
    uint256 newSystemPrice;
    uint256 newSystemRedemptionPrice;
    int256 ethPerRethMarket;
    int256 usdPerEthMarket;
    uint256 ethPerRethLST;
    LatestTroveData troveDataBefore_A;
    LatestTroveData troveDataBefore_B;
    LatestTroveData troveDataBefore_C;
    LatestTroveData troveDataBefore_D;
    LatestTroveData troveDataAfter_A;
    LatestTroveData troveDataAfter_B;
    LatestTroveData troveDataAfter_C;
    LatestTroveData troveDataAfter_D;
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

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2747:3717:244
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### redeem(address,uint256)

- **Signature**: `redeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 6831:197:244
- **Details**: [function_redeem_address_uint256.md](./function_redeem_address_uint256.md)

**Signature:**
```solidity
function redeem(address _from, uint256 _boldAmount) public;
```

### testSetLastGoodPriceOnDeploymentWETH()

- **Signature**: `testSetLastGoodPriceOnDeploymentWETH()`
- **Visibility**: public
- **Source Range**: 11797:309:244
- **Details**: [function_testSetLastGoodPriceOnDeploymentWETH.md](./function_testSetLastGoodPriceOnDeploymentWETH.md)

**Signature:**
```solidity
function testSetLastGoodPriceOnDeploymentWETH() public view;
```

### testSetLastGoodPriceOnDeploymentRETH()

- **Signature**: `testSetLastGoodPriceOnDeploymentRETH()`
- **Visibility**: public
- **Source Range**: 12112:725:244
- **Details**: [function_testSetLastGoodPriceOnDeploymentRETH.md](./function_testSetLastGoodPriceOnDeploymentRETH.md)

**Signature:**
```solidity
function testSetLastGoodPriceOnDeploymentRETH() public view;
```

### testSetLastGoodPriceOnDeploymentWSTETH()

- **Signature**: `testSetLastGoodPriceOnDeploymentWSTETH()`
- **Visibility**: public
- **Source Range**: 12843:484:244
- **Details**: [function_testSetLastGoodPriceOnDeploymentWSTETH.md](./function_testSetLastGoodPriceOnDeploymentWSTETH.md)

**Signature:**
```solidity
function testSetLastGoodPriceOnDeploymentWSTETH() public view;
```

### testFetchPriceReturnsCorrectPriceWETH()

- **Signature**: `testFetchPriceReturnsCorrectPriceWETH()`
- **Visibility**: public
- **Source Range**: 13360:308:244
- **Details**: [function_testFetchPriceReturnsCorrectPriceWETH.md](./function_testFetchPriceReturnsCorrectPriceWETH.md)

**Signature:**
```solidity
function testFetchPriceReturnsCorrectPriceWETH() public;
```

### testFetchPriceReturnsCorrectPriceRETH()

- **Signature**: `testFetchPriceReturnsCorrectPriceRETH()`
- **Visibility**: public
- **Source Range**: 13674:727:244
- **Details**: [function_testFetchPriceReturnsCorrectPriceRETH.md](./function_testFetchPriceReturnsCorrectPriceRETH.md)

**Signature:**
```solidity
function testFetchPriceReturnsCorrectPriceRETH() public;
```

### testFetchPriceReturnsCorrectPriceWSTETH()

- **Signature**: `testFetchPriceReturnsCorrectPriceWSTETH()`
- **Visibility**: public
- **Source Range**: 14407:485:244
- **Details**: [function_testFetchPriceReturnsCorrectPriceWSTETH.md](./function_testFetchPriceReturnsCorrectPriceWSTETH.md)

**Signature:**
```solidity
function testFetchPriceReturnsCorrectPriceWSTETH() public;
```

### testEthUsdStalenessThresholdSetWETH()

- **Signature**: `testEthUsdStalenessThresholdSetWETH()`
- **Visibility**: public
- **Source Range**: 14943:193:244
- **Details**: [function_testEthUsdStalenessThresholdSetWETH.md](./function_testEthUsdStalenessThresholdSetWETH.md)

**Signature:**
```solidity
function testEthUsdStalenessThresholdSetWETH() public view;
```

### testEthUsdStalenessThresholdSetRETH()

- **Signature**: `testEthUsdStalenessThresholdSetRETH()`
- **Visibility**: public
- **Source Range**: 15142:193:244
- **Details**: [function_testEthUsdStalenessThresholdSetRETH.md](./function_testEthUsdStalenessThresholdSetRETH.md)

**Signature:**
```solidity
function testEthUsdStalenessThresholdSetRETH() public view;
```

### testRethEthStalenessThresholdSetRETH()

- **Signature**: `testRethEthStalenessThresholdSetRETH()`
- **Visibility**: public
- **Source Range**: 15341:197:244
- **Details**: [function_testRethEthStalenessThresholdSetRETH.md](./function_testRethEthStalenessThresholdSetRETH.md)

**Signature:**
```solidity
function testRethEthStalenessThresholdSetRETH() public view;
```

### testStethUsdStalenessThresholdSetWSTETH()

- **Signature**: `testStethUsdStalenessThresholdSetWSTETH()`
- **Visibility**: public
- **Source Range**: 15544:205:244
- **Details**: [function_testStethUsdStalenessThresholdSetWSTETH.md](./function_testStethUsdStalenessThresholdSetWSTETH.md)

**Signature:**
```solidity
function testStethUsdStalenessThresholdSetWSTETH() public view;
```

### testRETHExchangeRateBetween1And2()

- **Signature**: `testRETHExchangeRateBetween1And2()`
- **Visibility**: public
- **Source Range**: 15828:170:244
- **Details**: [function_testRETHExchangeRateBetween1And2.md](./function_testRETHExchangeRateBetween1And2.md)

**Signature:**
```solidity
function testRETHExchangeRateBetween1And2() public;
```

### testWSTETHExchangeRateBetween1And2()

- **Signature**: `testWSTETHExchangeRateBetween1And2()`
- **Visibility**: public
- **Source Range**: 16004:167:244
- **Details**: [function_testWSTETHExchangeRateBetween1And2.md](./function_testWSTETHExchangeRateBetween1And2.md)

**Signature:**
```solidity
function testWSTETHExchangeRateBetween1And2() public;
```

### testRETHOracleAnswerBetween1And2()

- **Signature**: `testRETHOracleAnswerBetween1And2()`
- **Visibility**: public
- **Source Range**: 16177:187:244
- **Details**: [function_testRETHOracleAnswerBetween1And2.md](./function_testRETHOracleAnswerBetween1And2.md)

**Signature:**
```solidity
function testRETHOracleAnswerBetween1And2() public;
```

### testSTETHOracleAnswerWithin1PctOfETHOracleAnswer()

- **Signature**: `testSTETHOracleAnswerWithin1PctOfETHOracleAnswer()`
- **Visibility**: public
- **Source Range**: 16370:471:244
- **Details**: [function_testSTETHOracleAnswerWithin1PctOfETHOracleAnswer.md](./function_testSTETHOracleAnswerWithin1PctOfETHOracleAnswer.md)

**Signature:**
```solidity
function testSTETHOracleAnswerWithin1PctOfETHOracleAnswer() public;
```

### testOpenTroveWETH()

- **Signature**: `testOpenTroveWETH()`
- **Visibility**: public
- **Source Range**: 16880:609:244
- **Details**: [function_testOpenTroveWETH.md](./function_testOpenTroveWETH.md)

**Signature:**
```solidity
function testOpenTroveWETH() public;
```

### testOpenTroveRETH()

- **Signature**: `testOpenTroveRETH()`
- **Visibility**: public
- **Source Range**: 17495:798:244
- **Details**: [function_testOpenTroveRETH.md](./function_testOpenTroveRETH.md)

**Signature:**
```solidity
function testOpenTroveRETH() public;
```

### testOpenTroveWSTETH()

- **Signature**: `testOpenTroveWSTETH()`
- **Visibility**: public
- **Source Range**: 18299:802:244
- **Details**: [function_testOpenTroveWSTETH.md](./function_testOpenTroveWSTETH.md)

**Signature:**
```solidity
function testOpenTroveWSTETH() public;
```

### testManipulatedChainlinkReturnsStalePrice()

- **Signature**: `testManipulatedChainlinkReturnsStalePrice()`
- **Visibility**: public
- **Source Range**: 19149:374:244
- **Details**: [function_testManipulatedChainlinkReturnsStalePrice.md](./function_testManipulatedChainlinkReturnsStalePrice.md)

**Signature:**
```solidity
function testManipulatedChainlinkReturnsStalePrice() public;
```

### testManipulatedChainlinkReturns2kUsdPrice()

- **Signature**: `testManipulatedChainlinkReturns2kUsdPrice()`
- **Visibility**: public
- **Source Range**: 19529:321:244
- **Details**: [function_testManipulatedChainlinkReturns2kUsdPrice.md](./function_testManipulatedChainlinkReturns2kUsdPrice.md)

**Signature:**
```solidity
function testManipulatedChainlinkReturns2kUsdPrice() public;
```

### testOpenTroveWETHWithStalePriceReverts()

- **Signature**: `testOpenTroveWETHWithStalePriceReverts()`
- **Visibility**: public
- **Source Range**: 19856:784:244
- **Details**: [function_testOpenTroveWETHWithStalePriceReverts.md](./function_testOpenTroveWETHWithStalePriceReverts.md)

**Signature:**
```solidity
function testOpenTroveWETHWithStalePriceReverts() public;
```

### testAdjustTroveWETHWithStalePriceReverts()

- **Signature**: `testAdjustTroveWETHWithStalePriceReverts()`
- **Visibility**: public
- **Source Range**: 20646:1011:244
- **Details**: [function_testAdjustTroveWETHWithStalePriceReverts.md](./function_testAdjustTroveWETHWithStalePriceReverts.md)

**Signature:**
```solidity
function testAdjustTroveWETHWithStalePriceReverts() public;
```

### testOpenTroveWSTETHWithStalePriceReverts()

- **Signature**: `testOpenTroveWSTETHWithStalePriceReverts()`
- **Visibility**: public
- **Source Range**: 21663:751:244
- **Details**: [function_testOpenTroveWSTETHWithStalePriceReverts.md](./function_testOpenTroveWSTETHWithStalePriceReverts.md)

**Signature:**
```solidity
function testOpenTroveWSTETHWithStalePriceReverts() public;
```

### testAdjustTroveWSTETHWithStalePriceReverts()

- **Signature**: `testAdjustTroveWSTETHWithStalePriceReverts()`
- **Visibility**: public
- **Source Range**: 22420:1019:244
- **Details**: [function_testAdjustTroveWSTETHWithStalePriceReverts.md](./function_testAdjustTroveWSTETHWithStalePriceReverts.md)

**Signature:**
```solidity
function testAdjustTroveWSTETHWithStalePriceReverts() public;
```

### testOpenTroveRETHWithStaleRETHPriceReverts()

- **Signature**: `testOpenTroveRETHWithStaleRETHPriceReverts()`
- **Visibility**: public
- **Source Range**: 23445:976:244
- **Details**: [function_testOpenTroveRETHWithStaleRETHPriceReverts.md](./function_testOpenTroveRETHWithStaleRETHPriceReverts.md)

**Signature:**
```solidity
function testOpenTroveRETHWithStaleRETHPriceReverts() public;
```

### testAdjustTroveRETHWithStaleRETHPriceReverts()

- **Signature**: `testAdjustTroveRETHWithStaleRETHPriceReverts()`
- **Visibility**: public
- **Source Range**: 24427:1198:244
- **Details**: [function_testAdjustTroveRETHWithStaleRETHPriceReverts.md](./function_testAdjustTroveRETHWithStaleRETHPriceReverts.md)

**Signature:**
```solidity
function testAdjustTroveRETHWithStaleRETHPriceReverts() public;
```

### testOpenTroveRETHWithStaleETHPriceReverts()

- **Signature**: `testOpenTroveRETHWithStaleETHPriceReverts()`
- **Visibility**: public
- **Source Range**: 25631:972:244
- **Details**: [function_testOpenTroveRETHWithStaleETHPriceReverts.md](./function_testOpenTroveRETHWithStaleETHPriceReverts.md)

**Signature:**
```solidity
function testOpenTroveRETHWithStaleETHPriceReverts() public;
```

### testAdjustTroveRETHWithStaleETHPriceReverts()

- **Signature**: `testAdjustTroveRETHWithStaleETHPriceReverts()`
- **Visibility**: public
- **Source Range**: 26609:1197:244
- **Details**: [function_testAdjustTroveRETHWithStaleETHPriceReverts.md](./function_testAdjustTroveRETHWithStaleETHPriceReverts.md)

**Signature:**
```solidity
function testAdjustTroveRETHWithStaleETHPriceReverts() public;
```

### testWETHPriceFeedShutsDownWhenETHUSDOracleFails()

- **Signature**: `testWETHPriceFeedShutsDownWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 27842:906:244
- **Details**: [function_testWETHPriceFeedShutsDownWhenETHUSDOracleFails.md](./function_testWETHPriceFeedShutsDownWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testWETHPriceFeedShutsDownWhenETHUSDOracleFails() public;
```

### testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()

- **Signature**: `testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 28754:1184:244
- **Details**: [function_testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails.md](./function_testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails() public;
```

### testRETHPriceFeedShutsDownWhenETHUSDOracleFails()

- **Signature**: `testRETHPriceFeedShutsDownWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 29974:969:244
- **Details**: [function_testRETHPriceFeedShutsDownWhenETHUSDOracleFails.md](./function_testRETHPriceFeedShutsDownWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testRETHPriceFeedShutsDownWhenETHUSDOracleFails() public;
```

### testRETHPriceFeedShutsDownWhenExchangeRateFails()

- **Signature**: `testRETHPriceFeedShutsDownWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 30949:928:244
- **Details**: [function_testRETHPriceFeedShutsDownWhenExchangeRateFails.md](./function_testRETHPriceFeedShutsDownWhenExchangeRateFails.md)

**Signature:**
```solidity
function testRETHPriceFeedShutsDownWhenExchangeRateFails() public;
```

### testRETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()

- **Signature**: `testRETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 31883:1008:244
- **Details**: [function_testRETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails.md](./function_testRETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testRETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails() public;
```

### testRETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails()

- **Signature**: `testRETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 32897:870:244
- **Details**: [function_testRETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails.md](./function_testRETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails.md)

**Signature:**
```solidity
function testRETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails() public;
```

### testRETHPriceSourceIsLastGoodPriceWhenETHUSDFails()

- **Signature**: `testRETHPriceSourceIsLastGoodPriceWhenETHUSDFails()`
- **Visibility**: public
- **Source Range**: 33773:786:244
- **Details**: [function_testRETHPriceSourceIsLastGoodPriceWhenETHUSDFails.md](./function_testRETHPriceSourceIsLastGoodPriceWhenETHUSDFails.md)

**Signature:**
```solidity
function testRETHPriceSourceIsLastGoodPriceWhenETHUSDFails() public;
```

### testRETHPriceFeedShutsDownWhenRETHETHOracleFails()

- **Signature**: `testRETHPriceFeedShutsDownWhenRETHETHOracleFails()`
- **Visibility**: public
- **Source Range**: 34565:973:244
- **Details**: [function_testRETHPriceFeedShutsDownWhenRETHETHOracleFails.md](./function_testRETHPriceFeedShutsDownWhenRETHETHOracleFails.md)

**Signature:**
```solidity
function testRETHPriceFeedShutsDownWhenRETHETHOracleFails() public;
```

### testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenRETHETHOracleFails()

- **Signature**: `testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenRETHETHOracleFails()`
- **Visibility**: public
- **Source Range**: 35544:1013:244
- **Details**: [function_testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenRETHETHOracleFails.md](./function_testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenRETHETHOracleFails.md)

**Signature:**
```solidity
function testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenRETHETHOracleFails() public;
```

### testRETHPriceSourceIsETHUSDxCanonicalWhenRETHETHFails()

- **Signature**: `testRETHPriceSourceIsETHUSDxCanonicalWhenRETHETHFails()`
- **Visibility**: public
- **Source Range**: 36563:792:244
- **Details**: [function_testRETHPriceSourceIsETHUSDxCanonicalWhenRETHETHFails.md](./function_testRETHPriceSourceIsETHUSDxCanonicalWhenRETHETHFails.md)

**Signature:**
```solidity
function testRETHPriceSourceIsETHUSDxCanonicalWhenRETHETHFails() public;
```

### testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails()

- **Signature**: `testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 37361:2152:244
- **Details**: [function_testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails.md](./function_testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails() public;
```

### testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()

- **Signature**: `testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 39519:2079:244
- **Details**: [function_testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails.md](./function_testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails.md)

**Signature:**
```solidity
function testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails() public;
```

### testRETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical()

- **Signature**: `testRETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical()`
- **Visibility**: public
- **Source Range**: 41604:2258:244
- **Details**: [function_testRETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical.md](./function_testRETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical.md)

**Signature:**
```solidity
function testRETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical() public;
```

### testRETHPriceFeedShutsDownWhenBothOraclesFail()

- **Signature**: `testRETHPriceFeedShutsDownWhenBothOraclesFail()`
- **Visibility**: public
- **Source Range**: 43868:1187:244
- **Details**: [function_testRETHPriceFeedShutsDownWhenBothOraclesFail.md](./function_testRETHPriceFeedShutsDownWhenBothOraclesFail.md)

**Signature:**
```solidity
function testRETHPriceFeedShutsDownWhenBothOraclesFail() public;
```

### testRETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail()

- **Signature**: `testRETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail()`
- **Visibility**: public
- **Source Range**: 45061:1189:244
- **Details**: [function_testRETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail.md](./function_testRETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail.md)

**Signature:**
```solidity
function testRETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail() public;
```

### testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail()

- **Signature**: `testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail()`
- **Visibility**: public
- **Source Range**: 46256:1068:244
- **Details**: [function_testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail.md](./function_testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail.md)

**Signature:**
```solidity
function testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail() public;
```

### testWSTETHPriceFeedShutsDownWhenExchangeRateFails()

- **Signature**: `testWSTETHPriceFeedShutsDownWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 47362:946:244
- **Details**: [function_testWSTETHPriceFeedShutsDownWhenExchangeRateFails.md](./function_testWSTETHPriceFeedShutsDownWhenExchangeRateFails.md)

**Signature:**
```solidity
function testWSTETHPriceFeedShutsDownWhenExchangeRateFails() public;
```

### testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails()

- **Signature**: `testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 48314:895:244
- **Details**: [function_testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails.md](./function_testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails.md)

**Signature:**
```solidity
function testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails() public;
```

### testWSTETHPriceSourceIsLastGoodPricePriceWhenETHUSDOracleFails()

- **Signature**: `testWSTETHPriceSourceIsLastGoodPricePriceWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 49215:964:244
- **Details**: [function_testWSTETHPriceSourceIsLastGoodPricePriceWhenETHUSDOracleFails.md](./function_testWSTETHPriceSourceIsLastGoodPricePriceWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testWSTETHPriceSourceIsLastGoodPricePriceWhenETHUSDOracleFails() public;
```

### testWSTETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()

- **Signature**: `testWSTETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 50185:1056:244
- **Details**: [function_testWSTETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails.md](./function_testWSTETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testWSTETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails() public;
```

### testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails()

- **Signature**: `testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 51247:989:244
- **Details**: [function_testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails.md](./function_testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails() public;
```

### testWSTETHPriceShutdownWhenSTETHUSDOracleFails()

- **Signature**: `testWSTETHPriceShutdownWhenSTETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 52242:1013:244
- **Details**: [function_testWSTETHPriceShutdownWhenSTETHUSDOracleFails.md](./function_testWSTETHPriceShutdownWhenSTETHUSDOracleFails.md)

**Signature:**
```solidity
function testWSTETHPriceShutdownWhenSTETHUSDOracleFails() public;
```

### testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails()

- **Signature**: `testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 53261:988:244
- **Details**: [function_testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails.md](./function_testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails.md)

**Signature:**
```solidity
function testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails() public;
```

### testSTETHPriceSourceIsETHUSDxCanonicalWhenSTETHUSDOracleFails()

- **Signature**: `testSTETHPriceSourceIsETHUSDxCanonicalWhenSTETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 54255:805:244
- **Details**: [function_testSTETHPriceSourceIsETHUSDxCanonicalWhenSTETHUSDOracleFails.md](./function_testSTETHPriceSourceIsETHUSDxCanonicalWhenSTETHUSDOracleFails.md)

**Signature:**
```solidity
function testSTETHPriceSourceIsETHUSDxCanonicalWhenSTETHUSDOracleFails() public;
```

### testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails()

- **Signature**: `testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 55066:2176:244
- **Details**: [function_testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails.md](./function_testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenETHUSDOracleFails() public;
```

### testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()

- **Signature**: `testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 57248:1875:244
- **Details**: [function_testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails.md](./function_testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails.md)

**Signature:**
```solidity
function testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails() public;
```

### testSTETHWhenUsingETHUSDxCanonicalRemainsShutDownWhenETHUSDOracleFails()

- **Signature**: `testSTETHWhenUsingETHUSDxCanonicalRemainsShutDownWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 59129:1666:244
- **Details**: [function_testSTETHWhenUsingETHUSDxCanonicalRemainsShutDownWhenETHUSDOracleFails.md](./function_testSTETHWhenUsingETHUSDxCanonicalRemainsShutDownWhenETHUSDOracleFails.md)

**Signature:**
```solidity
function testSTETHWhenUsingETHUSDxCanonicalRemainsShutDownWhenETHUSDOracleFails() public;
```

### testSTETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical()

- **Signature**: `testSTETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical()`
- **Visibility**: public
- **Source Range**: 60801:2249:244
- **Details**: [function_testSTETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical.md](./function_testSTETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical.md)

**Signature:**
```solidity
function testSTETHWhenUsingETHUSDxCanonicalReturnsMinOfLastGoodPriceAndETHUSDxCanonical() public;
```

### testWSTETHPriceShutdownWhenBothOraclesFail()

- **Signature**: `testWSTETHPriceShutdownWhenBothOraclesFail()`
- **Visibility**: public
- **Source Range**: 63056:1253:244
- **Details**: [function_testWSTETHPriceShutdownWhenBothOraclesFail.md](./function_testWSTETHPriceShutdownWhenBothOraclesFail.md)

**Signature:**
```solidity
function testWSTETHPriceShutdownWhenBothOraclesFail() public;
```

### testWSTETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail()

- **Signature**: `testWSTETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail()`
- **Visibility**: public
- **Source Range**: 64315:1202:244
- **Details**: [function_testWSTETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail.md](./function_testWSTETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail.md)

**Signature:**
```solidity
function testWSTETHPriceFeedReturnsLastGoodPriceWhenBothOraclesFail() public;
```

### testWSTETHPriceSourceIsLastGoodPriceWhenBothOraclesFail()

- **Signature**: `testWSTETHPriceSourceIsLastGoodPriceWhenBothOraclesFail()`
- **Visibility**: public
- **Source Range**: 65523:1083:244
- **Details**: [function_testWSTETHPriceSourceIsLastGoodPriceWhenBothOraclesFail.md](./function_testWSTETHPriceSourceIsLastGoodPriceWhenBothOraclesFail.md)

**Signature:**
```solidity
function testWSTETHPriceSourceIsLastGoodPriceWhenBothOraclesFail() public;
```

### testNormalWETHRedemptionDoesNotHitShutdownBranch()

- **Signature**: `testNormalWETHRedemptionDoesNotHitShutdownBranch()`
- **Visibility**: public
- **Source Range**: 66640:1664:244
- **Details**: [function_testNormalWETHRedemptionDoesNotHitShutdownBranch.md](./function_testNormalWETHRedemptionDoesNotHitShutdownBranch.md)

**Signature:**
```solidity
function testNormalWETHRedemptionDoesNotHitShutdownBranch() public;
```

### testNormalRETHRedemptionDoesNotHitShutdownBranch()

- **Signature**: `testNormalRETHRedemptionDoesNotHitShutdownBranch()`
- **Visibility**: public
- **Source Range**: 68310:1672:244
- **Details**: [function_testNormalRETHRedemptionDoesNotHitShutdownBranch.md](./function_testNormalRETHRedemptionDoesNotHitShutdownBranch.md)

**Signature:**
```solidity
function testNormalRETHRedemptionDoesNotHitShutdownBranch() public;
```

### testNormalWSTETHRedemptionDoesNotHitShutdownBranch()

- **Signature**: `testNormalWSTETHRedemptionDoesNotHitShutdownBranch()`
- **Visibility**: public
- **Source Range**: 69988:1685:244
- **Details**: [function_testNormalWSTETHRedemptionDoesNotHitShutdownBranch.md](./function_testNormalWSTETHRedemptionDoesNotHitShutdownBranch.md)

**Signature:**
```solidity
function testNormalWSTETHRedemptionDoesNotHitShutdownBranch() public;
```

### testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice()

- **Signature**: `testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice()`
- **Visibility**: public
- **Source Range**: 71679:2123:244
- **Details**: [function_testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice.md](./function_testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice.md)

**Signature:**
```solidity
function testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice() public;
```

### testRedemptionOfWSTETHUsesMaxETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenWithin1pct()

- **Signature**: `testRedemptionOfWSTETHUsesMaxETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenWithin1pct()`
- **Visibility**: public
- **Source Range**: 73808:2803:244
- **Details**: [function_testRedemptionOfWSTETHUsesMaxETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenWithin1pct.md](./function_testRedemptionOfWSTETHUsesMaxETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenWithin1pct.md)

**Signature:**
```solidity
function testRedemptionOfWSTETHUsesMaxETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenWithin1pct() public;
```

### testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct()

- **Signature**: `testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct()`
- **Visibility**: public
- **Source Range**: 76617:3886:244
- **Details**: [function_testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct.md](./function_testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct.md)

**Signature:**
```solidity
function testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct() public;
```

### testRedemptionOfRETHUsesMaxCanonicalAndMarketforPrimaryPriceWhenWithin2pct()

- **Signature**: `testRedemptionOfRETHUsesMaxCanonicalAndMarketforPrimaryPriceWhenWithin2pct()`
- **Visibility**: public
- **Source Range**: 80509:2872:244
- **Details**: [function_testRedemptionOfRETHUsesMaxCanonicalAndMarketforPrimaryPriceWhenWithin2pct.md](./function_testRedemptionOfRETHUsesMaxCanonicalAndMarketforPrimaryPriceWhenWithin2pct.md)

**Signature:**
```solidity
function testRedemptionOfRETHUsesMaxCanonicalAndMarketforPrimaryPriceWhenWithin2pct() public;
```

### testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct()

- **Signature**: `testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct()`
- **Visibility**: public
- **Source Range**: 83387:3601:244
- **Details**: [function_testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct.md](./function_testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct.md)

**Signature:**
```solidity
function testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct() public;
```

### testRevertLowGasSTETHOracle()

- **Signature**: `testRevertLowGasSTETHOracle()`
- **Visibility**: public
- **Source Range**: 87040:760:244
- **Details**: [function_testRevertLowGasSTETHOracle.md](./function_testRevertLowGasSTETHOracle.md)

**Signature:**
```solidity
function testRevertLowGasSTETHOracle() public;
```

### testRevertLowGasRETHOracle()

- **Signature**: `testRevertLowGasRETHOracle()`
- **Visibility**: public
- **Source Range**: 87806:754:244
- **Details**: [function_testRevertLowGasRETHOracle.md](./function_testRevertLowGasRETHOracle.md)

**Signature:**
```solidity
function testRevertLowGasRETHOracle() public;
```

### testRevertLowGasETHOracle()

- **Signature**: `testRevertLowGasETHOracle()`
- **Visibility**: public
- **Source Range**: 88566:752:244
- **Details**: [function_testRevertLowGasETHOracle.md](./function_testRevertLowGasETHOracle.md)

**Signature:**
```solidity
function testRevertLowGasETHOracle() public;
```

### testRevertLowGasWSTETHToken()

- **Signature**: `testRevertLowGasWSTETHToken()`
- **Visibility**: public
- **Source Range**: 89390:759:244
- **Details**: [function_testRevertLowGasWSTETHToken.md](./function_testRevertLowGasWSTETHToken.md)

**Signature:**
```solidity
function testRevertLowGasWSTETHToken() public;
```

### testRevertLowGasRETHToken()

- **Signature**: `testRevertLowGasRETHToken()`
- **Visibility**: public
- **Source Range**: 90155:751:244
- **Details**: [function_testRevertLowGasRETHToken.md](./function_testRevertLowGasRETHToken.md)

**Signature:**
```solidity
function testRevertLowGasRETHToken() public;
```

### testRETHRedemptionOnlyHitsTrovesAtICRGte100()

- **Signature**: `testRETHRedemptionOnlyHitsTrovesAtICRGte100()`
- **Visibility**: public
- **Source Range**: 91191:8192:244
- **Details**: [function_testRETHRedemptionOnlyHitsTrovesAtICRGte100.md](./function_testRETHRedemptionOnlyHitsTrovesAtICRGte100.md)

**Signature:**
```solidity
function testRETHRedemptionOnlyHitsTrovesAtICRGte100() public;
```

### testSTETHRedemptionOnlyHitsTrovesAtICRGte100()

- **Signature**: `testSTETHRedemptionOnlyHitsTrovesAtICRGte100()`
- **Visibility**: public
- **Source Range**: 99389:8214:244
- **Details**: [function_testSTETHRedemptionOnlyHitsTrovesAtICRGte100.md](./function_testSTETHRedemptionOnlyHitsTrovesAtICRGte100.md)

**Signature:**
```solidity
function testSTETHRedemptionOnlyHitsTrovesAtICRGte100() public;
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
