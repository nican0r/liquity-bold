# Contract: ZapperLeverageMainnet

## Metadata

- **Name**: ZapperLeverageMainnet
- **Type**: Contract
- **Path**: test/zapperLeverage.t.sol

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

### USDC

```solidity
IERC20 internal constant USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48)
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### BOLD_TOKEN_INDEX

```solidity
uint128 internal constant BOLD_TOKEN_INDEX = 0
```

### COLL_TOKEN_INDEX

```solidity
uint256 internal constant COLL_TOKEN_INDEX = 1
```

### USDC_INDEX

```solidity
uint128 internal constant USDC_INDEX = 1
```

### uniV3PositionManager

```solidity
INonfungiblePositionManager internal constant uniV3PositionManager = INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88)
```

**INonfungiblePositionManager**: [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]

### uniswapV3Factory

```solidity
IUniswapV3Factory internal constant uniswapV3Factory = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984)
```

**IUniswapV3Factory**: [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]

### uniV3Quoter

```solidity
IQuoterV2 internal constant uniV3Quoter = IQuoterV2(0x61fFE014bA17989E743c5F6cB21bF9697530B21e)
```

**IQuoterV2**: [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

### uniV3Router

```solidity
ISwapRouter internal constant uniV3Router = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564)
```

**ISwapRouter**: [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

### UNIV3_FEE

```solidity
uint24 internal constant UNIV3_FEE = 3000
```

### UNIV3_FEE_USDC_WETH

```solidity
uint24 internal constant UNIV3_FEE_USDC_WETH = 500
```

### UNIV3_FEE_WETH_COLL

```solidity
uint24 internal constant UNIV3_FEE_WETH_COLL = 100
```

### NUM_COLLATERALS

```solidity
uint256 internal constant NUM_COLLATERALS = 3
```

### baseZapperArray

```solidity
IZapper[] internal baseZapperArray
```

**IZapper**: [src/Zappers/Interfaces/IZapper.sol/interface_IZapper.md]

### leverageZapperCurveArray

```solidity
ILeverageZapper[] internal leverageZapperCurveArray
```

**ILeverageZapper**: [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]

### leverageZapperUniV3Array

```solidity
ILeverageZapper[] internal leverageZapperUniV3Array
```

**ILeverageZapper**: [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]

### leverageZapperHybridArray

```solidity
ILeverageZapper[] internal leverageZapperHybridArray
```

**ILeverageZapper**: [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]

### hybridCurveUniV3ExchangeHelpers

```solidity
HybridCurveUniV3ExchangeHelpers internal hybridCurveUniV3ExchangeHelpers
```

**HybridCurveUniV3ExchangeHelpers**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpers.sol/contract_HybridCurveUniV3ExchangeHelpers.md]

### usdcCurvePool

```solidity
ICurveStableswapNGPool internal usdcCurvePool
```

**ICurveStableswapNGPool**: [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]

### contractsArray

```solidity
TestDeployer.LiquityContracts[] internal contractsArray
```

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

### OpenTroveVars

```solidity
struct OpenTroveVars {
    uint256 price;
    uint256 flashLoanAmount;
    uint256 expectedBoldAmount;
    uint256 maxNetDebt;
    uint256 effectiveBoldAmount;
    uint256 value;
    uint256 troveId;
}
```

### LeverVars

```solidity
struct LeverVars {
    uint256 price;
    uint256 currentCR;
    uint256 currentLR;
    uint256 currentCollAmount;
    uint256 flashLoanAmount;
    uint256 expectedBoldAmount;
    uint256 maxNetDebtIncrease;
    uint256 effectiveBoldAmount;
}
```

### TestVars

```solidity
struct TestVars {
    uint256 collAmount;
    uint256 initialLeverageRatio;
    uint256 troveId;
    uint256 initialDebt;
    uint256 newLeverageRatio;
    uint256 resultingCollateralRatio;
    uint256 flashLoanAmount;
    uint256 price;
    uint256 boldBalanceBeforeA;
    uint256 ethBalanceBeforeA;
    uint256 collBalanceBeforeA;
    uint256 boldBalanceBeforeZapper;
    uint256 ethBalanceBeforeZapper;
    uint256 collBalanceBeforeZapper;
    uint256 boldBalanceBeforeExchange;
    uint256 ethBalanceBeforeExchange;
    uint256 collBalanceBeforeExchange;
}
```

### OpenLeveragedTroveWithIndexParams

```solidity
struct OpenLeveragedTroveWithIndexParams {
    ILeverageZapper leverageZapper;
    IERC20 collToken;
    uint256 index;
    uint256 collAmount;
    uint256 leverageRatio;
    IPriceFeed priceFeed;
    ExchangeType exchangeType;
    uint256 branch;
    address batchManager;
}
```

### LeverUpParams

```solidity
struct LeverUpParams {
    ILeverageZapper leverageZapper;
    IERC20 collToken;
    uint256 troveId;
    uint256 leverageRatio;
    ITroveManager troveManager;
    IPriceFeed priceFeed;
    ExchangeType exchangeType;
    uint256 branch;
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

### ExchangeType

```solidity
enum ExchangeType {
    Curve,
    UniV3,
    HybridCurveUniV3
}
```

## Public/External Functions

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 3575:3711:338
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() override public;
```

### onERC721Received(address,address,uint256,bytes)

- **Signature**: `onERC721Received(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 11933:154:338
- **Details**: [function_onERC721Received_address_address_uint256_bytes.md](./function_onERC721Received_address_address_uint256_bytes.md)

**Signature:**
```solidity
function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4);
```

### testCanOpenTroveWithCurve()

- **Signature**: `testCanOpenTroveWithCurve()`
- **Visibility**: external
- **Source Range**: 15320:214:338
- **Details**: [function_testCanOpenTroveWithCurve.md](./function_testCanOpenTroveWithCurve.md)

**Signature:**
```solidity
function testCanOpenTroveWithCurve() external;
```

### testCanOpenTroveWithUniV3()

- **Signature**: `testCanOpenTroveWithUniV3()`
- **Visibility**: external
- **Source Range**: 15540:214:338
- **Details**: [function_testCanOpenTroveWithUniV3.md](./function_testCanOpenTroveWithUniV3.md)

**Signature:**
```solidity
function testCanOpenTroveWithUniV3() external;
```

### testCanOpenTroveWithHybrid()

- **Signature**: `testCanOpenTroveWithHybrid()`
- **Visibility**: external
- **Source Range**: 15760:254:338
- **Details**: [function_testCanOpenTroveWithHybrid.md](./function_testCanOpenTroveWithHybrid.md)

**Signature:**
```solidity
function testCanOpenTroveWithHybrid() external;
```

### testCanOpenTroveAndJoinBatchWithCurve()

- **Signature**: `testCanOpenTroveAndJoinBatchWithCurve()`
- **Visibility**: external
- **Source Range**: 16020:258:338
- **Details**: [function_testCanOpenTroveAndJoinBatchWithCurve.md](./function_testCanOpenTroveAndJoinBatchWithCurve.md)

**Signature:**
```solidity
function testCanOpenTroveAndJoinBatchWithCurve() external;
```

### testCanOpenTroveAndJoinBatchWithUniV3()

- **Signature**: `testCanOpenTroveAndJoinBatchWithUniV3()`
- **Visibility**: external
- **Source Range**: 16284:302:338
- **Details**: [function_testCanOpenTroveAndJoinBatchWithUniV3.md](./function_testCanOpenTroveAndJoinBatchWithUniV3.md)

**Signature:**
```solidity
function testCanOpenTroveAndJoinBatchWithUniV3() external;
```

### testCanOpenTroveAndJoinBatchWithHybrid()

- **Signature**: `testCanOpenTroveAndJoinBatchWithHybrid()`
- **Visibility**: external
- **Source Range**: 16592:298:338
- **Details**: [function_testCanOpenTroveAndJoinBatchWithHybrid.md](./function_testCanOpenTroveAndJoinBatchWithHybrid.md)

**Signature:**
```solidity
function testCanOpenTroveAndJoinBatchWithHybrid() external;
```

### testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithCurve()

- **Signature**: `testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithCurve()`
- **Visibility**: external
- **Source Range**: 21184:245:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithCurve.md](./function_testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithCurve.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithCurve() external;
```

### testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3()

- **Signature**: `testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3()`
- **Visibility**: external
- **Source Range**: 21435:245:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3.md](./function_testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3() external;
```

### testCanLeverUpTroveWithCurve()

- **Signature**: `testCanLeverUpTroveWithCurve()`
- **Visibility**: external
- **Source Range**: 25010:208:338
- **Details**: [function_testCanLeverUpTroveWithCurve.md](./function_testCanLeverUpTroveWithCurve.md)

**Signature:**
```solidity
function testCanLeverUpTroveWithCurve() external;
```

### testCanLeverUpTroveWithUniV3()

- **Signature**: `testCanLeverUpTroveWithUniV3()`
- **Visibility**: external
- **Source Range**: 25224:208:338
- **Details**: [function_testCanLeverUpTroveWithUniV3.md](./function_testCanLeverUpTroveWithUniV3.md)

**Signature:**
```solidity
function testCanLeverUpTroveWithUniV3() external;
```

### testCanLeverUpTroveWithHybrid()

- **Signature**: `testCanLeverUpTroveWithHybrid()`
- **Visibility**: external
- **Source Range**: 25438:248:338
- **Details**: [function_testCanLeverUpTroveWithHybrid.md](./function_testCanLeverUpTroveWithHybrid.md)

**Signature:**
```solidity
function testCanLeverUpTroveWithHybrid() external;
```

### testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver()

- **Signature**: `testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 29961:256:338
- **Details**: [function_testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver.md](./function_testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver.md)

**Signature:**
```solidity
function testCannotLeverUpTroveWithCurveIfZapperIsNotReceiver() external;
```

### testCannotLeverUpTroveWithUniV3IfZapperIsNotReceiver()

- **Signature**: `testCannotLeverUpTroveWithUniV3IfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 30223:256:338
- **Details**: [function_testCannotLeverUpTroveWithUniV3IfZapperIsNotReceiver.md](./function_testCannotLeverUpTroveWithUniV3IfZapperIsNotReceiver.md)

**Signature:**
```solidity
function testCannotLeverUpTroveWithUniV3IfZapperIsNotReceiver() external;
```

### testCannotLeverUpTroveWithHybridIfZapperIsNotReceiver()

- **Signature**: `testCannotLeverUpTroveWithHybridIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 30485:296:338
- **Details**: [function_testCannotLeverUpTroveWithHybridIfZapperIsNotReceiver.md](./function_testCannotLeverUpTroveWithHybridIfZapperIsNotReceiver.md)

**Signature:**
```solidity
function testCannotLeverUpTroveWithHybridIfZapperIsNotReceiver() external;
```

### testOnlyFlashLoanProviderCanCallLeverUpCallbackWithCurve()

- **Signature**: `testOnlyFlashLoanProviderCanCallLeverUpCallbackWithCurve()`
- **Visibility**: external
- **Source Range**: 33254:241:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallLeverUpCallbackWithCurve.md](./function_testOnlyFlashLoanProviderCanCallLeverUpCallbackWithCurve.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallLeverUpCallbackWithCurve() external;
```

### testOnlyFlashLoanProviderCanCallLeverUpCallbackWithUniV3()

- **Signature**: `testOnlyFlashLoanProviderCanCallLeverUpCallbackWithUniV3()`
- **Visibility**: external
- **Source Range**: 33501:241:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallLeverUpCallbackWithUniV3.md](./function_testOnlyFlashLoanProviderCanCallLeverUpCallbackWithUniV3.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallLeverUpCallbackWithUniV3() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithCurveFromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithCurveFromZapper()`
- **Visibility**: external
- **Source Range**: 34373:254:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithCurveFromZapper.md](./function_testOnlyOwnerOrManagerCanLeverUpWithCurveFromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithCurveFromZapper() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithUniV3FromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithUniV3FromZapper()`
- **Visibility**: external
- **Source Range**: 34633:254:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithUniV3FromZapper.md](./function_testOnlyOwnerOrManagerCanLeverUpWithUniV3FromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithUniV3FromZapper() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithHybridFromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithHybridFromZapper()`
- **Visibility**: external
- **Source Range**: 34893:294:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithHybridFromZapper.md](./function_testOnlyOwnerOrManagerCanLeverUpWithHybridFromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithHybridFromZapper() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 37339:278:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 37623:278:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 37907:348:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerVault()`
- **Visibility**: external
- **Source Range**: 40689:268:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerVault.md](./function_testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithCurveFromBalancerVault() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerVault()`
- **Visibility**: external
- **Source Range**: 40963:268:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerVault.md](./function_testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithUniV3FromBalancerVault() external;
```

### testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerVault()`
- **Visibility**: external
- **Source Range**: 41237:338:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerVault.md](./function_testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverUpWithHybridFromBalancerVault() external;
```

### testCanLeverDownTroveWithCurve()

- **Signature**: `testCanLeverDownTroveWithCurve()`
- **Visibility**: external
- **Source Range**: 46048:212:338
- **Details**: [function_testCanLeverDownTroveWithCurve.md](./function_testCanLeverDownTroveWithCurve.md)

**Signature:**
```solidity
function testCanLeverDownTroveWithCurve() external;
```

### testCanLeverDownTroveWithUniV3()

- **Signature**: `testCanLeverDownTroveWithUniV3()`
- **Visibility**: external
- **Source Range**: 46266:212:338
- **Details**: [function_testCanLeverDownTroveWithUniV3.md](./function_testCanLeverDownTroveWithUniV3.md)

**Signature:**
```solidity
function testCanLeverDownTroveWithUniV3() external;
```

### testCanLeverDownTroveWithHybrid()

- **Signature**: `testCanLeverDownTroveWithHybrid()`
- **Visibility**: external
- **Source Range**: 46484:252:338
- **Details**: [function_testCanLeverDownTroveWithHybrid.md](./function_testCanLeverDownTroveWithHybrid.md)

**Signature:**
```solidity
function testCanLeverDownTroveWithHybrid() external;
```

### testCannotLeverDownWithCurveFromZapperIfZapperIsNotReceiver()

- **Signature**: `testCannotLeverDownWithCurveFromZapperIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 51154:270:338
- **Details**: [function_testCannotLeverDownWithCurveFromZapperIfZapperIsNotReceiver.md](./function_testCannotLeverDownWithCurveFromZapperIfZapperIsNotReceiver.md)

**Signature:**
```solidity
function testCannotLeverDownWithCurveFromZapperIfZapperIsNotReceiver() external;
```

### testCannotLeverDownWithUniV3FromZapperIfZapperIsNotReceiver()

- **Signature**: `testCannotLeverDownWithUniV3FromZapperIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 51430:270:338
- **Details**: [function_testCannotLeverDownWithUniV3FromZapperIfZapperIsNotReceiver.md](./function_testCannotLeverDownWithUniV3FromZapperIfZapperIsNotReceiver.md)

**Signature:**
```solidity
function testCannotLeverDownWithUniV3FromZapperIfZapperIsNotReceiver() external;
```

### testCannotLeverDownWithHybridFromZapperIfZapperIsNotReceiver()

- **Signature**: `testCannotLeverDownWithHybridFromZapperIfZapperIsNotReceiver()`
- **Visibility**: external
- **Source Range**: 51706:339:338
- **Details**: [function_testCannotLeverDownWithHybridFromZapperIfZapperIsNotReceiver.md](./function_testCannotLeverDownWithHybridFromZapperIfZapperIsNotReceiver.md)

**Signature:**
```solidity
function testCannotLeverDownWithHybridFromZapperIfZapperIsNotReceiver() external;
```

### testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve()

- **Signature**: `testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve()`
- **Visibility**: external
- **Source Range**: 53808:245:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve.md](./function_testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve() external;
```

### testOnlyFlashLoanProviderCanCallLeverDownCallbackWithUniV3()

- **Signature**: `testOnlyFlashLoanProviderCanCallLeverDownCallbackWithUniV3()`
- **Visibility**: external
- **Source Range**: 54059:245:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallLeverDownCallbackWithUniV3.md](./function_testOnlyFlashLoanProviderCanCallLeverDownCallbackWithUniV3.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallLeverDownCallbackWithUniV3() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithCurveFromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithCurveFromZapper()`
- **Visibility**: external
- **Source Range**: 54910:258:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithCurveFromZapper.md](./function_testOnlyOwnerOrManagerCanLeverDownWithCurveFromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithCurveFromZapper() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithUniV3FromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithUniV3FromZapper()`
- **Visibility**: external
- **Source Range**: 55174:258:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithUniV3FromZapper.md](./function_testOnlyOwnerOrManagerCanLeverDownWithUniV3FromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithUniV3FromZapper() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithHybridFromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithHybridFromZapper()`
- **Visibility**: external
- **Source Range**: 55438:297:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithHybridFromZapper.md](./function_testOnlyOwnerOrManagerCanLeverDownWithHybridFromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithHybridFromZapper() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 57547:312:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 57865:312:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 58183:352:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerVault()`
- **Visibility**: external
- **Source Range**: 60631:272:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerVault.md](./function_testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithCurveFromBalancerVault() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerVault()`
- **Visibility**: external
- **Source Range**: 60909:272:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerVault.md](./function_testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithUniV3FromBalancerVault() external;
```

### testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerVault()`
- **Visibility**: external
- **Source Range**: 61187:342:338
- **Details**: [function_testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerVault.md](./function_testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanLeverDownWithHybridFromBalancerVault() external;
```

### testCanCloseTroveWithBaseZapper()

- **Signature**: `testCanCloseTroveWithBaseZapper()`
- **Visibility**: external
- **Source Range**: 63911:180:338
- **Details**: [function_testCanCloseTroveWithBaseZapper.md](./function_testCanCloseTroveWithBaseZapper.md)

**Signature:**
```solidity
function testCanCloseTroveWithBaseZapper() external;
```

### testCanCloseTroveWithLeverageCurve()

- **Signature**: `testCanCloseTroveWithLeverageCurve()`
- **Visibility**: external
- **Source Range**: 64097:201:338
- **Details**: [function_testCanCloseTroveWithLeverageCurve.md](./function_testCanCloseTroveWithLeverageCurve.md)

**Signature:**
```solidity
function testCanCloseTroveWithLeverageCurve() external;
```

### testCanCloseTroveWithLeverageUniV3()

- **Signature**: `testCanCloseTroveWithLeverageUniV3()`
- **Visibility**: external
- **Source Range**: 64304:201:338
- **Details**: [function_testCanCloseTroveWithLeverageUniV3.md](./function_testCanCloseTroveWithLeverageUniV3.md)

**Signature:**
```solidity
function testCanCloseTroveWithLeverageUniV3() external;
```

### testCanCloseTroveWithLeverageHybrid()

- **Signature**: `testCanCloseTroveWithLeverageHybrid()`
- **Visibility**: external
- **Source Range**: 64511:189:338
- **Details**: [function_testCanCloseTroveWithLeverageHybrid.md](./function_testCanCloseTroveWithLeverageHybrid.md)

**Signature:**
```solidity
function testCanCloseTroveWithLeverageHybrid() external;
```

### testCannotCloseTroveWithBaseZapperIfLessCollThanExpected()

- **Signature**: `testCannotCloseTroveWithBaseZapperIfLessCollThanExpected()`
- **Visibility**: external
- **Source Range**: 69259:230:338
- **Details**: [function_testCannotCloseTroveWithBaseZapperIfLessCollThanExpected.md](./function_testCannotCloseTroveWithBaseZapperIfLessCollThanExpected.md)

**Signature:**
```solidity
function testCannotCloseTroveWithBaseZapperIfLessCollThanExpected() external;
```

### testCannotCloseTroveWithLeverageCurveIfLessCollThanExpected()

- **Signature**: `testCannotCloseTroveWithLeverageCurveIfLessCollThanExpected()`
- **Visibility**: external
- **Source Range**: 69495:251:338
- **Details**: [function_testCannotCloseTroveWithLeverageCurveIfLessCollThanExpected.md](./function_testCannotCloseTroveWithLeverageCurveIfLessCollThanExpected.md)

**Signature:**
```solidity
function testCannotCloseTroveWithLeverageCurveIfLessCollThanExpected() external;
```

### testCannotCloseTroveWithLeverageUniV3IfLessCollThanExpected()

- **Signature**: `testCannotCloseTroveWithLeverageUniV3IfLessCollThanExpected()`
- **Visibility**: external
- **Source Range**: 69752:251:338
- **Details**: [function_testCannotCloseTroveWithLeverageUniV3IfLessCollThanExpected.md](./function_testCannotCloseTroveWithLeverageUniV3IfLessCollThanExpected.md)

**Signature:**
```solidity
function testCannotCloseTroveWithLeverageUniV3IfLessCollThanExpected() external;
```

### testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected()

- **Signature**: `testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected()`
- **Visibility**: external
- **Source Range**: 70009:239:338
- **Details**: [function_testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected.md](./function_testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected.md)

**Signature:**
```solidity
function testCannotCloseTroveWithLeverageHybridIfLessCollThanExpected() external;
```

### testCannotCloseTroveIfFrontRunByRedemption()

- **Signature**: `testCannotCloseTroveIfFrontRunByRedemption()`
- **Visibility**: external
- **Source Range**: 71250:2132:338
- **Details**: [function_testCannotCloseTroveIfFrontRunByRedemption.md](./function_testCannotCloseTroveIfFrontRunByRedemption.md)

**Signature:**
```solidity
function testCannotCloseTroveIfFrontRunByRedemption() external;
```

### testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper()

- **Signature**: `testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper()`
- **Visibility**: external
- **Source Range**: 73388:246:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper.md](./function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper() external;
```

### testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithCurve()

- **Signature**: `testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithCurve()`
- **Visibility**: external
- **Source Range**: 73640:250:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithCurve.md](./function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithCurve.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithCurve() external;
```

### testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithUniV3()

- **Signature**: `testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithUniV3()`
- **Visibility**: external
- **Source Range**: 73896:250:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithUniV3.md](./function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithUniV3.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithUniV3() external;
```

### testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithHybrid()

- **Signature**: `testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithHybrid()`
- **Visibility**: external
- **Source Range**: 74152:238:338
- **Details**: [function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithHybrid.md](./function_testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithHybrid.md)

**Signature:**
```solidity
function testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithHybrid() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromZapper()`
- **Visibility**: external
- **Source Range**: 75152:236:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromZapper.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromZapper() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithCurveFromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithCurveFromZapper()`
- **Visibility**: external
- **Source Range**: 75394:240:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithCurveFromZapper.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithCurveFromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithCurveFromZapper() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromZapper()`
- **Visibility**: external
- **Source Range**: 75640:240:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromZapper.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromZapper() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithHybridFromZapper()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithHybridFromZapper()`
- **Visibility**: external
- **Source Range**: 75886:228:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithHybridFromZapper.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithHybridFromZapper.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithHybridFromZapper() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 77043:260:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 77309:264:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 77579:264:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerFLProvider()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerFLProvider()`
- **Visibility**: external
- **Source Range**: 77849:252:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerFLProvider.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerFLProvider.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerFLProvider() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerVault()`
- **Visibility**: external
- **Source Range**: 79533:250:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerVault.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithBaseZapperFromBalancerVault() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerVault()`
- **Visibility**: external
- **Source Range**: 79789:254:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerVault.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithCurveFromBalancerVault() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerVault()`
- **Visibility**: external
- **Source Range**: 80049:254:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerVault.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithUniV3FromBalancerVault() external;
```

### testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerVault()

- **Signature**: `testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerVault()`
- **Visibility**: external
- **Source Range**: 80309:242:338
- **Details**: [function_testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerVault.md](./function_testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerVault.md)

**Signature:**
```solidity
function testOnlyOwnerOrManagerCanCloseTroveWithHybridFromBalancerVault() external;
```

### testApprovalIsNotReset()

- **Signature**: `testApprovalIsNotReset()`
- **Visibility**: external
- **Source Range**: 82024:447:338
- **Details**: [function_testApprovalIsNotReset.md](./function_testApprovalIsNotReset.md)

**Signature:**
```solidity
function testApprovalIsNotReset() external;
```

### testHybridExchangeHelpers()

- **Signature**: `testHybridExchangeHelpers()`
- **Visibility**: public
- **Source Range**: 88008:738:338
- **Details**: [function_testHybridExchangeHelpers.md](./function_testHybridExchangeHelpers.md)

**Signature:**
```solidity
function testHybridExchangeHelpers() public;
```

### testHybridExchangeHelpersNoDeviation()

- **Signature**: `testHybridExchangeHelpersNoDeviation()`
- **Visibility**: public
- **Source Range**: 89344:344:338
- **Details**: [function_testHybridExchangeHelpersNoDeviation.md](./function_testHybridExchangeHelpersNoDeviation.md)

**Signature:**
```solidity
function testHybridExchangeHelpersNoDeviation() public;
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
