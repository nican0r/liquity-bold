# Function: testSTETHOracleAnswerWithin1PctOfETHOracleAnswer()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testSTETHOracleAnswerWithin1PctOfETHOracleAnswer()`
- **Visibility**: public
- **Source Range**: 16370:471:244

## Implementation

```solidity
function testSTETHOracleAnswerWithin1PctOfETHOracleAnswer() public {
    uint256 stethUsd = _getLatestAnswerFromOracle(stethOracle);
    uint256 ethUsd = _getLatestAnswerFromOracle(ethOracle);
    uint256 relativeDelta;
    if (stethUsd > ethUsd) {
        relativeDelta = ((stethUsd - ethUsd) * 1e18) / ethUsd;
    } else {
        relativeDelta = ((ethUsd - stethUsd) * 1e18) / stethUsd;
    }
    assertLt(relativeDelta, 1e16);
}
```

## Related Implementations

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

### assertLt(uint256,uint256)

- **Kind**: internal
- **Source**: 11928:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256)`

```solidity
function assertLt(uint256 left, uint256 right) virtual internal pure {
    vm.assertLt(left, right);
}
```

## State Variable Reads

- **stethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testSTETHOracleAnswerWithin1PctOfETHOracleAnswer() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 1)
  │   💬 Args: [stethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 2)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 3)
  │   💬 Args: [ethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 4)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 5)
      💬 Args: [relativeDelta, 1e16]
      👁️  Def: internal
```
