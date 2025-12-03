# Liquity Bold Fuzzing Setup Documentation

## Overview

This document describes the fuzzing setup for the Liquity Bold protocol, configured in `test/recon/Setup.sol`. The setup deploys and initializes all core protocol contracts required for property-based fuzzing tests.

## Architecture

The Liquity Bold protocol consists of several interconnected smart contracts that manage collateralized debt positions (Troves). The setup handles complex circular dependencies between contracts through a multi-stage deployment process.

## System Parameters

The following system-wide parameters are configured as constants:

- **CCR (Critical Collateralization Ratio)**: 150% - System-wide threshold below which borrowing restrictions apply
- **MCR (Minimum Collateralization Ratio)**: 110% - Minimum collateralization for individual Troves
- **BCR (Batch Collateralization Ratio Buffer)**: 10% - Extra buffer required for batch operations
- **SCR (Shutdown Collateralization Ratio)**: 110% - Threshold triggering system shutdown
- **LIQUIDATION_PENALTY_SP**: 5% - Penalty for Troves liquidated to Stability Pool
- **LIQUIDATION_PENALTY_REDISTRIBUTION**: 10% - Penalty for redistributed liquidations

## Deployment Strategy

Due to circular dependencies (contracts reading addresses from AddressesRegistry in their constructors), the deployment follows a three-stage approach:

### Stage 1: Bootstrap Deployment
1. Deploy basic infrastructure:
   - WETHTester (collateral token)
   - BoldToken (stablecoin)
   - PriceFeedTestnet (mock oracle)
   - MockInterestRouter (mock interest calculator)
   - MetadataNFT (for Trove NFT metadata)

2. Create temporary mock contracts:
   - MockActivePool
   - MockDefaultPool
   - MockWETH

3. Deploy first AddressesRegistry with mock addresses
4. Deploy contracts that don't have circular dependencies:
   - TroveNFT
   - CollSurplusPool
   - SortedTroves
   - GasPool

### Stage 2: Core Pool Deployment
1. Deploy second AddressesRegistry with real TroveNFT but still mock pools
2. Deploy ActivePool and DefaultPool (which need priceFeed and basic setup)

### Stage 3: Final Contract Deployment
1. Deploy third AddressesRegistry with real ActivePool/DefaultPool
2. Deploy contracts requiring ActivePool:
   - BorrowerOperations
   - TroveManager
   - StabilityPool

3. Deploy CollateralRegistry (aggregates all branches)
4. Deploy helper contracts:
   - HintHelpers
   - MultiTroveGetter

5. Create final AddressesRegistry and set all addresses
6. Configure BoldToken with branch addresses
7. Set CollateralRegistry in BoldToken (renounces BoldToken ownership)

## Actor and Asset Setup

### Actors
Two actors are created for fuzzing:
- Actor 1: `address(0x100)`
- Actor 2: `address(0x200)`

### Asset Management
- Collateral token (WETH) is added to AssetManager
- Each actor receives `type(uint88).max` tokens
- Actors have maximum approvals for:
  - BorrowerOperations
  - ActivePool
  - DefaultPool
  - StabilityPool

## Core Contracts

### BorrowerOperations
Entry point for users to:
- Open new Troves
- Adjust existing Troves (add/remove collateral, borrow/repay debt)
- Close Troves
- Manage interest rate delegates and batch managers

### TroveManager
Manages Trove lifecycle:
- Liquidations (individual and batch)
- Redemptions
- Interest rate tracking
- Trove status management

### ActivePool
Holds collateral and tracks debt for all active Troves. Routes interest payments to StabilityPool and handles collateral movements during liquidations.

### DefaultPool
Temporary storage for collateral and debt from liquidated Troves pending redistribution to remaining Troves.

### StabilityPool
Users deposit BOLD to:
- Earn liquidation gains
- Stabilize the system by absorbing liquidated debt
- Receive interest yield from borrowers

### SortedTroves
Doubly-linked list maintaining Troves ordered by interest rate for efficient redemption ordering.

### CollateralRegistry
Aggregates multiple collateral branches, handles redemptions across all collateral types, and manages base redemption rate.

### BoldToken
ERC20 stablecoin with:
- Transfer protection for core contracts
- Minting/burning permissions for authorized contracts
- Branch registration system

## Helper Contracts

### GasPool
Holds WETH for gas compensation:
- Receives gas compensation when Troves open
- Refunds gas compensation when Troves close
- Pays liquidators during liquidations

### HintHelpers
Provides insertion hints for SortedTroves to optimize gas costs when opening/adjusting Troves.

### MultiTroveGetter
Batch getter for retrieving multiple Trove data in a single call.

## Test Mocks

### PriceFeedTestnet
Simple price oracle for testing with manual price setting capability. Default price: 200 BOLD per collateral unit.

### MockInterestRouter
Empty implementation of IInterestRouter for testing purposes.

### WETHTester
Test version of WETH with:
- Faucet functionality
- Owner-controlled minting
- Standard WETH deposit/withdrawal

## Key Design Decisions

### Why Multiple AddressesRegistry Deployments?
The AddressesRegistry.setAddresses() function renounces ownership after being called once. Since contracts read their dependencies from the registry in their constructors, we need to:
1. Deploy temporary registries with mock addresses
2. Deploy real contracts in dependency order
3. Create a final registry with all real addresses

This avoids CREATE2 complexity while handling circular dependencies.

### Why Manual Minting Instead of _finalizeAssetDeployment?
The WETHTester requires `onlyOwner` for minting, incompatible with AssetManager's expectation of permissionless MockERC20. Manual minting as contract owner then pranking for approvals provides the same result.

### Actor Address Selection
Addresses `0x100` and `0x200` are chosen to:
- Be easily identifiable in traces
- Avoid collision with precompiles (0x01-0x09)
- Be above the minimum requirement (>= 0x100 per setup guidelines)

## Configurable Parameters

While constructor parameters are immutable, several aspects can be modified through target functions:

- Price (via PriceFeedTestnet.setPrice())
- Trove collateral and debt (via BorrowerOperations)
- Stability Pool deposits (via StabilityPool)
- Interest rates (via BorrowerOperations and delegates)
- Batch manager configurations (via BorrowerOperations)

## Verification

The setup is verified by:
1. Successful compilation with `forge build`
2. Successful execution of `forge test --match-contract CryticToFoundry -vvv`
3. No reverts in setup() function
4. All contracts deployed and initialized
5. Actors funded with collateral and approvals set

## Future Agents

This setup provides the foundation for subsequent fuzzing phases:
- Phase 1: Identify and prepare contracts for invariant scaffolding
- Phase 2: Implement admin functions for parameter configuration
- Phase 3: Test setup correctness
- Coverage Phases: Implement handlers and achieve full coverage

## Contract Addresses (After Setup)

All contract addresses are stored in the Setup contract's state variables and accessible to target functions and invariants:
- addressesRegistry
- activePool
- boldToken
- borrowerOperations
- collSurplusPool
- collateralRegistry
- defaultPool
- gasPool
- sortedTroves
- stabilityPool
- troveManager
- troveNFT
- metadataNFT
- hintHelpers
- multiTroveGetter
- priceFeed
- interestRouter
- collToken
