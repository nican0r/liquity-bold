# Function: testEthUsdStalenessThresholdSetRETH()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testEthUsdStalenessThresholdSetRETH()`
- **Visibility**: public
- **Source Range**: 15142:193:244

## Implementation

```solidity
function testEthUsdStalenessThresholdSetRETH() public view {
    (, uint256 storedEthUsdStaleness, ) = rethPriceFeed.ethUsdOracle();
    assertEq(storedEthUsdStaleness, _24_HOURS);
}
```

## Related Implementations

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

- **IRETHPriceFeed::ethUsdOracle()**

## State Variable Reads

- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testEthUsdStalenessThresholdSetRETH() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [storedEthUsdStaleness, _24_HOURS]
      👁️  Def: internal
```
