# Function: throwPriceV1(contract IPriceFeedV1)

**Contract**: [test/Utils/E2EHelpers.sol/contract_SideEffectFreeGetPriceHelper.md]

## Metadata

- **Contract**: SideEffectFreeGetPriceHelper
- **Signature**: `throwPriceV1(contract IPriceFeedV1)`
- **Visibility**: external
- **Source Range**: 2519:115:287

## Implementation

```solidity
function throwPriceV1(IPriceFeedV1 priceFeed) external {
    _revert(abi.encode(priceFeed.fetchPrice()));
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

- **IPriceFeedV1::fetchPrice()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SideEffectFreeGetPriceHelper.throwPriceV1(contract IPriceFeedV1) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SideEffectFreeGetPriceHelper._revert(bytes) (NodeID: 1)
      💬 Args: [abi.encode(priceFeed.fetchPrice())]
      👁️  Def: internal
```
