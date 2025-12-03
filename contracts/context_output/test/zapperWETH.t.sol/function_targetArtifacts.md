# Function: targetArtifacts()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 3047:140:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_) {
    targetedArtifacts_ = _targetedArtifacts;
}
```

## State Variable Reads

- **_targetedArtifacts** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetArtifacts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
