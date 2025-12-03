# Function: excludeSelectors()

**Contract**: [test/Utils/E2EHelpers.sol/contract_E2EHelpers.md]

## Metadata

- **Contract**: E2EHelpers
- **Signature**: `excludeSelectors()`
- **Visibility**: public
- **Source Range**: 2754:147:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeSelectors() public view returns (FuzzSelector[] memory excludedSelectors_) {
    excludedSelectors_ = _excludedSelectors;
}
```

## State Variable Reads

- **_excludedSelectors** (`struct StdInvariant.FuzzSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
