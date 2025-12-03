# Function: testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail()`
- **Visibility**: public
- **Source Range**: 46256:1068:244

## Implementation

```solidity
function testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail() public {
    rethPriceFeed.fetchPrice();
    uint256 lastGoodPrice1 = rethPriceFeed.lastGoodPrice();
    assertGt(lastGoodPrice1, 0, "lastGoodPrice 0");
    assertEq(uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary));
    etchStaleMockToEthOracle(address(mockOracle).code);
    (, int256 mockPrice, , uint256 updatedAt, ) = ethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    etchStaleMockToRethOracle(address(mockOracle).code);
    (, mockPrice, , updatedAt, ) = rethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    rethPriceFeed.fetchPrice();
    assertEq(uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.lastGoodPrice));
}
```

## Related Implementations

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### etchStaleMockToEthOracle(bytes)

- **Kind**: internal
- **Source**: 7034:450:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchStaleMockToEthOracle(bytes)`

```solidity
function etchStaleMockToEthOracle(bytes memory _mockOracleCode) internal {
    vm.etch(address(ethOracle), _mockOracleCode);
    ChainlinkOracleMock mock = ChainlinkOracleMock(address(ethOracle));
    mock.setDecimals(8);
    mock.setPrice(2000e8);
    mock.setUpdatedAt(block.timestamp - 7 days);
}
```

### etchStaleMockToRethOracle(bytes)

- **Kind**: internal
- **Source**: 7490:490:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchStaleMockToRethOracle(bytes)`

```solidity
function etchStaleMockToRethOracle(bytes memory _mockOracleCode) internal {
    vm.etch(address(rethOracle), _mockOracleCode);
    ChainlinkOracleMock mock = ChainlinkOracleMock(address(rethOracle));
    mock.setDecimals(18);
    mock.setPrice(1e18);
    mock.setUpdatedAt(block.timestamp - 7 days);
}
```

## External Calls

- **IRETHPriceFeed::fetchPrice()**
- **IRETHPriceFeed::lastGoodPrice()**
- **IRETHPriceFeed::priceSource()**
- **AggregatorV3Interface::latestRoundData()**

## State Variable Reads

- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **rethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRETHPriceSourceIsLastGoodPriceWhenBothOraclesFail() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [lastGoodPrice1, 0, "lastGoodPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToEthOracle(bytes) (NodeID: 3)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToRethOracle(bytes) (NodeID: 5)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
      💬 Args: [uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.lastGoodPrice)]
      👁️  Def: internal
```
