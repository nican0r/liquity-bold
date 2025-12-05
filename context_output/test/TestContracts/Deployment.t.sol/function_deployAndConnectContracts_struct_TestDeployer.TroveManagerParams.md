# Function: deployAndConnectContracts(struct TestDeployer.TroveManagerParams)

**Contract**: [test/TestContracts/Deployment.t.sol/contract_TestDeployer.md]

## Metadata

- **Contract**: TestDeployer
- **Signature**: `deployAndConnectContracts(struct TestDeployer.TroveManagerParams)`
- **Visibility**: public
- **Source Range**: 7919:936:260

## Implementation

```solidity
function deployAndConnectContracts(TroveManagerParams memory troveManagerParams) public returns (LiquityContractsDev memory contracts, ICollateralRegistry collateralRegistry, IBoldToken boldToken, HintHelpers hintHelpers, MultiTroveGetter multiTroveGetter, IWETH WETH, Zappers memory zappers) {
    LiquityContractsDev[] memory contractsArray;
    TroveManagerParams[] memory troveManagerParamsArray = new TroveManagerParams[](1);
    Zappers[] memory zappersArray;
    troveManagerParamsArray[0] = troveManagerParams;
    (contractsArray, collateralRegistry, boldToken, hintHelpers, multiTroveGetter, WETH, zappersArray) = deployAndConnectContractsMultiColl(troveManagerParamsArray);
    contracts = contractsArray[0];
    zappers = zappersArray[0];
}
```

## Related Implementations

### deployAndConnectContractsMultiColl(struct TestDeployer.TroveManagerParams[])

- **Kind**: internal
- **Source**: 8861:840:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:deployAndConnectContractsMultiColl(struct TestDeployer.TroveManagerParams[])`

```solidity
function deployAndConnectContractsMultiColl(TroveManagerParams[] memory troveManagerParamsArray) public returns (LiquityContractsDev[] memory contractsArray, ICollateralRegistry collateralRegistry, IBoldToken boldToken, HintHelpers hintHelpers, MultiTroveGetter multiTroveGetter, IWETH WETH, Zappers[] memory zappersArray) {
    WETH = new WETHTester(100 ether, 1 days);
    (contractsArray, collateralRegistry, boldToken, hintHelpers, multiTroveGetter, zappersArray) = deployAndConnectContracts(troveManagerParamsArray, WETH);
}
```

### deployAndConnectContracts(struct TestDeployer.TroveManagerParams[],contract IWETH)

- **Kind**: internal
- **Source**: 10123:3446:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:deployAndConnectContracts(struct TestDeployer.TroveManagerParams[],contract IWETH)`

