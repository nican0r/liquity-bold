# Function: receive()

**Contract**: [test/TestContracts/NonPayableSwitch.sol/contract_NonPayableSwitch.md]

## Metadata

- **Contract**: NonPayableSwitch
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1012:62:276

## Implementation

```solidity
receive() external payable {
    require(isPayable);
}
```

## State Variable Reads

- **isPayable** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NonPayableSwitch.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
