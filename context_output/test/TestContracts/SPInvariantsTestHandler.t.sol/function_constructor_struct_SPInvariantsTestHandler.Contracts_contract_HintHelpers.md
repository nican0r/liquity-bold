# Function: constructor(struct SPInvariantsTestHandler.Contracts,contract HintHelpers)

**Contract**: [test/TestContracts/SPInvariantsTestHandler.t.sol/contract_SPInvariantsTestHandler.md]

## Metadata

- **Contract**: SPInvariantsTestHandler
- **Signature**: `constructor(struct SPInvariantsTestHandler.Contracts,contract HintHelpers)`
- **Visibility**: public
- **Source Range**: 2440:498:280

## Implementation

```solidity
constructor(Contracts memory contracts, HintHelpers hintHelpers_) {
    boldToken = contracts.boldToken;
    borrowerOperations = contracts.borrowerOperations;
    collateralToken = contracts.collateralToken;
    priceFeed = contracts.priceFeed;
    stabilityPool = contracts.stabilityPool;
    troveManager = contracts.troveManager;
    collSurplusPool = contracts.collSurplusPool;
    hintHelpers = hintHelpers_;
    initialPrice = priceFeed.getPrice();
}
```

## External Calls

- **IPriceFeedTestnet::getPrice()**

## State Variable Reads

- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]

## State Variable Writes

- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **collateralToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **priceFeed** (`contract IPriceFeedTestnet`) [test/TestContracts/Interfaces/IPriceFeedTestnet.sol/interface_IPriceFeedTestnet.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **initialPrice** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SPInvariantsTestHandler.constructor(struct SPInvariantsTestHandler.Contracts,contract HintHelpers) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SPInvariantsTestHandler
```
