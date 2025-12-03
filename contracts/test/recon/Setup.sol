// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";

// Managers
import {ActorManager} from "@recon/ActorManager.sol";
import {AssetManager} from "@recon/AssetManager.sol";

// Helpers
import {Utils} from "@recon/Utils.sol";

// Your deps
import "src/ActivePool.sol";
import "src/AddressesRegistry.sol";
import "src/BoldToken.sol";
import "src/BorrowerOperations.sol";
import "src/CollSurplusPool.sol";
import "src/CollateralRegistry.sol";
import "src/DefaultPool.sol";
import "src/GasPool.sol";
import "src/SortedTroves.sol";
import "src/StabilityPool.sol";
import "src/TroveManager.sol";
import "src/TroveNFT.sol";
import "src/HintHelpers.sol";
import "src/MultiTroveGetter.sol";

// Test contracts
import "test/TestContracts/PriceFeedTestnet.sol";
import "test/TestContracts/MockInterestRouter.sol";
import "test/TestContracts/WETHTester.sol";
import "test/TestContracts/BorrowerOperationsTester.t.sol";
import "test/TestContracts/TroveManagerTester.t.sol";

// NFT Metadata
import "src/NFTMetadata/MetadataNFT.sol";
import "src/NFTMetadata/utils/FixedAssets.sol";

// Interfaces
import "src/Interfaces/IAddressesRegistry.sol";
import "src/Interfaces/ITroveManager.sol";
import "src/Interfaces/IActivePool.sol";
import "src/Interfaces/IDefaultPool.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";

// Mock contracts for initialization to avoid circular dependencies
contract MockActivePool {
    function getCollBalance() external pure returns (uint256) { return 0; }
    function getBoldDebt() external pure returns (uint256) { return 0; }
}

contract MockDefaultPool {
    function getCollBalance() external pure returns (uint256) { return 0; }
    function getBoldDebt() external pure returns (uint256) { return 0; }
}

