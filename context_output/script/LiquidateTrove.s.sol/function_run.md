# Function: run()

**Contract**: [script/LiquidateTrove.s.sol/contract_LiquidateTrove.md]

## Metadata

- **Contract**: LiquidateTrove
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 615:1459:119

## Implementation

```solidity
function run() external {
    vm.startBroadcast();
    IAddressesRegistry addressesRegistry;
    try vm.envAddress("ADDRESSES_REGISTRY") returns (address value) {
        addressesRegistry = IAddressesRegistry(value);
    } catch {
        uint256 i = vm.envUint("BRANCH");
        string memory manifestJson = vm.readFile("deployment-manifest.json");
        addressesRegistry = IAddressesRegistry(vm.parseJsonAddress(manifestJson, string.concat(".branches[", i.toString(), "].addressesRegistry")));
    }
    vm.label(address(addressesRegistry), "AddressesRegistry");
    ITroveManager troveManager = addressesRegistry.troveManager();
    vm.label(address(troveManager), "TroveManager");
    IPriceFeedTestnet priceFeed = IPriceFeedTestnet(address(addressesRegistry.priceFeed()));
    vm.label(address(priceFeed), "PriceFeedTestnet");
    uint256 troveId = vm.envUint("TROVE_ID");
    LatestTroveData memory trove = troveManager.getLatestTroveData(troveId);
    uint256 originalPrice = priceFeed.getPrice();
    uint256 liquidationPrice = ((addressesRegistry.MCR() - 0.01 ether) * trove.entireDebt) / trove.entireColl;
    priceFeed.setPrice(liquidationPrice);
    uint256[] memory troveIds = new uint256[](1);
    troveIds[0] = troveId;
    troveManager.batchLiquidateTroves(troveIds);
    priceFeed.setPrice(originalPrice);
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
- **Vm::envAddress(string)**
- **Vm::envUint(string)**
- **Vm::readFile(string)**
- **Vm::parseJsonAddress(string,string)**
- **Vm::label(address,string)**
- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::priceFeed()**
- **ITroveManager::getLatestTroveData(uint256)**
- **IPriceFeedTestnet::getPrice()**
- **IAddressesRegistry::MCR()**
- **IPriceFeedTestnet::setPrice(uint256)**
- **ITroveManager::batchLiquidateTroves(uint256[])**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquidateTrove.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 1)
      💬 Args: [i]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 2)
        💬 Args: [value]
        👁️  Def: internal
```
