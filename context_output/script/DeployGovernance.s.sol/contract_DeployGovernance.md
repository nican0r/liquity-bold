# Contract: DeployGovernance

## Metadata

- **Name**: DeployGovernance
- **Type**: Contract
- **Path**: script/DeployGovernance.s.sol

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

### LUSD

```solidity
address internal constant LUSD = 0x5f98805A4E8be255a32880FDeC7F6728C6568bA0
```

### CRV

```solidity
address internal constant CRV = 0xD533a949740bb3306d119CC777fa900bA034cd52
```

### FUNDS_SAFE

```solidity
address internal constant FUNDS_SAFE = 0xF06016D822943C42e3Cb7FC3a6A3B1889C1045f8
```

### DEFI_COLLECTIVE_GRANTS_ADDRESS

```solidity
address internal constant DEFI_COLLECTIVE_GRANTS_ADDRESS = 0xDc6f869d2D34E4aee3E89A51f2Af6D54F0F7f690
```

### REGISTRATION_FEE

```solidity
uint128 private constant REGISTRATION_FEE = 100e18
```

### REGISTRATION_THRESHOLD_FACTOR

```solidity
uint128 private constant REGISTRATION_THRESHOLD_FACTOR = 0.0001e18
```

### UNREGISTRATION_THRESHOLD_FACTOR

```solidity
uint128 private constant UNREGISTRATION_THRESHOLD_FACTOR = 1e18 + 1
```

### UNREGISTRATION_AFTER_EPOCHS

```solidity
uint16 private constant UNREGISTRATION_AFTER_EPOCHS = 4
```

### VOTING_THRESHOLD_FACTOR

```solidity
uint128 private constant VOTING_THRESHOLD_FACTOR = 0.02e18
```

### MIN_CLAIM

```solidity
uint88 private constant MIN_CLAIM = 0
```

### MIN_ACCRUAL

```solidity
uint88 private constant MIN_ACCRUAL = 0
```

### EPOCH_DURATION

```solidity
uint32 internal constant EPOCH_DURATION = 7 days
```

### EPOCH_VOTING_CUTOFF

```solidity
uint32 private constant EPOCH_VOTING_CUTOFF = 6 days
```

### DURATION

```solidity
uint256 private constant DURATION = 7 days
```

### governance

```solidity
Governance private governance
```

**Governance**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

### initialInitiatives

```solidity
address[] private initialInitiatives
```

### curveUsdcBoldPool

```solidity
ICurveStableSwapNG private curveUsdcBoldPool
```

**ICurveStableSwapNG**: [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]

### curveUsdcBoldGauge

```solidity
ILiquidityGaugeV6 private curveUsdcBoldGauge
```

**ILiquidityGaugeV6**: [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]

### curveUsdcBoldInitiative

```solidity
CurveV2GaugeRewards private curveUsdcBoldInitiative
```

**CurveV2GaugeRewards**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

### curveLusdBoldPool

```solidity
ICurveStableSwapNG private curveLusdBoldPool
```

**ICurveStableSwapNG**: [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]

### curveLusdBoldGauge

```solidity
ILiquidityGaugeV6 private curveLusdBoldGauge
```

**ILiquidityGaugeV6**: [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]

### curveLusdBoldInitiative

```solidity
CurveV2GaugeRewards private curveLusdBoldInitiative
```

**CurveV2GaugeRewards**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

### defiCollectiveInitiative

```solidity
address private defiCollectiveInitiative
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

### DeployGovernanceParams

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
