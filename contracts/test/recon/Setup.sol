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

// Interfaces
import "src/Interfaces/IAddressesRegistry.sol";
import "src/Interfaces/IStabilityPool.sol";
import "src/Interfaces/IBoldToken.sol";
import "src/Interfaces/IActivePool.sol";
import "src/Interfaces/ITroveManager.sol";
import "src/Interfaces/IBorrowerOperations.sol";
import "src/Interfaces/IPriceFeed.sol";
import "src/Interfaces/ICollateralRegistry.sol";
import "src/Interfaces/IHintHelpers.sol";
import "src/Interfaces/IMultiTroveGetter.sol";
import {IPriceFeedTestnet} from "test/TestContracts/Interfaces/IPriceFeedTestnet.sol";
import "src/Interfaces/IWETH.sol";

// Use the test deployer to avoid circular dependencies
import {TestDeployer} from "test/TestContracts/Deployment.t.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    // Configuration constants
    uint8 internal constant DECIMALS = 18;
    
    // Core contracts
    IStabilityPool internal stabilityPool;
    IAddressesRegistry internal addressesRegistry;
    IBoldToken internal boldToken;
    IActivePool internal activePool;
    ITroveManager internal troveManager;
    IBorrowerOperations internal borrowerOperations;
    IPriceFeed internal priceFeed;
    
    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        // 1. Add actors
        _addActor(address(0x100)); // Actor 1
        _addActor(address(0x200)); // Actor 2

        // 2. Create collateral token using AssetManager (will be used as the collateral)
        _newAsset(DECIMALS);
        
        // 3. Use TestDeployer to deploy all contracts properly
        TestDeployer deployer = new TestDeployer();
        TestDeployer.LiquityContractsDev memory contracts;
        TestDeployer.Zappers memory zappers;
        ICollateralRegistry collateralRegistry;
        IHintHelpers hintHelpers;
        IMultiTroveGetter multiTroveGetter;
        IWETH weth;
        
        (contracts, collateralRegistry, boldToken, hintHelpers, multiTroveGetter, weth, zappers) = 
            deployer.deployAndConnectContracts();
        
        // 4. Store contract references for use in tests
        addressesRegistry = contracts.addressesRegistry;
        stabilityPool = contracts.stabilityPool;
        activePool = contracts.activePool;
        troveManager = contracts.troveManager;
        borrowerOperations = contracts.borrowerOperations;
        priceFeed = contracts.priceFeed;
        
        // 5. Set price in price feed to a reasonable value
        IPriceFeedTestnet(address(priceFeed)).setPrice(2000e18); // CONFIGURABLE: Price can be modified via priceFeed.setPrice()
        
        // 6. Set up approval array for contracts that need token access
        // Actors will need to approve StabilityPool and ActivePool to spend their tokens
        address[] memory approvalArray = new address[](2);
        approvalArray[0] = address(stabilityPool);
        approvalArray[1] = address(activePool);
        
        // 7. Finalize asset deployment (mints collateral tokens to actors and sets approvals)
        _finalizeAssetDeployment(_getActors(), approvalArray, type(uint88).max);
        
        // 8. Approve BOLD spending by StabilityPool for actors
        // Actors will get BOLD by opening troves via BorrowerOperations
        vm.prank(address(0x100));
        boldToken.approve(address(stabilityPool), type(uint256).max);
        vm.prank(address(0x200));
        boldToken.approve(address(stabilityPool), type(uint256).max);
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
