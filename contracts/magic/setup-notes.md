# Setup.sol Documentation

## Overview

The `Setup.sol` contract provides the fuzzing environment configuration for the Liquity Bold protocol's StabilityPool contract. It deploys and initializes all necessary contracts and dependencies, preparing them for fuzzing with Echidna and Foundry.

## Architecture

### Target Contract
The primary target for fuzzing is the **StabilityPool** contract, which:
- Holds Bold tokens deposited by stability pool depositors
- Absorbs debt from liquidated troves
- Distributes collateral gains to depositors
- Manages BOLD yield rewards

### Key Dependencies

The Setup uses the `TestDeployer` from the test infrastructure to deploy a complete Liquity Bold system, which includes:

1. **Core Protocol Contracts**:
   - `StabilityPool` - The main fuzzing target
   - `ActivePool` - Manages active trove collateral and debt
   - `TroveManager` - Handles trove operations and liquidations
   - `BorrowerOperations` - Manages borrower interactions
   - `BoldToken` - The system's stablecoin

2. **Supporting Contracts**:
   - `AddressesRegistry` - Central registry for contract addresses
   - `CollateralRegistry` - Manages collateral types
   - `PriceFeed` - Provides price oracle functionality
   - `HintHelpers` & `MultiTroveGetter` - Helper contracts for gas optimization

## Setup Process

### 1. Actor Management
```solidity
_addActor(address(0x100)); // Actor 1
_addActor(address(0x200)); // Actor 2
```
Two actors are configured to interact with the system during fuzzing.

### 2. Asset Deployment
```solidity
_newAsset(DECIMALS);
```
Creates a mock ERC20 token with 18 decimals to serve as the collateral token.

### 3. System Deployment
The setup leverages `TestDeployer.deployAndConnectContracts()` which:
- Deploys all protocol contracts with proper dependencies
- Configures the AddressesRegistry with all contract addresses
- Sets up token approvals between contracts
- Initializes all state properly

### 4. Price Configuration
```solidity
IPriceFeedTestnet(address(priceFeed)).setPrice(2000e18);
```
**CONFIGURABLE**: The collateral price is set to 2000 BOLD (2000e18). This can be modified during fuzzing via `priceFeed.setPrice()`.

### 5. Token Approvals
Actors are configured with:
- Infinite collateral token approvals for StabilityPool and ActivePool
- Infinite BOLD token approvals for StabilityPool

## Configuration Parameters

### Immutable Parameters (set in AddressesRegistry)
These are configured by TestDeployer and cannot be changed during fuzzing:
- **CCR (Critical Collateral Ratio)**: 150% (150e16)
- **MCR (Minimum Collateral Ratio)**: 110% (110e16)  
- **BCR (Batch Collateral Ratio Buffer)**: 10% (10e16)
- **SCR (Shutdown Collateral Ratio)**: 110% (110e16)
- **LIQUIDATION_PENALTY_SP**: 5% (5e16)
- **LIQUIDATION_PENALTY_REDISTRIBUTION**: 10% (10e16)

### Runtime Configurable Parameters
These can be modified via target functions:
- **Collateral Price**: Configurable via `priceFeed.setPrice(uint256)`
- All StabilityPool parameters are configurable through its interface

## Token Flow

1. **Collateral Tokens**: 
   - Actors receive `type(uint88).max` collateral tokens
   - Pre-approved for StabilityPool and ActivePool

2. **BOLD Tokens**:
   - Actors do NOT receive BOLD initially
   - Must acquire BOLD by opening troves via BorrowerOperations
   - Pre-approved for StabilityPool spending

## Target Functions

The following target function categories are available:

### StabilityPool Operations
- `stabilityPool_provideToSP(uint256 _topUp, bool _doClaim)` - Deposit BOLD to stability pool
- `stabilityPool_withdrawFromSP(uint256 _amount, bool _doClaim)` - Withdraw BOLD from stability pool
- `stabilityPool_claimAllCollGains()` - Claim accumulated collateral gains
- `stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd)` - Offset debt (liquidation)
- `stabilityPool_triggerBoldRewards(uint256 _boldYield)` - Distribute yield rewards

### Manager Operations  
- `switchActor(uint256 entropy)` - Switch between actors
- `switch_asset(uint256 entropy)` - Switch between assets (if multiple deployed)
- `add_new_asset(uint8 decimals)` - Deploy new collateral token
- `asset_approve(address to, uint128 amt)` - Approve token spending
- `asset_mint(address to, uint128 amt)` - Mint tokens (admin only)

## Testing

### Compilation
```bash
forge build
```

### Test Execution
```bash
forge test --match-contract CryticToFoundry -vvv
```

The setup has been validated to compile successfully and execute without reverts in the test harness.

## Notes for Agents

### For Property Specification (properties-phase-*)
When writing properties/invariants:
- StabilityPool balance should always equal sum of depositor balances
- Collateral gains should be distributed proportionally to deposits
- No BOLD can be created or destroyed (except via offset/mint operations)
- Total system debt should remain consistent

### For Coverage Analysis (coverage-phase-*)
Key functions to ensure coverage:
- Deposit/withdrawal flows in various states
- Liquidation scenarios (offset operations)
- Yield distribution mechanics
- Edge cases: empty pool, single depositor, scale changes

### For Handler Implementation
Handlers should:
- Respect the actor model (use `asActor` modifier)
- Handle preconditions (e.g., sufficient BOLD balance before deposit)
- Consider the full liquidation flow (actors need troves to liquidate)
- Account for time-dependent operations (interest accrual)

## Troubleshooting

### Common Issues

1. **"Caller is not BO or AP" errors**: BOLD tokens can only be minted by BorrowerOperations or ActivePool. Actors must open troves to get BOLD.

2. **Insufficient BOLD balance**: Actors start with no BOLD. They need to:
   - Open a trove via BorrowerOperations with collateral
   - This will mint BOLD against their collateral

3. **Approval issues**: All approvals are pre-configured. If you see approval errors, check that you're using the correct actor context (`asActor` modifier).

## Version Info
- Solidity: 0.8.24
- Foundry: Latest
- Chimera: Latest (from lib/chimera)
