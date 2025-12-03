# Contract: InvariantsTestHandler

## Metadata

- **Name**: InvariantsTestHandler
- **Type**: Contract
- **Path**: test/TestContracts/InvariantsTestHandler.t.sol

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

### weth (inherited from BaseMultiCollateralTest)

```solidity
IERC20 internal weth
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### collateralRegistry (inherited from BaseMultiCollateralTest)

```solidity
ICollateralRegistry internal collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### boldToken (inherited from BaseMultiCollateralTest)

```solidity
IBoldToken internal boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### hintHelpers (inherited from BaseMultiCollateralTest)

```solidity
HintHelpers internal hintHelpers
```

**HintHelpers**: [src/HintHelpers.sol/contract_HintHelpers.md]

### branches (inherited from BaseMultiCollateralTest)

```solidity
TestDeployer.LiquityContractsDev[] internal branches
```

### NON_EXISTENT

```solidity
ITroveManager.Status internal constant NON_EXISTENT = ITroveManager.Status.nonExistent
```

### ACTIVE

```solidity
ITroveManager.Status internal constant ACTIVE = ITroveManager.Status.active
```

### CLOSED_BY_OWNER

```solidity
ITroveManager.Status internal constant CLOSED_BY_OWNER = ITroveManager.Status.closedByOwner
```

### CLOSED_BY_LIQ

```solidity
ITroveManager.Status internal constant CLOSED_BY_LIQ = ITroveManager.Status.closedByLiquidation
```

### ZOMBIE

```solidity
ITroveManager.Status internal constant ZOMBIE = ITroveManager.Status.zombie
```

### _functionCaller

```solidity
FunctionCaller internal immutable _functionCaller
```

**FunctionCaller**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_FunctionCaller.md]

### _assumeNoExpectedFailures

```solidity
bool internal immutable _assumeNoExpectedFailures
```

### CCR

```solidity
mapping(uint256 => uint256) internal CCR
```

### BCR

```solidity
mapping(uint256 => uint256) internal BCR
```

### MCR

```solidity
mapping(uint256 => uint256) internal MCR
```

### SCR

```solidity
mapping(uint256 => uint256) internal SCR
```

### LIQ_PENALTY_SP

```solidity
mapping(uint256 => uint256) internal LIQ_PENALTY_SP
```

### LIQ_PENALTY_REDIST

```solidity
mapping(uint256 => uint256) internal LIQ_PENALTY_REDIST
```

### designatedVictimId

```solidity
mapping(uint256 => uint256) public designatedVictimId
```

### collSurplus

```solidity
mapping(uint256 => uint256) public collSurplus
```

### spBoldDeposits

```solidity
mapping(uint256 => uint256) public spBoldDeposits
```

### spBoldYield

```solidity
mapping(uint256 => uint256) public spBoldYield
```

### spColl

```solidity
mapping(uint256 => uint256) public spColl
```

### totalCollRedist

```solidity
mapping(uint256 => uint256) public totalCollRedist
```

### totalDebtRedist

```solidity
mapping(uint256 => uint256) public totalDebtRedist
```

### isShutdown

```solidity
mapping(uint256 => bool) public isShutdown
```

### _price

```solidity
mapping(uint256 => uint256) internal _price
```

### _handlerBold

```solidity
uint256 internal _handlerBold
```

### _baseRate

```solidity
uint256 internal _baseRate = INITIAL_BASE_RATE
```

### _timeSinceLastRedemption

```solidity
uint256 internal _timeSinceLastRedemption = 0
```

### _pendingInterest

```solidity
mapping(uint256 => uint256) internal _pendingInterest
```

### _troveIndexOf

```solidity
mapping(uint256 => mapping(address => uint256)) internal _troveIndexOf
```

### _troveIds

```solidity
mapping(uint256 => EnumerableSet) internal _troveIds
```

### _zombieTroveIds

```solidity
mapping(uint256 => EnumerableSet) internal _zombieTroveIds
```

### _troves

```solidity
mapping(uint256 => mapping(uint256 => Trove)) internal _troves
```

### _timeSinceLastTroveInterestRateAdjustment

```solidity
mapping(uint256 => mapping(uint256 => uint256)) internal _timeSinceLastTroveInterestRateAdjustment
```

### _batchManagers

```solidity
mapping(uint256 => EnumerableAddressSet) internal _batchManagers
```

### _batches

```solidity
mapping(uint256 => mapping(address => Batch)) internal _batches
```

### _timeSinceLastBatchInterestRateAdjustment

```solidity
mapping(uint256 => mapping(address => uint256)) internal _timeSinceLastBatchInterestRateAdjustment
```

### _batchManagerOf

```solidity
mapping(uint256 => mapping(uint256 => address)) internal _batchManagerOf
```

### _liquidation

```solidity
LiquidationTransientState internal _liquidation
```

### _redemption

```solidity
mapping(uint256 => RedemptionTransientState) internal _redemption
```

### _urgentRedemption

```solidity
UrgentRedemptionTransientState internal _urgentRedemption
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

