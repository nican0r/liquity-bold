// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "src/AddressesRegistry.sol";
import "src/ActivePool.sol";
import "src/BoldToken.sol";
import "src/BorrowerOperations.sol";
import "src/CollSurplusPool.sol";
import "src/DefaultPool.sol";
import "src/GasPool.sol";
import "src/HintHelpers.sol";
import "src/MultiTroveGetter.sol";
import "src/SortedTroves.sol";
import "src/StabilityPool.sol";
import "./BorrowerOperationsTester.t.sol";
import "./TroveManagerTester.t.sol";
import "./CollateralRegistryTester.sol";
import "src/TroveNFT.sol";
import "src/CollateralRegistry.sol";
import "./MockInterestRouter.sol";
import "./PriceFeedTestnet.sol";
import "./MockMetadataNFT.sol";
import "src/Zappers/WETHZapper.sol";
import "src/Zappers/GasCompZapper.sol";
import "src/Zappers/LeverageLSTZapper.sol";
import "src/Zappers/LeverageWETHZapper.sol";
import "src/Zappers/Modules/FlashLoans/BalancerFlashLoan.sol";
import "src/Zappers/Interfaces/IFlashLoanProvider.sol";
import "src/Zappers/Interfaces/IExchange.sol";
import "src/Zappers/Modules/Exchanges/Curve/ICurveFactory.sol";
import "src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol";
import "src/Zappers/Modules/Exchanges/Curve/ICurvePool.sol";
import "src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol";
import "src/Zappers/Modules/Exchanges/CurveExchange.sol";
import "src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol";
import "src/Zappers/Modules/Exchanges/UniV3Exchange.sol";
import "src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol";
import "src/Zappers/Modules/Exchanges/HybridCurveUniV3Exchange.sol";
import {WETHTester} from "./WETHTester.sol";
import {ERC20Faucet} from "./ERC20Faucet.sol";

import "src/PriceFeeds/WETHPriceFeed.sol";
import "src/PriceFeeds/WSTETHPriceFeed.sol";
import "src/PriceFeeds/RETHPriceFeed.sol";

