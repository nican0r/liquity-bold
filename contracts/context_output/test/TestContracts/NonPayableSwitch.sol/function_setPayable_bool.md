# Function: setPayable(bool)

**Contract**: [test/TestContracts/NonPayableSwitch.sol/contract_NonPayableSwitch.md]

## Metadata

- **Contract**: NonPayableSwitch
- **Signature**: `setPayable(bool)`
- **Visibility**: external
- **Source Range**: 363:85:276

## Implementation

```solidity
function setPayable(bool _isPayable) external {
    isPayable = _isPayable;
}
```

## State Variable Writes

- **isPayable** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NonPayableSwitch.setPayable(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
