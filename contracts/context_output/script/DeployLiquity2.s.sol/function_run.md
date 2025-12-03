# Function: run()

**Contract**: [script/DeployLiquity2.s.sol/contract_DeployLiquity2Script.md]

## Metadata

- **Contract**: DeployLiquity2Script
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 9550:13228:112

## Implementation

```solidity
function run() external {
    string memory saltStr = vm.envOr("SALT", block.timestamp.toString());
    SALT = keccak256(bytes(saltStr));
    if (vm.envBytes("DEPLOYER").length == 20) {
        deployer = vm.envAddress("DEPLOYER");
        vm.startBroadcast(deployer);
    } else {
        uint256 privateKey = vm.envUint("DEPLOYER");
        deployer = vm.addr(privateKey);
        vm.startBroadcast(privateKey);
    }
    string memory deploymentMode = vm.envOr("DEPLOYMENT_MODE", DEPLOYMENT_MODE_COMPLETE);
    require((deploymentMode.eq(DEPLOYMENT_MODE_COMPLETE) || deploymentMode.eq(DEPLOYMENT_MODE_BOLD_ONLY)) || deploymentMode.eq(DEPLOYMENT_MODE_USE_EXISTING_BOLD), string.concat("Bad deployment mode: ", deploymentMode));
    uint256 epochStart = vm.envOr("EPOCH_START", ((block.chainid == 1) ? _latestUTCMidnightBetweenWednesdayAndThursday() : block.timestamp) - EPOCH_DURATION);
    useTestnetPriceFeeds = vm.envOr("USE_TESTNET_PRICEFEEDS", false);
    _log("Deployer:               ", deployer.toHexString());
    _log("Deployer balance:       ", deployer.balance.decimal());
    _log("Deployment mode:        ", deploymentMode);
    _log("CREATE2 salt:           ", "keccak256(bytes(\"", saltStr, "\")) = ", uint256(SALT).toHexString());
    _log("Governance epoch start: ", epochStart.toString());
    _log("Use testnet PriceFeeds: ", useTestnetPriceFeeds ? "yes" : "no");
    bytes memory boldBytecode = bytes.concat(type(BoldToken).creationCode, abi.encode(deployer));
    address boldAddress = vm.computeCreate2Address(SALT, keccak256(boldBytecode));
    BoldToken boldToken;
    if (deploymentMode.eq(DEPLOYMENT_MODE_USE_EXISTING_BOLD)) {
        require(boldAddress.code.length > 0, string.concat("BOLD not found at ", boldAddress.toHexString()));
        boldToken = BoldToken(boldAddress);
        require(boldToken.totalSupply() == 0, "Some BOLD has been minted!");
        require(boldToken.collateralRegistryAddress() == address(0), "Collateral registry already set");
        require(boldToken.owner() == deployer, "Not BOLD owner");
    } else {
        boldToken = new BoldToken{salt: SALT}(deployer);
        assert(address(boldToken) == boldAddress);
    }
    if (deploymentMode.eq(DEPLOYMENT_MODE_BOLD_ONLY)) {
        vm.writeFile("deployment-manifest.json", string.concat("{\"boldToken\":\"", boldAddress.toHexString(), "\"}"));
        return;
    }
    if (block.chainid == 1) {
        WETH = IWETH(WETH_ADDRESS);
        USDC = IERC20Metadata(USDC_ADDRESS);
        curveStableswapFactory = curveStableswapFactoryMainnet;
        uniV3Router = uniV3RouterMainnet;
        uniV3Quoter = uniV3QuoterMainnet;
        uniswapV3Factory = uniswapV3FactoryMainnet;
        uniV3PositionManager = uniV3PositionManagerMainnet;
        balancerFactory = balancerFactoryMainnet;
        lqty = LQTY_ADDRESS;
        stakingV1 = LQTY_STAKING_ADDRESS;
        lusd = LUSD_ADDRESS;
    } else {
        if (block.chainid == 31337) {
            WETH = new WETHTester({_tapAmount: 100 ether, _tapPeriod: 1 days});
        } else {
            WETH = new WETHTester({_tapAmount: 0, _tapPeriod: type(uint256).max});
        }
        USDC = new ERC20Faucet("USDC", "USDC", 0, type(uint256).max);
        curveStableswapFactory = curveStableswapFactorySepolia;
        uniV3Router = uniV3RouterSepolia;
        uniV3Quoter = uniV3QuoterSepolia;
        uniswapV3Factory = uniswapV3FactorySepolia;
        uniV3PositionManager = uniV3PositionManagerSepolia;
        balancerFactory = balancerFactorySepolia;
        lqty = address(new ERC20Faucet("Liquity", "LQTY", 100 ether, 1 days));
        lusd = address(new ERC20Faucet("Liquity USD", "LUSD", 100 ether, 1 days));
        stakingV1 = address(new MockStakingV1(IERC20_GOV(lqty), IERC20_GOV(lusd)));
        ERC20Faucet(lqty).mock_setWildcardSpender(address(stakingV1), true);
    }
    TroveManagerParams[] memory troveManagerParamsArray = new TroveManagerParams[](NUM_BRANCHES);
    troveManagerParamsArray[0] = TroveManagerParams({CCR: CCR_WETH, MCR: MCR_WETH, SCR: SCR_WETH, BCR: BCR_ALL, LIQUIDATION_PENALTY_SP: LIQUIDATION_PENALTY_SP_WETH, LIQUIDATION_PENALTY_REDISTRIBUTION: LIQUIDATION_PENALTY_REDISTRIBUTION_WETH});
    troveManagerParamsArray[1] = TroveManagerParams({CCR: CCR_SETH, MCR: MCR_SETH, SCR: SCR_SETH, BCR: BCR_ALL, LIQUIDATION_PENALTY_SP: LIQUIDATION_PENALTY_SP_SETH, LIQUIDATION_PENALTY_REDISTRIBUTION: LIQUIDATION_PENALTY_REDISTRIBUTION_SETH});
    troveManagerParamsArray[2] = troveManagerParamsArray[1];
    string[] memory collNames = new string[](2);
    string[] memory collSymbols = new string[](2);
    collNames[0] = "Wrapped liquid staked Ether 2.0";
    collSymbols[0] = "wstETH";
    collNames[1] = "Rocket Pool ETH";
    collSymbols[1] = "rETH";
    DeployGovernanceParams memory deployGovernanceParams = DeployGovernanceParams({epochStart: epochStart, deployer: deployer, salt: SALT, stakingV1: stakingV1, lqty: lqty, lusd: lusd, bold: boldAddress});
    DeploymentResult memory deployed = _deployAndConnectContracts(troveManagerParamsArray, collNames, collSymbols, deployGovernanceParams);
    if (block.chainid == 11155111) {
        ERC20Faucet monkeyBalls = new ERC20Faucet("MonkeyBalls", "MB", 0, type(uint256).max);
        for (uint256 i = 0; i < deployed.contractsArray.length; ++i) {
            PriceFeedTestnet(address(deployed.contractsArray[i].priceFeed)).setPrice(2_000 ether);
            _provideFlashloanLiquidity(ERC20Faucet(address(deployed.contractsArray[i].collToken)), monkeyBalls);
            if (i == 0) {
                (uint256 price, ) = deployed.contractsArray[0].priceFeed.fetchPrice();
                uint256 token1Amount = 1_000_000 ether;
                _provideUniV3Liquidity(ERC20Faucet(address(USDC)), ERC20Faucet(address(WETH)), token1Amount, price, UNIV3_FEE_USDC_WETH);
            } else {
                uint256 token1Amount = 1_000 ether;
                _provideUniV3Liquidity(ERC20Faucet(address(WETH)), ERC20Faucet(address(deployed.contractsArray[i].collToken)), token1Amount, 1 ether, UNIV3_FEE_WETH_COLL);
            }
        }
        _provideCurveLiquidity(deployed.boldToken, deployed.contractsArray[0]);
    }
    ICurveStableswapNGPool lusdCurvePool;
    if (block.chainid == 1) {
        lusdCurvePool = _deployCurvePool(deployed.boldToken, IERC20Metadata(LUSD_ADDRESS));
    }
    (address governanceAddress, string memory governanceManifest) = deployGovernance(deployGovernanceParams, address(curveStableswapFactory), address(deployed.usdcCurvePool), address(lusdCurvePool));
    address computedGovernanceAddress = computeGovernanceAddress(deployGovernanceParams);
    assert(governanceAddress == computedGovernanceAddress);
    vm.stopBroadcast();
    vm.writeFile("deployment-manifest.json", _getManifestJson(deployed, governanceManifest));
    if (vm.envOr("OPEN_DEMO_TROVES", false)) {
        uint256[] memory demoAccounts = new uint256[](8);
        demoAccounts[0] = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
        demoAccounts[1] = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;
        demoAccounts[2] = 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a;
        demoAccounts[3] = 0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6;
        demoAccounts[4] = 0x47e179ec197488593b187f80a00eb0da91f1b9d0b13f8733639f19c30a34926a;
        demoAccounts[5] = 0x8b3a350cf5c34c9194ca85829a2df0ec3153be0318b5e2d3348e872092edffba;
        demoAccounts[6] = 0x92db14e403b83dfe3df233f83dfa3a0d7096f21ca9b0d6d6b8d88b2b4ec1564e;
        demoAccounts[7] = 0x4bbbf85ce3377467afe5d46f804f221813b2bb87f24d81f60f1fcdbf7cbf4356;
        DemoTroveParams[] memory demoTroves = new DemoTroveParams[](24);
        demoTroves[0] = DemoTroveParams(0, demoAccounts[0], 0, 35 ether, 2_800 ether, 5.0e16);
        demoTroves[1] = DemoTroveParams(0, demoAccounts[1], 0, 47 ether, 2_400 ether, 4.7e16);
        demoTroves[2] = DemoTroveParams(0, demoAccounts[2], 0, 40 ether, 4_000 ether, 3.3e16);
        demoTroves[3] = DemoTroveParams(0, demoAccounts[3], 0, 75 ether, 6_000 ether, 4.3e16);
        demoTroves[4] = DemoTroveParams(0, demoAccounts[4], 0, 29 ether, 2_280 ether, 5.0e16);
        demoTroves[5] = DemoTroveParams(0, demoAccounts[5], 0, 58.37 ether, 4_400 ether, 4.7e16);
        demoTroves[6] = DemoTroveParams(0, demoAccounts[6], 0, 43.92 ether, 5_500 ether, 3.8e16);
        demoTroves[7] = DemoTroveParams(0, demoAccounts[7], 0, 57.2 ether, 6_000 ether, 4.3e16);
        demoTroves[8] = DemoTroveParams(1, demoAccounts[0], 0, 31 ether, 2_000 ether, 3.3e16);
        demoTroves[9] = DemoTroveParams(1, demoAccounts[1], 0, 26 ether, 2_000 ether, 4.1e16);
        demoTroves[10] = DemoTroveParams(1, demoAccounts[2], 0, 28 ether, 2_300 ether, 3.8e16);
        demoTroves[11] = DemoTroveParams(1, demoAccounts[3], 0, 32 ether, 2_200 ether, 4.3e16);
        demoTroves[12] = DemoTroveParams(1, demoAccounts[4], 0, 95 ether, 12_000 ether, 7.0e16);
        demoTroves[13] = DemoTroveParams(1, demoAccounts[5], 0, 97 ether, 4_000 ether, 4.4e16);
        demoTroves[14] = DemoTroveParams(1, demoAccounts[6], 0, 81 ether, 11_000 ether, 3.3e16);
        demoTroves[15] = DemoTroveParams(1, demoAccounts[7], 0, 94 ether, 12_800 ether, 4.4e16);
        demoTroves[16] = DemoTroveParams(2, demoAccounts[0], 0, 45 ether, 3_000 ether, 2.4e16);
        demoTroves[17] = DemoTroveParams(2, demoAccounts[1], 0, 35 ether, 2_100 ether, 5.0e16);
        demoTroves[18] = DemoTroveParams(2, demoAccounts[2], 0, 67 ether, 2_200 ether, 4.5e16);
        demoTroves[19] = DemoTroveParams(2, demoAccounts[3], 0, 32 ether, 4_900 ether, 3.2e16);
        demoTroves[20] = DemoTroveParams(2, demoAccounts[4], 0, 82 ether, 4_500 ether, 6.9e16);
        demoTroves[21] = DemoTroveParams(2, demoAccounts[5], 0, 74 ether, 7_300 ether, 4.1e16);
        demoTroves[22] = DemoTroveParams(2, demoAccounts[6], 0, 54 ether, 6_900 ether, 2.9e16);
        demoTroves[23] = DemoTroveParams(2, demoAccounts[7], 0, 65 ether, 8_100 ether, 1.5e16);
        for (uint256 i = 0; i < deployed.contractsArray.length; i++) {
            tapFaucet(demoAccounts, deployed.contractsArray[i]);
        }
        openDemoTroves(demoTroves, deployed.contractsArray);
    }
}
```

