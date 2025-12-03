# Function: run()

**Contract**: [script/DeploySomeCurvePools.s.sol/contract_DeploySomeCurvePools.md]

## Metadata

- **Contract**: DeploySomeCurvePools
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 538:1498:115

## Implementation

```solidity
function run() external {
    vm.startBroadcast();
    for (uint256 i = 1; i <= 3; ++i) {
        address[] memory coins = new address[](2);
        uint8[] memory assetTypes = new uint8[](2);
        bytes4[] memory methodIds = new bytes4[](2);
        address[] memory oracles = new address[](2);
        coins[0] = address(new ERC20Faucet({_name: string.concat("Coin #", i.toString(), ".1"), _symbol: string.concat("COIN", i.toString(), "1"), _tapAmount: 0, _tapPeriod: 0}));
        coins[1] = address(new ERC20Faucet({_name: string.concat("Coin #", i.toString(), ".2"), _symbol: string.concat("COIN", i.toString(), "2"), _tapAmount: 0, _tapPeriod: 0}));
        factory.deploy_plain_pool({_name: string.concat("Fancy Pool #", i.toString()), _symbol: string.concat(string.concat("POOL", i.toString())), _coins: coins, _A: 100, _fee: 4000000, _offpeg_fee_multiplier: 20000000000, _ma_exp_time: 866, _implementation_idx: 0, _asset_types: assetTypes, _method_ids: methodIds, _oracles: oracles});
    }
}
```

## Related Implementations

### toString(uint256)

- **Kind**: internal
- **Source**: 447:696:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        /// @solidity memory-safe-assembly
        assembly {
            ptr := add(buffer, add(32, length))
        }
        while (true) {
            ptr--;
            /// @solidity memory-safe-assembly
            assembly {
                mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 10139:916:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10, rounded down, of a positive value.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

## External Calls

- **Vm::startBroadcast()**
- **ICurveStableSwapFactoryNG::deploy_plain_pool(string,string,address[],uint256,uint256,uint256,uint256,uint256,uint8[],bytes4[],address[])**

## State Variable Reads

- **factory** (`contract ICurveStableSwapFactoryNG`) [test/Interfaces/Curve/ICurveStableSwapFactoryNG.sol/interface_ICurveStableSwapFactoryNG.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploySomeCurvePools.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 3)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 4)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 5)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 6)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 7)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 8)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 9)
  │   💬 Args: [i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 10)
  │     💬 Args: [value]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 11)
      💬 Args: [i]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 12)
        💬 Args: [value]
        👁️  Def: internal
```
