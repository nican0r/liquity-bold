# Function: getAddress(address,bytes,bytes32)

**Contract**: [test/TestContracts/Deployment.t.sol/contract_TestDeployer.md]

## Metadata

- **Contract**: TestDeployer
- **Signature**: `getAddress(address,bytes,bytes32)`
- **Visibility**: public
- **Source Range**: 7080:325:260

## Implementation

```solidity
function getAddress(address _deployer, bytes memory _bytecode, bytes32 _salt) public pure returns (address) {
    bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), _deployer, _salt, keccak256(_bytecode)));
    return address(uint160(uint256(hash)));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestDeployer.getAddress(address,bytes,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
