// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "src/NFTMetadata/MetadataNFT.sol";

/// @dev Mock MetadataNFT for Echidna testing that doesn't require file system access
/// This is a minimal implementation that satisfies the IMetadataNFT interface
contract MockMetadataNFT is IMetadataNFT {
    function uri(TroveData memory /* _troveData */) external pure override returns (string memory) {
        // Return a minimal valid data URI for testing purposes
        return "data:application/json,{}";
    }
}
