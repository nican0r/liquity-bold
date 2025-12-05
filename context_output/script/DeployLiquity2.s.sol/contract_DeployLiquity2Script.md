# Contract: DeployLiquity2Script

## Metadata

- **Name**: DeployLiquity2Script
- **Type**: Contract
- **Path**: script/DeployLiquity2.s.sol

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

### LUSD (inherited from DeployGovernance)

```solidity
address internal constant LUSD = 0x5f98805A4E8be255a32880FDeC7F6728C6568bA0
```

### CRV (inherited from DeployGovernance)

```solidity
address internal constant CRV = 0xD533a949740bb3306d119CC777fa900bA034cd52
```

### FUNDS_SAFE (inherited from DeployGovernance)

```solidity
address internal constant FUNDS_SAFE = 0xF06016D822943C42e3Cb7FC3a6A3B1889C1045f8
```

### DEFI_COLLECTIVE_GRANTS_ADDRESS (inherited from DeployGovernance)

```solidity
address internal constant DEFI_COLLECTIVE_GRANTS_ADDRESS = 0xDc6f869d2D34E4aee3E89A51f2Af6D54F0F7f690
```

### REGISTRATION_FEE (inherited from DeployGovernance)

```solidity
uint128 private constant REGISTRATION_FEE = 100e18
```

### REGISTRATION_THRESHOLD_FACTOR (inherited from DeployGovernance)

```solidity
uint128 private constant REGISTRATION_THRESHOLD_FACTOR = 0.0001e18
```

### UNREGISTRATION_THRESHOLD_FACTOR (inherited from DeployGovernance)

```solidity
uint128 private constant UNREGISTRATION_THRESHOLD_FACTOR = 1e18 + 1
```

### UNREGISTRATION_AFTER_EPOCHS (inherited from DeployGovernance)

```solidity
uint16 private constant UNREGISTRATION_AFTER_EPOCHS = 4
```

### VOTING_THRESHOLD_FACTOR (inherited from DeployGovernance)

```solidity
uint128 private constant VOTING_THRESHOLD_FACTOR = 0.02e18
```

### MIN_CLAIM (inherited from DeployGovernance)

```solidity
uint88 private constant MIN_CLAIM = 0
```

### MIN_ACCRUAL (inherited from DeployGovernance)

```solidity
uint88 private constant MIN_ACCRUAL = 0
```

### EPOCH_DURATION (inherited from DeployGovernance)

```solidity
uint32 internal constant EPOCH_DURATION = 7 days
```

### EPOCH_VOTING_CUTOFF (inherited from DeployGovernance)

```solidity
uint32 private constant EPOCH_VOTING_CUTOFF = 6 days
```

### DURATION (inherited from DeployGovernance)

```solidity
uint256 private constant DURATION = 7 days
```

### governance (inherited from DeployGovernance)

```solidity
Governance private governance
```

**Governance**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

### initialInitiatives (inherited from DeployGovernance)

```solidity
address[] private initialInitiatives
```

### curveUsdcBoldPool (inherited from DeployGovernance)

```solidity
ICurveStableSwapNG private curveUsdcBoldPool
```

**ICurveStableSwapNG**: [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]

### curveUsdcBoldGauge (inherited from DeployGovernance)

```solidity
ILiquidityGaugeV6 private curveUsdcBoldGauge
```

**ILiquidityGaugeV6**: [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]

### curveUsdcBoldInitiative (inherited from DeployGovernance)

```solidity
CurveV2GaugeRewards private curveUsdcBoldInitiative
```

**CurveV2GaugeRewards**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

### curveLusdBoldPool (inherited from DeployGovernance)

```solidity
ICurveStableSwapNG private curveLusdBoldPool
```

**ICurveStableSwapNG**: [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]

### curveLusdBoldGauge (inherited from DeployGovernance)

```solidity
ILiquidityGaugeV6 private curveLusdBoldGauge
```

**ILiquidityGaugeV6**: [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]

### curveLusdBoldInitiative (inherited from DeployGovernance)

```solidity
CurveV2GaugeRewards private curveLusdBoldInitiative
```

**CurveV2GaugeRewards**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

