# Function: testRETHRedemptionOnlyHitsTrovesAtICRGte100()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRETHRedemptionOnlyHitsTrovesAtICRGte100()`
- **Visibility**: public
- **Source Range**: 91191:8192:244

## Implementation

```solidity
function testRETHRedemptionOnlyHitsTrovesAtICRGte100() public {
    Vars memory vars;
    ChainlinkOracleMock mockRETHOracle = etchMockToRethOracle();
    ChainlinkOracleMock mockETHOracle = etchMockToEthOracle();
    vars.usdPerEthMarket = 2000e8;
    mockETHOracle.setPrice(vars.usdPerEthMarket);
    vars.ethPerRethLST = rethToken.getExchangeRate();
    vars.ethPerRethMarket = (int256(vars.ethPerRethLST) * 99) / 100;
    mockRETHOracle.setPrice(vars.ethPerRethMarket);
    console.log(_getLatestAnswerFromOracle(rethOracle), "reth oracle latest answer");
    console.log(_getLatestAnswerFromOracle(ethOracle), "eth oracle latest answer");
    vm.startPrank(A);
    vars.troveId_A = contractsArray[1].borrowerOperations.openTrove(A, 0, 1000_000 ether, 51_000_000e18, 0, 0, 5e16, 51_000_000e18, address(0), address(0), address(0));
    vm.stopPrank();
    (vars.systemPrice, ) = contractsArray[1].priceFeed.fetchPrice();
    vars.coll = 10 ether;
    vars.debt_B = 10000e18 + 1e18;
    vars.debt_C = 10000e18;
    vars.debt_D = 10000e18 - 1e18;
    vm.startPrank(B);
    vars.troveId_B = contractsArray[1].borrowerOperations.openTrove(B, 0, vars.coll, vars.debt_B, 0, 0, 5e15, vars.debt_B, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(C);
    vars.troveId_C = contractsArray[1].borrowerOperations.openTrove(C, 0, vars.coll, vars.debt_C, 0, 0, 5e15, vars.debt_C, address(0), address(0), address(0));
    vm.stopPrank();
    vm.startPrank(D);
    vars.troveId_D = contractsArray[1].borrowerOperations.openTrove(D, 0, vars.coll, vars.debt_D, 0, 0, 5e15, vars.debt_D, address(0), address(0), address(0));
    vm.stopPrank();
    vars.ICR_C = contractsArray[1].troveManager.getCurrentICR(vars.troveId_C, vars.systemPrice);
    vars.newEthPrice = ((vars.usdPerEthMarket * 1e18) / int256(vars.ICR_C)) + 1;
    mockETHOracle.setPrice(vars.newEthPrice);
    (vars.newSystemPrice, ) = contractsArray[1].priceFeed.fetchPrice();
    vars.newSystemRedemptionPrice = (vars.newSystemPrice * 100) / 99;
    vars.ICR_A = contractsArray[1].troveManager.getCurrentICR(vars.troveId_A, vars.newSystemPrice);
    vars.ICR_B = contractsArray[1].troveManager.getCurrentICR(vars.troveId_B, vars.newSystemPrice);
    vars.ICR_C = contractsArray[1].troveManager.getCurrentICR(vars.troveId_C, vars.newSystemPrice);
    vars.ICR_D = contractsArray[1].troveManager.getCurrentICR(vars.troveId_D, vars.newSystemPrice);
    assertLt(vars.ICR_B, 1e18, "B ICR not < 100%");
    assertGt(vars.ICR_C, 1e18, "C ICR not > 100%");
    assertGt(vars.ICR_D, 1e18, "D ICR not > 100%");
    assertGt(vars.ICR_A, vars.ICR_D, "A ICR not > D ICR");
    vars.redemptionICR_A = contractsArray[1].troveManager.getCurrentICR(vars.troveId_A, vars.newSystemRedemptionPrice);
    vars.redemptionICR_B = contractsArray[1].troveManager.getCurrentICR(vars.troveId_B, vars.newSystemRedemptionPrice);
    vars.redemptionICR_C = contractsArray[1].troveManager.getCurrentICR(vars.troveId_C, vars.newSystemRedemptionPrice);
    vars.redemptionICR_D = contractsArray[1].troveManager.getCurrentICR(vars.troveId_D, vars.newSystemRedemptionPrice);
    assertGe(vars.redemptionICR_A, 1e18, "A ICR not > 100%");
    assertGe(vars.redemptionICR_B, 1e18, "B ICR not > 100%");
    assertGe(vars.redemptionICR_C, 1e18, "C ICR not > 100%");
    assertGe(vars.redemptionICR_D, 1e18, "D ICR not > 100%");
    vm.startPrank(A);
    contractsArray[0].stabilityPool.provideToSP(25_000_000e18, false);
    contractsArray[2].stabilityPool.provideToSP(25_000_000e18, false);
    vars.troveDataBefore_A = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_A);
    vars.troveDataBefore_B = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_B);
    vars.troveDataBefore_C = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_C);
    vars.troveDataBefore_D = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_D);
    collateralRegistry.redeemCollateral(50000e18, 100, 1e18);
    vars.troveDataAfter_A = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_A);
    vars.troveDataAfter_B = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_B);
    vars.troveDataAfter_C = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_C);
    vars.troveDataAfter_D = contractsArray[1].troveManager.getLatestTroveData(vars.troveId_D);
    assertEq(vars.troveDataAfter_B.entireDebt, vars.troveDataBefore_B.entireDebt, "B's debt not same after redeem");
    assertEq(vars.troveDataAfter_B.entireColl, vars.troveDataBefore_B.entireColl, "B's coll not same after redeem");
    assertLt(vars.troveDataAfter_A.entireDebt, vars.troveDataBefore_A.entireDebt, "A's debt not lower after redeem");
    assertLt(vars.troveDataAfter_A.entireColl, vars.troveDataBefore_A.entireColl, "A's coll not lower after redeem");
    assertLt(vars.troveDataAfter_C.entireDebt, vars.troveDataBefore_C.entireDebt, "C's debt not lower after redeem");
    assertLt(vars.troveDataAfter_C.entireColl, vars.troveDataBefore_C.entireColl, "C's coll not lower after redeem");
    assertLt(vars.troveDataAfter_D.entireDebt, vars.troveDataBefore_D.entireDebt, "D's debt not lower after redeem");
    assertLt(vars.troveDataAfter_D.entireColl, vars.troveDataBefore_D.entireColl, "D's coll not lower after redeem");
}
```