### Contracts (inherited from BaseMultiCollateralTest)

```solidity
struct Contracts {
    IWETH weth;
    ICollateralRegistry collateralRegistry;
    IBoldToken boldToken;
    HintHelpers hintHelpers;
    TestDeployer.LiquityContractsDev[] branches;
}
```

### OpenTroveContext

```solidity
struct OpenTroveContext {
    uint256 i;
    uint256 borrowed;
    uint256 icr;
    bool join;
    uint256 interestRate;
    uint32 batchManagerSeed;
    uint32 upperHintSeed;
    uint32 lowerHintSeed;
    address batchManager;
    uint256 upperHint;
    uint256 lowerHint;
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 batchManagementFee;
    uint256 upfrontFee;
    uint256 debt;
    uint256 coll;
    uint256 troveId;
    bool wasOpen;
    string errorString;
}
```

### AdjustTroveContext

```solidity
struct AdjustTroveContext {
    uint256 i;
    AdjustedTroveProperties prop;
    uint256 upperHint;
    uint256 lowerHint;
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 oldTCR;
    uint256 troveId;
    LatestTroveData t;
    address batchManager;
    uint256 batchManagementFee;
    Trove trove;
    bool wasActive;
    bool wasZombie;
    bool useZombie;
    uint256 maxDebtDec;
    int256 collDelta;
    int256 debtDelta;
    int256 $collDelta36;
    uint256 upfrontFee;
    string functionName;
    uint256 newICR;
    uint256 newTCR;
    uint256 newDebt;
    string errorString;
}
```

### AdjustTroveInterestRateContext

```solidity
struct AdjustTroveInterestRateContext {
    uint256 upperHint;
    uint256 lowerHint;
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 troveId;
    address batchManager;
    LatestTroveData t;
    Trove trove;
    bool wasActive;
    bool premature;
    uint256 upfrontFee;
    string errorString;
}
```

### CloseTroveContext

```solidity
struct CloseTroveContext {
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 troveId;
    LatestTroveData t;
    address batchManager;
    uint256 batchManagementFee;
    bool wasOpen;
    uint256 dealt;
    string errorString;
}
```

### ApplyMyPendingDebtContext

```solidity
struct ApplyMyPendingDebtContext {
    uint256 upperHint;
    uint256 lowerHint;
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 troveId;
    address batchManager;
    uint256 batchManagementFee;
    LatestTroveData t;
    Trove trove;
    bool wasOpen;
    string errorString;
}
```

### ProvideToSPContext

```solidity
struct ProvideToSPContext {
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 totalBoldDeposits;
    uint256 blockedSPYield;
    uint256 initialBoldDeposit;
    uint256 boldDeposit;
    uint256 boldYield;
    uint256 ethGain;
    uint256 ethStash;
    uint256 ethClaimed;
    uint256 boldClaimed;
    string errorString;
}
```

### WithdrawFromSPContext

```solidity
struct WithdrawFromSPContext {
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 totalBoldDeposits;
    uint256 blockedSPYield;
    uint256 initialBoldDeposit;
    uint256 boldDeposit;
    uint256 boldYield;
    uint256 ethGain;
    uint256 ethStash;
    uint256 ethClaimed;
    uint256 boldClaimed;
    uint256 withdrawn;
    string errorString;
}
```

### SetInterestBatchManagerContext

```solidity
struct SetInterestBatchManagerContext {
    address newBatchManager;
    uint256 upperHint;
    uint256 lowerHint;
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 troveId;
    LatestTroveData t;
    uint256 batchManagementFee;
    Trove trove;
    bool wasOpen;
    bool wasActive;
    uint256 upfrontFee;
    string errorString;
}
```

### RemoveFromBatchContext

