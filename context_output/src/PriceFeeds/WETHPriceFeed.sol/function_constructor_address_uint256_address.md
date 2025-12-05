# Function: constructor(address,uint256,address)

**Contract**: [src/PriceFeeds/WETHPriceFeed.sol/contract_WETHPriceFeed.md]

## Metadata

- **Contract**: WETHPriceFeed
- **Signature**: `constructor(address,uint256,address)`
- **Visibility**: public
- **Source Range**: 186:361:183

## Implementation

```solidity
constructor(address _ethUsdOracleAddress, uint256 _ethUsdStalenessThreshold, address _borrowerOperationsAddress) MainnetPriceFeedBase(_ethUsdOracleAddress,_ethUsdStalenessThreshold,_borrowerOperationsAddress) {
    _fetchPricePrimary();
    assert(priceSource == PriceSource.primary);
}
```

## Related Implementations

### _fetchPricePrimary()

- **Kind**: internal
- **Source**: 1298:523:183
- **Link**: `src/PriceFeeds/WETHPriceFeed.sol:WETHPriceFeed:_fetchPricePrimary()`

```solidity
function _fetchPricePrimary() internal returns (uint256, bool) {
    assert(priceSource == PriceSource.primary);
    (uint256 ethUsdPrice, bool ethUsdOracleDown) = _getOracleAnswer(ethUsdOracle);
    if (ethUsdOracleDown) return (_shutDownAndSwitchToLastGoodPrice(address(ethUsdOracle.aggregator)), true);
    lastGoodPrice = ethUsdPrice;
    return (ethUsdPrice, false);
}
```

### _getOracleAnswer(struct MainnetPriceFeedBase.Oracle)

- **Kind**: internal
- **Source**: 1695:660:181
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_getOracleAnswer(struct MainnetPriceFeedBase.Oracle)`

```solidity
function _getOracleAnswer(Oracle memory _oracle) internal view returns (uint256, bool) {
    ChainlinkResponse memory chainlinkResponse = _getCurrentChainlinkResponse(_oracle.aggregator);
    uint256 scaledPrice;
    bool oracleIsDown;
    if (!_isValidChainlinkPrice(chainlinkResponse, _oracle.stalenessThreshold)) {
        oracleIsDown = true;
    } else {
        scaledPrice = _scaleChainlinkPriceTo18decimals(chainlinkResponse.answer, _oracle.decimals);
    }
    return (scaledPrice, oracleIsDown);
}
```

### _getCurrentChainlinkResponse(contract AggregatorV3Interface)

- **Kind**: internal
- **Source**: 2699:1250:181
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_getCurrentChainlinkResponse(contract AggregatorV3Interface)`

```solidity
function _getCurrentChainlinkResponse(AggregatorV3Interface _aggregator) internal view returns (ChainlinkResponse memory chainlinkResponse) {
    uint256 gasBefore = gasleft();
    try _aggregator.latestRoundData() returns (uint80 roundId, int256 answer, uint256, uint256 updatedAt, uint80) {
        chainlinkResponse.roundId = roundId;
        chainlinkResponse.answer = answer;
        chainlinkResponse.timestamp = updatedAt;
        chainlinkResponse.success = true;
        return chainlinkResponse;
    } catch {
        if (gasleft() <= (gasBefore / 64)) revert InsufficientGasForExternalCall();
        return chainlinkResponse;
    }
}
```

### _isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256)

- **Kind**: internal
- **Source**: 4135:326:181
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256)`

```solidity
function _isValidChainlinkPrice(ChainlinkResponse memory chainlinkResponse, uint256 _stalenessThreshold) internal view returns (bool) {
    return (chainlinkResponse.success && ((block.timestamp - chainlinkResponse.timestamp) < _stalenessThreshold)) && (chainlinkResponse.answer > 0);
}
```

### _scaleChainlinkPriceTo18decimals(int256,uint256)

- **Kind**: internal
- **Source**: 4577:229:181
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_scaleChainlinkPriceTo18decimals(int256,uint256)`

```solidity
function _scaleChainlinkPriceTo18decimals(int256 _price, uint256 _decimals) internal pure returns (uint256) {
    return uint256(_price) * (10 ** (18 - _decimals));
}
```

### _shutDownAndSwitchToLastGoodPrice(address)

- **Kind**: internal
- **Source**: 2361:332:181
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_shutDownAndSwitchToLastGoodPrice(address)`

```solidity
function _shutDownAndSwitchToLastGoodPrice(address _failedOracleAddr) internal returns (uint256) {
    borrowerOperations.shutdownFromOracleFailure();
    priceSource = PriceSource.lastGoodPrice;
    emit ShutDownFromOracleFailure(_failedOracleAddr);
    return lastGoodPrice;
}
```

### (address,uint256,address)

- **Kind**: internal
- **Source**: 1201:488:181
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:constructor(address,uint256,address)`

```solidity
constructor(address _ethUsdOracleAddress, uint256 _ethUsdStalenessThreshold, address _borrowOperationsAddress) {
    ethUsdOracle.aggregator = AggregatorV3Interface(_ethUsdOracleAddress);
    ethUsdOracle.stalenessThreshold = _ethUsdStalenessThreshold;
    ethUsdOracle.decimals = ethUsdOracle.aggregator.decimals();
    borrowerOperations = IBorrowerOperations(_borrowOperationsAddress);
    assert(ethUsdOracle.decimals == 8);
}
```

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **lastGoodPrice** (`uint256`)
- **ethUsdOracle** (`struct MainnetPriceFeedBase.Oracle`)

## State Variable Writes

- **priceSource** (`enum IMainnetPriceFeed.PriceSource`)
- **ethUsdOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: WETHPriceFeed.constructor(address,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: WETHPriceFeed
  ├─ [1] ⚙️ FUNCTION: WETHPriceFeed._fetchPricePrimary() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._getOracleAnswer(struct MainnetPriceFeedBase.Oracle) (NodeID: 2)
  │ │   💬 Args: [ethUsdOracle]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._getCurrentChainlinkResponse(contract AggregatorV3Interface) (NodeID: 3)
  │ │ │   💬 Args: [_oracle.aggregator]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256) (NodeID: 4)
  │ │ │   💬 Args: [chainlinkResponse, _oracle.stalenessThreshold]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._scaleChainlinkPriceTo18decimals(int256,uint256) (NodeID: 5)
  │ │     💬 Args: [chainlinkResponse.answer, _oracle.decimals]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 6)
  │     💬 Args: [address(ethUsdOracle.aggregator)]
  │     👁️  Def: internal
  └─ [1] 🏗️ CONSTRUCTOR: MainnetPriceFeedBase.constructor(address,uint256,address) (NodeID: 7)
      💬 Args: [_ethUsdOracleAddress, _ethUsdStalenessThreshold, _borrowerOperationsAddress]
      🏗️  Contract: MainnetPriceFeedBase
```
