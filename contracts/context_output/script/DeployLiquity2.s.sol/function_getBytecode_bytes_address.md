# Function: getBytecode(bytes,address)

**Contract**: [script/DeployLiquity2.s.sol/contract_DeployLiquity2Script.md]

## Metadata

- **Contract**: DeployLiquity2Script
- **Signature**: `getBytecode(bytes,address)`
- **Visibility**: public
- **Source Range**: 25391:199:112

## Implementation

```solidity
function getBytecode(bytes memory _creationCode, address _addressesRegistry) public pure returns (bytes memory) {
    return abi.encodePacked(_creationCode, abi.encode(_addressesRegistry));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeployLiquity2Script.getBytecode(bytes,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
