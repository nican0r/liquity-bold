# Function: testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 53261:988:244

## Implementation

```solidity
function testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails() public {
    etchStaleMockToStethOracle(address(mockOracle).code);
    (, , , uint256 updatedAt, ) = stethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    (uint256 price, bool oracleFailedWhileBranchLive) = wstethPriceFeed.fetchPrice();
    assertTrue(oracleFailedWhileBranchLive);
    uint256 ethUsdPrice = _getLatestAnswerFromOracle(ethOracle);
    uint256 exchangeRate = wstETH.stEthPerToken();
    assertGt(ethUsdPrice, 0);
    assertGt(exchangeRate, 0);
    uint256 expectedPrice = LiquityMath._min(wstethPriceFeed.lastGoodPrice(), (ethUsdPrice * exchangeRate) / 1e18);
    assertEq(price, expectedPrice, "price not expected price");
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

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1594:89:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    vm.assertTrue(data);
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

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
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

- **AggregatorV3Interface::latestRoundData()**
- **IWSTETHPriceFeed::fetchPrice()**
- **IWSTETH::stEthPerToken()**
- **IWSTETHPriceFeed::lastGoodPrice()**

## State Variable Reads

- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **stethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **wstETH** (`contract IWSTETH`) [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testFetchPriceReturnsMinETHUSDxCanonicalAndLastGoodPriceWhenSTETHUSDOracleFails() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToStethOracle(bytes) (NodeID: 1)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 4)
  │   💬 Args: [ethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 5)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 6)
  │   💬 Args: [ethUsdPrice, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 7)
  │   💬 Args: [exchangeRate, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 8)
  │   💬 Args: [wstethPriceFeed.lastGoodPrice(), (ethUsdPrice * exchangeRate) / 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
      💬 Args: [price, expectedPrice, "price not expected price"]
      👁️  Def: internal
```
