# Function: testOpenTroveWSTETH()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testOpenTroveWSTETH()`
- **Visibility**: public
- **Source Range**: 18299:802:244

## Implementation

```solidity
function testOpenTroveWSTETH() public {
    uint256 latestAnswerStethUsd = _getLatestAnswerFromOracle(stethOracle);
    uint256 wstethStethExchangeRate = wstETH.stEthPerToken();
    uint256 calcdWstethUsdPrice = (latestAnswerStethUsd * wstethStethExchangeRate) / 1e18;
    uint256 coll = 5 ether;
    uint256 debtRequest = ((coll * calcdWstethUsdPrice) / 2) / 1e18;
    uint256 trovesCount = contractsArray[2].troveManager.getTroveIdsCount();
    assertEq(trovesCount, 0);
    vm.startPrank(A);
    contractsArray[2].borrowerOperations.openTrove(A, 0, coll, debtRequest, 0, 0, 5e16, debtRequest, address(0), address(0), address(0));
    trovesCount = contractsArray[2].troveManager.getTroveIdsCount();
    assertEq(trovesCount, 1);
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

- **IWSTETH::stEthPerToken()**
- **ITroveManager::getTroveIdsCount()**
- **Vm::startPrank(address)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**

## State Variable Reads

- **stethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **wstETH** (`contract IWSTETH`) [src/Interfaces/IWSTETH.sol/interface_IWSTETH.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testOpenTroveWSTETH() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 1)
  │   💬 Args: [stethOracle]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 2)
  │     💬 Args: [decimals, 18]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [trovesCount, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [trovesCount, 1]
      👁️  Def: internal
```
