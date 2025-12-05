# Function: testStethUsdStalenessThresholdSetWSTETH()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testStethUsdStalenessThresholdSetWSTETH()`
- **Visibility**: public
- **Source Range**: 15544:205:244

## Implementation

```solidity
function testStethUsdStalenessThresholdSetWSTETH() public view {
    (, uint256 storedStEthUsdStaleness, ) = wstethPriceFeed.stEthUsdOracle();
    assertEq(storedStEthUsdStaleness, _24_HOURS);
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

- **IWSTETHPriceFeed::stEthUsdOracle()**

## State Variable Reads

- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testStethUsdStalenessThresholdSetWSTETH() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [storedStEthUsdStaleness, _24_HOURS]
      👁️  Def: internal
```
