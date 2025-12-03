# Function: testNormalWETHRedemptionDoesNotHitShutdownBranch()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testNormalWETHRedemptionDoesNotHitShutdownBranch()`
- **Visibility**: public
- **Source Range**: 66640:1664:244

## Implementation

```solidity
function testNormalWETHRedemptionDoesNotHitShutdownBranch() public {
    wethPriceFeed.fetchPrice();
    uint256 lastGoodPrice1 = wethPriceFeed.lastGoodPrice();
    assertGt(lastGoodPrice1, 0, "lastGoodPrice 0");
    assertEq(uint8(wethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary));
    uint256 coll = 100 ether;
    uint256 debtRequest = 3000e18;
    vm.startPrank(A);
    contractsArray[0].borrowerOperations.openTrove(A, 0, coll, debtRequest, 0, 0, 5e16, debtRequest, address(0), address(0), address(0));
    etchStaleMockToEthOracle(address(mockOracle).code);
    (, , , uint256 updatedAt, ) = ethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    (, bool oracleFailedWhileBranchLive) = wethPriceFeed.fetchPrice();
    assertTrue(oracleFailedWhileBranchLive);
    assertEq(contractsArray[0].troveManager.shutdownTime(), block.timestamp);
    uint256 totalBoldRedeemAmount = 100e18;
    uint256 branch0DebtBefore = contractsArray[0].activePool.getBoldDebt();
    assertGt(branch0DebtBefore, 0);
    uint256 boldBalBefore_A = boldToken.balanceOf(A);
    redeem(A, totalBoldRedeemAmount);
    assertEq(boldToken.balanceOf(A), boldBalBefore_A);
    assertEq(contractsArray[0].activePool.getBoldDebt(), branch0DebtBefore);
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

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1594:89:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    vm.assertTrue(data);
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

- **IMainnetPriceFeed::fetchPrice()**
- **IMainnetPriceFeed::lastGoodPrice()**
- **IMainnetPriceFeed::priceSource()**
- **Vm::startPrank(address)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **AggregatorV3Interface::latestRoundData()**
- **ITroveManager::shutdownTime()**
- **IActivePool::getBoldDebt()**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **wethPriceFeed** (`contract IMainnetPriceFeed`) [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **collateralRegistry** (`contract CollateralRegistryTester`) [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testNormalWETHRedemptionDoesNotHitShutdownBranch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [lastGoodPrice1, 0, "lastGoodPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [uint8(wethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToEthOracle(bytes) (NodeID: 3)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 5)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [contractsArray[0].troveManager.shutdownTime(), block.timestamp]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 7)
  │   💬 Args: [branch0DebtBefore, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.redeem(address,uint256) (NodeID: 8)
  │   💬 Args: [A, totalBoldRedeemAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [boldToken.balanceOf(A), boldBalBefore_A]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
      💬 Args: [contractsArray[0].activePool.getBoldDebt(), branch0DebtBefore]
      👁️  Def: internal
```