```solidity
function deployAndConnectContracts(TroveManagerParams[] memory troveManagerParamsArray, IWETH _WETH) public returns (LiquityContractsDev[] memory contractsArray, ICollateralRegistry collateralRegistry, IBoldToken boldToken, HintHelpers hintHelpers, MultiTroveGetter multiTroveGetter, Zappers[] memory zappersArray) {
    DeploymentVarsDev memory vars;
    vars.numCollaterals = troveManagerParamsArray.length;
    vars.bytecode = abi.encodePacked(type(BoldToken).creationCode, abi.encode(address(this)));
    vars.boldTokenAddress = getAddress(address(this), vars.bytecode, SALT);
    boldToken = new BoldToken{salt: SALT}(address(this));
    assert(address(boldToken) == vars.boldTokenAddress);
    contractsArray = new LiquityContractsDev[](vars.numCollaterals);
    zappersArray = new Zappers[](vars.numCollaterals);
    vars.collaterals = new IERC20Metadata[](vars.numCollaterals);
    vars.addressesRegistries = new IAddressesRegistry[](vars.numCollaterals);
    vars.troveManagers = new ITroveManager[](vars.numCollaterals);
    vars.collaterals[0] = _WETH;
    (IAddressesRegistry addressesRegistry, address troveManagerAddress) = _deployAddressesRegistryDev(troveManagerParamsArray[0]);
    vars.addressesRegistries[0] = addressesRegistry;
    vars.troveManagers[0] = ITroveManager(troveManagerAddress);
    for (vars.i = 1; vars.i < vars.numCollaterals; vars.i++) {
        IERC20Metadata collToken = new ERC20Faucet(_nameToken(vars.i), _symboltoken(vars.i), 100 ether, 1 days);
        vars.collaterals[vars.i] = collToken;
        (addressesRegistry, troveManagerAddress) = _deployAddressesRegistryDev(troveManagerParamsArray[vars.i]);
        vars.addressesRegistries[vars.i] = addressesRegistry;
        vars.troveManagers[vars.i] = ITroveManager(troveManagerAddress);
    }
    collateralRegistry = new CollateralRegistry(boldToken, vars.collaterals, vars.troveManagers);
    hintHelpers = new HintHelpers(collateralRegistry);
    multiTroveGetter = new MultiTroveGetter(collateralRegistry);
    (contractsArray[0], zappersArray[0]) = _deployAndConnectCollateralContractsDev(_WETH, boldToken, collateralRegistry, _WETH, vars.addressesRegistries[0], address(vars.troveManagers[0]), hintHelpers, multiTroveGetter);
    for (vars.i = 1; vars.i < vars.numCollaterals; vars.i++) {
        (contractsArray[vars.i], zappersArray[vars.i]) = _deployAndConnectCollateralContractsDev(vars.collaterals[vars.i], boldToken, collateralRegistry, _WETH, vars.addressesRegistries[vars.i], address(vars.troveManagers[vars.i]), hintHelpers, multiTroveGetter);
    }
    boldToken.setCollateralRegistry(address(collateralRegistry));
}
```

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

### _deployAddressesRegistryDev(struct TestDeployer.TroveManagerParams)