## Related Implementations

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

### eq(string,string)

- **Kind**: internal
- **Source**: 86:141:291
- **Link**: `test/Utils/StringEquality.sol:StringEquality:eq(string,string)`

```solidity
function eq(string memory a, string memory b) internal pure returns (bool) {
    return keccak256(bytes(a)) == keccak256(bytes(b));
}
```

### _latestUTCMidnightBetweenWednesdayAndThursday()

- **Kind**: free-function
- **Source**: 2912:131:112
- **Link**: `script/DeployLiquity2.s.sol:_latestUTCMidnightBetweenWednesdayAndThursday()`

```solidity
function _latestUTCMidnightBetweenWednesdayAndThursday() view returns (uint256) {
    return (block.timestamp / 1 weeks) * 1 weeks;
}
```

### _log(string,string)

- **Kind**: internal
- **Source**: 289:111:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string)`

```solidity
function _log(string memory a, string memory b) internal pure {
    console.log(string.concat(a, b));
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### decimal(uint256)

- **Kind**: internal
- **Source**: 1342:608:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:decimal(uint256)`

```solidity
function decimal(uint256 n) internal pure returns (string memory) {
    if (n == type(uint256).max) {
        return "type(uint256).max";
    }
    uint256 integerPart = n / ONE;
    uint256 fractionalPart = n % ONE;
    if (fractionalPart == 0) {
        return string.concat(integerPart.groupRight(), DECIMAL_UNIT);
    } else {
        return string.concat(integerPart.groupRight(), DECIMAL_SEPARATOR, (ONE + fractionalPart).toString().slice(1).trimEnd("0"), DECIMAL_UNIT);
    }
}
```

### groupRight(uint256)

- **Kind**: internal
- **Source**: 1956:118:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:groupRight(uint256)`

```solidity
function groupRight(uint256 n) internal pure returns (string memory) {
    return n.toString().groupRight();
}
```

### groupRight(string)

- **Kind**: internal
- **Source**: 2080:135:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:groupRight(string)`

```solidity
function groupRight(string memory str) internal pure returns (string memory) {
    return bytes(str).groupRight().toString();
}
```

### groupRight(bytes)

- **Kind**: internal
- **Source**: 2221:539:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:groupRight(bytes)`

```solidity
function groupRight(bytes memory str) internal pure returns (bytes memory ret) {
    uint256 length = str.length;
    if (length == 0) return "";
    uint256 retLength = length + ((length - 1) / GROUP_DIGITS);
    ret = new bytes(retLength);
    uint256 j = 1;
    for (uint256 i = 1; i <= retLength; ++i) {
        if ((i % (GROUP_DIGITS + 1)) == 0) {
            ret[retLength - i] = GROUP_SEPARATOR;
        } else {
            ret[retLength - i] = str[length - (j++)];
        }
    }
}
```

### toString(bytes)

- **Kind**: internal
- **Source**: 718:109:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:toString(bytes)`

```solidity
function toString(bytes memory str) internal pure returns (string memory) {
    return string(str);
}
```

### slice(string,int256)

- **Kind**: internal
- **Source**: 2766:144:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:slice(string,int256)`

```solidity
function slice(string memory str, int256 start) internal pure returns (string memory) {
    return bytes(str).slice(start).toString();
}
```

### slice(bytes,int256)

- **Kind**: internal
- **Source**: 3083:144:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:slice(bytes,int256)`

```solidity
function slice(bytes memory str, int256 start) internal pure returns (bytes memory) {
    return str.slice(start, int256(str.length));
}
```

### slice(bytes,int256,int256)

- **Kind**: internal
- **Source**: 3277:472:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:slice(bytes,int256,int256)`

```solidity
function slice(bytes memory str, int256 start, int256 end) internal pure returns (bytes memory ret) {
    uint256 uStart = uint256((start < 0) ? (int256(str.length) + start) : start);
    uint256 uEnd = uint256((end < 0) ? (int256(str.length) + end) : end);
    assert(((0 <= uStart) && (uStart <= uEnd)) && (uEnd <= str.length));
    ret = new bytes(uEnd - uStart);
    for (uint256 i = uStart; i < uEnd; ++i) {
        ret[i - uStart] = str[i];
    }
}
```

### trimEnd(string,bytes1)

- **Kind**: internal
- **Source**: 3755:146:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:trimEnd(string,bytes1)`

```solidity
function trimEnd(string memory str, bytes1 char) internal pure returns (string memory) {
    return bytes(str).trimEnd(char).toString();
}
```

### trimEnd(bytes,bytes1)

- **Kind**: internal
- **Source**: 3907:229:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:trimEnd(bytes,bytes1)`

```solidity
function trimEnd(bytes memory str, bytes1 char) internal pure returns (bytes memory) {
    uint256 end;
    for (end = str.length; (end > 0) && (str[end - 1] == char); --end) {}
    return str.slice(0, int256(end));
}
```

### _log(string,string,string,string,string)

- **Kind**: internal
- **Source**: 700:171:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string,string,string,string)`

```solidity
function _log(string memory a, string memory b, string memory c, string memory d, string memory e) internal pure {
    console.log(string.concat(a, b, c, d, e));
}
```

### toHexString(uint256)

- **Kind**: internal
- **Source**: 1521:174:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toHexString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
function toHexString(uint256 value) internal pure returns (string memory) {
    unchecked {
        return toHexString(value, Math.log256(value) + 1);
    }
}
```

### toHexString(uint256,uint256)

- **Kind**: internal
- **Source**: 1818:437:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toHexString(uint256,uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
    bytes memory buffer = new bytes((2 * length) + 2);
    buffer[0] = "0";
    buffer[1] = "x";
    for (uint256 i = (2 * length) + 1; i > 1; --i) {
        buffer[i] = _SYMBOLS[value & 0xf];
        value >>= 4;
    }
    require(value == 0, "Strings: hex length insufficient");
    return string(buffer);
}
```

### log256(uint256)

- **Kind**: internal
- **Source**: 11708:663:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log256(uint256)`

```solidity
///  @dev Return the log in base 256, rounded down, of a positive value.
///  Returns 0 if given 0.
///  Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
function log256(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if ((value >> 128) > 0) {
            value >>= 128;
            result += 16;
        }
        if ((value >> 64) > 0) {
            value >>= 64;
            result += 8;
        }
        if ((value >> 32) > 0) {
            value >>= 32;
            result += 4;
        }
        if ((value >> 16) > 0) {
            value >>= 16;
            result += 2;
        }
        if ((value >> 8) > 0) {
            result += 1;
        }
    }
    return result;
}
```

### _deployAndConnectContracts(struct DeployLiquity2Script.TroveManagerParams[],string[],string[],struct DeployGovernance.DeployGovernanceParams)

- **Kind**: internal
- **Source**: 25596:4245:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_deployAndConnectContracts(struct DeployLiquity2Script.TroveManagerParams[],string[],string[],struct DeployGovernance.DeployGovernanceParams)`

```solidity
function _deployAndConnectContracts(TroveManagerParams[] memory troveManagerParamsArray, string[] memory _collNames, string[] memory _collSymbols, DeployGovernanceParams memory _deployGovernanceParams) internal returns (DeploymentResult memory r) {
    assert(_collNames.length == (troveManagerParamsArray.length - 1));
    assert(_collSymbols.length == (troveManagerParamsArray.length - 1));
    DeploymentVars memory vars;
    vars.numCollaterals = troveManagerParamsArray.length;
    r.boldToken = BoldToken(_deployGovernanceParams.bold);
    r.usdcCurvePool = _deployCurvePool(r.boldToken, USDC);
    r.contractsArray = new LiquityContracts[](vars.numCollaterals);
    vars.collaterals = new IERC20Metadata[](vars.numCollaterals);
    vars.addressesRegistries = new IAddressesRegistry[](vars.numCollaterals);
    vars.troveManagers = new ITroveManager[](vars.numCollaterals);
    if ((block.chainid == 1) && (!useTestnetPriceFeeds)) {
        vars.collaterals[0] = IERC20Metadata(WETH);
        vars.collaterals[1] = IERC20Metadata(WSTETH_ADDRESS);
        vars.collaterals[2] = IERC20Metadata(RETH_ADDRESS);
    } else {
        vars.collaterals[0] = WETH;
        for (vars.i = 1; vars.i < vars.numCollaterals; vars.i++) {
            vars.collaterals[vars.i] = new ERC20Faucet(_collNames[vars.i - 1], _collSymbols[vars.i - 1], 100 ether, 1 days);
        }
    }
    for (vars.i = 0; vars.i < vars.numCollaterals; vars.i++) {
        (IAddressesRegistry addressesRegistry, address troveManagerAddress) = _deployAddressesRegistry(troveManagerParamsArray[vars.i]);
        vars.addressesRegistries[vars.i] = addressesRegistry;
        vars.troveManagers[vars.i] = ITroveManager(troveManagerAddress);
    }
    r.collateralRegistry = new CollateralRegistry(r.boldToken, vars.collaterals, vars.troveManagers);
    r.hintHelpers = new HintHelpers(r.collateralRegistry);
    r.multiTroveGetter = new MultiTroveGetter(r.collateralRegistry);
    r.debtInFrontHelper = new DebtInFrontHelper(r.collateralRegistry, r.hintHelpers);
    for (vars.i = 0; vars.i < vars.numCollaterals; vars.i++) {
        vars.contracts = _deployAndConnectCollateralContracts(vars.collaterals[vars.i], r.boldToken, r.collateralRegistry, r.usdcCurvePool, vars.addressesRegistries[vars.i], address(vars.troveManagers[vars.i]), r.hintHelpers, r.multiTroveGetter, computeGovernanceAddress(_deployGovernanceParams));
        r.contractsArray[vars.i] = vars.contracts;
    }
    r.boldToken.setCollateralRegistry(address(r.collateralRegistry));
    r.exchangeHelpers = new HybridCurveUniV3ExchangeHelpers(USDC, WETH, r.usdcCurvePool, OTHER_TOKEN_INDEX, BOLD_TOKEN_INDEX, UNIV3_FEE_USDC_WETH, UNIV3_FEE_WETH_COLL, uniV3Quoter);
    r.exchangeHelpersV2 = new HybridCurveUniV3ExchangeHelpersV2({_usdc: address(USDC), _weth: address(WETH), _curvePool: r.usdcCurvePool, _usdcIndex: int128(OTHER_TOKEN_INDEX), _boldIndex: int128(BOLD_TOKEN_INDEX), _feeUsdcWeth: UNIV3_FEE_USDC_WETH, _feeWethColl: UNIV3_FEE_WETH_COLL, _uniV3Quoter: uniV3Quoter});
}
```

### _deployCurvePool(contract IBoldToken,contract IERC20Metadata)

- **Kind**: internal
- **Source**: 39480:1198:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_deployCurvePool(contract IBoldToken,contract IERC20Metadata)`