```solidity
struct RemoveFromBatchContext {
    uint256 upperHint;
    uint256 lowerHint;
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    uint256 troveId;
    LatestTroveData t;
    address batchManager;
    uint256 batchManagementFee;
    bool wasActive;
    bool premature;
    uint256 upfrontFee;
    string errorString;
}
```

### SetBatchManagerAnnualInterestRateContext

```solidity
struct SetBatchManagerAnnualInterestRateContext {
    uint256 upperHint;
    uint256 lowerHint;
    TestDeployer.LiquityContractsDev c;
    uint256 pendingInterest;
    LatestBatchData b;
    bool premature;
    uint256 upfrontFee;
    string errorString;
}
```

### LiquidationTotals

```solidity
struct LiquidationTotals {
    uint256 collGasComp;
    uint256 spCollGain;
    uint256 spOffset;
    uint256 collRedist;
    uint256 debtRedist;
    uint256 collSurplus;
}
```

### LiquidationTransientState

```solidity
struct LiquidationTransientState {
    address[] batch;
    EnumerableSet remaining;
    EnumerableAddressSet liquidated;
    EnumerableAddressSet batchManagers;
    LiquidationTotals t;
}
```

### Redeemed

```solidity
struct Redeemed {
    uint256 troveId;
    uint256 coll;
    uint256 debt;
    bool becomesZombie;
}
```

### RedemptionTransientState

```solidity
struct RedemptionTransientState {
    uint256 attemptedAmount;
    uint256 totalCollRedeemed;
    Redeemed[] redeemed;
    EnumerableAddressSet batchManagers;
    uint256 newDesignatedVictimId;
}
```

### UrgentRedemptionTransientState

```solidity
struct UrgentRedemptionTransientState {
    address[] batch;
    EnumerableSet redeemedIds;
    uint256 totalDebtRedeemed;
    uint256 totalCollRedeemed;
    Redeemed[] redeemed;
    EnumerableAddressSet batchManagers;
}
```

### Batch

