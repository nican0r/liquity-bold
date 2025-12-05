# Function: shutdownFromOracleFailure()

**Contract**: [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]

## Metadata

- **Contract**: BorrowerOperationsTester
- **Signature**: `shutdownFromOracleFailure()`
- **Visibility**: external
- **Source Range**: 51272:316:128
- **Inherited From**: BorrowerOperations

## Implementation

```solidity
function shutdownFromOracleFailure() external {
    _requireCallerIsPriceFeed();
    if (hasBeenShutDown) return;
    _applyShutdown();
}
```

## Related Implementations

### _requireCallerIsPriceFeed()

- **Kind**: internal
- **Source**: 63866:157:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireCallerIsPriceFeed()`

```solidity
function _requireCallerIsPriceFeed() internal view {
    if (msg.sender != address(priceFeed)) {
        revert CallerNotPriceFeed();
    }
}
```

### _applyShutdown()

- **Kind**: internal
- **Source**: 51594:145:128
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_applyShutdown()`

```solidity
function _applyShutdown() internal {
    activePool.mintAggInterest();
    hasBeenShutDown = true;
    troveManager.shutdown();
}
```

## State Variable Reads

- **hasBeenShutDown** (`bool`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

## State Variable Writes

- **hasBeenShutDown** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.shutdownFromOracleFailure() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireCallerIsPriceFeed() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._applyShutdown() (NodeID: 2)
      💬 Args: [no args]
      👁️  Def: internal
```