```solidity
function _deployCurvePool(IBoldToken _boldToken, IERC20Metadata _otherToken) internal returns (ICurveStableswapNGPool) {
    if (block.chainid == 31337) {
        return ICurveStableswapNGPool(address(0));
    }
    address[] memory coins = new address[](2);
    coins[BOLD_TOKEN_INDEX] = address(_boldToken);
    coins[OTHER_TOKEN_INDEX] = address(_otherToken);
    uint8[] memory assetTypes = new uint8[](2);
    bytes4[] memory methodIds = new bytes4[](2);
    address[] memory oracles = new address[](2);
    ICurveStableswapNGPool curvePool = curveStableswapFactory.deploy_plain_pool({name: string.concat("BOLD/", _otherToken.symbol(), " Pool"), symbol: string.concat("BOLD", _otherToken.symbol()), coins: coins, A: 100, fee: 4000000, offpeg_fee_multiplier: 20000000000, ma_exp_time: 866, implementation_id: 0, asset_types: assetTypes, method_ids: methodIds, oracles: oracles});
    return curvePool;
}
```

### _deployAddressesRegistry(struct DeployLiquity2Script.TroveManagerParams)

- **Kind**: internal
- **Source**: 29847:764:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_deployAddressesRegistry(struct DeployLiquity2Script.TroveManagerParams)`

```solidity
function _deployAddressesRegistry(TroveManagerParams memory _troveManagerParams) internal returns (IAddressesRegistry, address) {
    IAddressesRegistry addressesRegistry = new AddressesRegistry(deployer, _troveManagerParams.CCR, _troveManagerParams.MCR, _troveManagerParams.BCR, _troveManagerParams.SCR, _troveManagerParams.LIQUIDATION_PENALTY_SP, _troveManagerParams.LIQUIDATION_PENALTY_REDISTRIBUTION);
    address troveManagerAddress = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(TroveManager).creationCode, address(addressesRegistry))));
    return (addressesRegistry, troveManagerAddress);
}
```

### getBytecode(bytes,address)

- **Kind**: internal
- **Source**: 25391:199:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:getBytecode(bytes,address)`

```solidity
function getBytecode(bytes memory _creationCode, address _addressesRegistry) public pure returns (bytes memory) {
    return abi.encodePacked(_creationCode, abi.encode(_addressesRegistry));
}
```

### _deployAndConnectCollateralContracts(contract IERC20Metadata,contract IBoldToken,contract ICollateralRegistry,contract ICurveStableswapNGPool,contract IAddressesRegistry,address,contract IHintHelpers,contract IMultiTroveGetter,address)

- **Kind**: internal
- **Source**: 30617:5813:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_deployAndConnectCollateralContracts(contract IERC20Metadata,contract IBoldToken,contract ICollateralRegistry,contract ICurveStableswapNGPool,contract IAddressesRegistry,address,contract IHintHelpers,contract IMultiTroveGetter,address)`

```solidity
function _deployAndConnectCollateralContracts(IERC20Metadata _collToken, IBoldToken _boldToken, ICollateralRegistry _collateralRegistry, ICurveStableswapNGPool _usdcCurvePool, IAddressesRegistry _addressesRegistry, address _troveManagerAddress, IHintHelpers _hintHelpers, IMultiTroveGetter _multiTroveGetter, address _governance) internal returns (LiquityContracts memory contracts) {
    LiquityContractAddresses memory addresses;
    contracts.collToken = _collToken;
    contracts.addressesRegistry = _addressesRegistry;
    contracts.metadataNFT = deployMetadata(SALT);
    addresses.metadataNFT = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(MetadataNFT).creationCode, address(initializedFixedAssetReader))));
    assert(address(contracts.metadataNFT) == addresses.metadataNFT);
    contracts.interestRouter = IInterestRouter(_governance);
    addresses.borrowerOperations = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(BorrowerOperations).creationCode, address(contracts.addressesRegistry))));
    addresses.troveManager = _troveManagerAddress;
    addresses.troveNFT = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry))));
    addresses.stabilityPool = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(StabilityPool).creationCode, address(contracts.addressesRegistry))));
    addresses.activePool = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(ActivePool).creationCode, address(contracts.addressesRegistry))));
    addresses.defaultPool = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(DefaultPool).creationCode, address(contracts.addressesRegistry))));
    addresses.gasPool = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(GasPool).creationCode, address(contracts.addressesRegistry))));
    addresses.collSurplusPool = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(CollSurplusPool).creationCode, address(contracts.addressesRegistry))));
    addresses.sortedTroves = vm.computeCreate2Address(SALT, keccak256(getBytecode(type(SortedTroves).creationCode, address(contracts.addressesRegistry))));
    contracts.priceFeed = _deployPriceFeed(address(_collToken), addresses.borrowerOperations);
    IAddressesRegistry.AddressVars memory addressVars = IAddressesRegistry.AddressVars({collToken: _collToken, borrowerOperations: IBorrowerOperations(addresses.borrowerOperations), troveManager: ITroveManager(addresses.troveManager), troveNFT: ITroveNFT(addresses.troveNFT), metadataNFT: IMetadataNFT(addresses.metadataNFT), stabilityPool: IStabilityPool(addresses.stabilityPool), priceFeed: contracts.priceFeed, activePool: IActivePool(addresses.activePool), defaultPool: IDefaultPool(addresses.defaultPool), gasPoolAddress: addresses.gasPool, collSurplusPool: ICollSurplusPool(addresses.collSurplusPool), sortedTroves: ISortedTroves(addresses.sortedTroves), interestRouter: contracts.interestRouter, hintHelpers: _hintHelpers, multiTroveGetter: _multiTroveGetter, collateralRegistry: _collateralRegistry, boldToken: _boldToken, WETH: WETH});
    contracts.addressesRegistry.setAddresses(addressVars);
    contracts.borrowerOperations = new BorrowerOperations{salt: SALT}(contracts.addressesRegistry);
    contracts.troveManager = new TroveManager{salt: SALT}(contracts.addressesRegistry);
    contracts.troveNFT = new TroveNFT{salt: SALT}(contracts.addressesRegistry);
    contracts.stabilityPool = new StabilityPool{salt: SALT}(contracts.addressesRegistry);
    contracts.activePool = new ActivePool{salt: SALT}(contracts.addressesRegistry);
    contracts.defaultPool = new DefaultPool{salt: SALT}(contracts.addressesRegistry);
    contracts.gasPool = new GasPool{salt: SALT}(contracts.addressesRegistry);
    contracts.collSurplusPool = new CollSurplusPool{salt: SALT}(contracts.addressesRegistry);
    contracts.sortedTroves = new SortedTroves{salt: SALT}(contracts.addressesRegistry);
    assert(address(contracts.borrowerOperations) == addresses.borrowerOperations);
    assert(address(contracts.troveManager) == addresses.troveManager);
    assert(address(contracts.troveNFT) == addresses.troveNFT);
    assert(address(contracts.stabilityPool) == addresses.stabilityPool);
    assert(address(contracts.activePool) == addresses.activePool);
    assert(address(contracts.defaultPool) == addresses.defaultPool);
    assert(address(contracts.gasPool) == addresses.gasPool);
    assert(address(contracts.collSurplusPool) == addresses.collSurplusPool);
    assert(address(contracts.sortedTroves) == addresses.sortedTroves);
    _boldToken.setBranchAddresses(address(contracts.troveManager), address(contracts.stabilityPool), address(contracts.borrowerOperations), address(contracts.activePool));
    (contracts.gasCompZapper, contracts.wethZapper, contracts.leverageZapper) = _deployZappers(contracts.addressesRegistry, contracts.collToken, _boldToken, _usdcCurvePool);
}
```

### computeGovernanceAddress(struct DeployGovernance.DeployGovernanceParams)

- **Kind**: internal
- **Source**: 5078:217:111
- **Link**: `script/DeployGovernance.s.sol:DeployGovernance:computeGovernanceAddress(struct DeployGovernance.DeployGovernanceParams)`

```solidity
function computeGovernanceAddress(DeployGovernanceParams memory p) internal pure returns (address) {
    (address governanceAddress, ) = computeGovernanceAddressAndConfig(p);
    return governanceAddress;
}
```

### computeGovernanceAddressAndConfig(struct DeployGovernance.DeployGovernanceParams)

- **Kind**: internal
- **Source**: 5301:1182:111
- **Link**: `script/DeployGovernance.s.sol:DeployGovernance:computeGovernanceAddressAndConfig(struct DeployGovernance.DeployGovernanceParams)`

```solidity
function computeGovernanceAddressAndConfig(DeployGovernanceParams memory p) internal pure returns (address, IGovernance.Configuration memory) {
    IGovernance.Configuration memory governanceConfiguration = IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: p.epochStart, epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF});
    bytes memory bytecode = abi.encodePacked(type(Governance).creationCode, abi.encode(p.lqty, p.lusd, p.stakingV1, p.bold, governanceConfiguration, p.deployer, new address[](0)));
    address governanceAddress = vm.computeCreate2Address(p.salt, keccak256(bytecode));
    return (governanceAddress, governanceConfiguration);
}
```

### deployMetadata(bytes32)

- **Kind**: internal
- **Source**: 550:282:274
- **Link**: `test/TestContracts/MetadataDeployment.sol:MetadataDeployment:deployMetadata(bytes32)`

```solidity
function deployMetadata(bytes32 _salt) public returns (MetadataNFT) {
    _loadFiles();
    _storeFile();
    _deployFixedAssetReader(_salt);
    MetadataNFT metadataNFT = new MetadataNFT{salt: _salt}(initializedFixedAssetReader);
    return metadataNFT;
}
```

### _loadFiles()

- **Kind**: internal
- **Source**: 838:1597:274
- **Link**: `test/TestContracts/MetadataDeployment.sol:MetadataDeployment:_loadFiles()`

```solidity
function _loadFiles() internal {
    string memory root = string.concat(vm.projectRoot(), "/utils/assets/");
    uint256 offset = 0;
    bytes memory boldFile = bytes(vm.readFile(string.concat(root, "bold_logo.txt")));
    File memory bold = File(boldFile, offset, offset + boldFile.length);
    offset += boldFile.length;
    files[bytes4(keccak256("BOLD"))] = bold;
    bytes memory ethFile = bytes(vm.readFile(string.concat(root, "weth_logo.txt")));
    File memory eth = File(ethFile, offset, offset + ethFile.length);
    offset += ethFile.length;
    files[bytes4(keccak256("WETH"))] = eth;
    bytes memory wstethFile = bytes(vm.readFile(string.concat(root, "wsteth_logo.txt")));
    File memory wsteth = File(wstethFile, offset, offset + wstethFile.length);
    offset += wstethFile.length;
    files[bytes4(keccak256("wstETH"))] = wsteth;
    bytes memory rethFile = bytes(vm.readFile(string.concat(root, "reth_logo.txt")));
    File memory reth = File(rethFile, offset, offset + rethFile.length);
    offset += rethFile.length;
    files[bytes4(keccak256("rETH"))] = reth;
    bytes memory geistFile = bytes(vm.readFile(string.concat(root, "geist.txt")));
    File memory geist = File(geistFile, offset, offset + geistFile.length);
    offset += geistFile.length;
    files[bytes4(keccak256("geist"))] = geist;
}
```

### _storeFile()

- **Kind**: internal
- **Source**: 2441:448:274
- **Link**: `test/TestContracts/MetadataDeployment.sol:MetadataDeployment:_storeFile()`

```solidity
function _storeFile() internal {
    bytes memory data = bytes.concat(files[bytes4(keccak256("BOLD"))].data, files[bytes4(keccak256("WETH"))].data, files[bytes4(keccak256("wstETH"))].data, files[bytes4(keccak256("rETH"))].data, files[bytes4(keccak256("geist"))].data);
    pointer = SSTORE2.write(data);
}
```

### write(bytes)

- **Kind**: internal
- **Source**: 2052:1785:2
- **Link**: `lib/Solady/src/utils/SSTORE2.sol:SSTORE2:write(bytes)`

```solidity
/// @dev Writes `data` into the bytecode of a storage contract and returns its address.
function write(bytes memory data) internal returns (address pointer) {
    /// @solidity memory-safe-assembly
    assembly {
        let n := mload(data)
        mstore(add(data, gt(n, 0xfffe)), add(0xfe61000180600a3d393df300, shl(0x40, n)))
        pointer := create(0, add(data, 0x15), add(n, 0xb))
        if iszero(pointer) {
            mstore(0x00, 0x30116425)
            revert(0x1c, 0x04)
        }
        mstore(data, n)
    }
}
```

### _deployFixedAssetReader(bytes32)

- **Kind**: internal
- **Source**: 2895:1371:274
- **Link**: `test/TestContracts/MetadataDeployment.sol:MetadataDeployment:_deployFixedAssetReader(bytes32)`

```solidity
function _deployFixedAssetReader(bytes32 _salt) internal {
    bytes4[] memory sigs = new bytes4[](5);
    sigs[0] = bytes4(keccak256("BOLD"));
    sigs[1] = bytes4(keccak256("WETH"));
    sigs[2] = bytes4(keccak256("wstETH"));
    sigs[3] = bytes4(keccak256("rETH"));
    sigs[4] = bytes4(keccak256("geist"));
    FixedAssetReader.Asset[] memory FixedAssets = new FixedAssetReader.Asset[](5);
    FixedAssets[0] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("BOLD"))].start), uint128(files[bytes4(keccak256("BOLD"))].end));
    FixedAssets[1] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("WETH"))].start), uint128(files[bytes4(keccak256("WETH"))].end));
    FixedAssets[2] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("wstETH"))].start), uint128(files[bytes4(keccak256("wstETH"))].end));
    FixedAssets[3] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("rETH"))].start), uint128(files[bytes4(keccak256("rETH"))].end));
    FixedAssets[4] = FixedAssetReader.Asset(uint128(files[bytes4(keccak256("geist"))].start), uint128(files[bytes4(keccak256("geist"))].end));
    initializedFixedAssetReader = new FixedAssetReader{salt: _salt}(pointer, sigs, FixedAssets);
}
```

### _deployPriceFeed(address,address)

- **Kind**: internal
- **Source**: 36436:1280:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_deployPriceFeed(address,address)`

