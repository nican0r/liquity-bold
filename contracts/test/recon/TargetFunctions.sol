// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import { ActivePoolTargets } from "./targets/ActivePoolTargets.sol";
import { AdminTargets } from "./targets/AdminTargets.sol";
import { BoldTokenTargets } from "./targets/BoldTokenTargets.sol";
import { BorrowerOperationsTargets } from "./targets/BorrowerOperationsTargets.sol";
import { CollSurplusPoolTargets } from "./targets/CollSurplusPoolTargets.sol";
import { CollateralRegistryTargets } from "./targets/CollateralRegistryTargets.sol";
import { DefaultPoolTargets } from "./targets/DefaultPoolTargets.sol";
import { DoomsdayTargets } from "./targets/DoomsdayTargets.sol";
import { ManagersTargets } from "./targets/ManagersTargets.sol";
import { SortedTrovesTargets } from "./targets/SortedTrovesTargets.sol";
import { StabilityPoolTargets } from "./targets/StabilityPoolTargets.sol";
import { TroveManagerTargets } from "./targets/TroveManagerTargets.sol";
import { TroveNFTTargets } from "./targets/TroveNFTTargets.sol";

abstract contract TargetFunctions is
    ActivePoolTargets,
    AdminTargets,
    BoldTokenTargets,
    BorrowerOperationsTargets,
    CollSurplusPoolTargets,
    CollateralRegistryTargets,
    DefaultPoolTargets,
    DoomsdayTargets,
    ManagersTargets,
    SortedTrovesTargets,
    StabilityPoolTargets,
    TroveManagerTargets,
    TroveNFTTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
