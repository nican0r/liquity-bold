# Function: call(address,bytes)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_FunctionCaller.md]

## Metadata

- **Contract**: FunctionCaller
- **Signature**: `call(address,bytes)`
- **Visibility**: external
- **Source Range**: 3829:162:270

## Implementation

```solidity
function call(address to, bytes calldata callData) external returns (bytes memory) {
    vm.prank(msg.sender);
    return to.functionCall(callData);
}
```

## External Calls

- **Vm::prank(address)**
- **address::functionCall(address,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FunctionCaller.call(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