## Related Implementations

### etchMockToRethOracle()

- **Kind**: internal
- **Source**: 8922:428:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchMockToRethOracle()`

```solidity
function etchMockToRethOracle() internal returns (ChainlinkOracleMock) {
    vm.etch(address(rethOracle), address(mockOracle).code);
    ChainlinkOracleMock mock = ChainlinkOracleMock(address(rethOracle));
    mock.setDecimals(18);
    mock.setPrice(0);
    mock.setUpdatedAt(block.timestamp);
    return mock;
}
```

### etchMockToEthOracle()

- **Kind**: internal
- **Source**: 8492:424:244
- **Link**: `test/OracleMainnet.t.sol:OraclesMainnet:etchMockToEthOracle()`

```solidity
function etchMockToEthOracle() internal returns (ChainlinkOracleMock) {
    vm.etch(address(ethOracle), address(mockOracle).code);
    ChainlinkOracleMock mock = ChainlinkOracleMock(address(ethOracle));
    mock.setDecimals(8);
    mock.setPrice(0);
    mock.setUpdatedAt(block.timestamp);
    return mock;
}
```

### log(uint256,string)

- **Kind**: internal
- **Source**: 6702:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(uint256,string)`

```solidity
function log(uint256 p0, string memory p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(uint256,string)", p0, p1));
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

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 15596:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGe(left, right, err);
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

## External Calls

- **ChainlinkOracleMock::setPrice(int256)**
- **IRETHToken::getExchangeRate()**
- **Vm::startPrank(address)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**
- **IPriceFeed::fetchPrice()**
- **ITroveManager::getCurrentICR(uint256,uint256)**
- **IStabilityPool::provideToSP(uint256,bool)**
- **ITroveManager::getLatestTroveData(uint256)**
- **CollateralRegistryTester::redeemCollateral(uint256,uint256,uint256)**

## State Variable Reads

- **rethToken** (`contract IRETHToken`) [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]
- **rethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **ethOracle** (`contract AggregatorV3Interface`) [src/Dependencies/AggregatorV3Interface.sol/interface_AggregatorV3Interface.md]
- **contractsArray** (`struct TestDeployer.LiquityContracts[]`)
- **collateralRegistry** (`contract CollateralRegistryTester`) [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]
- **mockOracle** (`contract ChainlinkOracleMock`) [test/TestContracts/ChainlinkOracleMock.sol/contract_ChainlinkOracleMock.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRETHRedemptionOnlyHitsTrovesAtICRGte100() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchMockToRethOracle() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OraclesMainnet.etchMockToEthOracle() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 3)
  │   💬 Args: [_getLatestAnswerFromOracle(rethOracle), "reth oracle latest answer"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 6)
  │ │   💬 Args: [rethOracle]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 7)
  │ │     💬 Args: [decimals, 18]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 8)
  │   💬 Args: [_getLatestAnswerFromOracle(ethOracle), "eth oracle latest answer"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: OraclesMainnet._getLatestAnswerFromOracle(contract AggregatorV3Interface) (NodeID: 11)
  │ │   💬 Args: [ethOracle]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256) (NodeID: 12)
  │ │     💬 Args: [decimals, 18]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [vars.ICR_B, 1e18, "B ICR not < 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 14)
  │   💬 Args: [vars.ICR_C, 1e18, "C ICR not > 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 15)
  │   💬 Args: [vars.ICR_D, 1e18, "D ICR not > 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 16)
  │   💬 Args: [vars.ICR_A, vars.ICR_D, "A ICR not > D ICR"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 17)
  │   💬 Args: [vars.redemptionICR_A, 1e18, "A ICR not > 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 18)
  │   💬 Args: [vars.redemptionICR_B, 1e18, "B ICR not > 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 19)
  │   💬 Args: [vars.redemptionICR_C, 1e18, "C ICR not > 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 20)
  │   💬 Args: [vars.redemptionICR_D, 1e18, "D ICR not > 100%"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 21)
  │   💬 Args: [vars.troveDataAfter_B.entireDebt, vars.troveDataBefore_B.entireDebt, "B's debt not same after redeem"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 22)
  │   💬 Args: [vars.troveDataAfter_B.entireColl, vars.troveDataBefore_B.entireColl, "B's coll not same after redeem"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 23)
  │   💬 Args: [vars.troveDataAfter_A.entireDebt, vars.troveDataBefore_A.entireDebt, "A's debt not lower after redeem"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 24)
  │   💬 Args: [vars.troveDataAfter_A.entireColl, vars.troveDataBefore_A.entireColl, "A's coll not lower after redeem"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [vars.troveDataAfter_C.entireDebt, vars.troveDataBefore_C.entireDebt, "C's debt not lower after redeem"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 26)
  │   💬 Args: [vars.troveDataAfter_C.entireColl, vars.troveDataBefore_C.entireColl, "C's coll not lower after redeem"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 27)
  │   💬 Args: [vars.troveDataAfter_D.entireDebt, vars.troveDataBefore_D.entireDebt, "D's debt not lower after redeem"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 28)
      💬 Args: [vars.troveDataAfter_D.entireColl, vars.troveDataBefore_D.entireColl, "D's coll not lower after redeem"]
      👁️  Def: internal
```
