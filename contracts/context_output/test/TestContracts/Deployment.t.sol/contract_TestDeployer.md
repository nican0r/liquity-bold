# Contract: TestDeployer

## Metadata

- **Name**: TestDeployer
- **Type**: Contract
- **Path**: test/TestContracts/Deployment.t.sol

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

### vmSafe (inherited from ScriptBase)

```solidity
VmSafe internal constant vmSafe = VmSafe(VM_ADDRESS)
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

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

### IS_SCRIPT (inherited from Script)

```solidity
bool public IS_SCRIPT = true
```

### files (inherited from MetadataDeployment)

```solidity
mapping(bytes4 => File) public files
```

### pointer (inherited from MetadataDeployment)

```solidity
address public pointer
```

### initializedFixedAssetReader (inherited from MetadataDeployment)

```solidity
FixedAssetReader public initializedFixedAssetReader
```

**FixedAssetReader**: [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

### USDC

```solidity
IERC20 internal constant USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48)
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### WETH_MAINNET

```solidity
IWETH internal constant WETH_MAINNET = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2)
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### curveFactory

```solidity
ICurveFactory internal constant curveFactory = ICurveFactory(0x98EE851a00abeE0d95D08cF4CA2BdCE32aeaAF7F)
```

**ICurveFactory**: [src/Zappers/Modules/Exchanges/Curve/ICurveFactory.sol/interface_ICurveFactory.md]

### curveStableswapFactory

```solidity
ICurveStableswapNGFactory internal constant curveStableswapFactory = ICurveStableswapNGFactory(0x6A8cbed756804B16E05E741eDaBd5cB544AE21bf)
```

**ICurveStableswapNGFactory**: [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]

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

### uniV3Router

```solidity
ISwapRouter internal constant uniV3Router = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564)
```

**ISwapRouter**: [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

### uniV3PositionManager

```solidity
INonfungiblePositionManager internal constant uniV3PositionManager = INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88)
```

**INonfungiblePositionManager**: [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]

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

### SALT

```solidity
bytes32 internal constant SALT = keccak256("LiquityV2")
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

### File (inherited from MetadataDeployment)

```solidity
struct File {
    bytes data;
    uint256 start;
    uint256 end;
}
```

### LiquityContractsDevPools

```solidity
struct LiquityContractsDevPools {
    IDefaultPool defaultPool;
    ICollSurplusPool collSurplusPool;
    GasPool gasPool;
}
```

### LiquityContractsDev

```solidity
struct LiquityContractsDev {
    IAddressesRegistry addressesRegistry;
    IBorrowerOperationsTester borrowerOperations;
    ISortedTroves sortedTroves;
    IActivePool activePool;
    IStabilityPool stabilityPool;
    ITroveManagerTester troveManager;
    ITroveNFT troveNFT;
    IPriceFeedTestnet priceFeed;
    IInterestRouter interestRouter;
    IERC20Metadata collToken;
    LiquityContractsDevPools pools;
}
```

### LiquityContracts

```solidity
struct LiquityContracts {
    IAddressesRegistry addressesRegistry;
    IActivePool activePool;
    IBorrowerOperations borrowerOperations;
    ICollSurplusPool collSurplusPool;
    IDefaultPool defaultPool;
    ISortedTroves sortedTroves;
    IStabilityPool stabilityPool;
    ITroveManager troveManager;
    ITroveNFT troveNFT;
    IPriceFeed priceFeed;
    GasPool gasPool;
    IInterestRouter interestRouter;
    IERC20Metadata collToken;
}
```

### Zappers

```solidity
struct Zappers {
    WETHZapper wethZapper;
    GasCompZapper gasCompZapper;
    ILeverageZapper leverageZapperCurve;
    ILeverageZapper leverageZapperUniV3;
    ILeverageZapper leverageZapperHybrid;
}
```

### LiquityContractAddresses

