# Function: constructor(address,address,address,uint256,uint256,address)

**Contract**: [src/PriceFeeds/RETHPriceFeed.sol/contract_RETHPriceFeed.md]

## Metadata

- **Contract**: RETHPriceFeed
- **Signature**: `constructor(address,address,address,uint256,uint256,address)`
- **Visibility**: public
- **Source Range**: 280:787:182

## Implementation

```solidity
constructor(address _ethUsdOracleAddress, address _rEthEthOracleAddress, address _rEthTokenAddress, uint256 _ethUsdStalenessThreshold, uint256 _rEthEthStalenessThreshold, address _borrowerOperationsAddress) CompositePriceFeed(_ethUsdOracleAddress,_rEthTokenAddress,_ethUsdStalenessThreshold,_borrowerOperationsAddress) {
    rEthEthOracle.aggregator = AggregatorV3Interface(_rEthEthOracleAddress);
    rEthEthOracle.stalenessThreshold = _rEthEthStalenessThreshold;
    rEthEthOracle.decimals = rEthEthOracle.aggregator.decimals();
    _fetchPricePrimary(false);
    assert(priceSource == PriceSource.primary);
}
```

## Related Implementations

### _fetchPricePrimary(bool)

- **Kind**: internal
- **Source**: 1179:2379:182
- **Link**: `src/PriceFeeds/RETHPriceFeed.sol:RETHPriceFeed:_fetchPricePrimary(bool)`

