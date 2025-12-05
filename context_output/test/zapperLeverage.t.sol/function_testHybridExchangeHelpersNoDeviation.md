# Function: testHybridExchangeHelpersNoDeviation()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testHybridExchangeHelpersNoDeviation()`
- **Visibility**: public
- **Source Range**: 89344:344:338

## Implementation

```solidity
function testHybridExchangeHelpersNoDeviation() public {
    (uint256 price, ) = contractsArray[0].priceFeed.fetchPrice();
    (uint256 collAmount, uint256 slippage) = hybridCurveUniV3ExchangeHelpers.getCollFromBold(price, contractsArray[0].collToken, 0);
    assertGt(collAmount, 0);
    assertEq(slippage, 0);
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

- **IPriceFeed::fetchPrice()**
- **HybridCurveUniV3ExchangeHelpers::getCollFromBold(uint256,contract IERC20,uint256)**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **hybridCurveUniV3ExchangeHelpers** (`contract HybridCurveUniV3ExchangeHelpers`) [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpers.sol/contract_HybridCurveUniV3ExchangeHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testHybridExchangeHelpersNoDeviation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1)
  │   💬 Args: [collAmount, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [slippage, 0]
      👁️  Def: internal
```
