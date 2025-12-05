# Function: deployAndConnectContractsMainnet(struct TestDeployer.TroveManagerParams[])

**Contract**: [test/TestContracts/Deployment.t.sol/contract_TestDeployer.md]

## Metadata

- **Contract**: TestDeployer
- **Signature**: `deployAndConnectContractsMainnet(struct TestDeployer.TroveManagerParams[])`
- **Visibility**: public
- **Source Range**: 20372:4065:260

## Implementation

```solidity
function deployAndConnectContractsMainnet(TroveManagerParams[] memory _troveManagerParamsArray) public returns (DeploymentResultMainnet memory result) {
    DeploymentVarsMainnet memory vars;
    result.externalAddresses.ETHOracle = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
    result.externalAddresses.RETHOracle = 0x536218f9E9Eb48863970252233c8F271f554C2d0;
    result.externalAddresses.STETHOracle = 0xCfE54B5cD566aB89272946F602D76Ea879CAb4a8;
    result.externalAddresses.WSTETHToken = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0;
    result.externalAddresses.RETHToken = 0xae78736Cd615f374D3085123A210448E74Fc6393;
    vars.oracleParams.ethUsdStalenessThreshold = _24_HOURS;
    vars.oracleParams.stEthUsdStalenessThreshold = _24_HOURS;
    vars.oracleParams.rEthEthStalenessThreshold = _48_HOURS;
    vars.numCollaterals = 3;
    result.contractsArray = new LiquityContracts[](vars.numCollaterals);
    result.zappersArray = new Zappers[](vars.numCollaterals);
    vars.collaterals = new IERC20Metadata[](vars.numCollaterals);
    vars.addressesRegistries = new IAddressesRegistry[](vars.numCollaterals);
    vars.troveManagers = new ITroveManager[](vars.numCollaterals);
    address troveManagerAddress;
    vars.bytecode = abi.encodePacked(type(BoldToken).creationCode, abi.encode(address(this)));
    vars.boldTokenAddress = getAddress(address(this), vars.bytecode, SALT);
    result.boldToken = new BoldToken{salt: SALT}(address(this));
    assert(address(result.boldToken) == vars.boldTokenAddress);
    IWETH WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    vars.collaterals[0] = WETH;
    (vars.addressesRegistries[0], troveManagerAddress) = _deployAddressesRegistryMainnet(_troveManagerParamsArray[0]);
    vars.troveManagers[0] = ITroveManager(troveManagerAddress);
    vars.collaterals[1] = IERC20Metadata(0xae78736Cd615f374D3085123A210448E74Fc6393);
    (vars.addressesRegistries[1], troveManagerAddress) = _deployAddressesRegistryMainnet(_troveManagerParamsArray[1]);
    vars.troveManagers[1] = ITroveManager(troveManagerAddress);
    vars.collaterals[2] = IERC20Metadata(0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0);
    (vars.addressesRegistries[2], troveManagerAddress) = _deployAddressesRegistryMainnet(_troveManagerParamsArray[2]);
    vars.troveManagers[2] = ITroveManager(troveManagerAddress);
    result.collateralRegistry = new CollateralRegistryTester(result.boldToken, vars.collaterals, vars.troveManagers);
    result.hintHelpers = new HintHelpers(result.collateralRegistry);
    result.multiTroveGetter = new MultiTroveGetter(result.collateralRegistry);
    ICurveStableswapNGPool usdcCurvePool = _deployCurveBoldUsdcPool(result.boldToken, true);
    for (vars.i = 0; vars.i < vars.numCollaterals; vars.i++) {
        DeploymentParamsMainnet memory params;
        params.branch = vars.i;
        params.collToken = vars.collaterals[vars.i];
        params.boldToken = result.boldToken;
        params.collateralRegistry = result.collateralRegistry;
        params.weth = WETH;
        params.addressesRegistry = vars.addressesRegistries[vars.i];
        params.troveManagerAddress = address(vars.troveManagers[vars.i]);
        params.hintHelpers = result.hintHelpers;
        params.multiTroveGetter = result.multiTroveGetter;
        params.usdcCurvePool = usdcCurvePool;
        (result.contractsArray[vars.i], result.zappersArray[vars.i]) = _deployAndConnectCollateralContractsMainnet(params, result.externalAddresses, vars.oracleParams);
    }
    result.boldToken.setCollateralRegistry(address(result.collateralRegistry));
}
```