### defiCollectiveInitiative (inherited from DeployGovernance)

```solidity
address private defiCollectiveInitiative
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

### DEPLOYMENT_MODE_COMPLETE

```solidity
string internal constant DEPLOYMENT_MODE_COMPLETE = "complete"
```

### DEPLOYMENT_MODE_BOLD_ONLY

```solidity
string internal constant DEPLOYMENT_MODE_BOLD_ONLY = "bold-only"
```

### DEPLOYMENT_MODE_USE_EXISTING_BOLD

```solidity
string internal constant DEPLOYMENT_MODE_USE_EXISTING_BOLD = "use-existing-bold"
```

### NUM_BRANCHES

```solidity
uint256 internal constant NUM_BRANCHES = 3
```

### WETH_ADDRESS

```solidity
address internal WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
```

### USDC_ADDRESS

```solidity
address internal USDC_ADDRESS = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
```

### WETH

```solidity
IWETH internal WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### USDC

```solidity
IERC20Metadata internal USDC
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### WSTETH_ADDRESS

```solidity
address internal WSTETH_ADDRESS = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0
```

### RETH_ADDRESS

```solidity
address internal RETH_ADDRESS = 0xae78736Cd615f374D3085123A210448E74Fc6393
```

### ETH_ORACLE_ADDRESS

```solidity
address internal ETH_ORACLE_ADDRESS = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
```

### RETH_ORACLE_ADDRESS

```solidity
address internal RETH_ORACLE_ADDRESS = 0x536218f9E9Eb48863970252233c8F271f554C2d0
```

### STETH_ORACLE_ADDRESS

```solidity
address internal STETH_ORACLE_ADDRESS = 0xCfE54B5cD566aB89272946F602D76Ea879CAb4a8
```

### ETH_USD_STALENESS_THRESHOLD

```solidity
uint256 internal ETH_USD_STALENESS_THRESHOLD = 24 hours
```

### STETH_USD_STALENESS_THRESHOLD

```solidity
uint256 internal STETH_USD_STALENESS_THRESHOLD = 24 hours
```

### RETH_ETH_STALENESS_THRESHOLD

```solidity
uint256 internal RETH_ETH_STALENESS_THRESHOLD = 48 hours
```

### LQTY_ADDRESS

```solidity
address internal LQTY_ADDRESS = 0x6DEA81C8171D0bA574754EF6F8b412F2Ed88c54D
```

### LQTY_STAKING_ADDRESS

```solidity
address internal LQTY_STAKING_ADDRESS = 0x4f9Fbb3f1E99B56e0Fe2892e623Ed36A76Fc605d
```

### LUSD_ADDRESS

```solidity
address internal LUSD_ADDRESS = 0x5f98805A4E8be255a32880FDeC7F6728C6568bA0
```

### lqty

```solidity
address internal lqty
```

### stakingV1

```solidity
address internal stakingV1
```

### lusd

```solidity
address internal lusd
```

### curveStableswapFactory

```solidity
ICurveStableswapNGFactory internal curveStableswapFactory
```

**ICurveStableswapNGFactory**: [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]

### curveStableswapFactorySepolia

```solidity
ICurveStableswapNGFactory internal constant curveStableswapFactorySepolia = ICurveStableswapNGFactory(0xfb37b8D939FFa77114005e61CFc2e543d6F49A81)
```

**ICurveStableswapNGFactory**: [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]

### curveStableswapFactoryMainnet

```solidity
ICurveStableswapNGFactory internal constant curveStableswapFactoryMainnet = ICurveStableswapNGFactory(0x6A8cbed756804B16E05E741eDaBd5cB544AE21bf)
```

**ICurveStableswapNGFactory**: [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]

### BOLD_TOKEN_INDEX

```solidity
uint128 internal constant BOLD_TOKEN_INDEX = 0
```

### OTHER_TOKEN_INDEX

```solidity
uint128 internal constant OTHER_TOKEN_INDEX = 1
```

### UNIV3_FEE

```solidity
uint24 internal constant UNIV3_FEE = 0.3e4
```

### UNIV3_FEE_USDC_WETH

```solidity
uint24 internal constant UNIV3_FEE_USDC_WETH = 500
```

### UNIV3_FEE_WETH_COLL

```solidity
uint24 internal constant UNIV3_FEE_WETH_COLL = 100
```

### uniV3Router

```solidity
ISwapRouter internal uniV3Router
```

**ISwapRouter**: [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

### uniV3Quoter

```solidity
IQuoterV2 internal uniV3Quoter
```

**IQuoterV2**: [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

### uniswapV3Factory

```solidity
IUniswapV3Factory internal uniswapV3Factory
```

**IUniswapV3Factory**: [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]

### uniV3PositionManager

```solidity
INonfungiblePositionManager internal uniV3PositionManager
```

**INonfungiblePositionManager**: [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]

### uniV3RouterSepolia

```solidity
ISwapRouter internal constant uniV3RouterSepolia = ISwapRouter(0x65669fE35312947050C450Bd5d36e6361F85eC12)
```

**ISwapRouter**: [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

### uniV3QuoterSepolia

```solidity
IQuoterV2 internal constant uniV3QuoterSepolia = IQuoterV2(0xEd1f6473345F45b75F8179591dd5bA1888cf2FB3)
```

**IQuoterV2**: [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

### uniswapV3FactorySepolia

```solidity
IUniswapV3Factory internal constant uniswapV3FactorySepolia = IUniswapV3Factory(0x0227628f3F023bb0B980b67D528571c95c6DaC1c)
```

**IUniswapV3Factory**: [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]

### uniV3PositionManagerSepolia

```solidity
INonfungiblePositionManager internal constant uniV3PositionManagerSepolia = INonfungiblePositionManager(0x1238536071E1c677A632429e3655c799b22cDA52)
```

**INonfungiblePositionManager**: [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]

### uniV3RouterMainnet

```solidity
ISwapRouter internal constant uniV3RouterMainnet = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564)
```

**ISwapRouter**: [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

### uniV3QuoterMainnet

```solidity
IQuoterV2 internal constant uniV3QuoterMainnet = IQuoterV2(0x61fFE014bA17989E743c5F6cB21bF9697530B21e)
```

**IQuoterV2**: [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

### uniswapV3FactoryMainnet

```solidity
IUniswapV3Factory internal constant uniswapV3FactoryMainnet = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984)
```

**IUniswapV3Factory**: [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]

### uniV3PositionManagerMainnet

```solidity
INonfungiblePositionManager internal constant uniV3PositionManagerMainnet = INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88)
```

**INonfungiblePositionManager**: [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]

### balancerVault

```solidity
IVault internal constant balancerVault = IVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8)
```

**IVault**: [script/Interfaces/Balancer/IVault.sol/interface_IVault.md]

### balancerFactory

```solidity
IWeightedPoolFactory internal balancerFactory
```

**IWeightedPoolFactory**: [script/Interfaces/Balancer/IWeightedPool.sol/interface_IWeightedPoolFactory.md]

### balancerFactorySepolia

```solidity
IWeightedPoolFactory internal constant balancerFactorySepolia = IWeightedPoolFactory(0x7920BFa1b2041911b354747CA7A6cDD2dfC50Cfd)
```

**IWeightedPoolFactory**: [script/Interfaces/Balancer/IWeightedPool.sol/interface_IWeightedPoolFactory.md]

### balancerFactoryMainnet

```solidity
IWeightedPoolFactory internal constant balancerFactoryMainnet = IWeightedPoolFactory(0x897888115Ada5773E02aA29F775430BFB5F34c51)
```

**IWeightedPoolFactory**: [script/Interfaces/Balancer/IWeightedPool.sol/interface_IWeightedPoolFactory.md]

### SALT

```solidity
bytes32 internal SALT
```

### deployer

```solidity
address internal deployer
```

### useTestnetPriceFeeds

```solidity
bool internal useTestnetPriceFeeds
```

### lastTroveIndex

```solidity
uint256 internal lastTroveIndex
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

