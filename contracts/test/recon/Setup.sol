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
import "src/AddressesRegistry.sol";
import "src/BoldToken.sol";
import "src/TroveManager.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    AddressesRegistry addressesRegistry;
    BoldToken boldToken;
    TroveManager troveManager;
    
    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        addressesRegistry = new AddressesRegistry(); // TODO: Add parameters here
        boldToken = new BoldToken(); // TODO: Add parameters here
        troveManager = new TroveManager(); // TODO: Add parameters here
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
