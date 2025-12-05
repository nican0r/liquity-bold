# Function: testRevertLowGasWSTETHToken()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRevertLowGasWSTETHToken()`
- **Visibility**: public
- **Source Range**: 89390:759:244

## Implementation

```solidity
function testRevertLowGasWSTETHToken() public {
    (bool success, ) = address(wstethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
    assertTrue(success);
    etchGasGuzzlerMockToWstethToken(address(gasGuzzlerToken).code);
    vm.expectRevert(MainnetPriceFeedBase.InsufficientGasForExternalCall.selector);
    (bool revertsAsExpected, ) = address(wstethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
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

### etchGasGuzzlerMockToWstethToken(bytes)

- **Kind**: internal
- **Source**: 11551:192:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchGasGuzzlerMockToWstethToken(bytes)`

```solidity
function etchGasGuzzlerMockToWstethToken(bytes memory _mockTokenCode) internal {
    vm.etch(address(wstETH), _mockTokenCode);
}
```

## External Calls

- **unknown::unknown**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **gasGuzzlerToken** (`contract GasGuzzlerToken`) [test/TestContracts/GasGuzzlerToken.sol/contract_GasGuzzlerToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **wstETH** (`contract IWSTETH`) [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRevertLowGasWSTETHToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
  │   💬 Args: [success]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchGasGuzzlerMockToWstethToken(bytes) (NodeID: 2)
  │   💬 Args: [address(gasGuzzlerToken).code]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
      💬 Args: [revertsAsExpected]
      👁️  Def: internal
```
