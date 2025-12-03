# Function: run()

**Contract**: [script/DeployOnlyExchangeHelpers.s.sol/contract_DeployOnlyExchangeHelpers.md]

## Metadata

- **Contract**: DeployOnlyExchangeHelpers
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 1069:923:113

## Implementation

```solidity
function run() external {
    if (vm.envBytes("DEPLOYER").length == 20) {
        deployer = vm.envAddress("DEPLOYER");
        vm.startBroadcast(deployer);
    } else {
        uint256 privateKey = vm.envUint("DEPLOYER");
        deployer = vm.addr(privateKey);
        vm.startBroadcast(privateKey);
    }
    console2.log(deployer, "deployer");
    console2.log(deployer.balance, "deployer balance");
    IExchangeHelpers exchangeHelpers = new HybridCurveUniV3ExchangeHelpers(USDC, WETH, usdcCurvePool, USDC_INDEX, BOLD_TOKEN_INDEX, UNIV3_FEE_USDC_WETH, UNIV3_FEE_WETH_COLL, uniV3QuoterSepolia);
    console2.log(address(exchangeHelpers), "exchangeHelpers");
}
```

## Related Implementations

### log(address,string)

- **Kind**: internal
- **Source**: 8596:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(address,string)`

```solidity
function log(address p0, string memory p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(address,string)", p0, p1));
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

### log(uint256,string)

- **Kind**: internal
- **Source**: 6702:145:61
- **Link**: `lib/forge-std/src/console.sol:console:log(uint256,string)`

```solidity
function log(uint256 p0, string memory p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(uint256,string)", p0, p1));
}
```

## External Calls

- **Vm::envBytes(string)**
- **Vm::envAddress(string)**
- **Vm::startBroadcast(address)**
- **Vm::envUint(string)**
- **Vm::addr(uint256)**
- **Vm::startBroadcast(uint256)**

## State Variable Reads

- **deployer** (`address`)
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **usdcCurvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`uint128`)
- **BOLD_TOKEN_INDEX** (`uint128`)
- **UNIV3_FEE_USDC_WETH** (`uint24`)
- **UNIV3_FEE_WETH_COLL** (`uint24`)
- **uniV3QuoterSepolia** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

## State Variable Writes

- **deployer** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeployOnlyExchangeHelpers.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: console.log(address,string) (NodeID: 1)
  │   💬 Args: [deployer, "deployer"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 4)
  │   💬 Args: [deployer.balance, "deployer balance"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(address,string) (NodeID: 7)
      💬 Args: [address(exchangeHelpers), "exchangeHelpers"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
        💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
