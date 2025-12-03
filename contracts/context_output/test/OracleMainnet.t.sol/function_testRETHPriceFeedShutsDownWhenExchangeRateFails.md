# Function: testRETHPriceFeedShutsDownWhenExchangeRateFails()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRETHPriceFeedShutsDownWhenExchangeRateFails()`
- **Visibility**: public
- **Source Range**: 30949:928:244

## Implementation

```solidity
function testRETHPriceFeedShutsDownWhenExchangeRateFails() public {
    (uint256 price, bool oracleFailedWhileBranchLive) = rethPriceFeed.fetchPrice();
    assertGt(price, 0);
    assertFalse(oracleFailedWhileBranchLive);
    assertEq(contractsArray[1].troveManager.shutdownTime(), 0);
    etchMockToRethToken();
    uint256 rate = rethToken.getExchangeRate();
    assertEq(rate, 0, "rate not zero");
    (, oracleFailedWhileBranchLive) = rethPriceFeed.fetchPrice();
    assertTrue(oracleFailedWhileBranchLive);
    assertEq(contractsArray[1].troveManager.shutdownTime(), block.timestamp, "timestamps not equal");
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

### assertFalse(bool)

- **Kind**: internal
- **Source**: 1808:91:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool)`

```solidity
function assertFalse(bool data) virtual internal pure {
    vm.assertFalse(data);
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

### etchMockToRethToken()

- **Kind**: internal
- **Source**: 11136:210:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchMockToRethToken()`

```solidity
function etchMockToRethToken() internal {
    vm.etch(address(rethToken), address(mockRethToken).code);
    RETHTokenMock mock = RETHTokenMock(address(rethToken));
    mock.setExchangeRate(0);
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

- **IRETHPriceFeed::fetchPrice()**
- **ITroveManager::shutdownTime()**
- **IRETHToken::getExchangeRate()**

## State Variable Reads

- **rethPriceFeed** (`contract IRETHPriceFeed`) [src/Interfaces/IRETHPriceFeed.sol/interface_IRETHPriceFeed.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **rethToken** (`contract IRETHToken`) [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **mockRethToken** (`contract RETHTokenMock`) [test/TestContracts/RETHTokenMock.sol/contract_RETHTokenMock.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRETHPriceFeedShutsDownWhenExchangeRateFails() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1)
  │   💬 Args: [price, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 2)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [contractsArray[1].troveManager.shutdownTime(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchMockToRethToken() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [rate, 0, "rate not zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 6)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
      💬 Args: [contractsArray[1].troveManager.shutdownTime(), block.timestamp, "timestamps not equal"]
      👁️  Def: internal
```
