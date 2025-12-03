// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/TroveNFT.sol";

abstract contract TroveNFTTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function troveNFT_approve(address to, uint256 tokenId) public asActor {
        troveNFT.approve(to, tokenId);
    }

    function troveNFT_burn(uint256 _troveId) public asActor {
        troveNFT.burn(_troveId);
    }

    function troveNFT_mint(address _owner, uint256 _troveId) public asActor {
        troveNFT.mint(_owner, _troveId);
    }

    function troveNFT_safeTransferFrom(address from, address to, uint256 tokenId) public asActor {
        troveNFT.safeTransferFrom(from, to, tokenId);
    }

    function troveNFT_safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public asActor {
        troveNFT.safeTransferFrom(from, to, tokenId, data);
    }

    function troveNFT_setApprovalForAll(address operator, bool approved) public asActor {
        troveNFT.setApprovalForAll(operator, approved);
    }

    function troveNFT_transferFrom(address from, address to, uint256 tokenId) public asActor {
        troveNFT.transferFrom(from, to, tokenId);
    }
}