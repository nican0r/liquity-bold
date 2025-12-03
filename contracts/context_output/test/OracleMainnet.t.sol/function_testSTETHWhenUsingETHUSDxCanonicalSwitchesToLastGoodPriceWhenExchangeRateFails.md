# Function: testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 57248:1875:244

## Implementation

```solidity
function testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails() public {
    etchStaleMockToStethOracle(address(mockOracle).code);
    (, , , uint256 updatedAt, ) = stethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    assertEq(uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary), "not using primary");
    (uint256 price, bool oracleFailedWhileBranchLive) = wstethPriceFeed.fetchPrice();
    assertTrue(oracleFailedWhileBranchLive, "primary oracle calc didnt fail");
    assertEq(uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.ETHUSDxCanonical), "not using ethusdxcanonical");
    uint256 lastGoodPrice = wstethPriceFeed.lastGoodPrice();
    vm.etch(address(wstETH), address(mockWstethToken).code);
    uint256 rate = wstETH.stEthPerToken();
    assertEq(rate, 0, "mock rate non-zero");
    (price, oracleFailedWhileBranchLive) = wstethPriceFeed.fetchPrice();
    assertFalse(oracleFailedWhileBranchLive);
    assertEq(price, lastGoodPrice, "fetched price != lastGoodPrice");
    assertEq(uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.lastGoodPrice), "not using lastGoodPrice");
}
```

## Related Implementations

### etchStaleMockToStethOracle(bytes)

- **Kind**: internal
- **Source**: 7986:500:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchStaleMockToStethOracle(bytes)`

```solidity
function etchStaleMockToStethOracle(bytes memory _mockOracleCode) internal {
    vm.etch(address(stethOracle), _mockOracleCode);
    ChainlinkOracleMock mock = ChainlinkOracleMock(address(stethOracle));
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
- **IWSTETHPriceFeed::priceSource()**
- **IWSTETHPriceFeed::fetchPrice()**
- **IWSTETHPriceFeed::lastGoodPrice()**
- **Vm::etch(address,bytes)**
- **IWSTETH::stEthPerToken()**

## State Variable Reads

- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **stethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **wstETH** (`contract IWSTETH`) [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]
- **mockWstethToken** (`contract WSTETHTokenMock`) [test/TestContracts/WSTETHTokenMock.sol/contract_WSTETHTokenMock.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testSTETHWhenUsingETHUSDxCanonicalSwitchesToLastGoodPriceWhenExchangeRateFails() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToStethOracle(bytes) (NodeID: 1)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary), "not using primary"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
  │   💬 Args: [oracleFailedWhileBranchLive, "primary oracle calc didnt fail"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.ETHUSDxCanonical), "not using ethusdxcanonical"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [rate, 0, "mock rate non-zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 7)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [price, lastGoodPrice, "fetched price != lastGoodPrice"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
      💬 Args: [uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.lastGoodPrice), "not using lastGoodPrice"]
      👁️  Def: internal
```
