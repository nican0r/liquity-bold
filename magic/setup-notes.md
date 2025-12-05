# Setup.sol Documentation

## Overview
This document describes how the fuzzing setup works for the Liquity Bold protocol. The `Setup.sol` contract is responsible for deploying and configuring all target contracts needed for fuzzing with Echidna and Foundry.

## Setup Architecture

### File Location
`test/recon/Setup.sol`

### Inheritance Chain
```
Setup
├── BaseSetup (from Chimera)
├── ActorManager (from recon helpers)
├── AssetManager (from recon helpers)
└── Utils (from recon helpers)
```

## Deployment Strategy

The setup uses the **TestDeployer** pattern from `test/TestContracts/Deployment.t.sol` to deploy the entire Liquity Bold protocol. This approach:

1. **Avoids Code Duplication**: Reuses the existing deployment logic already tested in the test suite
2. **Maintains Consistency**: Ensures fuzzing uses the same deployment parameters as unit tests
3. **Simplifies Maintenance**: Changes to deployment logic only need to be made in one place

## Setup Process

The `setup()` function executes the following steps in order:

### 1. Actor Configuration
```solidity
_addActor(address(0x100)); // Actor 1
_addActor(address(0x200)); // Actor 2
```
- Creates 2 actors with addresses >= `address(0x100)`
- Actors represent different users interacting with the protocol
- These addresses will be used in target functions via the `asActor` modifier

### 2. Collateral Token Deployment
```solidity
_newAsset(DECIMALS); // 18 decimals
```
- Deploys a MockERC20 token to serve as collateral
- Uses 18 decimals (standard ERC20 decimals)
- This token is managed by AssetManager and made available via `_getAsset()`

### 3. Protocol Deployment via TestDeployer
```solidity
TestDeployer deployer = new TestDeployer();
(contracts, collateralRegistry, boldToken, hintHelpers, multiTroveGetter, weth, zappers) = 
    deployer.deployAndConnectContracts();
```

This deploys and connects:
- **AddressesRegistry**: Central registry for contract addresses
- **StabilityPool**: Handles liquidation and stability
- **ActivePool**: Manages active trove collateral
- **TroveManager**: Manages individual troves
- **BorrowerOperations**: User-facing borrowing interface
- **PriceFeed**: Provides collateral price data (testnet version)
- **BoldToken**: The protocol's stablecoin
- **CollateralRegistry**: Manages multiple collateral types
- **HintHelpers**: Provides insertion hints for sorted list
- **MultiTroveGetter**: Batch getter for trove data
- **WETH**: Gas compensation token
- **Zappers**: Convenience contracts for user interactions

### 4. Contract References Storage
```solidity
addressesRegistry = contracts.addressesRegistry;
stabilityPool = contracts.stabilityPool;
activePool = contracts.activePool;
troveManager = contracts.troveManager;
borrowerOperations = contracts.borrowerOperations;
priceFeed = contracts.priceFeed;
```
- Stores contract references as state variables for use in target functions
- Makes contracts accessible throughout the fuzzing session

### 5. Price Feed Configuration
```solidity
IPriceFeedTestnet(address(priceFeed)).setPrice(2000e18);
```
- Sets initial collateral price to 2000 USD (with 18 decimals)
- **CONFIGURABLE**: This can be modified during fuzzing via admin target functions
- Price affects liquidation thresholds and borrowing capacity

### 6. Approval Array Setup
```solidity
address[] memory approvalArray = new address[](2);
approvalArray[0] = address(stabilityPool);
approvalArray[1] = address(activePool);
```
- Defines which contracts can spend actors' collateral tokens
- StabilityPool needs approval for deposits
- ActivePool needs approval for trove collateral

### 7. Asset Finalization
```solidity
_finalizeAssetDeployment(_getActors(), approvalArray, type(uint88).max);
```
This critical step:
- Mints `type(uint88).max` collateral tokens to each actor
- Sets max approvals for StabilityPool and ActivePool to spend collateral
- Ensures actors have sufficient tokens for all fuzzing scenarios

### 8. BOLD Token Approvals
```solidity
vm.prank(address(0x100));
boldToken.approve(address(stabilityPool), type(uint256).max);
vm.prank(address(0x200));
boldToken.approve(address(stabilityPool), type(uint256).max);
```
- Approves StabilityPool to spend actors' BOLD tokens
- Actors will acquire BOLD by opening troves via BorrowerOperations
- Necessary for stability pool deposit operations

## Key Design Decisions

### Why TestDeployer?
The setup uses TestDeployer instead of manually deploying each contract because:
1. **Complexity**: Liquity Bold has many interdependent contracts
2. **Initialization Order**: Contracts must be deployed in specific order
3. **Configuration**: Proper linking between contracts is non-trivial
4. **Testing Parity**: Ensures fuzzing tests the same deployment as unit tests

### Contract Initialization Parameters
All contracts use `address(this)` as the admin/owner where applicable:
- Gives the fuzzing harness full control over the protocol
- Allows admin target functions to modify protocol parameters
- Enables testing of privileged operations

### Token Minting Strategy
Actors receive `type(uint88).max` collateral tokens:
- Large enough to prevent running out during fuzzing
- Small enough to avoid overflow issues in most calculations
- Provides realistic scenarios with bounded liquidity