```solidity
function _deployPriceFeed(address _collTokenAddress, address _borroweOperationsAddress) internal returns (IPriceFeed) {
    if ((block.chainid == 1) && (!useTestnetPriceFeeds)) {
        if (_collTokenAddress == address(WETH)) {
            return new WETHPriceFeed(ETH_ORACLE_ADDRESS, ETH_USD_STALENESS_THRESHOLD, _borroweOperationsAddress);
        } else if (_collTokenAddress == WSTETH_ADDRESS) {
            return new WSTETHPriceFeed(ETH_ORACLE_ADDRESS, STETH_ORACLE_ADDRESS, WSTETH_ADDRESS, ETH_USD_STALENESS_THRESHOLD, STETH_USD_STALENESS_THRESHOLD, _borroweOperationsAddress);
        }
        assert(_collTokenAddress == RETH_ADDRESS);
        return new RETHPriceFeed(ETH_ORACLE_ADDRESS, RETH_ORACLE_ADDRESS, RETH_ADDRESS, ETH_USD_STALENESS_THRESHOLD, RETH_ETH_STALENESS_THRESHOLD, _borroweOperationsAddress);
    }
    return new PriceFeedTestnet();
}
```

### _deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract ICurveStableswapNGPool)

- **Kind**: internal
- **Source**: 37722:1151:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract ICurveStableswapNGPool)`

```solidity
function _deployZappers(IAddressesRegistry _addressesRegistry, IERC20 _collToken, IBoldToken _boldToken, ICurveStableswapNGPool _usdcCurvePool) internal returns (GasCompZapper gasCompZapper, WETHZapper wethZapper, ILeverageZapper leverageZapper) {
    IFlashLoanProvider flashLoanProvider = new BalancerFlashLoan();
    IExchange hybridExchange = new HybridCurveUniV3Exchange(_collToken, _boldToken, USDC, WETH, _usdcCurvePool, OTHER_TOKEN_INDEX, BOLD_TOKEN_INDEX, UNIV3_FEE_USDC_WETH, UNIV3_FEE_WETH_COLL, uniV3Router);
    bool lst = _collToken != WETH;
    if (lst) {
        gasCompZapper = new GasCompZapper(_addressesRegistry, flashLoanProvider, hybridExchange);
    } else {
        wethZapper = new WETHZapper(_addressesRegistry, flashLoanProvider, hybridExchange);
    }
    leverageZapper = _deployHybridLeverageZapper(_addressesRegistry, flashLoanProvider, hybridExchange, lst);
}
```

### _deployHybridLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool)

- **Kind**: internal
- **Source**: 38879:595:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_deployHybridLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool)`

```solidity
function _deployHybridLeverageZapper(IAddressesRegistry _addressesRegistry, IFlashLoanProvider _flashLoanProvider, IExchange _hybridExchange, bool _lst) internal returns (ILeverageZapper) {
    ILeverageZapper leverageZapperHybrid;
    if (_lst) {
        leverageZapperHybrid = new LeverageLSTZapper(_addressesRegistry, _flashLoanProvider, _hybridExchange);
    } else {
        leverageZapperHybrid = new LeverageWETHZapper(_addressesRegistry, _flashLoanProvider, _hybridExchange);
    }
    return leverageZapperHybrid;
}
```

### _provideFlashloanLiquidity(contract ERC20Faucet,contract ERC20Faucet)

- **Kind**: internal
- **Source**: 40684:1716:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_provideFlashloanLiquidity(contract ERC20Faucet,contract ERC20Faucet)`

```solidity
function _provideFlashloanLiquidity(ERC20Faucet _collToken, ERC20Faucet _monkeyBalls) internal {
    uint256[] memory amountsIn = new uint256[](2);
    amountsIn[0] = 1_000_000 ether;
    amountsIn[1] = 1_000_000 ether;
    _collToken.mint(deployer, amountsIn[0]);
    _monkeyBalls.mint(deployer, amountsIn[1]);
    IERC20[] memory tokens = new IERC20[](2);
    (tokens[0], tokens[1]) = (address(_collToken) < address(_monkeyBalls)) ? (_collToken, _monkeyBalls) : (_monkeyBalls, _collToken);
    uint256[] memory normalizedWeights = new uint256[](2);
    normalizedWeights[0] = 0.5 ether;
    normalizedWeights[1] = 0.5 ether;
    IWeightedPool pool = balancerFactorySepolia.create({name: string.concat(_collToken.name(), "-", _monkeyBalls.name()), symbol: string.concat("bpt", _collToken.symbol(), _monkeyBalls.symbol()), tokens: tokens, normalizedWeights: normalizedWeights, rateProviders: new IRateProvider[](2), swapFeePercentage: 0.000001 ether, owner: deployer, salt: bytes32("NaCl")});
    _collToken.approve(address(balancerVault), amountsIn[0]);
    _monkeyBalls.approve(address(balancerVault), amountsIn[1]);
    balancerVault.joinPool(pool.getPoolId(), deployer, deployer, IVault.JoinPoolRequest({assets: tokens, maxAmountsIn: amountsIn, userData: abi.encode(IWeightedPool.JoinKind.INIT, amountsIn), fromInternalBalance: false}));
}
```

### _provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24)

- **Kind**: internal
- **Source**: 43825:3251:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24)`