```solidity
struct LiquityContractAddresses {
    address activePool;
    address borrowerOperations;
    address collSurplusPool;
    address defaultPool;
    address sortedTroves;
    address stabilityPool;
    address troveManager;
    address troveNFT;
    address metadataNFT;
    address priceFeed;
    address gasPool;
    address interestRouter;
}
```

### TroveManagerParams

```solidity
struct TroveManagerParams {
    uint256 CCR;
    uint256 MCR;
    uint256 BCR;
    uint256 SCR;
    uint256 LIQUIDATION_PENALTY_SP;
    uint256 LIQUIDATION_PENALTY_REDISTRIBUTION;
}
```

### DeploymentVarsDev

```solidity
struct DeploymentVarsDev {
    uint256 numCollaterals;
    IERC20Metadata[] collaterals;
    IAddressesRegistry[] addressesRegistries;
    ITroveManager[] troveManagers;
    bytes bytecode;
    address boldTokenAddress;
    uint256 i;
}
```

### DeploymentResultMainnet

```solidity
struct DeploymentResultMainnet {
    LiquityContracts[] contractsArray;
    ExternalAddresses externalAddresses;
    CollateralRegistryTester collateralRegistry;
    IBoldToken boldToken;
    HintHelpers hintHelpers;
    MultiTroveGetter multiTroveGetter;
    Zappers[] zappersArray;
}
```

### DeploymentVarsMainnet

```solidity
struct DeploymentVarsMainnet {
    OracleParams oracleParams;
    uint256 numCollaterals;
    IERC20Metadata[] collaterals;
    IAddressesRegistry[] addressesRegistries;
    ITroveManager[] troveManagers;
    IPriceFeed[] priceFeeds;
    bytes bytecode;
    address boldTokenAddress;
    uint256 i;
}
```

### DeploymentParamsMainnet

```solidity
struct DeploymentParamsMainnet {
    uint256 branch;
    IERC20Metadata collToken;
    IPriceFeed priceFeed;
    IBoldToken boldToken;
    ICollateralRegistry collateralRegistry;
    IWETH weth;
    IAddressesRegistry addressesRegistry;
    address troveManagerAddress;
    IHintHelpers hintHelpers;
    IMultiTroveGetter multiTroveGetter;
    ICurveStableswapNGPool usdcCurvePool;
}
```

### ExternalAddresses

```solidity
struct ExternalAddresses {
    address ETHOracle;
    address STETHOracle;
    address RETHOracle;
    address WSTETHToken;
    address RETHToken;
}
```

### OracleParams

```solidity
struct OracleParams {
    uint256 ethUsdStalenessThreshold;
    uint256 stEthUsdStalenessThreshold;
    uint256 rEthEthStalenessThreshold;
}
```

### UniV3Vars

