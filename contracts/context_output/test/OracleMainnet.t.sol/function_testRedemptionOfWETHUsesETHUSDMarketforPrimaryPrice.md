# Function: testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice()`
- **Visibility**: public
- **Source Range**: 71679:2123:244

## Implementation

```solidity
function testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice() public {
    wethPriceFeed.fetchPrice();
    uint256 lastGoodPrice1 = wethPriceFeed.lastGoodPrice();
    assertGt(lastGoodPrice1, 0, "lastGoodPrice 0");
    assertEq(uint8(wethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary));
    uint256 coll = 100 ether;
    uint256 debtRequest = 3000e18;
    vm.startPrank(A);
    contractsArray[0].borrowerOperations.openTrove(A, 0, coll, debtRequest, 0, 0, 5e16, debtRequest, address(0), address(0), address(0));
    uint256 expectedPrice = _getLatestAnswerFromOracle(ethOracle);
    assertGt(expectedPrice, 0);
    uint256 totalBoldRedeemAmount = 100e18;
    uint256 totalCorrespondingColl = (totalBoldRedeemAmount * DECIMAL_PRECISION) / expectedPrice;
    assertGt(totalCorrespondingColl, 0);
    uint256 redemptionFeePct = (collateralRegistry.getEffectiveRedemptionFeeInBold(totalBoldRedeemAmount) * DECIMAL_PRECISION) / totalBoldRedeemAmount;
    assertGt(redemptionFeePct, 0);
    uint256 totalCollFee = (totalCorrespondingColl * redemptionFeePct) / DECIMAL_PRECISION;
    uint256 expectedCollDelta = totalCorrespondingColl - totalCollFee;
    assertGt(expectedCollDelta, 0);
    uint256 branch0DebtBefore = contractsArray[0].activePool.getBoldDebt();
    assertGt(branch0DebtBefore, 0);
    uint256 A_collBefore = contractsArray[0].collToken.balanceOf(A);
    assertGt(A_collBefore, 0);
    redeem(A, totalBoldRedeemAmount);
    assertEq(contractsArray[0].activePool.getBoldDebt(), branch0DebtBefore - totalBoldRedeemAmount);
    assertEq(contractsArray[0].collToken.balanceOf(A), A_collBefore + expectedCollDelta);
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
- **CollateralRegistryTester::getEffectiveRedemptionFeeInBold(uint256)**
- **IActivePool::getBoldDebt()**
- **IERC20Metadata::balanceOf(address)**

## State Variable Reads

- **wethPriceFeed** (`contract IMainnetPriceFeed`) [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **collateralRegistry** (`contract CollateralRegistryTester`) [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRedemptionOfWETHUsesETHUSDMarketforPrimaryPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [lastGoodPrice1, 0, "lastGoodPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [uint8(wethPriceFeed.priceSource()), uint8(IMainnetPriceFeed.PriceSource.primary)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 3)
  │   💬 Args: [ethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 4)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 5)
  │   💬 Args: [expectedPrice, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 6)
  │   💬 Args: [totalCorrespondingColl, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 7)
  │   💬 Args: [redemptionFeePct, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 8)
  │   💬 Args: [expectedCollDelta, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 9)
  │   💬 Args: [branch0DebtBefore, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 10)
  │   💬 Args: [A_collBefore, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.redeem(address,uint256) (NodeID: 11)
  │   💬 Args: [A, totalBoldRedeemAmount]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
  │   💬 Args: [contractsArray[0].activePool.getBoldDebt(), branch0DebtBefore - totalBoldRedeemAmount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 13)
      💬 Args: [contractsArray[0].collToken.balanceOf(A), A_collBefore + expectedCollDelta]
      👁️  Def: internal
```