```solidity
function _provideUniV3Liquidity(ERC20Faucet _token1, ERC20Faucet _token2, uint256 _token1Amount, uint256 _price, uint24 _fee) internal {
    ProvideUniV3LiquidityVars memory vars;
    vars.token2Amount = (_token1Amount * DECIMAL_PRECISION) / _price;
    if (address(_token1) < address(_token2)) {
        vars.tokens[0] = address(_token1);
        vars.tokens[1] = address(_token2);
        vars.amounts[0] = _token1Amount;
        vars.amounts[1] = vars.token2Amount;
        vars.price = (DECIMAL_PRECISION * DECIMAL_PRECISION) / _price;
    } else {
        vars.tokens[0] = address(_token2);
        vars.tokens[1] = address(_token1);
        vars.amounts[0] = vars.token2Amount;
        vars.amounts[1] = _token1Amount;
        vars.price = _price;
    }
    uniV3PositionManagerSepolia.createAndInitializePoolIfNecessary(vars.tokens[0], vars.tokens[1], _fee, priceToSqrtPriceX96(vars.price));
    _token1.mint(deployer, _token1Amount);
    _token2.mint(deployer, vars.token2Amount);
    _token1.approve(address(uniV3PositionManagerSepolia), _token1Amount);
    _token2.approve(address(uniV3PositionManagerSepolia), vars.token2Amount);
    address uniV3PoolAddress = uniswapV3FactorySepolia.getPool(vars.tokens[0], vars.tokens[1], _fee);
    int24 TICK_SPACING = IUniswapV3Pool(uniV3PoolAddress).tickSpacing();
    (, int24 tick, , , , , ) = IUniswapV3Pool(uniV3PoolAddress).slot0();
    vars.tickLower = ((tick - 60) / TICK_SPACING) * TICK_SPACING;
    vars.tickUpper = ((tick + 60) / TICK_SPACING) * TICK_SPACING;
    INonfungiblePositionManager.MintParams memory params = INonfungiblePositionManager.MintParams({token0: vars.tokens[0], token1: vars.tokens[1], fee: _fee, tickLower: vars.tickLower, tickUpper: vars.tickUpper, amount0Desired: vars.amounts[0], amount1Desired: vars.amounts[1], amount0Min: 0, amount1Min: 0, recipient: deployer, deadline: block.timestamp + 600 minutes});
    uniV3PositionManagerSepolia.mint(params);
}
```

### priceToSqrtPriceX96(uint256)

- **Kind**: internal
- **Source**: 230:378:222
- **Link**: `src/Zappers/Modules/Exchanges/UniswapV3/UniPriceConverter.sol:UniPriceConverter:priceToSqrtPriceX96(uint256)`

```solidity
function priceToSqrtPriceX96(uint256 _price) public pure returns (uint160 sqrtPriceX96) {
    if (_price > (1 << 64)) {
        sqrtPriceX96 = uint160(Math.sqrt(_price / DECIMAL_PRECISION) << 96);
    } else {
        sqrtPriceX96 = uint160(Math.sqrt((_price << 192) / DECIMAL_PRECISION));
    }
}
```

### sqrt(uint256)

- **Kind**: internal
- **Source**: 6530:1642:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:sqrt(uint256)`

```solidity
///  @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded down.
///  Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
function sqrt(uint256 a) internal pure returns (uint256) {
    if (a == 0) {
        return 0;
    }
    uint256 result = 1 << (log2(a) >> 1);
    unchecked {
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        return min(result, a / result);
    }
}
```

### log2(uint256)

- **Kind**: internal
- **Source**: 8633:983:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log2(uint256)`

```solidity
///  @dev Return the log in base 2, rounded down, of a positive value.
///  Returns 0 if given 0.
function log2(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if ((value >> 128) > 0) {
            value >>= 128;
            result += 128;
        }
        if ((value >> 64) > 0) {
            value >>= 64;
            result += 64;
        }
        if ((value >> 32) > 0) {
            value >>= 32;
            result += 32;
        }
        if ((value >> 16) > 0) {
            value >>= 16;
            result += 16;
        }
        if ((value >> 8) > 0) {
            value >>= 8;
            result += 8;
        }
        if ((value >> 4) > 0) {
            value >>= 4;
            result += 4;
        }
        if ((value >> 2) > 0) {
            value >>= 2;
            result += 2;
        }
        if ((value >> 1) > 0) {
            result += 1;
        }
    }
    return result;
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### _provideCurveLiquidity(contract IBoldToken,struct DeployLiquity2Script.LiquityContracts)

- **Kind**: internal
- **Source**: 47240:1046:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_provideCurveLiquidity(contract IBoldToken,struct DeployLiquity2Script.LiquityContracts)`

```solidity
function _provideCurveLiquidity(IBoldToken _boldToken, LiquityContracts memory _contracts) internal {
    ICurveStableswapNGPool usdcCurvePool = HybridCurveUniV3Exchange(address(_contracts.leverageZapper.exchange())).curvePool();
    uint256 usdcAmount = 1e27;
    uint256 boldAmount = usdcAmount;
    ERC20Faucet(address(USDC)).mint(deployer, usdcAmount);
    (uint256 price, ) = _contracts.priceFeed.fetchPrice();
    _mintBold(boldAmount, price, _contracts);
    USDC.approve(address(usdcCurvePool), usdcAmount);
    _boldToken.approve(address(usdcCurvePool), boldAmount);
    uint256[] memory amountsDynamic = new uint256[](2);
    amountsDynamic[0] = boldAmount;
    amountsDynamic[1] = usdcAmount;
    usdcCurvePool.add_liquidity(amountsDynamic, 0);
}
```

### _mintBold(uint256,uint256,struct DeployLiquity2Script.LiquityContracts)

- **Kind**: internal
- **Source**: 42406:1167:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_mintBold(uint256,uint256,struct DeployLiquity2Script.LiquityContracts)`

```solidity
function _mintBold(uint256 _boldAmount, uint256 _price, LiquityContracts memory _contracts) internal {
    uint256 collAmount = (_boldAmount * 2 ether) / _price;
    ERC20Faucet(address(_contracts.collToken)).mint(deployer, collAmount);
    WETHTester(payable(address(WETH))).mint(deployer, ETH_GAS_COMPENSATION);
    if (_contracts.collToken == WETH) {
        WETH.approve(address(_contracts.borrowerOperations), collAmount + ETH_GAS_COMPENSATION);
    } else {
        _contracts.collToken.approve(address(_contracts.borrowerOperations), collAmount);
        WETH.approve(address(_contracts.borrowerOperations), ETH_GAS_COMPENSATION);
    }
    _contracts.borrowerOperations.openTrove({_owner: deployer, _ownerIndex: lastTroveIndex++, _ETHAmount: collAmount, _boldAmount: _boldAmount, _upperHint: 0, _lowerHint: 0, _annualInterestRate: 0.05 ether, _maxUpfrontFee: type(uint256).max, _addManager: address(0), _removeManager: address(0), _receiver: address(0)});
}
```

### deployGovernance(struct DeployGovernance.DeployGovernanceParams,address,address,address)

- **Kind**: internal
- **Source**: 3078:1994:111
- **Link**: `script/DeployGovernance.s.sol:DeployGovernance:deployGovernance(struct DeployGovernance.DeployGovernanceParams,address,address,address)`

```solidity
function deployGovernance(DeployGovernanceParams memory p, address _curveFactoryAddress, address _curveUsdcBoldPoolAddress, address _curveLusdBoldPoolAddress) internal returns (address, string memory) {
    (address governanceAddress, IGovernance.Configuration memory governanceConfiguration) = computeGovernanceAddressAndConfig(p);
    governance = new Governance{salt: p.salt}(p.lqty, p.lusd, p.stakingV1, p.bold, governanceConfiguration, p.deployer, initialInitiatives);
    assert(governanceAddress == address(governance));
    curveUsdcBoldPool = ICurveStableSwapNG(_curveUsdcBoldPoolAddress);
    curveLusdBoldPool = ICurveStableSwapNG(_curveLusdBoldPoolAddress);
    if (block.chainid == 1) {
        (curveUsdcBoldGauge, curveUsdcBoldInitiative) = deployCurveV2GaugeRewards({_governance: governance, _bold: p.bold, _curveFactoryAddress: _curveFactoryAddress, _curvePool: curveUsdcBoldPool});
        (curveLusdBoldGauge, curveLusdBoldInitiative) = deployCurveV2GaugeRewards({_governance: governance, _bold: p.bold, _curveFactoryAddress: _curveFactoryAddress, _curvePool: curveLusdBoldPool});
        initialInitiatives.push(address(curveUsdcBoldInitiative));
        initialInitiatives.push(address(curveLusdBoldInitiative));
        initialInitiatives.push(defiCollectiveInitiative = DEFI_COLLECTIVE_GRANTS_ADDRESS);
    } else {
        initialInitiatives.push(makeAddr("initiative1"));
        initialInitiatives.push(makeAddr("initiative2"));
        initialInitiatives.push(makeAddr("initiative3"));
    }
    governance.registerInitialInitiatives{gas: 600000}(initialInitiatives);
    return (governanceAddress, _getGovernanceManifestJson(p));
}
```

### deployCurveV2GaugeRewards(contract IGovernance,address,address,contract ICurveStableSwapNG)

- **Kind**: internal
- **Source**: 6489:862:111
- **Link**: `script/DeployGovernance.s.sol:DeployGovernance:deployCurveV2GaugeRewards(contract IGovernance,address,address,contract ICurveStableSwapNG)`

```solidity
function deployCurveV2GaugeRewards(IGovernance _governance, address _bold, address _curveFactoryAddress, ICurveStableSwapNG _curvePool) private returns (ILiquidityGaugeV6 gauge, CurveV2GaugeRewards curveV2GaugeRewards) {
    ICurveStableSwapFactoryNG curveFactory = ICurveStableSwapFactoryNG(_curveFactoryAddress);
    gauge = ILiquidityGaugeV6(curveFactory.deploy_gauge(address(_curvePool)));
    curveV2GaugeRewards = new CurveV2GaugeRewards(address(_governance), _bold, CRV, address(gauge), DURATION);
    gauge.add_reward(_bold, address(curveV2GaugeRewards));
    gauge.add_reward(LUSD, FUNDS_SAFE);
    gauge.set_gauge_manager(address(0));
}
```

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

### _getGovernanceManifestJson(struct DeployGovernance.DeployGovernanceParams)

- **Kind**: internal
- **Source**: 8693:1541:111
- **Link**: `script/DeployGovernance.s.sol:DeployGovernance:_getGovernanceManifestJson(struct DeployGovernance.DeployGovernanceParams)`

```solidity
function _getGovernanceManifestJson(DeployGovernanceParams memory p) internal view returns (string memory) {
    return string.concat("{", string.concat(string.concat("\"constants\":", _getGovernanceDeploymentConstants(p), ","), string.concat("\"governance\":\"", address(governance).toHexString(), "\","), string.concat("\"curveUsdcBoldPool\":\"", address(curveUsdcBoldPool).toHexString(), "\","), string.concat("\"curveUsdcBoldGauge\":\"", address(curveUsdcBoldGauge).toHexString(), "\","), string.concat("\"curveUsdcBoldInitiative\":\"", address(curveUsdcBoldInitiative).toHexString(), "\","), string.concat("\"curveLusdBoldPool\":\"", address(curveLusdBoldPool).toHexString(), "\","), string.concat("\"curveLusdBoldGauge\":\"", address(curveLusdBoldGauge).toHexString(), "\","), string.concat("\"curveLusdBoldInitiative\":\"", address(curveLusdBoldInitiative).toHexString(), "\",")), string.concat(string.concat("\"defiCollectiveInitiative\":\"", defiCollectiveInitiative.toHexString(), "\","), string.concat("\"stakingV1\":\"", p.stakingV1.toHexString(), "\","), string.concat("\"LQTYToken\":\"", p.lqty.toHexString(), "\","), string.concat("\"LUSDToken\":\"", p.lusd.toHexString(), "\","), string.concat("\"initialInitiatives\":", initialInitiatives.toJSON())), "}");
}
```

### _getGovernanceDeploymentConstants(struct DeployGovernance.DeployGovernanceParams)

- **Kind**: internal
- **Source**: 7357:1330:111
- **Link**: `script/DeployGovernance.s.sol:DeployGovernance:_getGovernanceDeploymentConstants(struct DeployGovernance.DeployGovernanceParams)`

```solidity
function _getGovernanceDeploymentConstants(DeployGovernanceParams memory p) internal pure returns (string memory) {
    return string.concat("{", string.concat(string.concat("\"REGISTRATION_FEE\":\"", REGISTRATION_FEE.toString(), "\","), string.concat("\"REGISTRATION_THRESHOLD_FACTOR\":\"", REGISTRATION_THRESHOLD_FACTOR.toString(), "\","), string.concat("\"UNREGISTRATION_THRESHOLD_FACTOR\":\"", UNREGISTRATION_THRESHOLD_FACTOR.toString(), "\","), string.concat("\"UNREGISTRATION_AFTER_EPOCHS\":\"", UNREGISTRATION_AFTER_EPOCHS.toString(), "\","), string.concat("\"VOTING_THRESHOLD_FACTOR\":\"", VOTING_THRESHOLD_FACTOR.toString(), "\","), string.concat("\"MIN_CLAIM\":\"", MIN_CLAIM.toString(), "\","), string.concat("\"MIN_ACCRUAL\":\"", MIN_ACCRUAL.toString(), "\","), string.concat("\"EPOCH_START\":\"", p.epochStart.toString(), "\",")), string.concat(string.concat("\"EPOCH_DURATION\":\"", EPOCH_DURATION.toString(), "\","), string.concat("\"EPOCH_VOTING_CUTOFF\":\"", EPOCH_VOTING_CUTOFF.toString(), "\","), string.concat("\"FUNDS_SAFE\":\"", FUNDS_SAFE.toHexString(), "\"")), "}");
}
```

### toJSON(address[])

- **Kind**: internal
- **Source**: 896:440:111
- **Link**: `script/DeployGovernance.s.sol:AddressArray:toJSON(address[])`

```solidity
function toJSON(address[] memory addresses) internal pure returns (string memory) {
    if (addresses.length == 0) return "[]";
    string memory commaSeparatedStrings = addresses[0].toJSON();
    for (uint256 i = 1; i < addresses.length; ++i) {
        commaSeparatedStrings = string.concat(commaSeparatedStrings, ",", addresses[i].toJSON());
    }
    return string.concat("[", commaSeparatedStrings, "]");
}
```

### _getManifestJson(struct DeployLiquity2Script.DeploymentResult,string)

- **Kind**: internal
- **Source**: 52111:1577:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_getManifestJson(struct DeployLiquity2Script.DeploymentResult,string)`

