# Function: run()

**Contract**: [script/ProvideUniV3Liquidity.s.sol/contract_ProvideUniV3Liquidity.md]

## Metadata

- **Contract**: ProvideUniV3Liquidity
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 1798:1032:122

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
    uint256 price = 2_000 ether;
    console2.log("WETH");
    uint256 token1Amount = 1_000_000 ether;
    _provideUniV3Liquidity(usdc, WETH, token1Amount, price, UNIV3_FEE_USDC_WETH);
    token1Amount = 1_000 ether;
    console2.log("wstETH");
    _provideUniV3Liquidity(WETH, wstETH, token1Amount, 1 ether, UNIV3_FEE_WETH_COLL);
    console2.log("rETH");
    _provideUniV3Liquidity(WETH, rETH, token1Amount, 1 ether, UNIV3_FEE_WETH_COLL);
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

### log(string)

- **Kind**: internal
- **Source**: 6191:121:61
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### _provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24)

- **Kind**: internal
- **Source**: 2878:2872:122
- **Link**: `script/ProvideUniV3Liquidity.s.sol:ProvideUniV3Liquidity:_provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24)`

```solidity
function _provideUniV3Liquidity(ERC20Faucet _token1, ERC20Faucet _token2, uint256 _token1Amount, uint256 _price, uint24 _fee) internal {
    uint256 token2Amount = (_token1Amount * DECIMAL_PRECISION) / _price;
    address[2] memory tokens;
    uint256[2] memory amounts;
    uint256 price;
    if (address(_token1) < address(_token2)) {
        tokens[0] = address(_token1);
        tokens[1] = address(_token2);
        amounts[0] = _token1Amount;
        amounts[1] = token2Amount;
        price = (DECIMAL_PRECISION * DECIMAL_PRECISION) / _price;
    } else {
        tokens[0] = address(_token2);
        tokens[1] = address(_token1);
        amounts[0] = token2Amount;
        amounts[1] = _token1Amount;
        price = _price;
    }
    uniV3PositionManagerSepolia.createAndInitializePoolIfNecessary(tokens[0], tokens[1], _fee, _priceToSqrtPrice(price));
    _token1.mint(deployer, _token1Amount);
    _token2.mint(deployer, token2Amount);
    _token1.approve(address(uniV3PositionManagerSepolia), _token1Amount);
    _token2.approve(address(uniV3PositionManagerSepolia), token2Amount);
    address uniV3PoolAddress = uniswapV3FactorySepolia.getPool(tokens[0], tokens[1], _fee);
    int24 TICK_SPACING = IUniswapV3Pool(uniV3PoolAddress).tickSpacing();
    (, int24 tick, , , , , ) = IUniswapV3Pool(uniV3PoolAddress).slot0();
    int24 tickLower = ((tick - 6000) / TICK_SPACING) * TICK_SPACING;
    int24 tickUpper = ((tick + 6000) / TICK_SPACING) * TICK_SPACING;
    INonfungiblePositionManager.MintParams memory params = INonfungiblePositionManager.MintParams({token0: tokens[0], token1: tokens[1], fee: _fee, tickLower: tickLower, tickUpper: tickUpper, amount0Desired: amounts[0], amount1Desired: amounts[1], amount0Min: 0, amount1Min: 0, recipient: deployer, deadline: block.timestamp + 600 minutes});
    uniV3PositionManagerSepolia.mint(params);
    console2.log("--");
    console2.log(_token1.name());
    console2.log(address(_token1), "address(_token1)");
    console2.log(_token1Amount, "_token1Amount");
    console2.log(_token1.balanceOf(uniV3PoolAddress), "token1.balanceOf(pool)");
    console2.log(_token2.name());
    console2.log(address(_token2), "address(_token2)");
    console2.log(token2Amount, "token2Amount");
    console2.log(_token2.balanceOf(uniV3PoolAddress), "token2.balanceOf(pool)");
}
```

### _priceToSqrtPrice(uint256)

- **Kind**: internal
- **Source**: 5756:152:122
- **Link**: `script/ProvideUniV3Liquidity.s.sol:ProvideUniV3Liquidity:_priceToSqrtPrice(uint256)`