### DeployGovernanceParams (inherited from DeployGovernance)

```solidity
struct DeployGovernanceParams {
    uint256 epochStart;
    address deployer;
    bytes32 salt;
    address stakingV1;
    address lqty;
    address lusd;
    address bold;
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
    MetadataNFT metadataNFT;
    IPriceFeed priceFeed;
    GasPool gasPool;
    IInterestRouter interestRouter;
    IERC20Metadata collToken;
    WETHZapper wethZapper;
    GasCompZapper gasCompZapper;
    ILeverageZapper leverageZapper;
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

### Zappers

```solidity
struct Zappers {
    WETHZapper wethZapper;
    GasCompZapper gasCompZapper;
}
```

### TroveManagerParams

```solidity
struct TroveManagerParams {
    uint256 CCR;
    uint256 MCR;
    uint256 SCR;
    uint256 BCR;
    uint256 LIQUIDATION_PENALTY_SP;
    uint256 LIQUIDATION_PENALTY_REDISTRIBUTION;
}
```

### DeploymentVars

```solidity
struct DeploymentVars {
    uint256 numCollaterals;
    IERC20Metadata[] collaterals;
    IAddressesRegistry[] addressesRegistries;
    ITroveManager[] troveManagers;
    LiquityContracts contracts;
    bytes bytecode;
    address boldTokenAddress;
    uint256 i;
}
```

### DemoTroveParams

```solidity
struct DemoTroveParams {
    uint256 collIndex;
    uint256 owner;
    uint256 ownerIndex;
    uint256 coll;
    uint256 debt;
    uint256 annualInterestRate;
}
```

### DeploymentResult

```solidity
struct DeploymentResult {
    LiquityContracts[] contractsArray;
    ICollateralRegistry collateralRegistry;
    IBoldToken boldToken;
    ICurveStableswapNGPool usdcCurvePool;
    HintHelpers hintHelpers;
    MultiTroveGetter multiTroveGetter;
    IDebtInFrontHelper debtInFrontHelper;
    IExchangeHelpers exchangeHelpers;
    IExchangeHelpersV2 exchangeHelpersV2;
}
```

### ProvideUniV3LiquidityVars

```solidity
struct ProvideUniV3LiquidityVars {
    uint256 token2Amount;
    address[2] tokens;
    uint256[2] amounts;
    uint256 price;
    int24 tickLower;
    int24 tickUpper;
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

### run()

- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 9550:13228:112
- **Details**: [function_run.md](./function_run.md)

**Signature:**
```solidity
function run() external;
```

### getBytecode(bytes,address)

- **Signature**: `getBytecode(bytes,address)`
- **Visibility**: public
- **Source Range**: 25391:199:112
- **Details**: [function_getBytecode_bytes_address.md](./function_getBytecode_bytes_address.md)

**Signature:**
```solidity
function getBytecode(bytes memory _creationCode, address _addressesRegistry) public pure returns (bytes memory);
```

### _priceToSqrtPrice(uint256)

- **Signature**: `_priceToSqrtPrice(uint256)`
- **Visibility**: public
- **Source Range**: 47082:152:112
- **Details**: [function__priceToSqrtPrice_uint256.md](./function__priceToSqrtPrice_uint256.md)

**Signature:**
```solidity
function _priceToSqrtPrice(uint256 _price) public pure returns (uint160);
```

### priceToSqrtPriceX96(uint256) (inherited from UniPriceConverter)

- **Signature**: `priceToSqrtPriceX96(uint256)`
- **Visibility**: public
- **Source Range**: 230:378:222
- **Details**: [function_priceToSqrtPriceX96_uint256.md](./function_priceToSqrtPriceX96_uint256.md)

**Signature:**
```solidity
function priceToSqrtPriceX96(uint256 _price) public pure returns (uint160 sqrtPriceX96);
```

### sqrtPriceX96ToPrice(uint160) (inherited from UniPriceConverter)

- **Signature**: `sqrtPriceX96ToPrice(uint160)`
- **Visibility**: public
- **Source Range**: 614:539:222
- **Details**: [function_sqrtPriceX96ToPrice_uint160.md](./function_sqrtPriceX96ToPrice_uint160.md)

**Signature:**
```solidity
function sqrtPriceX96ToPrice(uint160 _sqrtPriceX96) public pure returns (uint256 price);
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
