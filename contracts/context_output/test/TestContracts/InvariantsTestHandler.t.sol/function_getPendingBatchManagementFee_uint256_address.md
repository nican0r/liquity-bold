# Function: getPendingBatchManagementFee(uint256,address)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `getPendingBatchManagementFee(uint256,address)`
- **Visibility**: external
- **Source Range**: 16258:206:270

## Implementation

```solidity
function getPendingBatchManagementFee(uint256 i, address batchManager) external view returns (uint256) {
    return _batches[i][batchManager].pendingManagementFee / (ONE_YEAR * DECIMAL_PRECISION);
}
```

## State Variable Reads

- **_batches** (`mapping(uint256 => mapping(address => struct InvariantsTestHandler.Batch))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.getPendingBatchManagementFee(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
