# Function: testContractsDeployed()

**Contract**: [test/deployment.t.sol/contract_Deployment.md]

## Metadata

- **Contract**: Deployment
- **Signature**: `testContractsDeployed()`
- **Visibility**: public
- **Source Range**: 144:709:302

## Implementation

```solidity
function testContractsDeployed() public view {
    assertNotEq(address(activePool), address(0));
    assertNotEq(address(boldToken), address(0));
    assertNotEq(address(borrowerOperations), address(0));
    assertNotEq(address(collSurplusPool), address(0));
    assertNotEq(address(gasPool), address(0));
    assertNotEq(address(priceFeed), address(0));
    assertNotEq(address(sortedTroves), address(0));
    assertNotEq(address(stabilityPool), address(0));
    assertNotEq(address(troveManager), address(0));
    assertNotEq(address(mockInterestRouter), address(0));
    assertNotEq(address(collateralRegistry), address(0));
    logContractAddresses();
}
```

## Related Implementations

### assertNotEq(address,address)

- **Kind**: internal
- **Source**: 8446:116:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(address,address)`

```solidity
function assertNotEq(address left, address right) virtual internal pure {
    vm.assertNotEq(left, right);
}
```

### logContractAddresses()

- **Kind**: internal
- **Source**: 19255:645:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:logContractAddresses()`

```solidity
function logContractAddresses() public view {
    console.log("ActivePool addr: ", address(activePool));
    console.log("BorrowerOps addr: ", address(borrowerOperations));
    console.log("CollSurplusPool addr: ", address(collSurplusPool));
    console.log("DefaultPool addr: ", address(defaultPool));
    console.log("GasPool addr: ", address(gasPool));
    console.log("SortedTroves addr: ", address(sortedTroves));
    console.log("StabilityPool addr: ", address(stabilityPool));
    console.log("TroveManager addr: ", address(troveManager));
    console.log("BoldToken addr: ", address(boldToken));
}
```

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
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

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **gasPool** (`contract GasPool`) [src/GasPool.sol/contract_GasPool.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **troveManager** (`contract ITroveManagerTester`) [test/TestContracts/Interfaces/ITroveManagerTester.sol/interface_ITroveManagerTester.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deployment.testContractsDeployed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 1)
  │   💬 Args: [address(activePool), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 2)
  │   💬 Args: [address(boldToken), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 3)
  │   💬 Args: [address(borrowerOperations), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 4)
  │   💬 Args: [address(collSurplusPool), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 5)
  │   💬 Args: [address(gasPool), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 6)
  │   💬 Args: [address(priceFeed), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 7)
  │   💬 Args: [address(sortedTroves), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 8)
  │   💬 Args: [address(stabilityPool), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 9)
  │   💬 Args: [address(troveManager), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 10)
  │   💬 Args: [address(mockInterestRouter), address(0)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address) (NodeID: 11)
  │   💬 Args: [address(collateralRegistry), address(0)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest.logContractAddresses() (NodeID: 12)
      💬 Args: [no args]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 13)
    │   💬 Args: ["ActivePool addr: ", address(activePool)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 16)
    │   💬 Args: ["BorrowerOps addr: ", address(borrowerOperations)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 19)
    │   💬 Args: ["CollSurplusPool addr: ", address(collSurplusPool)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 20)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 21)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 22)
    │   💬 Args: ["DefaultPool addr: ", address(defaultPool)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 23)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 24)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 25)
    │   💬 Args: ["GasPool addr: ", address(gasPool)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 26)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 27)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 28)
    │   💬 Args: ["SortedTroves addr: ", address(sortedTroves)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 29)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 30)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 31)
    │   💬 Args: ["StabilityPool addr: ", address(stabilityPool)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 32)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 33)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 34)
    │   💬 Args: ["TroveManager addr: ", address(troveManager)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 35)
    │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 36)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console.log(string,address) (NodeID: 37)
        💬 Args: ["BoldToken addr: ", address(boldToken)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 38)
          💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 39)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```
