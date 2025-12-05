# Function: testRevertLowGasETHOracle()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRevertLowGasETHOracle()`
- **Visibility**: public
- **Source Range**: 88566:752:244

## Implementation

```solidity
function testRevertLowGasETHOracle() public {
    (bool success, ) = address(wethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
    assertTrue(success);
    etchGasGuzzlerToEthOracle(address(gasGuzzlerOracle).code);
    vm.expectRevert(MainnetPriceFeedBase.InsufficientGasForExternalCall.selector);
    (bool revertAsExpected, ) = address(wethPriceFeed).call{gas: 500000}(abi.encodeWithSignature("fetchPrice()"));
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

### etchGasGuzzlerToEthOracle(bytes)

- **Kind**: internal
- **Source**: 9792:411:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchGasGuzzlerToEthOracle(bytes)`

```solidity
function etchGasGuzzlerToEthOracle(bytes memory _mockOracleCode) internal {
    vm.etch(address(ethOracle), _mockOracleCode);
    GasGuzzlerOracle mock = GasGuzzlerOracle(address(ethOracle));
    mock.setDecimals(8);
    mock.setPrice(2000e8);
    mock.setUpdatedAt(block.timestamp);
}
```

## External Calls

- **unknown::unknown**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **wethPriceFeed** (`contract IMainnetPriceFeed`) [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]
- **gasGuzzlerOracle** (`contract GasGuzzlerOracle`) [test/TestContracts/GasGuzzlerOracle.sol/contract_GasGuzzlerOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRevertLowGasETHOracle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
  │   💬 Args: [success]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchGasGuzzlerToEthOracle(bytes) (NodeID: 2)
  │   💬 Args: [address(gasGuzzlerOracle).code]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
      💬 Args: [revertAsExpected]
      👁️  Def: internal
```
