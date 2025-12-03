# Function: targetSelectors()

**Contract**: [test/E2E.t.sol/contract_E2ETest.md]

## Metadata

- **Contract**: E2ETest
- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3532:146:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_) {
    targetedSelectors_ = _targetedSelectors;
}
```

## State Variable Reads

- **_targetedSelectors** (`struct StdInvariant.FuzzSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
