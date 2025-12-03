# Function: targetSenders()

**Contract**: [test/AnchoredSPInvariantsTest.t.sol/contract_AnchoredSPInvariantsTest.md]

## Metadata

- **Contract**: AnchoredSPInvariantsTest
- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3684:133:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSenders() public view returns (address[] memory targetedSenders_) {
    targetedSenders_ = _targetedSenders;
}
```

## State Variable Reads

- **_targetedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