```solidity
function _getManifestJson(DeploymentResult memory deployed, string memory _governanceManifest) internal view returns (string memory) {
    string[] memory branches = new string[](deployed.contractsArray.length);
    for (uint256 i = 0; i < branches.length; ++i) {
        branches[i] = _getBranchContractsJson(deployed.contractsArray[i]);
    }
    return string.concat("{", string.concat(string.concat("\"constants\":", _getDeploymentConstants(), ","), string.concat("\"collateralRegistry\":\"", address(deployed.collateralRegistry).toHexString(), "\","), string.concat("\"boldToken\":\"", address(deployed.boldToken).toHexString(), "\","), string.concat("\"hintHelpers\":\"", address(deployed.hintHelpers).toHexString(), "\","), string.concat("\"multiTroveGetter\":\"", address(deployed.multiTroveGetter).toHexString(), "\","), string.concat("\"debtInFrontHelper\":\"", address(deployed.debtInFrontHelper).toHexString(), "\","), string.concat("\"exchangeHelpers\":\"", address(deployed.exchangeHelpers).toHexString(), "\","), string.concat("\"exchangeHelpersV2\":\"", address(deployed.exchangeHelpersV2).toHexString(), "\",")), string.concat(string.concat("\"branches\":[", branches.join(","), "],"), string.concat("\"governance\":", _governanceManifest, "")), "}");
}
```

### _getBranchContractsJson(struct DeployLiquity2Script.LiquityContracts)

- **Kind**: internal
- **Source**: 48960:2249:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_getBranchContractsJson(struct DeployLiquity2Script.LiquityContracts)`

```solidity
function _getBranchContractsJson(LiquityContracts memory c) internal view returns (string memory) {
    return string.concat("{", string.concat(string.concat(string.concat("\"collSymbol\":\"", c.collToken.symbol(), "\","), string.concat("\"collToken\":\"", address(c.collToken).toHexString(), "\","), string.concat("\"addressesRegistry\":\"", address(c.addressesRegistry).toHexString(), "\","), string.concat("\"activePool\":\"", address(c.activePool).toHexString(), "\","), string.concat("\"borrowerOperations\":\"", address(c.borrowerOperations).toHexString(), "\","), string.concat("\"collSurplusPool\":\"", address(c.collSurplusPool).toHexString(), "\","), string.concat("\"defaultPool\":\"", address(c.defaultPool).toHexString(), "\","), string.concat("\"sortedTroves\":\"", address(c.sortedTroves).toHexString(), "\",")), string.concat(string.concat("\"stabilityPool\":\"", address(c.stabilityPool).toHexString(), "\","), string.concat("\"troveManager\":\"", address(c.troveManager).toHexString(), "\","), string.concat("\"troveNFT\":\"", address(c.troveNFT).toHexString(), "\","), string.concat("\"metadataNFT\":\"", address(c.metadataNFT).toHexString(), "\","), string.concat("\"priceFeed\":\"", address(c.priceFeed).toHexString(), "\","), string.concat("\"gasPool\":\"", address(c.gasPool).toHexString(), "\","), string.concat("\"interestRouter\":\"", address(c.interestRouter).toHexString(), "\","), string.concat("\"wethZapper\":\"", address(c.wethZapper).toHexString(), "\",")), string.concat(string.concat("\"gasCompZapper\":\"", address(c.gasCompZapper).toHexString(), "\","), string.concat("\"leverageZapper\":\"", address(c.leverageZapper).toHexString(), "\""))), "}");
}
```

### _getDeploymentConstants()

- **Kind**: internal
- **Source**: 51215:890:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:_getDeploymentConstants()`

```solidity
function _getDeploymentConstants() internal pure returns (string memory) {
    return string.concat("{", string.concat(string.concat("\"ETH_GAS_COMPENSATION\":\"", ETH_GAS_COMPENSATION.toString(), "\","), string.concat("\"INTEREST_RATE_ADJ_COOLDOWN\":\"", INTEREST_RATE_ADJ_COOLDOWN.toString(), "\","), string.concat("\"MAX_ANNUAL_INTEREST_RATE\":\"", MAX_ANNUAL_INTEREST_RATE.toString(), "\","), string.concat("\"MIN_ANNUAL_INTEREST_RATE\":\"", MIN_ANNUAL_INTEREST_RATE.toString(), "\","), string.concat("\"MIN_DEBT\":\"", MIN_DEBT.toString(), "\","), string.concat("\"SP_YIELD_SPLIT\":\"", SP_YIELD_SPLIT.toString(), "\","), string.concat("\"UPFRONT_INTEREST_PERIOD\":\"", UPFRONT_INTEREST_PERIOD.toString(), "\"")), "}");
}
```

### join(string[],string)

- **Kind**: internal
- **Source**: 4142:283:292
- **Link**: `test/Utils/StringFormatting.sol:StringFormatting:join(string[],string)`

```solidity
function join(string[] memory strs, string memory sep) internal pure returns (string memory ret) {
    if (strs.length == 0) return "";
    ret = strs[0];
    for (uint256 i = 1; i < strs.length; ++i) {
        ret = string.concat(ret, sep, strs[i]);
    }
}
```

### tapFaucet(uint256[],struct DeployLiquity2Script.LiquityContracts)

- **Kind**: internal
- **Source**: 22784:611:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:tapFaucet(uint256[],struct DeployLiquity2Script.LiquityContracts)`

```solidity
function tapFaucet(uint256[] memory accounts, LiquityContracts memory contracts) internal {
    for (uint256 i = 0; i < accounts.length; i++) {
        ERC20Faucet token = ERC20Faucet(address(contracts.collToken));
        vm.startBroadcast(accounts[i]);
        token.tap();
        vm.stopBroadcast();
        console2.log("%s.tap() => %s (balance: %s)", token.symbol(), vm.addr(accounts[i]), string.concat(formatAmount(token.balanceOf(vm.addr(accounts[i])), 18, 2), " ", token.symbol()));
    }
}
```

### log(string,string,address,string)

- **Kind**: internal
- **Source**: 38054:203:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,string,address,string)`

```solidity
function log(string memory p0, string memory p1, address p2, string memory p3) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,string,address,string)", p0, p1, p2, p3));
}
```

### formatAmount(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 48292:662:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:formatAmount(uint256,uint256,uint256)`

```solidity
function formatAmount(uint256 amount, uint256 decimals, uint256 digits) internal pure returns (string memory) {
    if (digits > decimals) {
        digits = decimals;
    }
    uint256 scaled = amount / (10 ** (decimals - digits));
    string memory whole = Strings.toString(scaled / (10 ** digits));
    if (digits == 0) {
        return whole;
    }
    string memory fractional = Strings.toString(scaled % (10 ** digits));
    for (uint256 i = bytes(fractional).length; i < digits; i++) {
        fractional = string.concat("0", fractional);
    }
    return string.concat(whole, ".", fractional);
}
```

### openDemoTroves(struct DeployLiquity2Script.DemoTroveParams[],struct DeployLiquity2Script.LiquityContracts[])

- **Kind**: internal
- **Source**: 23401:1927:112
- **Link**: `script/DeployLiquity2.s.sol:DeployLiquity2Script:openDemoTroves(struct DeployLiquity2Script.DemoTroveParams[],struct DeployLiquity2Script.LiquityContracts[])`

