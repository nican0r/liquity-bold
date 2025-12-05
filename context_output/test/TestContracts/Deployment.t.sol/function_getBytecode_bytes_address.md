# Function: getBytecode(bytes,address)

**Contract**: [test/TestContracts/Deployment.t.sol/contract_TestDeployer.md]

## Metadata

- **Contract**: TestDeployer
- **Signature**: `getBytecode(bytes,address)`
- **Visibility**: public
- **Source Range**: 6875:199:260

## Implementation

```solidity
function getBytecode(bytes memory _creationCode, address _addressesRegistry) public pure returns (bytes memory) {
    return abi.encodePacked(_creationCode, abi.encode(_addressesRegistry));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestDeployer.getBytecode(bytes,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