```solidity
function _fetchPricePrimary(bool _isRedemption) override internal returns (uint256, bool) {
    assert(priceSource == PriceSource.primary);
    (uint256 ethUsdPrice, bool ethUsdOracleDown) = _getOracleAnswer(ethUsdOracle);
    (uint256 rEthEthPrice, bool rEthEthOracleDown) = _getOracleAnswer(rEthEthOracle);
    (uint256 ethPerReth, bool exchangeRateIsDown) = _getCanonicalRate();
    if (ethUsdOracleDown) {
        return (_shutDownAndSwitchToLastGoodPrice(address(ethUsdOracle.aggregator)), true);
    }
    if (exchangeRateIsDown) {
        return (_shutDownAndSwitchToLastGoodPrice(rateProviderAddress), true);
    }
    if (rEthEthOracleDown) {
        return (_shutDownAndSwitchToETHUSDxCanonical(address(rEthEthOracle.aggregator), ethUsdPrice), true);
    }
    uint256 rEthUsdMarketPrice = (ethUsdPrice * rEthEthPrice) / 1e18;
    uint256 rEthUsdCanonicalPrice = (ethUsdPrice * ethPerReth) / 1e18;
    uint256 rEthUsdPrice;
    if (_isRedemption && _withinDeviationThreshold(rEthUsdMarketPrice, rEthUsdCanonicalPrice, RETH_ETH_DEVIATION_THRESHOLD)) {
        rEthUsdPrice = LiquityMath._max(rEthUsdMarketPrice, rEthUsdCanonicalPrice);
    } else {
        rEthUsdPrice = LiquityMath._min(rEthUsdMarketPrice, rEthUsdCanonicalPrice);
    }
    lastGoodPrice = rEthUsdPrice;
    return (rEthUsdPrice, false);
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

### _getCanonicalRate()

- **Kind**: internal
- **Source**: 3564:793:182
- **Link**: `src/PriceFeeds/RETHPriceFeed.sol:RETHPriceFeed:_getCanonicalRate()`

```solidity
function _getCanonicalRate() override internal view returns (uint256, bool) {
    uint256 gasBefore = gasleft();
    try IRETHToken(rateProviderAddress).getExchangeRate() returns (uint256 ethPerReth) {
        if (ethPerReth == 0) return (0, true);
        return (ethPerReth, false);
    } catch {
        if (gasleft() <= (gasBefore / 64)) revert InsufficientGasForExternalCall();
        return (0, true);
    }
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

### _shutDownAndSwitchToETHUSDxCanonical(address,uint256)

- **Kind**: internal
- **Source**: 1663:408:180
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:_shutDownAndSwitchToETHUSDxCanonical(address,uint256)`

```solidity
function _shutDownAndSwitchToETHUSDxCanonical(address _failedOracleAddr, uint256 _ethUsdPrice) internal returns (uint256) {
    borrowerOperations.shutdownFromOracleFailure();
    priceSource = PriceSource.ETHUSDxCanonical;
    emit ShutDownFromOracleFailure(_failedOracleAddr);
    return _fetchPriceETHUSDxCanonical(_ethUsdPrice);
}
```

### _fetchPriceETHUSDxCanonical(uint256)

- **Kind**: internal
- **Source**: 3176:847:180
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:_fetchPriceETHUSDxCanonical(uint256)`

```solidity
function _fetchPriceETHUSDxCanonical(uint256 _ethUsdPrice) internal returns (uint256) {
    assert(priceSource == PriceSource.ETHUSDxCanonical);
    (uint256 lstRate, bool exchangeRateIsDown) = _getCanonicalRate();
    if (exchangeRateIsDown) {
        priceSource = PriceSource.lastGoodPrice;
        return lastGoodPrice;
    }
    uint256 lstUsdCanonicalPrice = (_ethUsdPrice * lstRate) / 1e18;
    uint256 bestPrice = LiquityMath._min(lstUsdCanonicalPrice, lastGoodPrice);
    lastGoodPrice = bestPrice;
    return bestPrice;
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

### _withinDeviationThreshold(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 4029:518:180
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:_withinDeviationThreshold(uint256,uint256,uint256)`

```solidity
function _withinDeviationThreshold(uint256 _priceToCheck, uint256 _referencePrice, uint256 _deviationThreshold) internal pure returns (bool) {
    uint256 max = (_referencePrice * (DECIMAL_PRECISION + _deviationThreshold)) / 1e18;
    uint256 min = (_referencePrice * (DECIMAL_PRECISION - _deviationThreshold)) / 1e18;
    return (_priceToCheck >= min) && (_priceToCheck <= max);
}
```

### _max(uint256,uint256)

- **Kind**: internal
- **Source**: 255:114:137
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_max(uint256,uint256)`

```solidity
function _max(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? _a : _b;
}
```

### (address,address,uint256,address)

- **Kind**: internal
- **Source**: 464:369:180
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:constructor(address,address,uint256,address)`

```solidity
constructor(address _ethUsdOracleAddress, address _rateProviderAddress, uint256 _ethUsdStalenessThreshold, address _borrowerOperationsAddress) MainnetPriceFeedBase(_ethUsdOracleAddress,_ethUsdStalenessThreshold,_borrowerOperationsAddress) {
    rateProviderAddress = _rateProviderAddress;
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

## External Calls

- **AggregatorV3Interface::decimals()**

## State Variable Reads

- **rEthEthOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **RETH_ETH_DEVIATION_THRESHOLD** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **lastGoodPrice** (`uint256`)
- **ethUsdOracle** (`struct MainnetPriceFeedBase.Oracle`)

## State Variable Writes

- **rEthEthOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **priceSource** (`enum IMainnetPriceFeed.PriceSource`)
- **rateProviderAddress** (`address`)
- **ethUsdOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: RETHPriceFeed.constructor(address,address,address,uint256,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: RETHPriceFeed
  ├─ [1] ⚙️ FUNCTION: RETHPriceFeed._fetchPricePrimary(bool) (NodeID: 1)
  │   💬 Args: [false]
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
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._getOracleAnswer(struct MainnetPriceFeedBase.Oracle) (NodeID: 6)
  │ │   💬 Args: [rEthEthOracle]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._getCurrentChainlinkResponse(contract AggregatorV3Interface) (NodeID: 7)
  │ │ │   💬 Args: [_oracle.aggregator]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256) (NodeID: 8)
  │ │ │   💬 Args: [chainlinkResponse, _oracle.stalenessThreshold]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._scaleChainlinkPriceTo18decimals(int256,uint256) (NodeID: 9)
  │ │     💬 Args: [chainlinkResponse.answer, _oracle.decimals]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: RETHPriceFeed._getCanonicalRate() (NodeID: 10)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 11)
  │ │   💬 Args: [address(ethUsdOracle.aggregator)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 12)
  │ │   💬 Args: [rateProviderAddress]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CompositePriceFeed._shutDownAndSwitchToETHUSDxCanonical(address,uint256) (NodeID: 13)
  │ │   💬 Args: [address(rEthEthOracle.aggregator), ethUsdPrice]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: CompositePriceFeed._fetchPriceETHUSDxCanonical(uint256) (NodeID: 14)
  │ │     💬 Args: [_ethUsdPrice]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: RETHPriceFeed._getCanonicalRate() (NodeID: 15)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 16)
  │ │       💬 Args: [lstUsdCanonicalPrice, lastGoodPrice]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CompositePriceFeed._withinDeviationThreshold(uint256,uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [rEthUsdMarketPrice, rEthUsdCanonicalPrice, RETH_ETH_DEVIATION_THRESHOLD]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 18)
  │ │   💬 Args: [rEthUsdMarketPrice, rEthUsdCanonicalPrice]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 19)
  │     💬 Args: [rEthUsdMarketPrice, rEthUsdCanonicalPrice]
  │     👁️  Def: internal
  └─ [1] 🏗️ CONSTRUCTOR: CompositePriceFeed.constructor(address,address,uint256,address) (NodeID: 20)
      💬 Args: [_ethUsdOracleAddress, _rEthTokenAddress, _ethUsdStalenessThreshold, _borrowerOperationsAddress]
      🏗️  Contract: CompositePriceFeed
    └─ [2] 🏗️ CONSTRUCTOR: MainnetPriceFeedBase.constructor(address,uint256,address) (NodeID: 21)
        💬 Args: [_ethUsdOracleAddress, _ethUsdStalenessThreshold, _borrowerOperationsAddress]
        🏗️  Contract: MainnetPriceFeedBase
```