```solidity
function _priceToSqrtPrice(uint256 _price) public pure returns (uint160) {
    return uint160(Math.sqrt((_price << 192) / DECIMAL_PRECISION));
}
```

### sqrt(uint256)

- **Kind**: internal
- **Source**: 6530:1642:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:sqrt(uint256)`

```solidity
///  @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded down.
///  Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
function sqrt(uint256 a) internal pure returns (uint256) {
    if (a == 0) {
        return 0;
    }
    uint256 result = 1 << (log2(a) >> 1);
    unchecked {
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        return min(result, a / result);
    }
}
```

### log2(uint256)

- **Kind**: internal
- **Source**: 8633:983:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log2(uint256)`

```solidity
///  @dev Return the log in base 2, rounded down, of a positive value.
///  Returns 0 if given 0.
function log2(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if ((value >> 128) > 0) {
            value >>= 128;
            result += 128;
        }
        if ((value >> 64) > 0) {
            value >>= 64;
            result += 64;
        }
        if ((value >> 32) > 0) {
            value >>= 32;
            result += 32;
        }
        if ((value >> 16) > 0) {
            value >>= 16;
            result += 16;
        }
        if ((value >> 8) > 0) {
            value >>= 8;
            result += 8;
        }
        if ((value >> 4) > 0) {
            value >>= 4;
            result += 4;
        }
        if ((value >> 2) > 0) {
            value >>= 2;
            result += 2;
        }
        if ((value >> 1) > 0) {
            result += 1;
        }
    }
    return result;
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
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
- **usdc** (`contract ERC20Faucet`) [test/TestContracts/ERC20Faucet.sol/contract_ERC20Faucet.md]
- **WETH** (`contract WETHTester`) [test/TestContracts/WETHTester.sol/contract_WETHTester.md]
- **UNIV3_FEE_USDC_WETH** (`uint24`)
- **wstETH** (`contract ERC20Faucet`) [test/TestContracts/ERC20Faucet.sol/contract_ERC20Faucet.md]
- **UNIV3_FEE_WETH_COLL** (`uint24`)
- **rETH** (`contract ERC20Faucet`) [test/TestContracts/ERC20Faucet.sol/contract_ERC20Faucet.md]
- **DECIMAL_PRECISION** (`uint256`)
- **uniV3PositionManagerSepolia** (`contract INonfungiblePositionManager`) [src/Zappers/Modules/Exchanges/UniswapV3/INonfungiblePositionManager.sol/interface_INonfungiblePositionManager.md]
- **uniswapV3FactorySepolia** (`contract IUniswapV3Factory`) [src/Zappers/Modules/Exchanges/UniswapV3/IUniswapV3Factory.sol/interface_IUniswapV3Factory.md]

## State Variable Writes

- **deployer** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ProvideUniV3Liquidity.run() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 7)
  │   💬 Args: ["WETH"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ProvideUniV3Liquidity._provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24) (NodeID: 10)
  │   💬 Args: [usdc, WETH, token1Amount, price, UNIV3_FEE_USDC_WETH]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ProvideUniV3Liquidity._priceToSqrtPrice(uint256) (NodeID: 11)
  │ │   💬 Args: [price]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 12)
  │ │     💬 Args: [(_price << 192) / DECIMAL_PRECISION]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 13)
  │ │   │   💬 Args: [a]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 14)
  │ │       💬 Args: [result, a / result]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 15)
  │ │   💬 Args: ["--"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 16)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 17)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 18)
  │ │   💬 Args: [_token1.name()]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(address,string) (NodeID: 21)
  │ │   💬 Args: [address(_token1), "address(_token1)"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 22)
  │ │     💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 23)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 24)
  │ │   💬 Args: [_token1Amount, "_token1Amount"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 25)
  │ │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 26)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 27)
  │ │   💬 Args: [_token1.balanceOf(uniV3PoolAddress), "token1.balanceOf(pool)"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 28)
  │ │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 29)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 30)
  │ │   💬 Args: [_token2.name()]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 31)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 32)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(address,string) (NodeID: 33)
  │ │   💬 Args: [address(_token2), "address(_token2)"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 34)
  │ │     💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 35)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 36)
  │ │   💬 Args: [token2Amount, "token2Amount"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 37)
  │ │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 38)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 39)
  │     💬 Args: [_token2.balanceOf(uniV3PoolAddress), "token2.balanceOf(pool)"]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 40)
  │       💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 41)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 42)
  │   💬 Args: ["wstETH"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 43)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 44)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ProvideUniV3Liquidity._provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24) (NodeID: 45)
  │   💬 Args: [WETH, wstETH, token1Amount, 1 ether, UNIV3_FEE_WETH_COLL]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ProvideUniV3Liquidity._priceToSqrtPrice(uint256) (NodeID: 46)
  │ │   💬 Args: [price]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 47)
  │ │     💬 Args: [(_price << 192) / DECIMAL_PRECISION]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 48)
  │ │   │   💬 Args: [a]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 49)
  │ │       💬 Args: [result, a / result]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 50)
  │ │   💬 Args: ["--"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 51)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 52)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 53)
  │ │   💬 Args: [_token1.name()]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 54)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 55)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(address,string) (NodeID: 56)
  │ │   💬 Args: [address(_token1), "address(_token1)"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 57)
  │ │     💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 58)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 59)
  │ │   💬 Args: [_token1Amount, "_token1Amount"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 60)
  │ │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 61)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 62)
  │ │   💬 Args: [_token1.balanceOf(uniV3PoolAddress), "token1.balanceOf(pool)"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 63)
  │ │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 64)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 65)
  │ │   💬 Args: [_token2.name()]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 66)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 67)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(address,string) (NodeID: 68)
  │ │   💬 Args: [address(_token2), "address(_token2)"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 69)
  │ │     💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 70)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 71)
  │ │   💬 Args: [token2Amount, "token2Amount"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 72)
  │ │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 73)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 74)
  │     💬 Args: [_token2.balanceOf(uniV3PoolAddress), "token2.balanceOf(pool)"]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 75)
  │       💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 76)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 77)
  │   💬 Args: ["rETH"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 78)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 79)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ProvideUniV3Liquidity._provideUniV3Liquidity(contract ERC20Faucet,contract ERC20Faucet,uint256,uint256,uint24) (NodeID: 80)
      💬 Args: [WETH, rETH, token1Amount, 1 ether, UNIV3_FEE_WETH_COLL]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ProvideUniV3Liquidity._priceToSqrtPrice(uint256) (NodeID: 81)
    │   💬 Args: [price]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 82)
    │     💬 Args: [(_price << 192) / DECIMAL_PRECISION]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 83)
    │   │   💬 Args: [a]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 84)
    │       💬 Args: [result, a / result]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 85)
    │   💬 Args: ["--"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 86)
    │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 87)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 88)
    │   💬 Args: [_token1.name()]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 89)
    │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 90)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(address,string) (NodeID: 91)
    │   💬 Args: [address(_token1), "address(_token1)"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 92)
    │     💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 93)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 94)
    │   💬 Args: [_token1Amount, "_token1Amount"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 95)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 96)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 97)
    │   💬 Args: [_token1.balanceOf(uniV3PoolAddress), "token1.balanceOf(pool)"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 98)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 99)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 100)
    │   💬 Args: [_token2.name()]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 101)
    │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 102)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(address,string) (NodeID: 103)
    │   💬 Args: [address(_token2), "address(_token2)"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 104)
    │     💬 Args: [abi.encodeWithSignature("log(address,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 105)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 106)
    │   💬 Args: [token2Amount, "token2Amount"]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 107)
    │     💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 108)
    │       💬 Args: [_sendLogPayloadView]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: console.log(uint256,string) (NodeID: 109)
        💬 Args: [_token2.balanceOf(uniV3PoolAddress), "token2.balanceOf(pool)"]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 110)
          💬 Args: [abi.encodeWithSignature("log(uint256,string)", p0, p1)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 111)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```
