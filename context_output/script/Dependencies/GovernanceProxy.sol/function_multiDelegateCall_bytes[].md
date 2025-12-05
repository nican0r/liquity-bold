# Function: multiDelegateCall(bytes[])

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `multiDelegateCall(bytes[])`
- **Visibility**: external
- **Source Range**: 9639:168:110

## Implementation

```solidity
function multiDelegateCall(bytes[] calldata inputs) override external returns (bytes[] memory returnValues) {
    return governance.multiDelegateCall(inputs);
}
```

## External Calls

- **Governance::multiDelegateCall(bytes[])**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.multiDelegateCall(bytes[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Call multiple functions of the contract while preserving `msg.sender`
 @param inputs Function calls to perform, encoded using `abi.encodeCall()` or equivalent
 @return returnValues Raw data returned by each call
