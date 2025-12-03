# Function: testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct()`
- **Visibility**: public
- **Source Range**: 76617:3886:244

## Implementation

```solidity
function testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct() public {
    console.log("test::first wsteth pricefeed call");
    wstethPriceFeed.fetchPrice();
    uint256 lastGoodPrice1 = wstethPriceFeed.lastGoodPrice();
    assertGt(lastGoodPrice1, 0, "lastGoodPrice 0");
    assertEq(uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary));
    uint256 coll = 100 ether;
    uint256 debtRequest = 3000e18;
    vm.startPrank(A);
    contractsArray[2].borrowerOperations.openTrove(A, 0, coll, debtRequest, 0, 0, 5e16, debtRequest, address(0), address(0), address(0));
    (, int256 rawEthUsdPrice, , , ) = ethOracle.latestRoundData();
    assertGt(rawEthUsdPrice, 0, "eth-usd price not 0");
    etchStaleMockToStethOracle(address(mockOracle).code);
    ChainlinkOracleMock mock = ChainlinkOracleMock(address(stethOracle));
    mock.setPrice(int256((rawEthUsdPrice * 90e6) / 1e8));
    mock.setUpdatedAt(block.timestamp);
    mock.setDecimals(8);
    assertEq(contractsArray[2].troveManager.shutdownTime(), 0, "is shutdown");
    uint256 ethUsdPrice = _getLatestAnswerFromOracle(ethOracle);
    uint256 stethUsdPrice = _getLatestAnswerFromOracle(stethOracle);
    console.log(stethUsdPrice, "test stehUsdPrice after replacement");
    console.log(ethUsdPrice, "test ethUsdPrice after replacement");
    console.log((ethUsdPrice * 90e16) / 1e18, "test ethUsdPrice * 90e16 / 1e18");
    assertLt(stethUsdPrice, ethUsdPrice, "steth-usd not < eth-usd");
    uint256 expectedPrice = (stethUsdPrice * wstETH.stEthPerToken()) / 1e18;
    assertGt(expectedPrice, 0, "expected price not 0");
    uint256 totalBoldRedeemAmount = 100e18;
    uint256 totalCorrespondingColl = (totalBoldRedeemAmount * DECIMAL_PRECISION) / expectedPrice;
    assertGt(totalCorrespondingColl, 0, "coll not 0");
    uint256 redemptionFeePct = (collateralRegistry.getEffectiveRedemptionFeeInBold(totalBoldRedeemAmount) * DECIMAL_PRECISION) / totalBoldRedeemAmount;
    assertGt(redemptionFeePct, 0, "fee not 0");
    uint256 totalCollFee = (totalCorrespondingColl * redemptionFeePct) / DECIMAL_PRECISION;
    uint256 expectedCollDelta = totalCorrespondingColl - totalCollFee;
    assertGt(expectedCollDelta, 0, "delta not 0");
    uint256 branch2DebtBefore = contractsArray[2].activePool.getBoldDebt();
    assertGt(branch2DebtBefore, 0);
    uint256 A_collBefore = contractsArray[2].collToken.balanceOf(A);
    assertGt(A_collBefore, 0);
    redeem(A, totalBoldRedeemAmount);
    assertEq(contractsArray[2].troveManager.shutdownTime(), 0, "is shutdown");
    assertEq(contractsArray[2].activePool.getBoldDebt(), branch2DebtBefore - totalBoldRedeemAmount, "remaining branch debt wrong");
    assertEq(contractsArray[2].collToken.balanceOf(A), A_collBefore + expectedCollDelta, "remaining branch coll wrong");
}
```

## Related Implementations

### log(string)

- **Kind**: internal
- **Source**: 6191:121:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

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

### assertGt(int256,int256,string)

- **Kind**: internal
- **Source**: 13822:132:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(int256,int256,string)`

```solidity
function assertGt(int256 left, int256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
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

### log(uint256,string)

- **Kind**: internal
- **Source**: 6702:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(uint256,string)`

```solidity
function log(uint256 p0, string memory p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(uint256,string)", p0, p1));
}
```

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
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

## External Calls

- **IWSTETHPriceFeed::fetchPrice()**
- **IWSTETHPriceFeed::lastGoodPrice()**
- **IWSTETHPriceFeed::priceSource()**
- **Vm::startPrank(address)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **AggregatorV3Interface::latestRoundData()**
- **ChainlinkOracleMock::setPrice(int256)**
- **ChainlinkOracleMock::setUpdatedAt(uint256)**
- **ChainlinkOracleMock::setDecimals(uint8)**
- **ITroveManager::shutdownTime()**
- **IWSTETH::stEthPerToken()**
- **CollateralRegistryTester::getEffectiveRedemptionFeeInBold(uint256)**
- **IActivePool::getBoldDebt()**
- **IERC20Metadata::balanceOf(address)**

## State Variable Reads

- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **stethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **wstETH** (`contract IWSTETH`) [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]
- **collateralRegistry** (`contract CollateralRegistryTester`) [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRedemptionOfWSTETHUsesMinETHUSDMarketandWSTETHUSDMarketForPrimaryPriceWhenNotWithin1pct() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["test::first wsteth pricefeed call"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [lastGoodPrice1, 0, "lastGoodPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [uint8(wstethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(int256,int256,string) (NodeID: 6)
  │   💬 Args: [rawEthUsdPrice, 0, "eth-usd price not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToStethOracle(bytes) (NodeID: 7)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [contractsArray[2].troveManager.shutdownTime(), 0, "is shutdown"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 9)
  │   💬 Args: [ethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 10)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 11)
  │   💬 Args: [stethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 12)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 13)
  │   💬 Args: [stethUsdPrice, "test stehUsdPrice after replacement"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 16)
  │   💬 Args: [ethUsdPrice, "test ethUsdPrice after replacement"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 19)
  │   💬 Args: [(ethUsdPrice * 90e16) / 1e18, "test ethUsdPrice * 90e16 / 1e18"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 20)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 21)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 22)
  │   💬 Args: [stethUsdPrice, ethUsdPrice, "steth-usd not < eth-usd"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 23)
  │   💬 Args: [expectedPrice, 0, "expected price not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 24)
  │   💬 Args: [totalCorrespondingColl, 0, "coll not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [redemptionFeePct, 0, "fee not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 26)
  │   💬 Args: [expectedCollDelta, 0, "delta not 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 27)
  │   💬 Args: [branch2DebtBefore, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 28)
  │   💬 Args: [A_collBefore, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.redeem(address,uint256) (NodeID: 29)
  │   💬 Args: [A, totalBoldRedeemAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 30)
  │   💬 Args: [contractsArray[2].troveManager.shutdownTime(), 0, "is shutdown"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 31)
  │   💬 Args: [contractsArray[2].activePool.getBoldDebt(), branch2DebtBefore - totalBoldRedeemAmount, "remaining branch debt wrong"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 32)
      💬 Args: [contractsArray[2].collToken.balanceOf(A), A_collBefore + expectedCollDelta, "remaining branch coll wrong"]
      👁️  Def: internal
```