## Related Implementations

### getAddress(address,bytes,bytes32)

- **Kind**: internal
- **Source**: 7080:325:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:getAddress(address,bytes,bytes32)`

```solidity
function getAddress(address _deployer, bytes memory _bytecode, bytes32 _salt) public pure returns (address) {
    bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), _deployer, _salt, keccak256(_bytecode)));
    return address(uint160(uint256(hash)));
}
```

### _deployAddressesRegistryMainnet(struct TestDeployer.TroveManagerParams)

- **Kind**: internal
- **Source**: 24443:756:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployAddressesRegistryMainnet(struct TestDeployer.TroveManagerParams)`

```solidity
function _deployAddressesRegistryMainnet(TroveManagerParams memory _troveManagerParams) internal returns (IAddressesRegistry, address) {
    IAddressesRegistry addressesRegistry = new AddressesRegistry(address(this), _troveManagerParams.CCR, _troveManagerParams.MCR, _troveManagerParams.BCR, _troveManagerParams.SCR, _troveManagerParams.LIQUIDATION_PENALTY_SP, _troveManagerParams.LIQUIDATION_PENALTY_REDISTRIBUTION);
    address troveManagerAddress = getAddress(address(this), getBytecode(type(TroveManager).creationCode, address(addressesRegistry)), SALT);
    return (addressesRegistry, troveManagerAddress);
}
```

### getBytecode(bytes,address)

- **Kind**: internal
- **Source**: 6875:199:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:getBytecode(bytes,address)`

```solidity
function getBytecode(bytes memory _creationCode, address _addressesRegistry) public pure returns (bytes memory) {
    return abi.encodePacked(_creationCode, abi.encode(_addressesRegistry));
}
```

### _deployCurveBoldUsdcPool(contract IBoldToken,bool)

- **Kind**: internal
- **Source**: 38753:1451:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployCurveBoldUsdcPool(contract IBoldToken,bool)`

```solidity
function _deployCurveBoldUsdcPool(IBoldToken _boldToken, bool _mainnet) internal returns (ICurveStableswapNGPool) {
    if (!_mainnet) return ICurveStableswapNGPool(address(0));
    address[] memory coins = new address[](2);
    coins[BOLD_TOKEN_INDEX] = address(_boldToken);
    coins[USDC_INDEX] = address(USDC);
    uint8[] memory assetTypes = new uint8[](2);
    bytes4[] memory methodIds = new bytes4[](2);
    address[] memory oracles = new address[](2);
    ICurveStableswapNGPool curvePool = curveStableswapFactory.deploy_plain_pool("USDC-BOLD", "USDCBOLD", coins, 4000, 1000000, 20000000000, 865, 0, assetTypes, methodIds, oracles);
    return curvePool;
}
```

### _deployAndConnectCollateralContractsMainnet(struct TestDeployer.DeploymentParamsMainnet,struct TestDeployer.ExternalAddresses,struct TestDeployer.OracleParams)

