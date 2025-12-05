# Function: testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 28754:1184:244

## Implementation

```solidity
function testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails() public {
    wethPriceFeed.fetchPrice();
    uint256 lastGoodPrice1 = wethPriceFeed.lastGoodPrice();
    assertGt(lastGoodPrice1, 0, "lastGoodPrice 0");
    etchStaleMockToEthOracle(address(mockOracle).code);
    (, int256 mockPrice, , uint256 updatedAt, ) = ethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    assertGt(mockPrice, 0, "mockPrice 0");
    assertNotEq(lastGoodPrice1, uint256(mockPrice));
    (uint256 price, bool ethUsdFailed) = wethPriceFeed.fetchPrice();
    assertTrue(ethUsdFailed);
    assertEq(price, lastGoodPrice1, "current price != lastGoodPrice");
    assertEq(wethPriceFeed.lastGoodPrice(), lastGoodPrice1, "lastGoodPrice not same");
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### assertGt(int256,int256,string)

- **Kind**: internal
- **Source**: 13822:132:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(int256,int256,string)`

```solidity
function assertGt(int256 left, int256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertNotEq(uint256,uint256)

- **Kind**: internal
- **Source**: 7186:116:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(uint256,uint256)`

```solidity
function assertNotEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertNotEq(left, right);
}
```

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1594:89:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    vm.assertTrue(data);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **IMainnetPriceFeed::fetchPrice()**
- **IMainnetPriceFeed::lastGoodPrice()**
- **AggregatorV3Interface::latestRoundData()**

## State Variable Reads

- **wethPriceFeed** (`contract IMainnetPriceFeed`) [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]
- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testWETHPriceFeedReturnsLastGoodPriceWhenETHUSDOracleFails() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [lastGoodPrice1, 0, "lastGoodPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToEthOracle(bytes) (NodeID: 2)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(int256,int256,string) (NodeID: 4)
  │   💬 Args: [mockPrice, 0, "mockPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [lastGoodPrice1, uint256(mockPrice)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 6)
  │   💬 Args: [ethUsdFailed]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [price, lastGoodPrice1, "current price != lastGoodPrice"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
      💬 Args: [wethPriceFeed.lastGoodPrice(), lastGoodPrice1, "lastGoodPrice not same"]
      👁️  Def: internal
```
