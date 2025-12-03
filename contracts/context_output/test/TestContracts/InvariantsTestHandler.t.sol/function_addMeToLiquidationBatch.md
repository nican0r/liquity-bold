# Function: addMeToLiquidationBatch()

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `addMeToLiquidationBatch()`
- **Visibility**: external
- **Source Range**: 48081:139:270

## Implementation

```solidity
function addMeToLiquidationBatch() external {
    logCall("addMeToLiquidationBatch");
    _addToLiquidationBatch(msg.sender);
}
```

## Related Implementations

### logCall(string)

- **Kind**: internal
- **Source**: 433:154:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:logCall(string)`

```solidity
function logCall(string memory functionName) internal view {
    _logCaller();
    _log(_callPrefix(), functionName, "();");
    _log();
}
```

### _logCaller()

- **Kind**: internal
- **Source**: 189:101:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:_logCaller()`

```solidity
function _logCaller() internal view {
    _log("vm.prank(", vm.getLabel(msg.sender), ");");
}
```

### _log(string,string,string)

- **Kind**: internal
- **Source**: 406:131:289
- **Link**: `test/Utils/Logging.sol:Logging:_log(string,string,string)`

```solidity
function _log(string memory a, string memory b, string memory c) internal pure {
    console.log(string.concat(a, b, c));
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
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

### _callPrefix()

- **Kind**: internal
- **Source**: 296:131:251
- **Link**: `test/TestContracts/BaseHandler.sol:BaseHandler:_callPrefix()`

```solidity
function _callPrefix() internal view returns (string memory) {
    return string.concat(vm.getLabel(address(this)), ".");
}
```

### _log()

- **Kind**: internal
- **Source**: 141:60:289
- **Link**: `test/Utils/Logging.sol:Logging:_log()`

```solidity
function _log() internal pure {
    console.log();
}
```

### log()

- **Kind**: internal
- **Source**: 986:95:61
- **Link**: `lib/forge-std/src/console.sol:console:log()`

```solidity
function log() internal pure {
    _sendLogPayload(abi.encodeWithSignature("log()"));
}
```

### _addToLiquidationBatch(address)

- **Kind**: internal
- **Source**: 115811:103:270
- **Link**: `test/TestContracts/InvariantsTestHandler.t.sol:InvariantsTestHandler:_addToLiquidationBatch(address)`

```solidity
function _addToLiquidationBatch(address owner) internal {
    _liquidation.batch.push(owner);
}
```

## State Variable Writes

- **_liquidation** (`struct InvariantsTestHandler.LiquidationTransientState`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTestHandler.addMeToLiquidationBatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseHandler.logCall(string) (NodeID: 1)
  │   💬 Args: ["addMeToLiquidationBatch"]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHandler._logCaller() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 3)
  │ │     💬 Args: ["vm.prank(", vm.getLabel(msg.sender), ");"]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
  │ │       💬 Args: [string.concat(a, b, c)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │ │         💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Logging._log(string,string,string) (NodeID: 7)
  │ │   💬 Args: [_callPrefix(), functionName, "();"]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseHandler._callPrefix() (NodeID: 11)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 8)
  │ │     💬 Args: [string.concat(a, b, c)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Logging._log() (NodeID: 12)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log() (NodeID: 13)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │         💬 Args: [abi.encodeWithSignature("log()")]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InvariantsTestHandler._addToLiquidationBatch(address) (NodeID: 16)
      💬 Args: [msg.sender]
      👁️  Def: internal
```