/// @notice Echidna-compatible deployer that doesn't use forge-std cheatcodes for file system access
/// @dev This is a simplified version of TestDeployer that uses MockMetadataNFT instead of the real one
contract TestDeployerEchidna {
    IERC20 constant USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IWETH constant WETH_MAINNET = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

    // Curve
    ICurveFactory constant curveFactory = ICurveFactory(0x98EE851a00abeE0d95D08cF4CA2BdCE32aeaAF7F);
    ICurveStableswapNGFactory constant curveStableswapFactory =
        ICurveStableswapNGFactory(0x6A8cbed756804B16E05E741eDaBd5cB544AE21bf);
    uint128 constant BOLD_TOKEN_INDEX = 0;
    uint256 constant COLL_TOKEN_INDEX = 1;
    uint128 constant USDC_INDEX = 1;

    // UniV3
    ISwapRouter constant uniV3Router = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    INonfungiblePositionManager constant uniV3PositionManager =
        INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);
    uint24 constant UNIV3_FEE = 3000; // 0.3%
    uint24 constant UNIV3_FEE_USDC_WETH = 500; // 0.05%
    uint24 constant UNIV3_FEE_WETH_COLL = 100; // 0.01%

    bytes32 constant SALT = keccak256("LiquityV2");

    struct LiquityContractsDevPools {
        IDefaultPool defaultPool;
        ICollSurplusPool collSurplusPool;
        GasPool gasPool;
    }

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

    struct Zappers {
        WETHZapper wethZapper;
        GasCompZapper gasCompZapper;
        ILeverageZapper leverageZapperCurve;
        ILeverageZapper leverageZapperUniV3;
        ILeverageZapper leverageZapperHybrid;
    }

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

    struct TroveManagerParams {
        uint256 CCR;
        uint256 MCR;
        uint256 BCR;
        uint256 SCR;
        uint256 LIQUIDATION_PENALTY_SP;
        uint256 LIQUIDATION_PENALTY_REDISTRIBUTION;
    }

    struct DeploymentVarsDev {
        uint256 numCollaterals;
        IERC20Metadata[] collaterals;
        IAddressesRegistry[] addressesRegistries;
        ITroveManager[] troveManagers;
        bytes bytecode;
        address boldTokenAddress;
        uint256 i;
    }

    function getBytecode(bytes memory _creationCode, address _addressesRegistry) public pure returns (bytes memory) {
        return abi.encodePacked(_creationCode, abi.encode(_addressesRegistry));
    }

    function getAddress(address _deployer, bytes memory _bytecode, bytes32 _salt) public pure returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), _deployer, _salt, keccak256(_bytecode)));
        return address(uint160(uint256(hash)));
    }

    function _nameToken(uint256 _index) internal pure returns (string memory) {
        if (_index == 1) return "Wrapped Staked Ether";
        if (_index == 2) return "Rocket Pool ETH";
        return "LST Tester";
    }

    function _symboltoken(uint256 _index) internal pure returns (string memory) {
        if (_index == 1) return "wstETH";
        if (_index == 2) return "rETH";
        return "LST";
    }

    function deployAndConnectContracts()
        external
        returns (
            LiquityContractsDev memory contracts,
            ICollateralRegistry collateralRegistry,
            IBoldToken boldToken,
            HintHelpers hintHelpers,
            MultiTroveGetter multiTroveGetter,
            IWETH WETH,
            Zappers memory zappers
        )
    {
        return deployAndConnectContracts(TroveManagerParams(150e16, 110e16, 10e16, 110e16, 5e16, 10e16));
    }

    function deployAndConnectContracts(TroveManagerParams memory troveManagerParams)
        public
        returns (
            LiquityContractsDev memory contracts,
            ICollateralRegistry collateralRegistry,
            IBoldToken boldToken,
            HintHelpers hintHelpers,
            MultiTroveGetter multiTroveGetter,
            IWETH WETH,
            Zappers memory zappers
        )
    {
        LiquityContractsDev[] memory contractsArray;
        TroveManagerParams[] memory troveManagerParamsArray = new TroveManagerParams[](1);
        Zappers[] memory zappersArray;

        troveManagerParamsArray[0] = troveManagerParams;

        (contractsArray, collateralRegistry, boldToken, hintHelpers, multiTroveGetter, WETH, zappersArray) =
            deployAndConnectContractsMultiColl(troveManagerParamsArray);
        contracts = contractsArray[0];
        zappers = zappersArray[0];
    }

    function deployAndConnectContractsMultiColl(TroveManagerParams[] memory troveManagerParamsArray)
        public
        returns (
            LiquityContractsDev[] memory contractsArray,
            ICollateralRegistry collateralRegistry,
            IBoldToken boldToken,
            HintHelpers hintHelpers,
            MultiTroveGetter multiTroveGetter,
            IWETH WETH,
            Zappers[] memory zappersArray
        )
    {
        WETH = new WETHTester(
            100 ether, //     _tapAmount
            1 days //         _tapPeriod
        );
        (contractsArray, collateralRegistry, boldToken, hintHelpers, multiTroveGetter, zappersArray) =
            deployAndConnectContracts(troveManagerParamsArray, WETH);
    }

    function deployAndConnectContracts(TroveManagerParams[] memory troveManagerParamsArray, IWETH _WETH)
        public
        returns (
            LiquityContractsDev[] memory contractsArray,
            ICollateralRegistry collateralRegistry,
            IBoldToken boldToken,
            HintHelpers hintHelpers,
            MultiTroveGetter multiTroveGetter,
            Zappers[] memory zappersArray
        )
    {
        DeploymentVarsDev memory vars;
        vars.numCollaterals = troveManagerParamsArray.length;

        // Deploy Bold
        vars.bytecode = abi.encodePacked(type(BoldToken).creationCode, abi.encode(address(this)));
        vars.boldTokenAddress = getAddress(address(this), vars.bytecode, SALT);
        boldToken = new BoldToken{salt: SALT}(address(this));
        assert(address(boldToken) == vars.boldTokenAddress);

        contractsArray = new LiquityContractsDev[](vars.numCollaterals);
        zappersArray = new Zappers[](vars.numCollaterals);
        vars.collaterals = new IERC20Metadata[](vars.numCollaterals);
        vars.addressesRegistries = new IAddressesRegistry[](vars.numCollaterals);
        vars.troveManagers = new ITroveManager[](vars.numCollaterals);

        // Deploy the first branch with WETH collateral
        vars.collaterals[0] = _WETH;
        (IAddressesRegistry addressesRegistry, address troveManagerAddress) =
            _deployAddressesRegistryDev(troveManagerParamsArray[0]);
        vars.addressesRegistries[0] = addressesRegistry;
        vars.troveManagers[0] = ITroveManager(troveManagerAddress);

        for (vars.i = 1; vars.i < vars.numCollaterals; vars.i++) {
            IERC20Metadata collToken = new ERC20Faucet(
                _nameToken(vars.i),
                _symboltoken(vars.i),
                100 ether,
                1 days
            );
            vars.collaterals[vars.i] = collToken;
            (addressesRegistry, troveManagerAddress) = _deployAddressesRegistryDev(troveManagerParamsArray[vars.i]);
            vars.addressesRegistries[vars.i] = addressesRegistry;
            vars.troveManagers[vars.i] = ITroveManager(troveManagerAddress);
        }

        collateralRegistry = new CollateralRegistry(boldToken, vars.collaterals, vars.troveManagers);
        hintHelpers = new HintHelpers(collateralRegistry);
        multiTroveGetter = new MultiTroveGetter(collateralRegistry);

        (contractsArray[0], zappersArray[0]) = _deployAndConnectCollateralContractsDev(
            _WETH,
            boldToken,
            collateralRegistry,
            _WETH,
            vars.addressesRegistries[0],
            address(vars.troveManagers[0]),
            hintHelpers,
            multiTroveGetter
        );

        for (vars.i = 1; vars.i < vars.numCollaterals; vars.i++) {
            (contractsArray[vars.i], zappersArray[vars.i]) = _deployAndConnectCollateralContractsDev(
                vars.collaterals[vars.i],
                boldToken,
                collateralRegistry,
                _WETH,
                vars.addressesRegistries[vars.i],
                address(vars.troveManagers[vars.i]),
                hintHelpers,
                multiTroveGetter
            );
        }

        boldToken.setCollateralRegistry(address(collateralRegistry));
    }

    function _deployAddressesRegistryDev(TroveManagerParams memory _troveManagerParams)
        internal
        returns (IAddressesRegistry, address)
    {
        IAddressesRegistry addressesRegistry = new AddressesRegistry(
            address(this),
            _troveManagerParams.CCR,
            _troveManagerParams.MCR,
            _troveManagerParams.BCR,
            _troveManagerParams.SCR,
            _troveManagerParams.LIQUIDATION_PENALTY_SP,
            _troveManagerParams.LIQUIDATION_PENALTY_REDISTRIBUTION
        );
        address troveManagerAddress = getAddress(
            address(this), getBytecode(type(TroveManagerTester).creationCode, address(addressesRegistry)), SALT
        );

        return (addressesRegistry, troveManagerAddress);
    }

    function _deployAndConnectCollateralContractsDev(
        IERC20Metadata _collToken,
        IBoldToken _boldToken,
        ICollateralRegistry _collateralRegistry,
        IWETH _weth,
        IAddressesRegistry _addressesRegistry,
        address _troveManagerAddress,
        IHintHelpers _hintHelpers,
        IMultiTroveGetter _multiTroveGetter
    ) internal returns (LiquityContractsDev memory contracts, Zappers memory zappers) {
        LiquityContractAddresses memory addresses;
        contracts.collToken = _collToken;

        contracts.addressesRegistry = _addressesRegistry;
        contracts.priceFeed = new PriceFeedTestnet();
        contracts.interestRouter = new MockInterestRouter();

        // Deploy Mock Metadata (instead of using file system access)
        MockMetadataNFT metadataNFT = new MockMetadataNFT{salt: SALT}();
        addresses.metadataNFT = getAddress(
            address(this), type(MockMetadataNFT).creationCode, SALT
        );
        assert(address(metadataNFT) == addresses.metadataNFT);

        // Pre-calc addresses
        addresses.borrowerOperations = getAddress(
            address(this),
            getBytecode(type(BorrowerOperationsTester).creationCode, address(contracts.addressesRegistry)),
            SALT
        );
        addresses.troveManager = _troveManagerAddress;
        addresses.troveNFT = getAddress(
            address(this), getBytecode(type(TroveNFT).creationCode, address(contracts.addressesRegistry)), SALT
        );
        addresses.stabilityPool = getAddress(
            address(this), getBytecode(type(StabilityPool).creationCode, address(contracts.addressesRegistry)), SALT
        );
        addresses.activePool = getAddress(
            address(this), getBytecode(type(ActivePool).creationCode, address(contracts.addressesRegistry)), SALT
        );
        addresses.defaultPool = getAddress(
            address(this), getBytecode(type(DefaultPool).creationCode, address(contracts.addressesRegistry)), SALT
        );
        addresses.gasPool = getAddress(
            address(this), getBytecode(type(GasPool).creationCode, address(contracts.addressesRegistry)), SALT
        );
        addresses.collSurplusPool = getAddress(
            address(this), getBytecode(type(CollSurplusPool).creationCode, address(contracts.addressesRegistry)), SALT
        );
        addresses.sortedTroves = getAddress(
            address(this), getBytecode(type(SortedTroves).creationCode, address(contracts.addressesRegistry)), SALT
        );

        // Deploy contracts
        IAddressesRegistry.AddressVars memory addressVars = IAddressesRegistry.AddressVars({
            collToken: _collToken,
            borrowerOperations: IBorrowerOperations(addresses.borrowerOperations),
            troveManager: ITroveManager(addresses.troveManager),
            troveNFT: ITroveNFT(addresses.troveNFT),
            metadataNFT: IMetadataNFT(addresses.metadataNFT),
            stabilityPool: IStabilityPool(addresses.stabilityPool),
            priceFeed: contracts.priceFeed,
            activePool: IActivePool(addresses.activePool),
            defaultPool: IDefaultPool(addresses.defaultPool),
            gasPoolAddress: addresses.gasPool,
            collSurplusPool: ICollSurplusPool(addresses.collSurplusPool),
            sortedTroves: ISortedTroves(addresses.sortedTroves),
            interestRouter: contracts.interestRouter,
            hintHelpers: _hintHelpers,
            multiTroveGetter: _multiTroveGetter,
            collateralRegistry: _collateralRegistry,
            boldToken: _boldToken,
            WETH: _weth
        });
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

        // Connect contracts
        _boldToken.setBranchAddresses(
            address(contracts.troveManager),
            address(contracts.stabilityPool),
            address(contracts.borrowerOperations),
            address(contracts.activePool)
        );

        // deploy zappers
        _deployZappers(
            contracts.addressesRegistry,
            contracts.collToken,
            _boldToken,
            _weth,
            contracts.priceFeed,
            ICurveStableswapNGPool(address(0)),
            false,
            zappers
        );
    }

    function _deployZappers(
        IAddressesRegistry _addressesRegistry,
        IERC20 _collToken,
        IBoldToken _boldToken,
        IWETH _weth,
        IPriceFeed _priceFeed,
        ICurveStableswapNGPool /* _usdcCurvePool */,
        bool _mainnet,
        Zappers memory zappers
    ) internal {
        IFlashLoanProvider flashLoanProvider = new BalancerFlashLoan();
        IExchange curveExchange = _deployCurveExchange(_collToken, _boldToken, _priceFeed, _mainnet);

        bool lst = _collToken != _weth;
        if (lst) {
            zappers.gasCompZapper = new GasCompZapper(_addressesRegistry, flashLoanProvider, curveExchange);
        } else {
            zappers.wethZapper = new WETHZapper(_addressesRegistry, flashLoanProvider, curveExchange);
        }
    }

    function _deployCurveExchange(
        IERC20 _collToken,
        IBoldToken _boldToken,
        IPriceFeed /* _priceFeed */,
        bool _mainnet
    ) internal returns (IExchange) {
        // For dev/test deployments, use a mock exchange with no actual pool
        if (!_mainnet) return new CurveExchange(_collToken, _boldToken, ICurvePool(address(0)), 1, 0);

        // Mainnet deployment would deploy actual Curve pool here
        // For now, return mock for all cases in Echidna testing
        return new CurveExchange(_collToken, _boldToken, ICurvePool(address(0)), 1, 0);
    }
}
