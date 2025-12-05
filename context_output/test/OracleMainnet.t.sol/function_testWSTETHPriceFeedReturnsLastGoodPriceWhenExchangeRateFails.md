# Function: testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 48314:895:244

## Implementation

```solidity
function testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails() public {
    wstethPriceFeed.fetchPrice();
    uint256 lastGoodPrice1 = wstethPriceFeed.lastGoodPrice();
    assertGt(lastGoodPrice1, 0, "lastGoodPrice 0");
    vm.etch(address(wstETH), address(mockWstethToken).code);
    uint256 rate = wstETH.stEthPerToken();
    assertEq(rate, 0);
    (uint256 price, bool oracleFailedWhileBranchLive) = wstethPriceFeed.fetchPrice();
    assertTrue(oracleFailedWhileBranchLive);
    assertEq(price, lastGoodPrice1);
    assertEq(wstethPriceFeed.lastGoodPrice(), lastGoodPrice1);
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

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1594:89:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    vm.assertTrue(data);
}
```

## External Calls

- **IWSTETHPriceFeed::fetchPrice()**
- **IWSTETHPriceFeed::lastGoodPrice()**
- **Vm::etch(address,bytes)**
- **IWSTETH::stEthPerToken()**

## State Variable Reads

- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **wstETH** (`contract IWSTETH`) [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]
- **mockWstethToken** (`contract WSTETHTokenMock`) [test/TestContracts/WSTETHTokenMock.sol/contract_WSTETHTokenMock.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testWSTETHPriceFeedReturnsLastGoodPriceWhenExchangeRateFails() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [lastGoodPrice1, 0, "lastGoodPrice 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [rate, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 3)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [price, lastGoodPrice1]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
      💬 Args: [wstethPriceFeed.lastGoodPrice(), lastGoodPrice1]
      👁️  Def: internal
```