```solidity
struct UniV3Vars {
    IExchange uniV3Exchange;
    uint256 price;
    address[2] tokens;
}
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

### getBytecode(bytes,address)

- **Signature**: `getBytecode(bytes,address)`
- **Visibility**: public
- **Source Range**: 6875:199:260
- **Details**: [function_getBytecode_bytes_address.md](./function_getBytecode_bytes_address.md)

**Signature:**
```solidity
function getBytecode(bytes memory _creationCode, address _addressesRegistry) public pure returns (bytes memory);
```

### getAddress(address,bytes,bytes32)

- **Signature**: `getAddress(address,bytes,bytes32)`
- **Visibility**: public
- **Source Range**: 7080:325:260
- **Details**: [function_getAddress_address_bytes_bytes32.md](./function_getAddress_address_bytes_bytes32.md)

**Signature:**
```solidity
function getAddress(address _deployer, bytes memory _bytecode, bytes32 _salt) public pure returns (address);
```

### deployAndConnectContracts()

- **Signature**: `deployAndConnectContracts()`
- **Visibility**: external
- **Source Range**: 7411:502:260
- **Details**: [function_deployAndConnectContracts.md](./function_deployAndConnectContracts.md)

**Signature:**
```solidity
function deployAndConnectContracts() external returns (LiquityContractsDev memory contracts, ICollateralRegistry collateralRegistry, IBoldToken boldToken, HintHelpers hintHelpers, MultiTroveGetter multiTroveGetter, IWETH WETH, Zappers memory zappers);
```

### deployAndConnectContracts(struct TestDeployer.TroveManagerParams)

- **Signature**: `deployAndConnectContracts(struct TestDeployer.TroveManagerParams)`
- **Visibility**: public
- **Source Range**: 7919:936:260
- **Details**: [function_deployAndConnectContracts_struct_TestDeployer.TroveManagerParams.md](./function_deployAndConnectContracts_struct_TestDeployer.TroveManagerParams.md)

**Signature:**
```solidity
function deployAndConnectContracts(TroveManagerParams memory troveManagerParams) public returns (LiquityContractsDev memory contracts, ICollateralRegistry collateralRegistry, IBoldToken boldToken, HintHelpers hintHelpers, MultiTroveGetter multiTroveGetter, IWETH WETH, Zappers memory zappers);
```

### deployAndConnectContractsMultiColl(struct TestDeployer.TroveManagerParams[])

- **Signature**: `deployAndConnectContractsMultiColl(struct TestDeployer.TroveManagerParams[])`
- **Visibility**: public
- **Source Range**: 8861:840:260
- **Details**: [function_deployAndConnectContractsMultiColl_struct_TestDeployer.TroveManagerParams[].md](./function_deployAndConnectContractsMultiColl_struct_TestDeployer.TroveManagerParams[].md)

**Signature:**
```solidity
function deployAndConnectContractsMultiColl(TroveManagerParams[] memory troveManagerParamsArray) public returns (LiquityContractsDev[] memory contractsArray, ICollateralRegistry collateralRegistry, IBoldToken boldToken, HintHelpers hintHelpers, MultiTroveGetter multiTroveGetter, IWETH WETH, Zappers[] memory zappersArray);
```

### deployAndConnectContracts(struct TestDeployer.TroveManagerParams[],contract IWETH)

- **Signature**: `deployAndConnectContracts(struct TestDeployer.TroveManagerParams[],contract IWETH)`
- **Visibility**: public
- **Source Range**: 10123:3446:260
- **Details**: [function_deployAndConnectContracts_struct_TestDeployer.TroveManagerParams[]_contract_IWETH.md](./function_deployAndConnectContracts_struct_TestDeployer.TroveManagerParams[]_contract_IWETH.md)

**Signature:**
```solidity
function deployAndConnectContracts(TroveManagerParams[] memory troveManagerParamsArray, IWETH _WETH) public returns (LiquityContractsDev[] memory contractsArray, ICollateralRegistry collateralRegistry, IBoldToken boldToken, HintHelpers hintHelpers, MultiTroveGetter multiTroveGetter, Zappers[] memory zappersArray);
```

### deployAndConnectContractsMainnet(struct TestDeployer.TroveManagerParams[])

- **Signature**: `deployAndConnectContractsMainnet(struct TestDeployer.TroveManagerParams[])`
- **Visibility**: public
- **Source Range**: 20372:4065:260
- **Details**: [function_deployAndConnectContractsMainnet_struct_TestDeployer.TroveManagerParams[].md](./function_deployAndConnectContractsMainnet_struct_TestDeployer.TroveManagerParams[].md)

**Signature:**
```solidity
function deployAndConnectContractsMainnet(TroveManagerParams[] memory _troveManagerParamsArray) public returns (DeploymentResultMainnet memory result);
```

### deployMetadata(bytes32) (inherited from MetadataDeployment)

- **Signature**: `deployMetadata(bytes32)`
- **Visibility**: public
- **Source Range**: 550:282:274
- **Details**: [function_deployMetadata_bytes32.md](./function_deployMetadata_bytes32.md)

**Signature:**
```solidity
function deployMetadata(bytes32 _salt) public returns (MetadataNFT);
```