contract MockWETH {
    function approve(address, uint256) external pure returns (bool) { return true; }
}

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    // Configuration constants
    uint256 internal constant DECIMALS = 18;
    
    // System parameters - CONFIGURABLE via admin functions
    uint256 internal constant CCR = 150e16; // 150% Critical Collateralization Ratio
    uint256 internal constant MCR = 110e16; // 110% Minimum Collateralization Ratio
    uint256 internal constant BCR = 10e16;  // 10% Batch Collateralization Ratio buffer
    uint256 internal constant SCR = 110e16; // 110% Shutdown Collateralization Ratio
    uint256 internal constant LIQUIDATION_PENALTY_SP = 5e16; // 5% Stability Pool liquidation penalty
    uint256 internal constant LIQUIDATION_PENALTY_REDISTRIBUTION = 10e16; // 10% Redistribution liquidation penalty
    
    // Core contracts
    AddressesRegistry addressesRegistry;
    ActivePool activePool;
    BoldToken boldToken;
    BorrowerOperationsTester borrowerOperations;
    CollSurplusPool collSurplusPool;
    CollateralRegistry collateralRegistry;
    DefaultPool defaultPool;
    GasPool gasPool;
    SortedTroves sortedTroves;
    StabilityPool stabilityPool;
    TroveManagerTester troveManager;
    TroveNFT troveNFT;
    MetadataNFT metadataNFT;
    
    // Helper contracts
    HintHelpers hintHelpers;
    MultiTroveGetter multiTroveGetter;
    
    // Test mocks
    PriceFeedTestnet priceFeed;
    MockInterestRouter interestRouter;
    WETHTester collToken; // WETH as collateral token
    
    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        // 1. Add additional actors
        _addActor(address(0x100)); // Actor 1
        _addActor(address(0x200)); // Actor 2
        
        // 2. Deploy WETH as collateral token (using WETHTester for test environment)
        collToken = new WETHTester(100 ether, 1 days);
        
        // 3. Add collToken as an asset in AssetManager
        _addAsset(address(collToken));
        
        // 4. Deploy BoldToken with address(this) as owner
        boldToken = new BoldToken(address(this));
        
        // 5. Deploy test mocks and MetadataNFT
        priceFeed = new PriceFeedTestnet();
        interestRouter = new MockInterestRouter();
        
        bytes4[] memory sigs = new bytes4[](0);
        FixedAssetReader.Asset[] memory assets = new FixedAssetReader.Asset[](0);
        FixedAssetReader assetReader = new FixedAssetReader(address(0), sigs, assets);
        metadataNFT = new MetadataNFT(assetReader);
        
        // 6. Create mock contracts for circular dependency resolution
        MockActivePool mockActivePool = new MockActivePool();
        MockDefaultPool mockDefaultPool = new MockDefaultPool();
        MockWETH mockWETH = new MockWETH();
        
        // 7. Deploy first AddressesRegistry with mocks to deploy initial contracts
        AddressesRegistry tempRegistry1 = new AddressesRegistry(
            address(this), CCR, MCR, BCR, SCR, LIQUIDATION_PENALTY_SP, LIQUIDATION_PENALTY_REDISTRIBUTION
        );
        
        IAddressesRegistry.AddressVars memory tempVars1 = IAddressesRegistry.AddressVars({
            collToken: IERC20Metadata(address(collToken)),
            borrowerOperations: IBorrowerOperations(address(1)), // dummy
            troveManager: ITroveManager(address(1)), // dummy  
            troveNFT: ITroveNFT(address(0)),
            metadataNFT: IMetadataNFT(address(metadataNFT)),
            stabilityPool: IStabilityPool(address(0)),
            priceFeed: IPriceFeed(address(priceFeed)),
            activePool: IActivePool(address(mockActivePool)),
            defaultPool: IDefaultPool(address(mockDefaultPool)),
            gasPoolAddress: address(0),
            collSurplusPool: ICollSurplusPool(address(0)),
            sortedTroves: ISortedTroves(address(0)),
            interestRouter: IInterestRouter(address(interestRouter)),
            hintHelpers: IHintHelpers(address(0)),
            multiTroveGetter: IMultiTroveGetter(address(0)),
            collateralRegistry: ICollateralRegistry(address(0)),
            boldToken: IBoldToken(address(boldToken)),
            WETH: IWETH(address(mockWETH))
        });
        tempRegistry1.setAddresses(tempVars1);
        
        // 8. Deploy contracts that only need activePool/defaultPool/priceFeed (not borrowerOps/troveManager)
        troveNFT = new TroveNFT(tempRegistry1);
        collSurplusPool = new CollSurplusPool(tempRegistry1);
        sortedTroves = new SortedTroves(tempRegistry1);
        gasPool = new GasPool(tempRegistry1);
        
        // 9. Deploy second registry with real troveNFT but still mock activePool/defaultPool
        AddressesRegistry tempRegistry2 = new AddressesRegistry(
            address(this), CCR, MCR, BCR, SCR, LIQUIDATION_PENALTY_SP, LIQUIDATION_PENALTY_REDISTRIBUTION
        );
        
        IAddressesRegistry.AddressVars memory tempVars2 = IAddressesRegistry.AddressVars({
            collToken: IERC20Metadata(address(collToken)),
            borrowerOperations: IBorrowerOperations(address(0)),
            troveManager: ITroveManager(address(0)),
            troveNFT: ITroveNFT(address(troveNFT)),
            metadataNFT: IMetadataNFT(address(metadataNFT)),
            stabilityPool: IStabilityPool(address(0)),
            priceFeed: IPriceFeed(address(priceFeed)),
            activePool: IActivePool(address(mockActivePool)),
            defaultPool: IDefaultPool(address(mockDefaultPool)),
            gasPoolAddress: address(gasPool),
            collSurplusPool: ICollSurplusPool(address(collSurplusPool)),
            sortedTroves: ISortedTroves(address(sortedTroves)),
            interestRouter: IInterestRouter(address(interestRouter)),
            hintHelpers: IHintHelpers(address(0)),
            multiTroveGetter: IMultiTroveGetter(address(0)),
            collateralRegistry: ICollateralRegistry(address(0)),
            boldToken: IBoldToken(address(boldToken)),
            WETH: IWETH(address(collToken))
        });
        tempRegistry2.setAddresses(tempVars2);
        
        // 10. Deploy activePool and defaultPool
        activePool = new ActivePool(tempRegistry2);
        defaultPool = new DefaultPool(tempRegistry2);
        
        // 11. Create a temp registry for deploying borrowerOperations/troveManager
        // This registry has all the info needed for constructors but not borrowerOperations/troveManager themselves
        AddressesRegistry tempRegistry = new AddressesRegistry(
            address(this), CCR, MCR, BCR, SCR, LIQUIDATION_PENALTY_SP, LIQUIDATION_PENALTY_REDISTRIBUTION
        );
        
        IAddressesRegistry.AddressVars memory tempVars = IAddressesRegistry.AddressVars({
            collToken: IERC20Metadata(address(collToken)),
            borrowerOperations: IBorrowerOperations(address(0)),  // Will be set in final registry
            troveManager: ITroveManager(address(0)),  // Will be set in final registry
            troveNFT: ITroveNFT(address(troveNFT)),
            metadataNFT: IMetadataNFT(address(metadataNFT)),
            stabilityPool: IStabilityPool(address(0)),  // Will be set in final registry
            priceFeed: IPriceFeed(address(priceFeed)),
            activePool: IActivePool(address(activePool)),
            defaultPool: IDefaultPool(address(defaultPool)),
            gasPoolAddress: address(gasPool),
            collSurplusPool: ICollSurplusPool(address(collSurplusPool)),
            sortedTroves: ISortedTroves(address(sortedTroves)),
            interestRouter: IInterestRouter(address(interestRouter)),
            hintHelpers: IHintHelpers(address(0)),  // Will be set in final registry
            multiTroveGetter: IMultiTroveGetter(address(0)),  // Will be set in final registry
            collateralRegistry: ICollateralRegistry(address(0)),  // Will be set in final registry
            boldToken: IBoldToken(address(boldToken)),
            WETH: IWETH(address(collToken))
        });
        tempRegistry.setAddresses(tempVars);
        
        // 12. Deploy remaining contracts using the temp registry
        borrowerOperations = new BorrowerOperationsTester(tempRegistry);
        troveManager = new TroveManagerTester(tempRegistry);
        stabilityPool = new StabilityPool(tempRegistry);
        
        // 13. Deploy CollateralRegistry
        IERC20Metadata[] memory collaterals = new IERC20Metadata[](1);
        collaterals[0] = IERC20Metadata(address(collToken));
        
        ITroveManager[] memory troveManagers = new ITroveManager[](1);
        troveManagers[0] = ITroveManager(address(troveManager));
        
        collateralRegistry = new CollateralRegistry(boldToken, collaterals, troveManagers);
        
        // 14. Deploy helper contracts
        hintHelpers = new HintHelpers(collateralRegistry);
        multiTroveGetter = new MultiTroveGetter(collateralRegistry);
        
        // 15. NOW set all addresses in the addressesRegistry
        // All contracts have been deployed and can now be registered
        IAddressesRegistry.AddressVars memory finalVars = IAddressesRegistry.AddressVars({
            collToken: IERC20Metadata(address(collToken)),
            borrowerOperations: IBorrowerOperations(address(borrowerOperations)),
            troveManager: ITroveManager(address(troveManager)),
            troveNFT: ITroveNFT(address(troveNFT)),
            metadataNFT: IMetadataNFT(address(metadataNFT)),
            stabilityPool: IStabilityPool(address(stabilityPool)),
            priceFeed: IPriceFeed(address(priceFeed)),
            activePool: IActivePool(address(activePool)),
            defaultPool: IDefaultPool(address(defaultPool)),
            gasPoolAddress: address(gasPool),
            collSurplusPool: ICollSurplusPool(address(collSurplusPool)),
            sortedTroves: ISortedTroves(address(sortedTroves)),
            interestRouter: IInterestRouter(address(interestRouter)),
            hintHelpers: IHintHelpers(address(hintHelpers)),
            multiTroveGetter: IMultiTroveGetter(address(multiTroveGetter)),
            collateralRegistry: ICollateralRegistry(address(collateralRegistry)),
            boldToken: IBoldToken(address(boldToken)),
            WETH: IWETH(address(collToken))
        });
        addressesRegistry.setAddresses(finalVars);
        
        // 16. Configure BoldToken with branch addresses
        boldToken.setBranchAddresses(
            address(troveManager),
            address(stabilityPool),
            address(borrowerOperations),
            address(activePool)
        );
        
        // 17. Set collateral registry in BoldToken (this renounces ownership)
        boldToken.setCollateralRegistry(address(collateralRegistry));
        
        // 18. Set up approval array for contracts that need collToken access
        address[] memory approvalArray = new address[](4);
        approvalArray[0] = address(borrowerOperations);
        approvalArray[1] = address(activePool);
        approvalArray[2] = address(defaultPool);
        approvalArray[3] = address(stabilityPool);
        
        // 19. Manually mint collToken to actors and approve (can't use _finalizeAssetDeployment due to WETHTester onlyOwner)
        address[] memory actors = _getActors();
        uint256 mintAmount = type(uint88).max;
        
        for (uint256 i; i < actors.length; i++) {
            // Mint collToken to actors (as owner of WETHTester)
            collToken.mint(actors[i], mintAmount);
            
            // Set approvals for each actor
            for (uint256 j; j < approvalArray.length; j++) {
                vm.prank(actors[i]);
                collToken.approve(approvalArray[j], type(uint256).max);
            }
        }
    }

    /// === MODIFIERS === ///
    /// Prank admin and actor
    
    modifier asAdmin {
        vm.prank(address(this));
        _;
    }

    modifier asActor {
        vm.prank(address(_getActor()));
        _;
    }
}
