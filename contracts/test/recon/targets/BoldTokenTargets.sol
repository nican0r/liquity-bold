// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/BoldToken.sol";

abstract contract BoldTokenTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for transfer with max amount
    function boldToken_transfer_clamped_max(uint256 amount) public asActor {
        uint256 balance = boldToken.balanceOf(_getActor());
        amount = balance > 0 ? amount % (balance + 1) : 0;
        boldToken.transfer(_getActors()[0], amount);
    }

    // Clamped handler for transferFrom with max amount and valid addresses
    function boldToken_transferFrom_clamped(uint256 amount) public asActor {
        address sender = _getActors()[0];
        uint256 maxByBalance = boldToken.balanceOf(sender);
        uint256 maxByAllowance = boldToken.allowance(sender, _getActor());
        uint256 maxAmount = maxByBalance < maxByAllowance ? maxByBalance : maxByAllowance;
        amount = maxAmount > 0 ? amount % (maxAmount + 1) : 0;
        boldToken.transferFrom(sender, _getActors()[0], amount);
    }

    // Clamped handler for approve with valid spender
    function boldToken_approve_clamped(uint256 amount) public asActor {
        boldToken.approve(_getActors()[0], amount);
    }

    // Clamped handler for increaseAllowance with meaningful value
    function boldToken_increaseAllowance_clamped() public asActor {
        boldToken.increaseAllowance(_getActors()[0], 1000e18);
    }

    // Clamped handler for decreaseAllowance with max value
    function boldToken_decreaseAllowance_clamped(uint256 subtractedValue) public asActor {
        address spender = _getActors()[0];
        uint256 allowance = boldToken.allowance(_getActor(), spender);
        subtractedValue = allowance > 0 ? subtractedValue % (allowance + 1) : 0;
        boldToken.decreaseAllowance(spender, subtractedValue);
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function boldToken_approve(address spender, uint256 amount) public asActor {
        boldToken.approve(spender, amount);
    }

    function boldToken_decreaseAllowance(address spender, uint256 subtractedValue) public asActor {
        boldToken.decreaseAllowance(spender, subtractedValue);
    }

    function boldToken_increaseAllowance(address spender, uint256 addedValue) public asActor {
        boldToken.increaseAllowance(spender, addedValue);
    }

    function boldToken_permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public asActor {
        boldToken.permit(owner, spender, value, deadline, v, r, s);
    }

    function boldToken_transfer(address recipient, uint256 amount) public asActor {
        boldToken.transfer(recipient, amount);
    }

    function boldToken_transferFrom(address sender, address recipient, uint256 amount) public asActor {
        boldToken.transferFrom(sender, recipient, amount);
    }
}