- **Kind**: internal
- **Source**: 25205:5751:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployAndConnectCollateralContractsMainnet(struct TestDeployer.DeploymentParamsMainnet,struct TestDeployer.ExternalAddresses,struct TestDeployer.OracleParams)`

```solidity
function _deployAndConnectCollateralContractsMainnet(DeploymentParamsMainnet memory _params, ExternalAddresses memory _externalAddresses, OracleParams memory _oracleParams) internal returns (LiquityContracts memory contracts, Zappers memory zappers) {
    LiquityContractAddresses memory addresses;
    contracts.collToken = _params.collToken;
    contracts.interestRouter = new MockInterestRouter();
    contracts.addressesRegistry = _params.addressesRegistry;
    MetadataNFT metadataNFT = deployMetadata(SALT);
    addresses.metadataNFT = getAddress(address(this), getBytecode(type(MetadataNFT).creationCode, address(initializedFixedAssetReader)), SALT);
    assert(address(metadataNFT) == addresses.metadataNFT);
    addresses.borrowerOperations = getAddress(address(this), getBytecode(type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.troveManager = _params.troveManagerAddress;
    addresses.troveNFT = getAddress(address(this), getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.stabilityPool = getAddress(address(this), getBytecode(type(StabilityPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.activePool = getAddress(address(this), getBytecode(type(ActivePool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.defaultPool = getAddress(address(this), getBytecode(type(DefaultPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.gasPool = getAddress(address(this), getBytecode(type(GasPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.collSurplusPool = getAddress(address(this), getBytecode(type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.sortedTroves = getAddress(address(this), getBytecode(type(SortedTroves).creationCode, address(contracts.addressesRegistry)), SALT);
    contracts.priceFeed = _deployPriceFeed(_params.branch, _externalAddresses, _oracleParams, addresses.borrowerOperations);
    IAddressesRegistry.AddressVars memory addressVars = IAddressesRegistry.AddressVars({collToken: _params.collToken, borrowerOperations: IBorrowerOperations(addresses.borrowerOperations), troveManager: ITroveManager(addresses.troveManager), troveNFT: ITroveNFT(addresses.troveNFT), metadataNFT: IMetadataNFT(addresses.metadataNFT), stabilityPool: IStabilityPool(addresses.stabilityPool), priceFeed: contracts.priceFeed, activePool: IActivePool(addresses.activePool), defaultPool: IDefaultPool(addresses.defaultPool), gasPoolAddress: addresses.gasPool, collSurplusPool: ICollSurplusPool(addresses.collSurplusPool), sortedTroves: ISortedTroves(addresses.sortedTroves), interestRouter: contracts.interestRouter, hintHelpers: _params.hintHelpers, multiTroveGetter: _params.multiTroveGetter, collateralRegistry: _params.collateralRegistry, boldToken: _params.boldToken, WETH: _params.weth});
    contracts.addressesRegistry.setAddresses(addressVars);
    contracts.borrowerOperations = new BorrowerOperationsTester{salt: SALT}(contracts.addressesRegistry);
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
    _params.boldToken.setBranchAddresses(address(contracts.troveManager), address(contracts.stabilityPool), address(contracts.borrowerOperations), address(contracts.activePool));
    _deployZappers(contracts.addressesRegistry, contracts.collToken, _params.boldToken, _params.weth, contracts.priceFeed, _params.usdcCurvePool, true, zappers);
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

### _deployPriceFeed(uint256,struct TestDeployer.ExternalAddresses,struct TestDeployer.OracleParams,address)

- **Kind**: internal
- **Source**: 30962:1269:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployPriceFeed(uint256,struct TestDeployer.ExternalAddresses,struct TestDeployer.OracleParams,address)`

```solidity
function _deployPriceFeed(uint256 _branch, ExternalAddresses memory _externalAddresses, OracleParams memory _oracleParams, address _borrowerOperationsAddress) internal returns (IPriceFeed) {
    if (_branch == 0) {
        return new WETHPriceFeed(_externalAddresses.ETHOracle, _oracleParams.ethUsdStalenessThreshold, _borrowerOperationsAddress);
    } else if (_branch == 1) {
        return new RETHPriceFeed(_externalAddresses.ETHOracle, _externalAddresses.RETHOracle, _externalAddresses.RETHToken, _oracleParams.ethUsdStalenessThreshold, _oracleParams.rEthEthStalenessThreshold, _borrowerOperationsAddress);
    }
    return new WSTETHPriceFeed(_externalAddresses.ETHOracle, _externalAddresses.STETHOracle, _externalAddresses.WSTETHToken, _oracleParams.ethUsdStalenessThreshold, _oracleParams.stEthUsdStalenessThreshold, _borrowerOperationsAddress);
}
```

### _deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IWETH,contract IPriceFeed,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers)

- **Kind**: internal
- **Source**: 32237:1204:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IWETH,contract IPriceFeed,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers)`

```solidity
function _deployZappers(IAddressesRegistry _addressesRegistry, IERC20 _collToken, IBoldToken _boldToken, IWETH _weth, IPriceFeed _priceFeed, ICurveStableswapNGPool _usdcCurvePool, bool _mainnet, Zappers memory zappers) internal {
    IFlashLoanProvider flashLoanProvider = new BalancerFlashLoan();
    IExchange curveExchange = _deployCurveExchange(_collToken, _boldToken, _priceFeed, _mainnet);
    bool lst = _collToken != _weth;
    if (lst) {
        zappers.gasCompZapper = new GasCompZapper(_addressesRegistry, flashLoanProvider, curveExchange);
    } else {
        zappers.wethZapper = new WETHZapper(_addressesRegistry, flashLoanProvider, curveExchange);
    }
    if (_mainnet) {
        _deployLeverageZappers(_addressesRegistry, _collToken, _boldToken, _priceFeed, flashLoanProvider, curveExchange, _usdcCurvePool, lst, zappers);
    }
}
```

### _deployCurveExchange(contract IERC20,contract IBoldToken,contract IPriceFeed,bool)

- **Kind**: internal
- **Source**: 33447:1143:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployCurveExchange(contract IERC20,contract IBoldToken,contract IPriceFeed,bool)`

```solidity
function _deployCurveExchange(IERC20 _collToken, IBoldToken _boldToken, IPriceFeed _priceFeed, bool _mainnet) internal returns (IExchange) {
    if (!_mainnet) return new CurveExchange(_collToken, _boldToken, ICurvePool(address(0)), 1, 0);
    (uint256 price, ) = _priceFeed.fetchPrice();
    address[2] memory coins;
    coins[BOLD_TOKEN_INDEX] = address(_boldToken);
    coins[COLL_TOKEN_INDEX] = address(_collToken);
    ICurvePool curvePool = curveFactory.deploy_pool("LST-Bold pool", "LBLD", coins, 0, 400000, 145000000000000, 26000000, 45000000, 230000000000000, 2000000000000, 146000000000000, 600, price);
    IExchange curveExchange = new CurveExchange(_collToken, _boldToken, curvePool, 1, 0);
    return curveExchange;
}
```

### _deployLeverageZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,contract IExchange,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers)

- **Kind**: internal
- **Source**: 34596:855:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployLeverageZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,contract IExchange,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers)`

```solidity
function _deployLeverageZappers(IAddressesRegistry _addressesRegistry, IERC20 _collToken, IBoldToken _boldToken, IPriceFeed _priceFeed, IFlashLoanProvider _flashLoanProvider, IExchange _curveExchange, ICurveStableswapNGPool _usdcCurvePool, bool _lst, Zappers memory zappers) internal {
    zappers.leverageZapperCurve = _deployCurveLeverageZapper(_addressesRegistry, _flashLoanProvider, _curveExchange, _lst);
    zappers.leverageZapperUniV3 = _deployUniV3LeverageZapper(_addressesRegistry, _collToken, _boldToken, _priceFeed, _flashLoanProvider, _lst);
    zappers.leverageZapperHybrid = _deployHybridLeverageZapper(_addressesRegistry, _collToken, _boldToken, _flashLoanProvider, _usdcCurvePool, _lst);
}
```

### _deployCurveLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool)

- **Kind**: internal
- **Source**: 35457:587:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployCurveLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool)`

```solidity
function _deployCurveLeverageZapper(IAddressesRegistry _addressesRegistry, IFlashLoanProvider _flashLoanProvider, IExchange _curveExchange, bool _lst) internal returns (ILeverageZapper) {
    ILeverageZapper leverageZapperCurve;
    if (_lst) {
        leverageZapperCurve = new LeverageLSTZapper(_addressesRegistry, _flashLoanProvider, _curveExchange);
    } else {
        leverageZapperCurve = new LeverageWETHZapper(_addressesRegistry, _flashLoanProvider, _curveExchange);
    }
    return leverageZapperCurve;
}
```

### _deployUniV3LeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,bool)

- **Kind**: internal
- **Source**: 36163:1524:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployUniV3LeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,bool)`

```solidity
function _deployUniV3LeverageZapper(IAddressesRegistry _addressesRegistry, IERC20 _collToken, IBoldToken _boldToken, IPriceFeed _priceFeed, IFlashLoanProvider _flashLoanProvider, bool _lst) internal returns (ILeverageZapper) {
    UniV3Vars memory vars;
    vars.uniV3Exchange = new UniV3Exchange(_collToken, _boldToken, UNIV3_FEE, uniV3Router);
    ILeverageZapper leverageZapperUniV3;
    if (_lst) {
        leverageZapperUniV3 = new LeverageLSTZapper(_addressesRegistry, _flashLoanProvider, vars.uniV3Exchange);
    } else {
        leverageZapperUniV3 = new LeverageWETHZapper(_addressesRegistry, _flashLoanProvider, vars.uniV3Exchange);
    }
    (vars.price, ) = _priceFeed.fetchPrice();
    if (address(_boldToken) < address(_collToken)) {
        vars.tokens[0] = address(_boldToken);
        vars.tokens[1] = address(_collToken);
    } else {
        vars.tokens[0] = address(_collToken);
        vars.tokens[1] = address(_boldToken);
    }
    uniV3PositionManager.createAndInitializePoolIfNecessary(vars.tokens[0], vars.tokens[1], UNIV3_FEE, UniV3Exchange(address(vars.uniV3Exchange)).priceToSqrtPrice(_boldToken, _collToken, vars.price));
    return leverageZapperUniV3;
}
```

### _deployHybridLeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IFlashLoanProvider,contract ICurveStableswapNGPool,bool)

- **Kind**: internal
- **Source**: 37693:1054:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployHybridLeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IFlashLoanProvider,contract ICurveStableswapNGPool,bool)`

```solidity
function _deployHybridLeverageZapper(IAddressesRegistry _addressesRegistry, IERC20 _collToken, IBoldToken _boldToken, IFlashLoanProvider _flashLoanProvider, ICurveStableswapNGPool _usdcCurvePool, bool _lst) internal returns (ILeverageZapper) {
    IExchange hybridExchange = new HybridCurveUniV3Exchange(_collToken, _boldToken, USDC, WETH_MAINNET, _usdcCurvePool, USDC_INDEX, BOLD_TOKEN_INDEX, UNIV3_FEE_USDC_WETH, UNIV3_FEE_WETH_COLL, uniV3Router);
    ILeverageZapper leverageZapperHybrid;
    if (_lst) {
        leverageZapperHybrid = new LeverageLSTZapper(_addressesRegistry, _flashLoanProvider, hybridExchange);
    } else {
        leverageZapperHybrid = new LeverageWETHZapper(_addressesRegistry, _flashLoanProvider, hybridExchange);
    }
    return leverageZapperHybrid;
}
```

## External Calls

- **unknown::unknown**
- **IBoldToken::setCollateralRegistry(address)**

## State Variable Reads

- **SALT** (`bytes32`)
- **BOLD_TOKEN_INDEX** (`uint128`)
- **USDC_INDEX** (`uint128`)
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **curveStableswapFactory** (`contract ICurveStableswapNGFactory`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol/interface_ICurveStableswapNGFactory.md]
- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]
- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)
- **COLL_TOKEN_INDEX** (`uint256`)
- **curveFactory** (`contract ICurveFactory`) [src/Zappers/Modules/Exchanges/Curve/ICurveFactory.sol/interface_ICurveFactory.md]
- **UNIV3_FEE** (`uint24`)
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **uniV3PositionManager** (`contract INonfungiblePositionManager`) [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]
- **WETH_MAINNET** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **UNIV3_FEE_USDC_WETH** (`uint24`)
- **UNIV3_FEE_WETH_COLL** (`uint24`)

## State Variable Writes

- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)
- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestDeployer.deployAndConnectContractsMainnet(struct TestDeployer.TroveManagerParams[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 1)
  │   💬 Args: [address(this), vars.bytecode, SALT]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TestDeployer._deployAddressesRegistryMainnet(struct TestDeployer.TroveManagerParams) (NodeID: 2)
  │   💬 Args: [_troveManagerParamsArray[0]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 3)
  │     💬 Args: [address(this), getBytecode(type(TroveManager).creationCode, address(addressesRegistry)), SALT]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 4)
  │       💬 Args: [type(TroveManager).creationCode, address(addressesRegistry)]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TestDeployer._deployAddressesRegistryMainnet(struct TestDeployer.TroveManagerParams) (NodeID: 5)
  │   💬 Args: [_troveManagerParamsArray[1]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 6)
  │     💬 Args: [address(this), getBytecode(type(TroveManager).creationCode, address(addressesRegistry)), SALT]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 7)
  │       💬 Args: [type(TroveManager).creationCode, address(addressesRegistry)]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TestDeployer._deployAddressesRegistryMainnet(struct TestDeployer.TroveManagerParams) (NodeID: 8)
  │   💬 Args: [_troveManagerParamsArray[2]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 9)
  │     💬 Args: [address(this), getBytecode(type(TroveManager).creationCode, address(addressesRegistry)), SALT]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 10)
  │       💬 Args: [type(TroveManager).creationCode, address(addressesRegistry)]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TestDeployer._deployCurveBoldUsdcPool(contract IBoldToken,bool) (NodeID: 11)
  │   💬 Args: [result.boldToken, true]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TestDeployer._deployAndConnectCollateralContractsMainnet(struct TestDeployer.DeploymentParamsMainnet,struct TestDeployer.ExternalAddresses,struct TestDeployer.OracleParams) (NodeID: 12)
      💬 Args: [params, result.externalAddresses, vars.oracleParams]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MetadataDeployment.deployMetadata(bytes32) (NodeID: 13)
    │   💬 Args: [SALT]
    │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: MetadataDeployment._loadFiles() (NodeID: 14)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: MetadataDeployment._storeFile() (NodeID: 15)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SSTORE2.write(bytes) (NodeID: 16)
    │ │     💬 Args: [data]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: MetadataDeployment._deployFixedAssetReader(bytes32) (NodeID: 17)
    │     💬 Args: [_salt]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 18)
    │   💬 Args: [address(this), getBytecode(type(MetadataNFT).creationCode, address(initializedFixedAssetReader)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 19)
    │     💬 Args: [type(MetadataNFT).creationCode, address(initializedFixedAssetReader)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 20)
    │   💬 Args: [address(this), getBytecode(type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 21)
    │     💬 Args: [type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 22)
    │   💬 Args: [address(this), getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 23)
    │     💬 Args: [type(TroveNFT).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 24)
    │   💬 Args: [address(this), getBytecode(type(StabilityPool).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 25)
    │     💬 Args: [type(StabilityPool).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 26)
    │   💬 Args: [address(this), getBytecode(type(ActivePool).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 27)
    │     💬 Args: [type(ActivePool).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 28)
    │   💬 Args: [address(this), getBytecode(type(DefaultPool).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 29)
    │     💬 Args: [type(DefaultPool).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 30)
    │   💬 Args: [address(this), getBytecode(type(GasPool).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 31)
    │     💬 Args: [type(GasPool).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 32)
    │   💬 Args: [address(this), getBytecode(type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 33)
    │     💬 Args: [type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 34)
    │   💬 Args: [address(this), getBytecode(type(SortedTroves).creationCode, address(contracts.addressesRegistry)), SALT]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 35)
    │     💬 Args: [type(SortedTroves).creationCode, address(contracts.addressesRegistry)]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: TestDeployer._deployPriceFeed(uint256,struct TestDeployer.ExternalAddresses,struct TestDeployer.OracleParams,address) (NodeID: 36)
    │   💬 Args: [_params.branch, _externalAddresses, _oracleParams, addresses.borrowerOperations]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TestDeployer._deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IWETH,contract IPriceFeed,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers) (NodeID: 37)
        💬 Args: [contracts.addressesRegistry, contracts.collToken, _params.boldToken, _params.weth, contracts.priceFeed, _params.usdcCurvePool, true, zappers]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: TestDeployer._deployCurveExchange(contract IERC20,contract IBoldToken,contract IPriceFeed,bool) (NodeID: 38)
      │   💬 Args: [_collToken, _boldToken, _priceFeed, _mainnet]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: TestDeployer._deployLeverageZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,contract IExchange,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers) (NodeID: 39)
          💬 Args: [_addressesRegistry, _collToken, _boldToken, _priceFeed, flashLoanProvider, curveExchange, _usdcCurvePool, lst, zappers]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: TestDeployer._deployCurveLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool) (NodeID: 40)
        │   💬 Args: [_addressesRegistry, _flashLoanProvider, _curveExchange, _lst]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: TestDeployer._deployUniV3LeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,bool) (NodeID: 41)
        │   💬 Args: [_addressesRegistry, _collToken, _boldToken, _priceFeed, _flashLoanProvider, _lst]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: TestDeployer._deployHybridLeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IFlashLoanProvider,contract ICurveStableswapNGPool,bool) (NodeID: 42)
            💬 Args: [_addressesRegistry, _collToken, _boldToken, _flashLoanProvider, _usdcCurvePool, _lst]
            👁️  Def: internal
```
