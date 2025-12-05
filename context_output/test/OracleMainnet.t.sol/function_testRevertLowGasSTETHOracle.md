# Function: testRevertLowGasSTETHOracle()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRevertLowGasSTETHOracle()`
- **Visibility**: public
- **Source Range**: 87040:760:244

## Implementation

```solidity
function testRevertLowGasSTETHOracle() public {
    (bool success, ) = address(wstethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
    assertTrue(success);
    etchGasGuzzlerToStethOracle(address(gasGuzzlerOracle).code);
    vm.expectRevert(MainnetPriceFeedBase.InsufficientGasForExternalCall.selector);
    (bool revertAsExpected, ) = address(wstethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
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

### etchGasGuzzlerToStethOracle(bytes)

- **Kind**: internal
- **Source**: 10669:461:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchGasGuzzlerToStethOracle(bytes)`

```solidity
function etchGasGuzzlerToStethOracle(bytes memory _mockOracleCode) internal {
    vm.etch(address(stethOracle), _mockOracleCode);
    GasGuzzlerOracle mock = GasGuzzlerOracle(address(stethOracle));
    mock.setDecimals(8);
    mock.setPrice(2000e8);
    mock.setUpdatedAt(block.timestamp);
}
```

## External Calls

- **unknown::unknown**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **gasGuzzlerOracle** (`contract GasGuzzlerOracle`) [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **stethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRevertLowGasSTETHOracle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
  │   💬 Args: [success]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchGasGuzzlerToStethOracle(bytes) (NodeID: 2)
  │   💬 Args: [address(gasGuzzlerOracle).code]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
      💬 Args: [revertAsExpected]
      👁️  Def: internal
```
