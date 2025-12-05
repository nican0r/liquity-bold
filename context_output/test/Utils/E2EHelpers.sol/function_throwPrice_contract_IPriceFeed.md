# Function: throwPrice(contract IPriceFeed)

**Contract**: [test/Utils/E2EHelpers.sol/contract_SideEffectFreeGetPriceHelper.md]

## Metadata

- **Contract**: SideEffectFreeGetPriceHelper
- **Signature**: `throwPrice(contract IPriceFeed)`
- **Visibility**: external
- **Source Range**: 2368:145:287

## Implementation

```solidity
function throwPrice(IPriceFeed priceFeed) external {
    (uint256 price, ) = priceFeed.fetchPrice();
    _revert(abi.encode(price));
}
```

## Related Implementations

### _revert(bytes)

- **Kind**: internal
- **Source**: 2211:151:287
- **Link**: `test/Utils/E2EHelpers.sol:SideEffectFreeGetPriceHelper:_revert(bytes)`

```solidity
function _revert(bytes memory revertData) internal pure {
    assembly {
        revert(add(32, revertData), mload(revertData))
    }
}
```

## External Calls

- **IPriceFeed::fetchPrice()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SideEffectFreeGetPriceHelper.throwPrice(contract IPriceFeed) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SideEffectFreeGetPriceHelper._revert(bytes) (NodeID: 1)
      💬 Args: [abi.encode(price)]
      👁️  Def: internal
```
