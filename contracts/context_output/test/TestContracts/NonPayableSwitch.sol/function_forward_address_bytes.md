# Function: forward(address,bytes)

**Contract**: [test/TestContracts/NonPayableSwitch.sol/contract_NonPayableSwitch.md]

## Metadata

- **Contract**: NonPayableSwitch
- **Signature**: `forward(address,bytes)`
- **Visibility**: external
- **Source Range**: 454:380:276

## Implementation

```solidity
function forward(address _dest, bytes calldata _data) external payable {
    (bool success, bytes memory returnData) = _dest.call{value: msg.value}(_data);
    require(success, string(returnData));
}
```

## External Calls

- **unknown::unknown**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NonPayableSwitch.forward(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