```solidity
function openDemoTroves(DemoTroveParams[] memory demoTroves, LiquityContracts[] memory contractsArray) internal {
    for (uint256 i = 0; i < demoTroves.length; i++) {
        console2.log("openTrove({ coll: %18e, borrow: %18e, rate: %18e%% })", demoTroves[i].coll, demoTroves[i].debt, demoTroves[i].annualInterestRate * 100);
        DemoTroveParams memory trove = demoTroves[i];
        LiquityContracts memory contracts = contractsArray[trove.collIndex];
        vm.startBroadcast(trove.owner);
        IERC20 collToken = IERC20(contracts.collToken);
        IERC20 wethToken = IERC20(contracts.addressesRegistry.WETH());
        if (collToken == wethToken) {
            wethToken.approve(address(contracts.borrowerOperations), trove.coll + ETH_GAS_COMPENSATION);
        } else {
            wethToken.approve(address(contracts.borrowerOperations), ETH_GAS_COMPENSATION);
            collToken.approve(address(contracts.borrowerOperations), trove.coll);
        }
        IBorrowerOperations(contracts.borrowerOperations).openTrove(vm.addr(trove.owner), trove.ownerIndex, trove.coll, trove.debt, 0, 0, trove.annualInterestRate, type(uint256).max, address(0), address(0), address(0));
        vm.stopBroadcast();
    }
}
```

### log(string,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 32233:193:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,uint256,uint256)`

```solidity
function log(string memory p0, uint256 p1, uint256 p2, uint256 p3) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,uint256,uint256)", p0, p1, p2, p3));
}
```

## External Calls

- **Vm::envOr(string,string)**
- **Vm::envBytes(string)**
- **Vm::envAddress(string)**
- **Vm::startBroadcast(address)**
- **Vm::envUint(string)**
- **Vm::addr(uint256)**
- **Vm::startBroadcast(uint256)**
- **Vm::envOr(string,uint256)**
- **Vm::envOr(string,bool)**
- **address::toHexString(address)**
- **Vm::computeCreate2Address(bytes32,bytes32)**
- **BoldToken::totalSupply()**
- **BoldToken::collateralRegistryAddress()**
- **BoldToken::owner()**
- **unknown::unknown**
- **Vm::writeFile(string,string)**
- **ERC20Faucet::mock_setWildcardSpender(address,bool)**
- **PriceFeedTestnet::setPrice(uint256)**
- **IPriceFeed::fetchPrice()**
- **Vm::stopBroadcast()**

## State Variable Reads