- **Kind**: internal
- **Source**: 13575:768:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployAddressesRegistryDev(struct TestDeployer.TroveManagerParams)`

```solidity
function _deployAddressesRegistryDev(TroveManagerParams memory _troveManagerParams) internal returns (IAddressesRegistry, address) {
    IAddressesRegistry addressesRegistry = new AddressesRegistry(address(this), _troveManagerParams.CCR, _troveManagerParams.MCR, _troveManagerParams.BCR, _troveManagerParams.SCR, _troveManagerParams.LIQUIDATION_PENALTY_SP, _troveManagerParams.LIQUIDATION_PENALTY_REDISTRIBUTION);
    address troveManagerAddress = getAddress(address(this), getBytecode(type(TroveManagerTester).creationCode, address(addressesRegistry)), SALT);
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

### _nameToken(uint256)

- **Kind**: internal
- **Source**: 9707:217:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_nameToken(uint256)`

```solidity
function _nameToken(uint256 _index) internal pure returns (string memory) {
    if (_index == 1) return "Wrapped Staked Ether";
    if (_index == 2) return "Rocket Pool ETH";
    return "LST Tester";
}
```

### _symboltoken(uint256)

- **Kind**: internal
- **Source**: 9930:187:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_symboltoken(uint256)`

```solidity
function _symboltoken(uint256 _index) internal pure returns (string memory) {
    if (_index == 1) return "wstETH";
    if (_index == 2) return "rETH";
    return "LST";
}
```

### _deployAndConnectCollateralContractsDev(contract IERC20Metadata,contract IBoldToken,contract ICollateralRegistry,contract IWETH,contract IAddressesRegistry,address,contract IHintHelpers,contract IMultiTroveGetter)

- **Kind**: internal
- **Source**: 14349:5859:260
- **Link**: `test/TestContracts/Deployment.t.sol:TestDeployer:_deployAndConnectCollateralContractsDev(contract IERC20Metadata,contract IBoldToken,contract ICollateralRegistry,contract IWETH,contract IAddressesRegistry,address,contract IHintHelpers,contract IMultiTroveGetter)`

```solidity
function _deployAndConnectCollateralContractsDev(IERC20Metadata _collToken, IBoldToken _boldToken, ICollateralRegistry _collateralRegistry, IWETH _weth, IAddressesRegistry _addressesRegistry, address _troveManagerAddress, IHintHelpers _hintHelpers, IMultiTroveGetter _multiTroveGetter) internal returns (LiquityContractsDev memory contracts, Zappers memory zappers) {
    LiquityContractAddresses memory addresses;
    contracts.collToken = _collToken;
    contracts.addressesRegistry = _addressesRegistry;
    contracts.priceFeed = new PriceFeedTestnet();
    contracts.interestRouter = new MockInterestRouter();
    MetadataNFT metadataNFT = deployMetadata(SALT);
    addresses.metadataNFT = getAddress(address(this), getBytecode(type(MetadataNFT).creationCode, address(initializedFixedAssetReader)), SALT);
    assert(address(metadataNFT) == addresses.metadataNFT);
    addresses.borrowerOperations = getAddress(address(this), getBytecode(type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.troveManager = _troveManagerAddress;
    addresses.troveNFT = getAddress(address(this), getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.stabilityPool = getAddress(address(this), getBytecode(type(StabilityPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.activePool = getAddress(address(this), getBytecode(type(ActivePool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.defaultPool = getAddress(address(this), getBytecode(type(DefaultPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.gasPool = getAddress(address(this), getBytecode(type(GasPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.collSurplusPool = getAddress(address(this), getBytecode(type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)), SALT);
    addresses.sortedTroves = getAddress(address(this), getBytecode(type(SortedTroves).creationCode, address(contracts.addressesRegistry)), SALT);
    IAddressesRegistry.AddressVars memory addressVars = IAddressesRegistry.AddressVars({collToken: _collToken, borrowerOperations: IBorrowerOperations(addresses.borrowerOperations), troveManager: ITroveManager(addresses.troveManager), troveNFT: ITroveNFT(addresses.troveNFT), metadataNFT: IMetadataNFT(addresses.metadataNFT), stabilityPool: IStabilityPool(addresses.stabilityPool), priceFeed: contracts.priceFeed, activePool: IActivePool(addresses.activePool), defaultPool: IDefaultPool(addresses.defaultPool), gasPoolAddress: addresses.gasPool, collSurplusPool: ICollSurplusPool(addresses.collSurplusPool), sortedTroves: ISortedTroves(addresses.sortedTroves), interestRouter: contracts.interestRouter, hintHelpers: _hintHelpers, multiTroveGetter: _multiTroveGetter, collateralRegistry: _collateralRegistry, boldToken: _boldToken, WETH: _weth});
    contracts.addressesRegistry.setAddresses(addressVars);
    contracts.borrowerOperations = new BorrowerOperationsTester{salt: SALT}(contracts.addressesRegistry);
    contracts.troveManager = new TroveManagerTester{salt: SALT}(contracts.addressesRegistry);
    contracts.troveNFT = new TroveNFT{salt: SALT}(contracts.addressesRegistry);
    contracts.stabilityPool = new StabilityPool{salt: SALT}(contracts.addressesRegistry);
    contracts.activePool = new ActivePool{salt: SALT}(contracts.addressesRegistry);
    contracts.pools.defaultPool = new DefaultPool{salt: SALT}(contracts.addressesRegistry);
    contracts.pools.gasPool = new GasPool{salt: SALT}(contracts.addressesRegistry);
    contracts.pools.collSurplusPool = new CollSurplusPool{salt: SALT}(contracts.addressesRegistry);
    contracts.sortedTroves = new SortedTroves{salt: SALT}(contracts.addressesRegistry);
    assert(address(contracts.borrowerOperations) == addresses.borrowerOperations);
    assert(address(contracts.troveManager) == addresses.troveManager);
    assert(address(contracts.troveNFT) == addresses.troveNFT);
    assert(address(contracts.stabilityPool) == addresses.stabilityPool);
    assert(address(contracts.activePool) == addresses.activePool);
    assert(address(contracts.pools.defaultPool) == addresses.defaultPool);
    assert(address(contracts.pools.gasPool) == addresses.gasPool);
    assert(address(contracts.pools.collSurplusPool) == addresses.collSurplusPool);
    assert(address(contracts.sortedTroves) == addresses.sortedTroves);
    _boldToken.setBranchAddresses(address(contracts.troveManager), address(contracts.stabilityPool), address(contracts.borrowerOperations), address(contracts.activePool));
    _deployZappers(contracts.addressesRegistry, contracts.collToken, _boldToken, _weth, contracts.priceFeed, ICurveStableswapNGPool(address(0)), false, zappers);
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

## State Variable Reads

- **SALT** (`bytes32`)
- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]
- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)
- **BOLD_TOKEN_INDEX** (`uint128`)
- **COLL_TOKEN_INDEX** (`uint256`)
- **curveFactory** (`contract ICurveFactory`) [src/Zappers/Modules/Exchanges/Curve/ICurveFactory.sol/interface_ICurveFactory.md]
- **UNIV3_FEE** (`uint24`)
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **uniV3PositionManager** (`contract INonfungiblePositionManager`) [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **WETH_MAINNET** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **USDC_INDEX** (`uint128`)
- **UNIV3_FEE_USDC_WETH** (`uint24`)
- **UNIV3_FEE_WETH_COLL** (`uint24`)

## State Variable Writes

- **files** (`mapping(bytes4 => struct MetadataDeployment.File)`)
- **pointer** (`address`)
- **initializedFixedAssetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestDeployer.deployAndConnectContracts(struct TestDeployer.TroveManagerParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: TestDeployer.deployAndConnectContractsMultiColl(struct TestDeployer.TroveManagerParams[]) (NodeID: 1)
      💬 Args: [troveManagerParamsArray]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: TestDeployer.deployAndConnectContracts(struct TestDeployer.TroveManagerParams[],contract IWETH) (NodeID: 2)
        💬 Args: [troveManagerParamsArray, WETH]
        👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 3)
      │   💬 Args: [address(this), vars.bytecode, SALT]
      │   👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: TestDeployer._deployAddressesRegistryDev(struct TestDeployer.TroveManagerParams) (NodeID: 4)
      │   💬 Args: [troveManagerParamsArray[0]]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 5)
      │     💬 Args: [address(this), getBytecode(type(TroveManagerTester).creationCode, address(addressesRegistry)), SALT]
      │     👁️  Def: public
      │   └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 6)
      │       💬 Args: [type(TroveManagerTester).creationCode, address(addressesRegistry)]
      │       👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: TestDeployer._nameToken(uint256) (NodeID: 7)
      │   💬 Args: [vars.i]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: TestDeployer._symboltoken(uint256) (NodeID: 8)
      │   💬 Args: [vars.i]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: TestDeployer._deployAddressesRegistryDev(struct TestDeployer.TroveManagerParams) (NodeID: 9)
      │   💬 Args: [troveManagerParamsArray[vars.i]]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 10)
      │     💬 Args: [address(this), getBytecode(type(TroveManagerTester).creationCode, address(addressesRegistry)), SALT]
      │     👁️  Def: public
      │   └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 11)
      │       💬 Args: [type(TroveManagerTester).creationCode, address(addressesRegistry)]
      │       👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: TestDeployer._deployAndConnectCollateralContractsDev(contract IERC20Metadata,contract IBoldToken,contract ICollateralRegistry,contract IWETH,contract IAddressesRegistry,address,contract IHintHelpers,contract IMultiTroveGetter) (NodeID: 12)
      │   💬 Args: [_WETH, boldToken, collateralRegistry, _WETH, vars.addressesRegistries[0], address(vars.troveManagers[0]), hintHelpers, multiTroveGetter]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: MetadataDeployment.deployMetadata(bytes32) (NodeID: 13)
      │ │   💬 Args: [SALT]
      │ │   👁️  Def: public
      │ │ ├─ [5] ⚙️ FUNCTION: MetadataDeployment._loadFiles() (NodeID: 14)
      │ │ │   💬 Args: [no args]
      │ │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: MetadataDeployment._storeFile() (NodeID: 15)
      │ │ │   💬 Args: [no args]
      │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SSTORE2.write(bytes) (NodeID: 16)
      │ │ │     💬 Args: [data]
      │ │ │     👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: MetadataDeployment._deployFixedAssetReader(bytes32) (NodeID: 17)
      │ │     💬 Args: [_salt]
      │ │     👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 18)
      │ │   💬 Args: [address(this), getBytecode(type(MetadataNFT).creationCode, address(initializedFixedAssetReader)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 19)
      │ │     💬 Args: [type(MetadataNFT).creationCode, address(initializedFixedAssetReader)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 20)
      │ │   💬 Args: [address(this), getBytecode(type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 21)
      │ │     💬 Args: [type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 22)
      │ │   💬 Args: [address(this), getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 23)
      │ │     💬 Args: [type(TroveNFT).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 24)
      │ │   💬 Args: [address(this), getBytecode(type(StabilityPool).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 25)
      │ │     💬 Args: [type(StabilityPool).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 26)
      │ │   💬 Args: [address(this), getBytecode(type(ActivePool).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 27)
      │ │     💬 Args: [type(ActivePool).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 28)
      │ │   💬 Args: [address(this), getBytecode(type(DefaultPool).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 29)
      │ │     💬 Args: [type(DefaultPool).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 30)
      │ │   💬 Args: [address(this), getBytecode(type(GasPool).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 31)
      │ │     💬 Args: [type(GasPool).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 32)
      │ │   💬 Args: [address(this), getBytecode(type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 33)
      │ │     💬 Args: [type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 34)
      │ │   💬 Args: [address(this), getBytecode(type(SortedTroves).creationCode, address(contracts.addressesRegistry)), SALT]
      │ │   👁️  Def: public
      │ │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 35)
      │ │     💬 Args: [type(SortedTroves).creationCode, address(contracts.addressesRegistry)]
      │ │     👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: TestDeployer._deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IWETH,contract IPriceFeed,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers) (NodeID: 36)
      │     💬 Args: [contracts.addressesRegistry, contracts.collToken, _boldToken, _weth, contracts.priceFeed, ICurveStableswapNGPool(address(0)), false, zappers]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: TestDeployer._deployCurveExchange(contract IERC20,contract IBoldToken,contract IPriceFeed,bool) (NodeID: 37)
      │   │   💬 Args: [_collToken, _boldToken, _priceFeed, _mainnet]
      │   │   👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: TestDeployer._deployLeverageZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,contract IExchange,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers) (NodeID: 38)
      │       💬 Args: [_addressesRegistry, _collToken, _boldToken, _priceFeed, flashLoanProvider, curveExchange, _usdcCurvePool, lst, zappers]
      │       👁️  Def: internal
      │     ├─ [6] ⚙️ FUNCTION: TestDeployer._deployCurveLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool) (NodeID: 39)
      │     │   💬 Args: [_addressesRegistry, _flashLoanProvider, _curveExchange, _lst]
      │     │   👁️  Def: internal
      │     ├─ [6] ⚙️ FUNCTION: TestDeployer._deployUniV3LeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,bool) (NodeID: 40)
      │     │   💬 Args: [_addressesRegistry, _collToken, _boldToken, _priceFeed, _flashLoanProvider, _lst]
      │     │   👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: TestDeployer._deployHybridLeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IFlashLoanProvider,contract ICurveStableswapNGPool,bool) (NodeID: 41)
      │         💬 Args: [_addressesRegistry, _collToken, _boldToken, _flashLoanProvider, _usdcCurvePool, _lst]
      │         👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: TestDeployer._deployAndConnectCollateralContractsDev(contract IERC20Metadata,contract IBoldToken,contract ICollateralRegistry,contract IWETH,contract IAddressesRegistry,address,contract IHintHelpers,contract IMultiTroveGetter) (NodeID: 42)
          💬 Args: [vars.collaterals[vars.i], boldToken, collateralRegistry, _WETH, vars.addressesRegistries[vars.i], address(vars.troveManagers[vars.i]), hintHelpers, multiTroveGetter]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: MetadataDeployment.deployMetadata(bytes32) (NodeID: 43)
        │   💬 Args: [SALT]
        │   👁️  Def: public
        │ ├─ [5] ⚙️ FUNCTION: MetadataDeployment._loadFiles() (NodeID: 44)
        │ │   💬 Args: [no args]
        │ │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: MetadataDeployment._storeFile() (NodeID: 45)
        │ │   💬 Args: [no args]
        │ │   👁️  Def: internal
        │ │ └─ [6] ⚙️ FUNCTION: SSTORE2.write(bytes) (NodeID: 46)
        │ │     💬 Args: [data]
        │ │     👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: MetadataDeployment._deployFixedAssetReader(bytes32) (NodeID: 47)
        │     💬 Args: [_salt]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 48)
        │   💬 Args: [address(this), getBytecode(type(MetadataNFT).creationCode, address(initializedFixedAssetReader)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 49)
        │     💬 Args: [type(MetadataNFT).creationCode, address(initializedFixedAssetReader)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 50)
        │   💬 Args: [address(this), getBytecode(type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 51)
        │     💬 Args: [type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 52)
        │   💬 Args: [address(this), getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 53)
        │     💬 Args: [type(TroveNFT).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 54)
        │   💬 Args: [address(this), getBytecode(type(StabilityPool).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 55)
        │     💬 Args: [type(StabilityPool).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 56)
        │   💬 Args: [address(this), getBytecode(type(ActivePool).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 57)
        │     💬 Args: [type(ActivePool).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 58)
        │   💬 Args: [address(this), getBytecode(type(DefaultPool).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 59)
        │     💬 Args: [type(DefaultPool).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 60)
        │   💬 Args: [address(this), getBytecode(type(GasPool).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 61)
        │     💬 Args: [type(GasPool).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 62)
        │   💬 Args: [address(this), getBytecode(type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 63)
        │     💬 Args: [type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 64)
        │   💬 Args: [address(this), getBytecode(type(SortedTroves).creationCode, address(contracts.addressesRegistry)), SALT]
        │   👁️  Def: public
        │ └─ [5] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 65)
        │     💬 Args: [type(SortedTroves).creationCode, address(contracts.addressesRegistry)]
        │     👁️  Def: public
        └─ [4] ⚙️ FUNCTION: TestDeployer._deployZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IWETH,contract IPriceFeed,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers) (NodeID: 66)
            💬 Args: [contracts.addressesRegistry, contracts.collToken, _boldToken, _weth, contracts.priceFeed, ICurveStableswapNGPool(address(0)), false, zappers]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: TestDeployer._deployCurveExchange(contract IERC20,contract IBoldToken,contract IPriceFeed,bool) (NodeID: 67)
          │   💬 Args: [_collToken, _boldToken, _priceFeed, _mainnet]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: TestDeployer._deployLeverageZappers(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,contract IExchange,contract ICurveStableswapNGPool,bool,struct TestDeployer.Zappers) (NodeID: 68)
              💬 Args: [_addressesRegistry, _collToken, _boldToken, _priceFeed, flashLoanProvider, curveExchange, _usdcCurvePool, lst, zappers]
              👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: TestDeployer._deployCurveLeverageZapper(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange,bool) (NodeID: 69)
            │   💬 Args: [_addressesRegistry, _flashLoanProvider, _curveExchange, _lst]
            │   👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: TestDeployer._deployUniV3LeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IPriceFeed,contract IFlashLoanProvider,bool) (NodeID: 70)
            │   💬 Args: [_addressesRegistry, _collToken, _boldToken, _priceFeed, _flashLoanProvider, _lst]
            │   👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: TestDeployer._deployHybridLeverageZapper(contract IAddressesRegistry,contract IERC20,contract IBoldToken,contract IFlashLoanProvider,contract ICurveStableswapNGPool,bool) (NodeID: 71)
                💬 Args: [_addressesRegistry, _collToken, _boldToken, _flashLoanProvider, _usdcCurvePool, _lst]
                👁️  Def: internal
```
