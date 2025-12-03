# Function: testOpenTroveWSTETHWithStalePriceReverts()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testOpenTroveWSTETHWithStalePriceReverts()`
- **Visibility**: public
- **Source Range**: 21663:751:244

## Implementation

```solidity
function testOpenTroveWSTETHWithStalePriceReverts() public {
    etchStaleMockToStethOracle(address(mockOracle).code);
    (, , , uint256 updatedAt, ) = stethOracle.latestRoundData();
    assertEq(updatedAt, block.timestamp - 7 days);
    assertFalse(contractsArray[2].borrowerOperations.hasBeenShutDown());
    uint256 price = _getLatestAnswerFromOracle(stethOracle);
    uint256 coll = 5 ether;
    uint256 debtRequest = ((coll * price) / 2) / 1e18;
    vm.startPrank(A);
    vm.expectRevert(BorrowerOperations.NewOracleFailureDetected.selector);
    contractsArray[2].borrowerOperations.openTrove(A, 0, coll, debtRequest, 0, 0, 5e16, debtRequest, address(0), address(0), address(0));
}
```

## Related Implementations

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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

## External Calls

- **AggregatorV3Interface::latestRoundData()**
- **IBorrowerOperations::hasBeenShutDown()**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**

## State Variable Reads

- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **stethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testOpenTroveWSTETHWithStalePriceReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchStaleMockToStethOracle(bytes) (NodeID: 1)
  │   💬 Args: [address(mockOracle).code]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [updatedAt, block.timestamp - 7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool) (NodeID: 3)
  │   💬 Args: [contractsArray[2].borrowerOperations.hasBeenShutDown()]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 4)
      💬 Args: [stethOracle]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 5)
        💬 Args: [decimals, 18]
        👁️  Def: internal
```
