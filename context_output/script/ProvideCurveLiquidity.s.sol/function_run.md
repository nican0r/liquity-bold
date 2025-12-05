# Function: run()

**Contract**: [script/ProvideCurveLiquidity.s.sol/contract_ProvideCurveLiquidity.md]

## Metadata

- **Contract**: ProvideCurveLiquidity
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 225:610:121

## Implementation

```solidity
function run() external {
    vm.startBroadcast();
    _loadDeploymentFromManifest("deployment-manifest.json");
    uint256 boldAmount = 200_000 ether;
    uint256 usdcAmount = (boldAmount * (10 ** usdc.decimals())) / (10 ** boldToken.decimals());
    uint256[] memory amounts = new uint256[](2);
    (amounts[0], amounts[1]) = (curveUsdcBold.coins(0) == BOLD) ? (boldAmount, usdcAmount) : (usdcAmount, boldAmount);
    boldToken.approve(address(curveUsdcBold), boldAmount);
    usdc.approve(address(curveUsdcBold), usdcAmount);
    curveUsdcBold.add_liquidity(amounts, 0);
}
```

## Related Implementations

### _loadDeploymentFromManifest(string)

- **Kind**: internal
- **Source**: 3348:5791:296
- **Link**: `test/Utils/UseDeployment.sol:UseDeployment:_loadDeploymentFromManifest(string)`

```solidity
function _loadDeploymentFromManifest(string memory deploymentManifestJson) internal {
    string memory json = vm.readFile(deploymentManifestJson);
    collateralRegistry = ICollateralRegistry(json.readAddress(".collateralRegistry"));
    boldToken = IBoldToken(BOLD = json.readAddress(".boldToken"));
    hintHelpers = IHintHelpers(json.readAddress(".hintHelpers"));
    exchangeHelpers = IExchangeHelpers(json.readAddress(".exchangeHelpers"));
    governance = Governance(json.readAddress(".governance.governance"));
    curveUsdcBold = ICurveStableSwapNG(json.readAddress(".governance.curveUsdcBoldPool"));
    curveUsdcBoldGauge = ILiquidityGaugeV6(json.readAddress(".governance.curveUsdcBoldGauge"));
    curveUsdcBoldInitiative = CurveV2GaugeRewards(json.readAddress(".governance.curveUsdcBoldInitiative"));
    curveLusdBold = ICurveStableSwapNG(json.readAddress(".governance.curveLusdBoldPool"));
    curveLusdBoldGauge = ILiquidityGaugeV6(json.readAddress(".governance.curveLusdBoldGauge"));
    curveLusdBoldInitiative = CurveV2GaugeRewards(json.readAddress(".governance.curveLusdBoldInitiative"));
    defiCollectiveInitiative = json.readAddress(".governance.defiCollectiveInitiative");
    initialInitiatives = json.readAddressArray(".governance.initialInitiatives");
    vm.label(address(collateralRegistry), "CollateralRegistry");
    vm.label(address(hintHelpers), "HintHelpers");
    vm.label(address(exchangeHelpers), "ExchangeHelpers");
    vm.label(address(governance), "Governance");
    vm.label(address(curveUsdcBold), "CurveStableSwapNG");
    vm.label(address(curveUsdcBoldGauge), "LiquidityGaugeV6");
    vm.label(address(curveUsdcBoldInitiative), "CurveV2GaugeRewards");
    vm.label(address(curveLusdBold), "CurveStableSwapNG");
    vm.label(address(curveLusdBoldGauge), "LiquidityGaugeV6");
    vm.label(address(curveLusdBoldInitiative), "CurveV2GaugeRewards");
    ETH_GAS_COMPENSATION = json.readUint(".constants.ETH_GAS_COMPENSATION");
    MIN_DEBT = json.readUint(".constants.MIN_DEBT");
    EPOCH_START = json.readUint(".governance.constants.EPOCH_START");
    EPOCH_DURATION = json.readUint(".governance.constants.EPOCH_DURATION");
    REGISTRATION_FEE = json.readUint(".governance.constants.REGISTRATION_FEE");
    LQTY = json.readAddress(".governance.LQTYToken");
    USDC = (curveUsdcBold.coins(0) != BOLD) ? curveUsdcBold.coins(0) : curveUsdcBold.coins(1);
    LUSD = address(IUserProxy(governance.userProxyImplementation()).lusd());
    for (uint256 i = 0; i < collateralRegistry.totalCollaterals(); ++i) {
        string memory branch = string.concat(".branches[", i.toString(), "]");
        branches.push() = BranchContracts({collToken: IERC20(json.readAddress(string.concat(branch, ".collToken"))), addressesRegistry: IAddressesRegistry(json.readAddress(string.concat(branch, ".addressesRegistry"))), priceFeed: IPriceFeed(json.readAddress(string.concat(branch, ".priceFeed"))), troveNFT: ITroveNFT(json.readAddress(string.concat(branch, ".troveNFT"))), troveManager: ITroveManager(json.readAddress(string.concat(branch, ".troveManager"))), borrowerOperations: IBorrowerOperations(json.readAddress(string.concat(branch, ".borrowerOperations"))), sortedTroves: ISortedTroves(json.readAddress(string.concat(branch, ".sortedTroves"))), activePool: IActivePool(json.readAddress(string.concat(branch, ".activePool"))), defaultPool: IDefaultPool(json.readAddress(string.concat(branch, ".defaultPool"))), stabilityPool: IStabilityPool(json.readAddress(string.concat(branch, ".stabilityPool"))), leverageZapper: ILeverageZapper(json.readAddress(string.concat(branch, ".leverageZapper"))), zapper: IZapper(coalesce(json.readAddress(string.concat(branch, ".wethZapper")), json.readAddress(string.concat(branch, ".gasCompZapper"))))});
        vm.label(address(branches[i].priceFeed), "PriceFeed");
        vm.label(address(branches[i].troveNFT), "TroveNFT");
        vm.label(address(branches[i].troveManager), "TroveManager");
        vm.label(address(branches[i].borrowerOperations), "BorrowerOperations");
        vm.label(address(branches[i].sortedTroves), "SortedTroves");
        vm.label(address(branches[i].activePool), "ActivePool");
        vm.label(address(branches[i].defaultPool), "DefaultPool");
        vm.label(address(branches[i].stabilityPool), "StabilityPool");
        vm.label(address(branches[i].leverageZapper), "LeverageZapper");
        vm.label(address(branches[i].zapper), "Zapper");
        string memory collSymbol = branches[i].collToken.symbol();
        if (collSymbol.eq("WETH")) {
            WETH = address(branches[i].collToken);
        } else if (collSymbol.eq("wstETH")) {
            WSTETH = address(branches[i].collToken);
        } else if (collSymbol.eq("rETH")) {
            RETH = address(branches[i].collToken);
        } else {
            revert(string.concat("Unexpected collateral ", collSymbol));
        }
    }
    vm.label(WETH, "WETH");
    vm.label(WSTETH, "wstETH");
    vm.label(RETH, "rETH");
    vm.label(BOLD, "BOLD");
    vm.label(USDC, "USDC");
    vm.label(LQTY, "LQTY");
    vm.label(LUSD, "LUSD");
    weth = IWETH(WETH);
    usdc = IERC20(USDC);
    lqty = IERC20(LQTY);
    lusd = IERC20(LUSD);
}
```