```solidity
struct Batch {
    uint256 interestRateMin;
    uint256 interestRateMax;
    uint256 interestRate;
    uint256 managementRate;
    uint256 pendingManagementFee;
    uint256 period;
    EnumerableSet troves;
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

### constructor(struct BaseMultiCollateralTest.Contracts,bool)

- **Signature**: `constructor(struct BaseMultiCollateralTest.Contracts,bool)`
- **Visibility**: public
- **Source Range**: 13070:765:270
- **Details**: [function_constructor_struct_BaseMultiCollateralTest.Contracts_bool.md](./function_constructor_struct_BaseMultiCollateralTest.Contracts_bool.md)

**Signature:**
```solidity
constructor(Contracts memory contracts, bool assumeNoExpectedFailures);
```

### numTroves(uint256)

- **Signature**: `numTroves(uint256)`
- **Visibility**: public
- **Source Range**: 13995:103:270
- **Details**: [function_numTroves_uint256.md](./function_numTroves_uint256.md)

**Signature:**
```solidity
function numTroves(uint256 i) public view returns (uint256);
```

### numZombies(uint256)

- **Signature**: `numZombies(uint256)`
- **Visibility**: external
- **Source Range**: 14104:112:270
- **Details**: [function_numZombies_uint256.md](./function_numZombies_uint256.md)

**Signature:**
```solidity
function numZombies(uint256 i) external view returns (uint256);
```

### troveIdOf(uint256,address)

- **Signature**: `troveIdOf(uint256,address)`
- **Visibility**: external
- **Source Range**: 14222:121:270
- **Details**: [function_troveIdOf_uint256_address.md](./function_troveIdOf_uint256_address.md)

**Signature:**
```solidity
function troveIdOf(uint256 i, address owner) external view returns (uint256);
```

### getTrove(uint256,uint256)

- **Signature**: `getTrove(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 14349:486:270
- **Details**: [function_getTrove_uint256_uint256.md](./function_getTrove_uint256_uint256.md)

**Signature:**
```solidity
function getTrove(uint256 i, uint256 j) external view returns (uint256 troveId, uint256 coll, uint256 debt, ITroveManager.Status status, address batchManager, uint256 totalCollRedist_, uint256 totalDebtRedist_);
```

### getTroveById(uint256,uint256)

- **Signature**: `getTroveById(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 14841:664:270
- **Details**: [function_getTroveById_uint256_uint256.md](./function_getTroveById_uint256_uint256.md)

**Signature:**
```solidity
function getTroveById(uint256 i, uint256 troveId) public view returns (uint256 coll, uint256 debt, ITroveManager.Status status, address batchManager, uint256 totalCollRedist_, uint256 totalDebtRedist_);
```

### getBatchSize(uint256,address)

- **Signature**: `getBatchSize(uint256,address)`
- **Visibility**: external
- **Source Range**: 15511:150:270
- **Details**: [function_getBatchSize_uint256_address.md](./function_getBatchSize_uint256_address.md)

**Signature:**
```solidity
function getBatchSize(uint256 i, address batchManager) external view returns (uint256);
```

### getTroveIdFromBatch(uint256,address,uint256)

- **Signature**: `getTroveIdFromBatch(uint256,address,uint256)`
- **Visibility**: external
- **Source Range**: 15667:168:270
- **Details**: [function_getTroveIdFromBatch_uint256_address_uint256.md](./function_getTroveIdFromBatch_uint256_address_uint256.md)

**Signature:**
```solidity
function getTroveIdFromBatch(uint256 i, address batchManager, uint256 j) external view returns (uint256);
```

### getRedemptionRate()

- **Signature**: `getRedemptionRate()`
- **Visibility**: external
- **Source Range**: 15841:119:270
- **Details**: [function_getRedemptionRate.md](./function_getRedemptionRate.md)

**Signature:**
```solidity
function getRedemptionRate() external view returns (uint256);
```

### getGasPool(uint256)

- **Signature**: `getGasPool(uint256)`
- **Visibility**: external
- **Source Range**: 15966:122:270
- **Details**: [function_getGasPool_uint256.md](./function_getGasPool_uint256.md)

**Signature:**
```solidity
function getGasPool(uint256 i) external view returns (uint256);
```

### getPendingInterest(uint256)

- **Signature**: `getPendingInterest(uint256)`
- **Visibility**: external
- **Source Range**: 16094:158:270
- **Details**: [function_getPendingInterest_uint256.md](./function_getPendingInterest_uint256.md)

**Signature:**
```solidity
function getPendingInterest(uint256 i) external view returns (uint256);
```

### getPendingBatchManagementFee(uint256,address)

- **Signature**: `getPendingBatchManagementFee(uint256,address)`
- **Visibility**: external
- **Source Range**: 16258:206:270
- **Details**: [function_getPendingBatchManagementFee_uint256_address.md](./function_getPendingBatchManagementFee_uint256_address.md)

**Signature:**
```solidity
function getPendingBatchManagementFee(uint256 i, address batchManager) external view returns (uint256);
```

### getInterestAccrual(uint256)

- **Signature**: `getInterestAccrual(uint256)`
- **Visibility**: external
- **Source Range**: 16470:295:270
- **Details**: [function_getInterestAccrual_uint256.md](./function_getInterestAccrual_uint256.md)

**Signature:**
```solidity
function getInterestAccrual(uint256 i) external view returns (uint256 interestAccrual);
```

### getBatchManagementFeeAccrual(uint256)

- **Signature**: `getBatchManagementFeeAccrual(uint256)`
- **Visibility**: external
- **Source Range**: 16771:332:270
- **Details**: [function_getBatchManagementFeeAccrual_uint256.md](./function_getBatchManagementFeeAccrual_uint256.md)

**Signature:**
```solidity
function getBatchManagementFeeAccrual(uint256 i) external view returns (uint256 batchManagementFeeAccrual);
```

### warp(uint256)

- **Signature**: `warp(uint256)`
- **Visibility**: external
- **Source Range**: 17248:1555:270
- **Details**: [function_warp_uint256.md](./function_warp_uint256.md)

**Signature:**
```solidity
function warp(uint256 timeDelta) external;
```

### setPrice(uint256,uint256)

- **Signature**: `setPrice(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 18809:613:270
- **Details**: [function_setPrice_uint256_uint256.md](./function_setPrice_uint256_uint256.md)

**Signature:**
```solidity
function setPrice(uint256 i, uint256 tcr) external;
```

### openTrove(uint256,uint256,uint256,uint256,uint32,uint32)

- **Signature**: `openTrove(uint256,uint256,uint256,uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 19428:445:270
- **Details**: [function_openTrove_uint256_uint256_uint256_uint256_uint32_uint32.md](./function_openTrove_uint256_uint256_uint256_uint256_uint32_uint32.md)

**Signature:**
```solidity
function openTrove(uint256 i, uint256 borrowed, uint256 icr, uint256 interestRate, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### openTroveAndJoinInterestBatchManager(uint256,uint256,uint256,uint32,uint32,uint32)

- **Signature**: `openTroveAndJoinInterestBatchManager(uint256,uint256,uint256,uint32,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 19879:506:270
- **Details**: [function_openTroveAndJoinInterestBatchManager_uint256_uint256_uint256_uint32_uint32_uint32.md](./function_openTroveAndJoinInterestBatchManager_uint256_uint256_uint256_uint32_uint32_uint32.md)

**Signature:**
```solidity
function openTroveAndJoinInterestBatchManager(uint256 i, uint256 borrowed, uint256 icr, uint32 batchManagerSeed, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### adjustTrove(uint256,uint8,uint256,bool,uint256,bool,uint32,uint32,uint32)

- **Signature**: `adjustTrove(uint256,uint8,uint256,bool,uint256,bool,uint32,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 28030:10321:270
- **Details**: [function_adjustTrove_uint256_uint8_uint256_bool_uint256_bool_uint32_uint32_uint32.md](./function_adjustTrove_uint256_uint8_uint256_bool_uint256_bool_uint32_uint32_uint32.md)

**Signature:**
```solidity
function adjustTrove(uint256 i, uint8 prop, uint256 collChange, bool isCollInc, uint256 debtChange, bool isDebtInc, uint32 useZombieSeed, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### adjustTroveInterestRate(uint256,uint256,uint32,uint32)

- **Signature**: `adjustTroveInterestRate(uint256,uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 38357:5885:270
- **Details**: [function_adjustTroveInterestRate_uint256_uint256_uint32_uint32.md](./function_adjustTroveInterestRate_uint256_uint256_uint32_uint32.md)

**Signature:**
```solidity
function adjustTroveInterestRate(uint256 i, uint256 newInterestRate, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### closeTrove(uint256)

- **Signature**: `closeTrove(uint256)`
- **Visibility**: external
- **Source Range**: 44248:3827:270
- **Details**: [function_closeTrove_uint256.md](./function_closeTrove_uint256.md)

**Signature:**
```solidity
function closeTrove(uint256 i) external;
```

### addMeToLiquidationBatch()

- **Signature**: `addMeToLiquidationBatch()`
- **Visibility**: external
- **Source Range**: 48081:139:270
- **Details**: [function_addMeToLiquidationBatch.md](./function_addMeToLiquidationBatch.md)

**Signature:**
```solidity
function addMeToLiquidationBatch() external;
```

### batchLiquidateTroves(uint256)

- **Signature**: `batchLiquidateTroves(uint256)`
- **Visibility**: external
- **Source Range**: 48226:5821:270
- **Details**: [function_batchLiquidateTroves_uint256.md](./function_batchLiquidateTroves_uint256.md)

**Signature:**
```solidity
function batchLiquidateTroves(uint256 i) external;
```

### redeemCollateral(uint256,uint256)

- **Signature**: `redeemCollateral(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 54053:6106:270
- **Details**: [function_redeemCollateral_uint256_uint256.md](./function_redeemCollateral_uint256_uint256.md)

**Signature:**
```solidity
function redeemCollateral(uint256 amount, uint256 maxIterationsPerCollateral) external;
```

### shutdown(uint256)

- **Signature**: `shutdown(uint256)`
- **Visibility**: external
- **Source Range**: 60165:1548:270
- **Details**: [function_shutdown_uint256.md](./function_shutdown_uint256.md)

**Signature:**
```solidity
function shutdown(uint256 i) external;
```

### addMeToUrgentRedemptionBatch()

- **Signature**: `addMeToUrgentRedemptionBatch()`
- **Visibility**: external
- **Source Range**: 61719:154:270
- **Details**: [function_addMeToUrgentRedemptionBatch.md](./function_addMeToUrgentRedemptionBatch.md)

**Signature:**
```solidity
function addMeToUrgentRedemptionBatch() external;
```

### urgentRedemption(uint256,uint256)

- **Signature**: `urgentRedemption(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 61879:4964:270
- **Details**: [function_urgentRedemption_uint256_uint256.md](./function_urgentRedemption_uint256_uint256.md)

**Signature:**
```solidity
function urgentRedemption(uint256 i, uint256 amount) external;
```

### applyMyPendingDebt(uint256,uint32,uint32)

- **Signature**: `applyMyPendingDebt(uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 66849:3012:270
- **Details**: [function_applyMyPendingDebt_uint256_uint32_uint32.md](./function_applyMyPendingDebt_uint256_uint32_uint32.md)

**Signature:**
```solidity
function applyMyPendingDebt(uint256 i, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### provideToSP(uint256,uint256,bool)

- **Signature**: `provideToSP(uint256,uint256,bool)`
- **Visibility**: external
- **Source Range**: 69867:3987:270
- **Details**: [function_provideToSP_uint256_uint256_bool.md](./function_provideToSP_uint256_uint256_bool.md)

**Signature:**
```solidity
function provideToSP(uint256 i, uint256 amount, bool claim) external;
```

### withdrawFromSP(uint256,uint256,bool)

- **Signature**: `withdrawFromSP(uint256,uint256,bool)`
- **Visibility**: external
- **Source Range**: 73860:4250:270
- **Details**: [function_withdrawFromSP_uint256_uint256_bool.md](./function_withdrawFromSP_uint256_uint256_bool.md)

**Signature:**
```solidity
function withdrawFromSP(uint256 i, uint256 amount, bool claim) external;
```

### claimAllCollGains(uint256)

- **Signature**: `claimAllCollGains(uint256)`
- **Visibility**: external
- **Source Range**: 78116:2194:270
- **Details**: [function_claimAllCollGains_uint256.md](./function_claimAllCollGains_uint256.md)

**Signature:**
```solidity
function claimAllCollGains(uint256 i) external;
```

### registerBatchManager(uint256,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `registerBatchManager(uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 80398:5587:270
- **Details**: [function_registerBatchManager_uint256_uint256_uint256_uint256_uint256_uint256.md](./function_registerBatchManager_uint256_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function registerBatchManager(uint256 i, uint256 minInterestRate, uint256 maxInterestRate, uint256 currentInterestRate, uint256 annualManagementFee, uint256 minInterestRateChangePeriod) external;
```

### lowerBatchManagementFee(uint256,uint256)

- **Signature**: `lowerBatchManagementFee(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 85991:2775:270
- **Details**: [function_lowerBatchManagementFee_uint256_uint256.md](./function_lowerBatchManagementFee_uint256_uint256.md)

**Signature:**
```solidity
function lowerBatchManagementFee(uint256 i, uint256 newManagementFee) external;
```

### setInterestBatchManager(uint256,uint32,uint32,uint32)

- **Signature**: `setInterestBatchManager(uint256,uint32,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 88772:5470:270
- **Details**: [function_setInterestBatchManager_uint256_uint32_uint32_uint32.md](./function_setInterestBatchManager_uint256_uint32_uint32_uint32.md)

**Signature:**
```solidity
function setInterestBatchManager(uint256 i, uint32 newBatchManagerSeed, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### removeFromBatch(uint256,uint256,uint32,uint32)

- **Signature**: `removeFromBatch(uint256,uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 94248:5785:270
- **Details**: [function_removeFromBatch_uint256_uint256_uint32_uint32.md](./function_removeFromBatch_uint256_uint256_uint32_uint32.md)

**Signature:**
```solidity
function removeFromBatch(uint256 i, uint256 newInterestRate, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### setBatchManagerAnnualInterestRate(uint256,uint256,uint32,uint32)

- **Signature**: `setBatchManagerAnnualInterestRate(uint256,uint256,uint32,uint32)`
- **Visibility**: external
- **Source Range**: 100039:5981:270
- **Details**: [function_setBatchManagerAnnualInterestRate_uint256_uint256_uint32_uint32.md](./function_setBatchManagerAnnualInterestRate_uint256_uint256_uint32_uint32.md)

**Signature:**
```solidity
function setBatchManagerAnnualInterestRate(uint256 i, uint256 newAnnualInterestRate, uint32 upperHintSeed, uint32 lowerHintSeed) external;
```

### _decodeCustomError(bytes)

- **Signature**: `_decodeCustomError(bytes)`
- **Visibility**: public
- **Source Range**: 128655:7970:270
- **Details**: [function__decodeCustomError_bytes.md](./function__decodeCustomError_bytes.md)

**Signature:**
```solidity
function _decodeCustomError(bytes memory revertData) public pure returns (bytes4 selector, string memory errorString);
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
