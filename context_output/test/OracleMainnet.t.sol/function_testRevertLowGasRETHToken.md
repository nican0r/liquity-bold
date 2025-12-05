# Function: testRevertLowGasRETHToken()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRevertLowGasRETHToken()`
- **Visibility**: public
- **Source Range**: 90155:751:244

## Implementation

```solidity
function testRevertLowGasRETHToken() public {
    (bool success, ) = address(rethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
    assertTrue(success);
    etchGasGuzzlerMockToRethToken(address(gasGuzzlerToken).code);
    vm.expectRevert(MainnetPriceFeedBase.InsufficientGasForExternalCall.selector);
    (bool revertsAsExpected, ) = address(rethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
    assertTrue(revertsAsExpected);
}
```

## Related Implementations

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1594:89:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    vm.assertTrue(data);
}
```

### etchGasGuzzlerMockToRethToken(bytes)

- **Kind**: internal
- **Source**: 11352:193:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchGasGuzzlerMockToRethToken(bytes)`

```solidity
function etchGasGuzzlerMockToRethToken(bytes memory _mockTokenCode) internal {
    vm.etch(address(rethToken), _mockTokenCode);
}
```

## External Calls

- **unknown::unknown**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **gasGuzzlerToken** (`contract GasGuzzlerToken`) [test/TestContracts/GasGuzzlerToken.sol/contract_GasGuzzlerToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **rethToken** (`contract IRETHToken`) [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRevertLowGasRETHToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
  │   💬 Args: [success]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchGasGuzzlerMockToRethToken(bytes) (NodeID: 2)
  │   💬 Args: [address(gasGuzzlerToken).code]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
      💬 Args: [revertsAsExpected]
      👁️  Def: internal
```
