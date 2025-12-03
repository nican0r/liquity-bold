# Function: testRevertLowGasRETHOracle()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRevertLowGasRETHOracle()`
- **Visibility**: public
- **Source Range**: 87806:754:244

## Implementation

```solidity
function testRevertLowGasRETHOracle() public {
    (bool success, ) = address(rethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
    assertTrue(success);
    etchGasGuzzlerToRethOracle(address(gasGuzzlerOracle).code);
    vm.expectRevert(MainnetPriceFeedBase.InsufficientGasForExternalCall.selector);
    (bool revertAsExpected, ) = address(rethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
    assertTrue(revertAsExpected);
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

### etchGasGuzzlerToRethOracle(bytes)

- **Kind**: internal
- **Source**: 10209:454:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchGasGuzzlerToRethOracle(bytes)`

```solidity
function etchGasGuzzlerToRethOracle(bytes memory _mockOracleCode) internal {
    vm.etch(address(rethOracle), _mockOracleCode);
    GasGuzzlerOracle mock = GasGuzzlerOracle(address(rethOracle));
    mock.setDecimals(18);
    mock.setPrice(11e17);
    mock.setUpdatedAt(block.timestamp);
}
```

## External Calls

- **unknown::unknown**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **gasGuzzlerOracle** (`contract GasGuzzlerOracle`) [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **rethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRevertLowGasRETHOracle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
  │   💬 Args: [success]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchGasGuzzlerToRethOracle(bytes) (NodeID: 2)
  │   💬 Args: [address(gasGuzzlerOracle).code]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
      💬 Args: [revertAsExpected]
      👁️  Def: internal
```