## Available Contracts for Fuzzing

### Core Protocol Contracts
- `stabilityPool`: Test stability pool deposits, withdrawals, and liquidations
- `borrowerOperations`: Test trove opening, closing, and management
- `troveManager`: Test liquidations and redemptions (typically admin)
- `activePool`: Test collateral and debt accounting
- `boldToken`: Test BOLD token transfers and approvals
- `priceFeed`: Test price updates (admin only in testnet version)

### Supporting Contracts
- `addressesRegistry`: Registry of all contract addresses
- `collateralRegistry`: Multi-collateral management
- `hintHelpers`: Helper for sorted list operations
- `multiTroveGetter`: Batch data retrieval

## Modifiers

### `asActor`
```solidity
modifier asActor {
    vm.prank(address(_getActor()));
    _;
}
```
- Executes function as current actor
- Actor can be switched via `switchActor()` target function
- Used for user-facing operations

### `asAdmin`
```solidity
modifier asAdmin {
    vm.prank(address(this));
    _;
}
```
- Executes function as setup contract (admin)
- Used for privileged operations
- Useful for testing admin functions

## Configuration Parameters

### DECIMALS (Constant)
- **Value**: 18
- **Purpose**: ERC20 token decimals
- **Modifiable**: No (constant)

### Price Feed Initial Price
- **Value**: 2000e18 (2000 USD)
- **Purpose**: Initial collateral price
- **Modifiable**: Yes, via `IPriceFeedTestnet.setPrice()`
- **Location**: Line 75

### Trove Manager Parameters
The TestDeployer uses default parameters:
- **CCR (Critical Collateralization Ratio)**: 150%
- **MCR (Minimum Collateralization Ratio)**: 110%
- **BCR**: 10%
- **SCR**: 110%
- **Liquidation Penalty (SP)**: 5%
- **Liquidation Penalty (Redistribution)**: 10%

These can be tested with different values by modifying the TestDeployer call.

## Integration with Target Functions

Target functions are organized in separate files under `test/recon/targets/`:

### StabilityPoolTargets.sol
- `stabilityPool_provideToSP()`: Deposit BOLD to stability pool
- `stabilityPool_withdrawFromSP()`: Withdraw BOLD from stability pool
- `stabilityPool_claimAllCollGains()`: Claim collateral gains
- `stabilityPool_offset()`: Process liquidation offset
- `stabilityPool_triggerBoldRewards()`: Distribute yield rewards

### AdminTargets.sol
- Currently empty, reserved for admin operations
- Could add price feed updates, parameter changes, etc.

### DoomsdayTargets.sol
- Contains stateless modifier for handler cleanup
- Reserved for extreme edge case testing

### ManagersTargets.sol
- `switchActor()`: Change active actor
- `switch_asset()`: Change active asset
- `add_new_asset()`: Deploy new collateral token
- `asset_approve()`: Approve token spending
- `asset_mint()`: Mint tokens to address

## Testing Verification

### Compilation Check
```bash
forge build
```
Should compile without errors.

### Setup Execution Check
```bash
forge test --match-contract CryticToFoundry -vvv
```
Should pass without reverts in setup phase.

## Common Issues and Solutions

### Issue: "IWETH not found"
**Solution**: Import added at line 27: `import "src/Interfaces/IWETH.sol";`

### Issue: Setup reverts during deployment
**Solution**: Check that TestDeployer dependencies are available and properly imported

### Issue: Actor runs out of tokens
**Solution**: Increase mint amount in `_finalizeAssetDeployment()` call (currently `type(uint88).max`)

### Issue: Approval errors during fuzzing
**Solution**: Verify approval array includes all contracts that need token access

## Future Enhancements

Potential improvements for the setup:

1. **Multi-Collateral Testing**: Deploy multiple collateral types with different parameters
2. **Custom TroveManager Parameters**: Test with various risk parameters
3. **Pre-seeded Troves**: Create initial troves to test with existing state
4. **Batch Operations**: Deploy multiple actors for more complex interactions
5. **Admin Target Functions**: Add functions to modify protocol parameters during fuzzing

## Related Files

- `test/recon/Setup.sol`: This setup contract
- `test/recon/TargetFunctions.sol`: Aggregates all target function contracts
- `test/recon/Properties.sol`: Invariant properties to test
- `test/recon/BeforeAfter.sol`: Ghost variable tracking
- `test/recon/CryticToFoundry.sol`: Foundry test harness
- `test/recon/CryticTester.sol`: Echidna test harness
- `test/TestContracts/Deployment.t.sol`: TestDeployer implementation
- `lib/chimera/`: Chimera fuzzing framework
- `lib/setup-helpers/`: Recon fuzzing helpers (ActorManager, AssetManager)

## Summary

The setup successfully:
✅ Deploys all required Liquity Bold protocol contracts
✅ Configures 2 actors with sufficient collateral tokens
✅ Sets up proper approvals for StabilityPool and ActivePool
✅ Initializes price feed with reasonable default
✅ Provides access to all contracts via state variables
✅ Compiles without errors
✅ Executes without reverts

The setup is production-ready for fuzzing campaigns with Echidna and Foundry.
