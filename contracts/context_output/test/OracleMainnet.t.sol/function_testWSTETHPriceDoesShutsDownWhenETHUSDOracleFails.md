# Function: testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails()`
- **Visibility**: public
- **Source Range**: 51247:989:244

## Implementation

```solidity
function testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails() public {
    (, bool oracleFailedWhileBranchLive) = wstethPriceFeed.fetchPrice();
    assertFalse(oracleFailedWhileBranchLive);
    assertEq(contractsArray[2].troveManager.shutdownTime(), 0);
    etchStaleMockToEthOracle(address(mockOracle).code);
    (, , , uint256 updatedAt, ) = ethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    (, oracleFailedWhileBranchLive) = wstethPriceFeed.fetchPrice();
    assertTrue(oracleFailedWhileBranchLive);
    assertEq(contractsArray[2].troveManager.shutdownTime(), block.timestamp);
}
```

## Related Implementations

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

## External Calls

- **IWSTETHPriceFeed::fetchPrice()**
- **ITroveManager::shutdownTime()**
- **AggregatorV3Interface::latestRoundData()**

## State Variable Reads

- **wstethPriceFeed** (`contract IWSTETHPriceFeed`) [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testWSTETHPriceDoesShutsDownWhenETHUSDOracleFails() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 1)
  │   💬 Args: [oracleFailedWhileBranchLive]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [contractsArray[2].troveManager.shutdownTime(), 0]
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
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
      💬 Args: [contractsArray[2].troveManager.shutdownTime(), block.timestamp]
      👁️  Def: internal
```
