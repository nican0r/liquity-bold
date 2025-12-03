# Function: testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct()`
- **Visibility**: public
- **Source Range**: 83387:3601:244

## Implementation

```solidity
function testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct() public {
    rethPriceFeed.fetchPrice();
    uint256 lastGoodPrice1 = rethPriceFeed.lastGoodPrice();
    assertGt(lastGoodPrice1, 0, "lastGoodPrice 0");
    assertEq(uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary));
    uint256 coll = 100 ether;
    uint256 debtRequest = 3000e18;
    vm.startPrank(A);
    contractsArray[1].borrowerOperations.openTrove(A, 0, coll, debtRequest, 0, 0, 5e16, debtRequest, address(0), address(0), address(0));
    vm.stopPrank();
    etchStaleMockToRethOracle(address(mockOracle).code);
    ChainlinkOracleMock mock = ChainlinkOracleMock(address(rethOracle));
    mock.setPrice(95e16);
    mock.setUpdatedAt(block.timestamp);
    mock.setDecimals(18);
    (, int256 price, , , ) = rethOracle.latestRoundData();
    assertEq(price, 95e16, "reth-eth price not 0.95");
    uint256 canonicalRethRate = rethToken.getExchangeRate();
    uint256 marketRethPrice = _getLatestAnswerFromOracle(rethOracle);
    uint256 ethUsdPrice = _getLatestAnswerFromOracle(ethOracle);
    assertNotEq(canonicalRethRate, marketRethPrice, "raw price and rate equal");
    uint256 min = ((1e18 - 2e16) * canonicalRethRate) / 1e18;
    assertLe(marketRethPrice, min, "market reth-eth price not < min");
    uint256 expectedPrice = (LiquityMath._min(canonicalRethRate, marketRethPrice) * ethUsdPrice) / 1e18;
    assertGt(expectedPrice, 0, "expected price not 0");
    uint256 totalBoldRedeemAmount = 100e18;
    uint256 totalCorrespondingColl = (totalBoldRedeemAmount * DECIMAL_PRECISION) / expectedPrice;
    assertGt(totalCorrespondingColl, 0, "coll not 0");
    uint256 redemptionFeePct = (collateralRegistry.getEffectiveRedemptionFeeInBold(totalBoldRedeemAmount) * DECIMAL_PRECISION) / totalBoldRedeemAmount;
    assertGt(redemptionFeePct, 0, "fee not 0");
    uint256 totalCollFee = (totalCorrespondingColl * redemptionFeePct) / DECIMAL_PRECISION;
    uint256 expectedCollDelta = totalCorrespondingColl - totalCollFee;
    assertGt(expectedCollDelta, 0, "delta not 0");
    uint256 branch1DebtBefore = contractsArray[1].activePool.getBoldDebt();
    assertGt(branch1DebtBefore, 0);
    uint256 A_collBefore = contractsArray[1].collToken.balanceOf(A);
    assertGt(A_collBefore, 0);
    redeem(A, totalBoldRedeemAmount);
    assertEq(contractsArray[1].activePool.getBoldDebt(), branch1DebtBefore - totalBoldRedeemAmount, "active debt != branch - redeemed");
    assertEq(contractsArray[1].collToken.balanceOf(A), A_collBefore + expectedCollDelta, "A's coll didn't change");
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

### assertEq(int256,int256,string)

- **Kind**: internal
- **Source**: 2980:132:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256,string)`

```solidity
function assertEq(int256 left, int256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

### assertNotEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 7308:140:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(uint256,uint256,string)`

```solidity
function assertNotEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertNotEq(left, right, err);
}
```

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14412:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLe(left, right, err);
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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### redeem(address,uint256)

- **Kind**: internal
- **Source**: 6831:197:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:redeem(address,uint256)`

```solidity
function redeem(address _from, uint256 _boldAmount) public {
    vm.startPrank(_from);
    collateralRegistry.redeemCollateral(_boldAmount, MAX_UINT256, 1e18);
    vm.stopPrank();
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

- **IRETHPriceFeed::fetchPrice()**
- **IRETHPriceFeed::lastGoodPrice()**
- **IRETHPriceFeed::priceSource()**
- **Vm::startPrank(address)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**
- **ChainlinkOracleMock::setPrice(int256)**
- **ChainlinkOracleMock::setUpdatedAt(uint256)**
- **ChainlinkOracleMock::setDecimals(uint8)**
- **AggregatorV3Interface::latestRoundData()**
- **IRETHToken::getExchangeRate()**
- **CollateralRegistryTester::getEffectiveRedemptionFeeInBold(uint256)**
- **IActivePool::getBoldDebt()**
- **IERC20Metadata::balanceOf(address)**

## State Variable Reads

- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **rethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **rethToken** (`contract IRETHToken`) [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **collateralRegistry** (`contract CollateralRegistryTester`) [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRedemptionOfRETHUsesMinCanonicalAndMarketforPrimaryPriceWhenDeviationGreaterThan2pct() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [lastGoodPrice1, 0, "lastGoodPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [uint8(rethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToRethOracle(bytes) (NodeID: 3)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256,string) (NodeID: 4)
  │   💬 Args: [price, 95e16, "reth-eth price not 0.95"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 5)
  │   💬 Args: [rethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 6)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 7)
  │   💬 Args: [ethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 8)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [canonicalRethRate, marketRethPrice, "raw price and rate equal"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [marketRethPrice, min, "market reth-eth price not < min"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 11)
  │   💬 Args: [canonicalRethRate, marketRethPrice]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [expectedPrice, 0, "expected price not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [totalCorrespondingColl, 0, "coll not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 14)
  │   💬 Args: [redemptionFeePct, 0, "fee not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 15)
  │   💬 Args: [expectedCollDelta, 0, "delta not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 16)
  │   💬 Args: [branch1DebtBefore, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 17)
  │   💬 Args: [A_collBefore, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.redeem(address,uint256) (NodeID: 18)
  │   💬 Args: [A, totalBoldRedeemAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 19)
  │   💬 Args: [contractsArray[1].activePool.getBoldDebt(), branch1DebtBefore - totalBoldRedeemAmount, "active debt != branch - redeemed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 20)
      💬 Args: [contractsArray[1].collToken.balanceOf(A), A_collBefore + expectedCollDelta, "A's coll didn't change"]
      👁️  Def: internal
```
