# Function: excludeArtifacts()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2459:141:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_) {
    excludedArtifacts_ = _excludedArtifacts;
}
```

## State Variable Reads

- **_excludedArtifacts** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeArtifacts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
