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

    // Clamped handler for approve with valid address
    function troveNFT_approve_clamped(uint256 tokenId) public asActor {
        address to = _getActors()[0];
        troveNFT.approve(to, tokenId);
    }

    // Clamped handler for safeTransferFrom with valid addresses
    function troveNFT_safeTransferFrom_clamped(uint256 tokenId) public asActor {
        address from = _getActor();
        address to = _getActors()[0];
        troveNFT.safeTransferFrom(from, to, tokenId);
    }

    // Clamped handler for transferFrom with valid addresses
    function troveNFT_transferFrom_clamped(uint256 tokenId) public asActor {
        address from = _getActor();
        address to = _getActors()[0];
        troveNFT.transferFrom(from, to, tokenId);
    }

    // Clamped handler for setApprovalForAll with valid operator
    function troveNFT_setApprovalForAll_clamped(bool approved) public asActor {
        address operator = _getActors()[0];
        troveNFT.setApprovalForAll(operator, approved);
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function troveNFT_approve(address to, uint256 tokenId) public asActor {
        troveNFT.approve(to, tokenId);
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