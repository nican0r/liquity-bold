# Function: testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 39519:2079:244

## Implementation

```solidity
function testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails() public {
    etchStaleMockToRethOracle(address(mockOracle).code);
    (, , , uint256 updatedAt, ) = rethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    assertEq(uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary), "not using primary");
    (uint256 price, bool oracleFailedWhileBranchLive) = rethPriceFeed.fetchPrice();
    assertTrue(oracleFailedWhileBranchLive, "primary oracle calc didnt fail");
    assertEq(uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.ETHUSDxCanonical), "not using ethusdxcanonical");
    uint256 lastGoodPrice = rethPriceFeed.lastGoodPrice();
    uint256 ethUsdPrice = _getLatestAnswerFromOracle(ethOracle);
    uint256 exchangeRate = rethToken.getExchangeRate();
    assertGt(ethUsdPrice, 0);
    assertGt(exchangeRate, 0);
    etchMockToRethToken();
    uint256 rate = rethToken.getExchangeRate();
    assertEq(rate, 0, "mock rate non-zero");
    (price, oracleFailedWhileBranchLive) = rethPriceFeed.fetchPrice();
    assertFalse(oracleFailedWhileBranchLive);
    assertEq(price, lastGoodPrice, "fetched price != lastGoodPrice");
    assertEq(uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.lastGoodPrice), "not using lastGoodPrice");
}
```

## Related Implementations

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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
}
```

### _getLatestAnswerFromOracle(contract AggregatorV3Interface)

- **Kind**: internal
- **Source**: 6470:355:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:_getLatestAnswerFromOracle(contract AggregatorV3Interface)`

```solidity
function _getLatestAnswerFromOracle(AggregatorV3Interface _oracle) internal view returns (uint256) {
    (, int256 answer, , , ) = _oracle.latestRoundData();
    uint256 decimals = _oracle.decimals();
    assertLe(decimals, 18);
    return uint256(answer) * (10 ** (18 - decimals));
}
```

### assertLe(uint256,uint256)

- **Kind**: internal
- **Source**: 14296:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256)`

```solidity
function assertLe(uint256 left, uint256 right) virtual internal pure {
    vm.assertLe(left, right);
}
```

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### etchMockToRethToken()

- **Kind**: internal
- **Source**: 11136:210:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchMockToRethToken()`

```solidity
function etchMockToRethToken() internal {
    vm.etch(address(rethToken), address(mockRethToken).code);
    RETHTokenMock mock = RETHTokenMock(address(rethToken));
    mock.setExchangeRate(0);
}
```

### assertFalse(bool)

- **Kind**: internal
- **Source**: 1808:91:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool)`

```solidity
function assertFalse(bool data) virtual internal pure {
    vm.assertFalse(data);
}
```

## External Calls

- **AggregatorV3Interface::latestRoundData()**
- **IRETHPriceFeed::priceSource()**
- **IRETHPriceFeed::fetchPrice()**
- **IRETHPriceFeed::lastGoodPrice()**
- **IRETHToken::getExchangeRate()**

## State Variable Reads

- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **rethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **rethToken** (`contract IRETHToken`) [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **mockRethToken** (`contract RETHTokenMock`) [test/TestContracts/RETHTokenMock.sol/contract_RETHTokenMock.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToRethOracle(bytes) (NodeID: 1)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary), "not using primary"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
  │   💬 Args: [oracleFailedWhileBranchLive, "primary oracle calc didnt fail"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.ETHUSDxCanonical), "not using ethusdxcanonical"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 6)
  │   💬 Args: [ethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 7)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 8)
  │   💬 Args: [ethUsdPrice, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 9)
  │   💬 Args: [exchangeRate, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchMockToRethToken() (NodeID: 10)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [rate, 0, "mock rate non-zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 12)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [price, lastGoodPrice, "fetched price != lastGoodPrice"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 14)
      💬 Args: [uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.lastGoodPrice), "not using lastGoodPrice"]
      👁️  Def: internal
```
