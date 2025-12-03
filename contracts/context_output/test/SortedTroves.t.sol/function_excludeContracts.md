# Function: excludeContracts()

**Contract**: [test/SortedTroves.t.sol/contract_SortedTrovesTest.md]

## Metadata

- **Contract**: SortedTrovesTest
- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_) {
    excludedContracts_ = _excludedContracts;
}
```

## State Variable Reads

- **_excludedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeContracts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
