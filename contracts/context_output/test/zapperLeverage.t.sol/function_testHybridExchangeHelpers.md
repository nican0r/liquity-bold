# Function: testHybridExchangeHelpers()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testHybridExchangeHelpers()`
- **Visibility**: public
- **Source Range**: 88008:738:338

## Implementation

```solidity
function testHybridExchangeHelpers() public {
    for (uint256 i = 0; i < 3; i++) {
        (uint256 price, ) = contractsArray[i].priceFeed.fetchPrice();
        _testHybridExchangeHelpers(price, contractsArray[i].collToken, 1 ether, 1e16);
        _testHybridExchangeHelpers(price * 1e3, contractsArray[i].collToken, 1 ether, 1e16);
        _testHybridExchangeHelpers(price * 1e6, contractsArray[i].collToken, 1 ether, 1e16);
    }
}
```

## Related Implementations

### _testHybridExchangeHelpers(uint256,contract IERC20,uint256,uint256)

- **Kind**: internal
- **Source**: 88752:586:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testHybridExchangeHelpers(uint256,contract IERC20,uint256,uint256)`

```solidity
function _testHybridExchangeHelpers(uint256 _boldAmount, IERC20 _collToken, uint256 _desiredCollAmount, uint256 _acceptedSlippage) internal {
    (uint256 collAmount, uint256 slippage) = hybridCurveUniV3ExchangeHelpers.getCollFromBold(_boldAmount, _collToken, _desiredCollAmount);
    assertGe(collAmount, ((DECIMAL_PRECISION - slippage) * _desiredCollAmount) / DECIMAL_PRECISION);
    assertLe(slippage, _acceptedSlippage);
}
```

### assertGe(uint256,uint256)

- **Kind**: internal
- **Source**: 15480:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256)`

```solidity
function assertGe(uint256 left, uint256 right) virtual internal pure {
    vm.assertGe(left, right);
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

## External Calls

- **IPriceFeed::fetchPrice()**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **hybridCurveUniV3ExchangeHelpers** (`contract HybridCurveUniV3ExchangeHelpers`) [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpers.sol/contract_HybridCurveUniV3ExchangeHelpers.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testHybridExchangeHelpers() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testHybridExchangeHelpers(uint256,contract IERC20,uint256,uint256) (NodeID: 1)
  │   💬 Args: [price, contractsArray[i].collToken, 1 ether, 1e16]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [collAmount, ((DECIMAL_PRECISION - slippage) * _desiredCollAmount) / DECIMAL_PRECISION]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 3)
  │     💬 Args: [slippage, _acceptedSlippage]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testHybridExchangeHelpers(uint256,contract IERC20,uint256,uint256) (NodeID: 4)
  │   💬 Args: [price * 1e3, contractsArray[i].collToken, 1 ether, 1e16]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256) (NodeID: 5)
  │ │   💬 Args: [collAmount, ((DECIMAL_PRECISION - slippage) * _desiredCollAmount) / DECIMAL_PRECISION]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 6)
  │     💬 Args: [slippage, _acceptedSlippage]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testHybridExchangeHelpers(uint256,contract IERC20,uint256,uint256) (NodeID: 7)
      💬 Args: [price * 1e6, contractsArray[i].collToken, 1 ether, 1e16]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256) (NodeID: 8)
    │   💬 Args: [collAmount, ((DECIMAL_PRECISION - slippage) * _desiredCollAmount) / DECIMAL_PRECISION]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 9)
        💬 Args: [slippage, _acceptedSlippage]
        👁️  Def: internal
```