- **deployer** (`address`)
- **DEPLOYMENT_MODE_COMPLETE** (`string`)
- **DEPLOYMENT_MODE_BOLD_ONLY** (`string`)
- **DEPLOYMENT_MODE_USE_EXISTING_BOLD** (`string`)
- **SALT** (`bytes32`)
- **useTestnetPriceFeeds** (`bool`)
- **WETH_ADDRESS** (`address`)
- **USDC_ADDRESS** (`address`)
- **curveStableswapFactoryMainnet** (`contract ICurveStableswapNGFactory`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]
- **uniV3RouterMainnet** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **uniV3QuoterMainnet** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]
- **uniswapV3FactoryMainnet** (`contract IUniswapV3Factory`) [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]
- **uniV3PositionManagerMainnet** (`contract INonfungiblePositionManager`) [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]
- **balancerFactoryMainnet** (`contract IWeightedPoolFactory`) [script/Interfaces/Balancer/IWeightedPool.sol/interface_IWeightedPoolFactory.md]
- **LQTY_ADDRESS** (`address`)
- **LQTY_STAKING_ADDRESS** (`address`)
- **LUSD_ADDRESS** (`address`)
- **curveStableswapFactorySepolia** (`contract ICurveStableswapNGFactory`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]
- **uniV3RouterSepolia** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **uniV3QuoterSepolia** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]
- **uniswapV3FactorySepolia** (`contract IUniswapV3Factory`) [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]
- **uniV3PositionManagerSepolia** (`contract INonfungiblePositionManager`) [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]
- **balancerFactorySepolia** (`contract IWeightedPoolFactory`) [script/Interfaces/Balancer/IWeightedPool.sol/interface_IWeightedPoolFactory.md]
- **lqty** (`address`)
- **lusd** (`address`)
- **stakingV1** (`address`)
- **NUM_BRANCHES** (`uint256`)
- **USDC** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **UNIV3_FEE_USDC_WETH** (`uint24`)
- **UNIV3_FEE_WETH_COLL** (`uint24`)
- **curveStableswapFactory** (`contract ICurveStableswapNGFactory`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **_SYMBOLS** (`bytes16`)
- **WSTETH_ADDRESS** (`address`)
- **RETH_ADDRESS** (`address`)
- **OTHER_TOKEN_INDEX** (`uint128`)
- **BOLD_TOKEN_INDEX** (`uint128`)
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]
- **REGISTRATION_FEE** (`uint128`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint128`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint128`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint16`)
- **VOTING_THRESHOLD_FACTOR** (`uint128`)
- **MIN_CLAIM** (`uint88`)
- **MIN_ACCRUAL** (`uint88`)
- **EPOCH_DURATION** (`uint32`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]
- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)
- **ETH_ORACLE_ADDRESS** (`address`)
- **ETH_USD_STALENESS_THRESHOLD** (`uint256`)
- **STETH_ORACLE_ADDRESS** (`address`)
- **STETH_USD_STALENESS_THRESHOLD** (`uint256`)
- **RETH_ORACLE_ADDRESS** (`address`)
- **RETH_ETH_STALENESS_THRESHOLD** (`uint256`)
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **balancerVault** (`contract IVault`) [script/Interfaces/Balancer/IVault.sol/interface_IVault.md]
- **initialInitiatives** (`address[]`)
- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]
- **curveUsdcBoldPool** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveLusdBoldPool** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveUsdcBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **curveLusdBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **DEFI_COLLECTIVE_GRANTS_ADDRESS** (`address`)
- **CRV** (`address`)
- **DURATION** (`uint256`)
- **LUSD** (`address`)
- **FUNDS_SAFE** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **curveUsdcBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **curveLusdBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **defiCollectiveInitiative** (`address`)

## State Variable Writes

- **SALT** (`bytes32`)
- **deployer** (`address`)
- **useTestnetPriceFeeds** (`bool`)
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **USDC** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **curveStableswapFactory** (`contract ICurveStableswapNGFactory`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]
- **uniswapV3Factory** (`contract IUniswapV3Factory`) [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]
- **uniV3PositionManager** (`contract INonfungiblePositionManager`) [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]
- **balancerFactory** (`contract IWeightedPoolFactory`) [script/Interfaces/Balancer/IWeightedPool.sol/interface_IWeightedPoolFactory.md]
- **lqty** (`address`)
- **stakingV1** (`address`)
- **lusd** (`address`)
- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)
- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]
- **lastTroveIndex** (`uint256`)
- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]
- **curveUsdcBoldPool** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveLusdBoldPool** (`contract ICurveStableSwapNG`) [test/Interfaces/Curve/ICurveStableSwapNG.sol/interface_ICurveStableSwapNG.md]
- **curveUsdcBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **curveUsdcBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **curveLusdBoldGauge** (`contract ILiquidityGaugeV6`) [test/Interfaces/Curve/ILiquidityGaugeV6.sol/interface_ILiquidityGaugeV6.md]
- **curveLusdBoldInitiative** (`contract CurveV2GaugeRewards`) [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **initialInitiatives** (`address[]`)
- **defiCollectiveInitiative** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeployLiquity2Script.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1)
  │   💬 Args: [block.timestamp]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 3)
  │   💬 Args: [deploymentMode, DEPLOYMENT_MODE_USE_EXISTING_BOLD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 4)
  │   💬 Args: [deploymentMode, DEPLOYMENT_MODE_BOLD_ONLY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 5)
  │   💬 Args: [deploymentMode, DEPLOYMENT_MODE_COMPLETE]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown._latestUTCMidnightBetweenWednesdayAndThursday() (NodeID: 6)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 7)
  │   💬 Args: ["Deployer:               ", deployer.toHexString()]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 8)
  │     💬 Args: [string.concat(a, b)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 11)
  │   💬 Args: ["Deployer balance:       ", deployer.balance.decimal()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 15)
  │ │   💬 Args: [deployer.balance]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 16)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 17)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 18)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 19)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 20)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 21)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 22)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 23)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 24)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 25)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 26)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 27)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 28)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 29)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 30)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 31)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 32)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 33)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 34)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 35)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 36)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 37)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 12)
  │     💬 Args: [string.concat(a, b)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 13)
  │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 14)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 38)
  │   💬 Args: ["Deployment mode:        ", deploymentMode]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 39)
  │     💬 Args: [string.concat(a, b)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 40)
  │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 41)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log(string,string,string,string,string) (NodeID: 42)
  │   💬 Args: ["CREATE2 salt:           ", "keccak256(bytes(\"", saltStr, "\")) = ", uint256(SALT).toHexString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toHexString(uint256) (NodeID: 46)
  │ │   💬 Args: [uint256(SALT)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 47)
  │ │     💬 Args: [value, Math.log256(value) + 1]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log256(uint256) (NodeID: 48)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 43)
  │     💬 Args: [string.concat(a, b, c, d, e)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 44)
  │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 45)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 49)
  │   💬 Args: ["Governance epoch start: ", epochStart.toString()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 53)
  │ │   💬 Args: [epochStart]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 54)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 50)
  │     💬 Args: [string.concat(a, b)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 51)
  │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 52)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Logging._log(string,string) (NodeID: 55)
  │   💬 Args: ["Use testnet PriceFeeds: ", useTestnetPriceFeeds ? "yes" : "no"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 56)
  │     💬 Args: [string.concat(a, b)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 57)
  │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 58)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 59)
  │   💬 Args: [deploymentMode, DEPLOYMENT_MODE_USE_EXISTING_BOLD]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StringEquality.eq(string,string) (NodeID: 60)
  │   💬 Args: [deploymentMode, DEPLOYMENT_MODE_BOLD_ONLY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script._deployAndConnectContracts(struct DeployLiquity2Script.TroveManagerParams[],string[],string[],struct DeployGovernance.DeployGovernanceParams) (NodeID: 61)
  │   💬 Args: [troveManagerParamsArray, collNames, collSymbols, deployGovernanceParams]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DeployLiquity2Script._deployCurvePool(contract IBoldToken,contract IERC20Metadata) (NodeID: 62)
  │ │   💬 Args: [r.boldToken, USDC]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DeployLiquity2Script._deployAddressesRegistry(struct DeployLiquity2Script.TroveManagerParams) (NodeID: 63)
  │ │   💬 Args: [troveManagerParamsArray[vars.i]]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 64)
  │ │     💬 Args: [type(TroveManager).creationCode, address(addressesRegistry)]
  │ │     👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: DeployLiquity2Script._deployAndConnectCollateralContracts(contract IERC20Metadata,contract IBoldToken,contract ICollateralRegistry,contract ICurveStableswapNGPool,contract IAddressesRegistry,address,contract IHintHelpers,contract IMultiTroveGetter,address) (NodeID: 65)
  │     💬 Args: [vars.collaterals[vars.i], r.boldToken, r.collateralRegistry, r.usdcCurvePool, vars.addressesRegistries[vars.i], address(vars.troveManagers[vars.i]), r.hintHelpers, r.multiTroveGetter, computeGovernanceAddress(_deployGovernanceParams)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: DeployGovernance.computeGovernanceAddress(struct DeployGovernance.DeployGovernanceParams) (NodeID: 83)
  │   │   💬 Args: [_deployGovernanceParams]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: DeployGovernance.computeGovernanceAddressAndConfig(struct DeployGovernance.DeployGovernanceParams) (NodeID: 84)
  │   │     💬 Args: [p]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MetadataDeployment.deployMetadata(bytes32) (NodeID: 66)
  │   │   💬 Args: [SALT]
  │   │   👁️  Def: public
  │   │ ├─ [4] ⚙️ FUNCTION: MetadataDeployment._loadFiles() (NodeID: 67)
  │   │ │   💬 Args: [no args]
  │   │ │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: MetadataDeployment._storeFile() (NodeID: 68)
  │   │ │   💬 Args: [no args]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: SSTORE2.write(bytes) (NodeID: 69)
  │   │ │     💬 Args: [data]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: MetadataDeployment._deployFixedAssetReader(bytes32) (NodeID: 70)
  │   │     💬 Args: [_salt]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 71)
  │   │   💬 Args: [type(MetadataNFT).creationCode, address(initializedFixedAssetReader)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 72)
  │   │   💬 Args: [type(BorrowerOperations).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 73)
  │   │   💬 Args: [type(TroveNFT).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 74)
  │   │   💬 Args: [type(StabilityPool).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 75)
  │   │   💬 Args: [type(ActivePool).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 76)
  │   │   💬 Args: [type(DefaultPool).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 77)
  │   │   💬 Args: [type(GasPool).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 78)
  │   │   💬 Args: [type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 79)
  │   │   💬 Args: [type(SortedTroves).creationCode, address(contracts.addressesRegistry)]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script._deployPriceFeed(address,address) (NodeID: 80)
  │   │   💬 Args: [address(_collToken), addresses.borrowerOperations]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: DeployLiquity2Script._deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract ICurveStableswapNGPool) (NodeID: 81)
  │       💬 Args: [contracts.addressesRegistry, contracts.collToken, _boldToken, _usdcCurvePool]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: DeployLiquity2Script._deployHybridLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool) (NodeID: 82)
  │         💬 Args: [_addressesRegistry, flashLoanProvider, hybridExchange, lst]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script._provideFlashloanLiquidity(contract ERC20Faucet,contract ERC20Faucet) (NodeID: 85)
  │   💬 Args: [ERC20Faucet(address(deployed.contractsArray[i].collToken)), monkeyBalls]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script._provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24) (NodeID: 86)
  │   💬 Args: [ERC20Faucet(address(USDC)), ERC20Faucet(address(WETH)), token1Amount, price, UNIV3_FEE_USDC_WETH]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: UniPriceConverter.priceToSqrtPriceX96(uint256) (NodeID: 87)
  │     💬 Args: [vars.price]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 88)
  │   │   💬 Args: [_price / DECIMAL_PRECISION]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 89)
  │   │ │   💬 Args: [a]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 90)
  │   │     💬 Args: [result, a / result]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 91)
  │       💬 Args: [(_price << 192) / DECIMAL_PRECISION]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 92)
  │     │   💬 Args: [a]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 93)
  │         💬 Args: [result, a / result]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script._provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24) (NodeID: 94)
  │   💬 Args: [ERC20Faucet(address(WETH)), ERC20Faucet(address(deployed.contractsArray[i].collToken)), token1Amount, 1 ether, UNIV3_FEE_WETH_COLL]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: UniPriceConverter.priceToSqrtPriceX96(uint256) (NodeID: 95)
  │     💬 Args: [vars.price]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 96)
  │   │   💬 Args: [_price / DECIMAL_PRECISION]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 97)
  │   │ │   💬 Args: [a]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 98)
  │   │     💬 Args: [result, a / result]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 99)
  │       💬 Args: [(_price << 192) / DECIMAL_PRECISION]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 100)
  │     │   💬 Args: [a]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 101)
  │         💬 Args: [result, a / result]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script._provideCurveLiquidity(contract IBoldToken,struct DeployLiquity2Script.LiquityContracts) (NodeID: 102)
  │   💬 Args: [deployed.boldToken, deployed.contractsArray[0]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: DeployLiquity2Script._mintBold(uint256,uint256,struct DeployLiquity2Script.LiquityContracts) (NodeID: 103)
  │     💬 Args: [boldAmount, price, _contracts]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script._deployCurvePool(contract IBoldToken,contract IERC20Metadata) (NodeID: 104)
  │   💬 Args: [deployed.boldToken, IERC20Metadata(LUSD_ADDRESS)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployGovernance.deployGovernance(struct DeployGovernance.DeployGovernanceParams,address,address,address) (NodeID: 105)
  │   💬 Args: [deployGovernanceParams, address(curveStableswapFactory), address(deployed.usdcCurvePool), address(lusdCurvePool)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DeployGovernance.computeGovernanceAddressAndConfig(struct DeployGovernance.DeployGovernanceParams) (NodeID: 106)
  │ │   💬 Args: [p]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DeployGovernance.deployCurveV2GaugeRewards(contract IGovernance,address,address,contract ICurveStableSwapNG) (NodeID: 107)
  │ │   💬 Args: [governance, p.bold, _curveFactoryAddress, curveUsdcBoldPool]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: DeployGovernance.deployCurveV2GaugeRewards(contract IGovernance,address,address,contract ICurveStableSwapNG) (NodeID: 108)
  │ │   💬 Args: [governance, p.bold, _curveFactoryAddress, curveLusdBoldPool]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 109)
  │ │   💬 Args: ["initiative1"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 110)
  │ │     💬 Args: [name]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 111)
  │ │   💬 Args: ["initiative2"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 112)
  │ │     💬 Args: [name]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 113)
  │ │   💬 Args: ["initiative3"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 114)
  │ │     💬 Args: [name]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: DeployGovernance._getGovernanceManifestJson(struct DeployGovernance.DeployGovernanceParams) (NodeID: 115)
  │     💬 Args: [p]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: DeployGovernance._getGovernanceDeploymentConstants(struct DeployGovernance.DeployGovernanceParams) (NodeID: 116)
  │   │   💬 Args: [p]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 117)
  │   │ │   💬 Args: [REGISTRATION_FEE]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 118)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 119)
  │   │ │   💬 Args: [REGISTRATION_THRESHOLD_FACTOR]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 120)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 121)
  │   │ │   💬 Args: [UNREGISTRATION_THRESHOLD_FACTOR]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 122)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 123)
  │   │ │   💬 Args: [UNREGISTRATION_AFTER_EPOCHS]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 124)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 125)
  │   │ │   💬 Args: [VOTING_THRESHOLD_FACTOR]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 126)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 127)
  │   │ │   💬 Args: [MIN_CLAIM]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 128)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 129)
  │   │ │   💬 Args: [MIN_ACCRUAL]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 130)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 131)
  │   │ │   💬 Args: [p.epochStart]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 132)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 133)
  │   │ │   💬 Args: [EPOCH_DURATION]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 134)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 135)
  │   │     💬 Args: [EPOCH_VOTING_CUTOFF]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 136)
  │   │       💬 Args: [value]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: AddressArray.toJSON(address[]) (NodeID: 137)
  │       💬 Args: [initialInitiatives]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployGovernance.computeGovernanceAddress(struct DeployGovernance.DeployGovernanceParams) (NodeID: 138)
  │   💬 Args: [deployGovernanceParams]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: DeployGovernance.computeGovernanceAddressAndConfig(struct DeployGovernance.DeployGovernanceParams) (NodeID: 139)
  │     💬 Args: [p]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script._getManifestJson(struct DeployLiquity2Script.DeploymentResult,string) (NodeID: 140)
  │   💬 Args: [deployed, governanceManifest]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DeployLiquity2Script._getBranchContractsJson(struct DeployLiquity2Script.LiquityContracts) (NodeID: 141)
  │ │   💬 Args: [deployed.contractsArray[i]]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: DeployLiquity2Script._getDeploymentConstants() (NodeID: 142)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 143)
  │ │ │   💬 Args: [ETH_GAS_COMPENSATION]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 144)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 145)
  │ │ │   💬 Args: [INTEREST_RATE_ADJ_COOLDOWN]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 146)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 147)
  │ │ │   💬 Args: [MAX_ANNUAL_INTEREST_RATE]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 148)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 149)
  │ │ │   💬 Args: [MIN_ANNUAL_INTEREST_RATE]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 150)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 151)
  │ │ │   💬 Args: [MIN_DEBT]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 152)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 153)
  │ │ │   💬 Args: [SP_YIELD_SPLIT]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 154)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 155)
  │ │     💬 Args: [UPFRONT_INTEREST_PERIOD]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 156)
  │ │       💬 Args: [value]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StringFormatting.join(string[],string) (NodeID: 157)
  │     💬 Args: [branches, ","]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeployLiquity2Script.tapFaucet(uint256[],struct DeployLiquity2Script.LiquityContracts) (NodeID: 158)
  │   💬 Args: [demoAccounts, deployed.contractsArray[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string,string,address,string) (NodeID: 159)
  │     💬 Args: ["%s.tap() => %s (balance: %s)", token.symbol(), vm.addr(accounts[i]), string.concat(formatAmount(token.balanceOf(vm.addr(accounts[i])), 18, 2), " ", token.symbol())]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: DeployLiquity2Script.formatAmount(uint256,uint256,uint256) (NodeID: 162)
  │   │   💬 Args: [token.balanceOf(vm.addr(accounts[i])), 18, 2]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 163)
  │   │ │   💬 Args: [scaled / (10 ** digits)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 164)
  │   │ │     💬 Args: [value]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 165)
  │   │     💬 Args: [scaled % (10 ** digits)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 166)
  │   │       💬 Args: [value]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 160)
  │       💬 Args: [abi.encodeWithSignature("log(string,string,address,string)", p0, p1, p2, p3)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 161)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: DeployLiquity2Script.openDemoTroves(struct DeployLiquity2Script.DemoTroveParams[],struct DeployLiquity2Script.LiquityContracts[]) (NodeID: 167)
      💬 Args: [demoTroves, deployed.contractsArray]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console.log(string,uint256,uint256,uint256) (NodeID: 168)
        💬 Args: ["openTrove({ coll: %18e, borrow: %18e, rate: %18e%% })", demoTroves[i].coll, demoTroves[i].debt, demoTroves[i].annualInterestRate * 100]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 169)
          💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256,uint256)", p0, p1, p2, p3)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 170)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```
