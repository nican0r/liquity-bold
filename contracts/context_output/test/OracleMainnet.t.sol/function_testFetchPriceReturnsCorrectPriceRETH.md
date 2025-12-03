# Function: testFetchPriceReturnsCorrectPriceRETH()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testFetchPriceReturnsCorrectPriceRETH()`
- **Visibility**: public
- **Source Range**: 13674:727:244

## Implementation

```solidity
function testFetchPriceReturnsCorrectPriceRETH() public {
    (uint256 fetchedRethUsdPrice, ) = rethPriceFeed.fetchPrice();
    assertGt(fetchedRethUsdPrice, 0);
    uint256 latestAnswerREthEth = _getLatestAnswerFromOracle(rethOracle);
    uint256 latestAnswerEthUsd = _getLatestAnswerFromOracle(ethOracle);
    uint256 expectedMarketPrice = (latestAnswerREthEth * latestAnswerEthUsd) / 1e18;
    uint256 rate = rethToken.getExchangeRate();
    assertGt(rate, 1e18);
    uint256 expectedCanonicalPrice = (rate * latestAnswerEthUsd) / 1e18;
    uint256 expectedPrice = LiquityMath._min(expectedMarketPrice, expectedCanonicalPrice);
    assertEq(fetchedRethUsdPrice, expectedPrice);
}
```

## Related Implementations

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
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

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
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

## External Calls

- **IRETHPriceFeed::fetchPrice()**
- **IRETHToken::getExchangeRate()**

## State Variable Reads

- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **rethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **rethToken** (`contract IRETHToken`) [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testFetchPriceReturnsCorrectPriceRETH() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1)
  │   💬 Args: [fetchedRethUsdPrice, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 2)
  │   💬 Args: [rethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 3)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 4)
  │   💬 Args: [ethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 5)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 6)
  │   💬 Args: [rate, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 7)
  │   💬 Args: [expectedMarketPrice, expectedCanonicalPrice]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
      💬 Args: [fetchedRethUsdPrice, expectedPrice]
      👁️  Def: internal
```