### readAddress(string,string)

- **Kind**: internal
- **Source**: 2285:146:53
- **Link**: `lib/forge-std/src/StdJson.sol:stdJson:readAddress(string,string)`

```solidity
function readAddress(string memory json, string memory key) internal pure returns (address) {
    return vm.parseJsonAddress(json, key);
}
```

### readAddressArray(string,string)

- **Kind**: internal
- **Source**: 2437:165:53
- **Link**: `lib/forge-std/src/StdJson.sol:stdJson:readAddressArray(string,string)`

```solidity
function readAddressArray(string memory json, string memory key) internal pure returns (address[] memory) {
    return vm.parseJsonAddressArray(json, key);
}
```

### readUint(string,string)

- **Kind**: internal
- **Source**: 1022:140:53
- **Link**: `lib/forge-std/src/StdJson.sol:stdJson:readUint(string,string)`

```solidity
function readUint(string memory json, string memory key) internal pure returns (uint256) {
    return vm.parseJsonUint(json, key);
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 447:696:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        /// @solidity memory-safe-assembly
        assembly {
            ptr := add(buffer, add(32, length))
        }
        while (true) {
            ptr--;
            /// @solidity memory-safe-assembly
            assembly {
                mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 10139:916:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10, rounded down, of a positive value.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

### coalesce(address,address)

- **Kind**: free-function
- **Source**: 1783:102:296
- **Link**: `test/Utils/UseDeployment.sol:coalesce(address,address)`

```solidity
function coalesce(address a, address b) pure returns (address) {
    return (a != address(0)) ? a : b;
}
```

### eq(string,string)

- **Kind**: internal
- **Source**: 86:141:291
- **Link**: `test/Utils/StringEquality.sol:StringEquality:eq(string,string)`

```solidity
function eq(string memory a, string memory b) internal pure returns (bool) {
    return keccak256(bytes(a)) == keccak256(bytes(b));
}
```

## External Calls

- **Vm::startBroadcast()**
- **IERC20Metadata::decimals()**
- **IBoldToken::decimals()**
- **ICurveStableSwapNG::coins(uint256)**
- **IBoldToken::approve(address,uint256)**
- **IERC20Metadata::approve(address,uint256)**
- **ICurveStableSwapNG::add_liquidity(uint256[],uint256)**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **hintHelpers** (`contract IHintHelpers`) [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]
- **exchangeHelpers** (`contract IExchangeHelpers`) [src/Zappers/Interfaces/IExchangeHelpers.sol/interface_IExchangeHelpers.md]
- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]
- **curveUsdcBold** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveUsdcBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **curveUsdcBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **curveLusdBold** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveLusdBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **curveLusdBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **BOLD** (`address`)
- **branches** (`struct UseDeployment.BranchContracts[]`)
- **WETH** (`address`)
- **WSTETH** (`address`)
- **RETH** (`address`)
- **USDC** (`address`)
- **LQTY** (`address`)
- **LUSD** (`address`)
- **vm** (`contract VmSafe`) [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

## State Variable Writes

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **BOLD** (`address`)
- **hintHelpers** (`contract IHintHelpers`) [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]
- **exchangeHelpers** (`contract IExchangeHelpers`) [src/Zappers/Interfaces/IExchangeHelpers.sol/interface_IExchangeHelpers.md]
- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]
- **curveUsdcBold** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveUsdcBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **curveUsdcBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **curveLusdBold** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveLusdBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **curveLusdBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **defiCollectiveInitiative** (`address`)
- **initialInitiatives** (`address[]`)
- **ETH_GAS_COMPENSATION** (`uint256`)
- **MIN_DEBT** (`uint256`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **REGISTRATION_FEE** (`uint256`)
- **LQTY** (`address`)
- **USDC** (`address`)
- **LUSD** (`address`)
- **branches** (`struct UseDeployment.BranchContracts[]`)
- **WETH** (`address`)
- **WSTETH** (`address`)
- **RETH** (`address`)
- **weth** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **usdc** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **lqty** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **lusd** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ProvideCurveLiquidity.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: UseDeployment._loadDeploymentFromManifest(string) (NodeID: 1)
      💬 Args: ["deployment-manifest.json"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 2)
    │   💬 Args: [json, ".collateralRegistry"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 3)
    │   💬 Args: [json, ".boldToken"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 4)
    │   💬 Args: [json, ".hintHelpers"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 5)
    │   💬 Args: [json, ".exchangeHelpers"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 6)
    │   💬 Args: [json, ".governance.governance"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 7)
    │   💬 Args: [json, ".governance.curveUsdcBoldPool"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 8)
    │   💬 Args: [json, ".governance.curveUsdcBoldGauge"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 9)
    │   💬 Args: [json, ".governance.curveUsdcBoldInitiative"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 10)
    │   💬 Args: [json, ".governance.curveLusdBoldPool"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 11)
    │   💬 Args: [json, ".governance.curveLusdBoldGauge"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 12)
    │   💬 Args: [json, ".governance.curveLusdBoldInitiative"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 13)
    │   💬 Args: [json, ".governance.defiCollectiveInitiative"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddressArray(string,string) (NodeID: 14)
    │   💬 Args: [json, ".governance.initialInitiatives"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readUint(string,string) (NodeID: 15)
    │   💬 Args: [json, ".constants.ETH_GAS_COMPENSATION"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readUint(string,string) (NodeID: 16)
    │   💬 Args: [json, ".constants.MIN_DEBT"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readUint(string,string) (NodeID: 17)
    │   💬 Args: [json, ".governance.constants.EPOCH_START"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readUint(string,string) (NodeID: 18)
    │   💬 Args: [json, ".governance.constants.EPOCH_DURATION"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readUint(string,string) (NodeID: 19)
    │   💬 Args: [json, ".governance.constants.REGISTRATION_FEE"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 20)
    │   💬 Args: [json, ".governance.LQTYToken"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 21)
    │   💬 Args: [i]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 22)
    │     💬 Args: [value]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 23)
    │   💬 Args: [json, string.concat(branch, ".collToken")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 24)
    │   💬 Args: [json, string.concat(branch, ".addressesRegistry")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 25)
    │   💬 Args: [json, string.concat(branch, ".priceFeed")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 26)
    │   💬 Args: [json, string.concat(branch, ".troveNFT")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 27)
    │   💬 Args: [json, string.concat(branch, ".troveManager")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 28)
    │   💬 Args: [json, string.concat(branch, ".borrowerOperations")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 29)
    │   💬 Args: [json, string.concat(branch, ".sortedTroves")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 30)
    │   💬 Args: [json, string.concat(branch, ".activePool")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 31)
    │   💬 Args: [json, string.concat(branch, ".defaultPool")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 32)
    │   💬 Args: [json, string.concat(branch, ".stabilityPool")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 33)
    │   💬 Args: [json, string.concat(branch, ".leverageZapper")]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.coalesce(address,address) (NodeID: 34)
    │   💬 Args: [json.readAddress(string.concat(branch, ".wethZapper")), json.readAddress(string.concat(branch, ".gasCompZapper"))]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 35)
    │ │   💬 Args: [json, string.concat(branch, ".wethZapper")]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: stdJson.readAddress(string,string) (NodeID: 36)
    │     💬 Args: [json, string.concat(branch, ".gasCompZapper")]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 37)
    │   💬 Args: [collSymbol, "WETH"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 38)
    │   💬 Args: [collSymbol, "wstETH"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 39)
        💬 Args: [collSymbol, "rETH"]
        👁️  Def: internal
```
