# Function: targetContracts()

**Contract**: [test/interestRateAggregate.t.sol/contract_InterestRateAggregate.md]

## Metadata

- **Contract**: InterestRateAggregate
- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 3385:141:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetContracts() public view returns (address[] memory targetedContracts_) {
    targetedContracts_ = _targetedContracts;
}
```

## State Variable Reads

- **_targetedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetContracts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
