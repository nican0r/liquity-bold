# Function: provideToSPs(address,uint256[3])

**Contract**: [test/RedemptionHelper.t.sol/contract_RedemptionHelperTest.md]

## Metadata

- **Contract**: RedemptionHelperTest
- **Signature**: `provideToSPs(address,uint256[3])`
- **Visibility**: public
- **Source Range**: 5887:289:245

## Implementation

```solidity
function provideToSPs(address account, uint256[NUM_BRANCHES] memory bold) public {
    for (uint256 i = 0; i < bold.length; ++i) {
        bold[i] = _bound(bold[i], 0, boldToken.balanceOf(account) - 1);
        if (bold[i] > 0) provideToSP(i, account, bold[i]);
    }
}
```

## Related Implementations

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1646:1263:58
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### provideToSP(uint256,address,uint256)

- **Kind**: internal
- **Source**: 5704:177:245
- **Link**: `test/RedemptionHelper.t.sol:RedemptionHelperTest:provideToSP(uint256,address,uint256)`

```solidity
function provideToSP(uint256 branchIdx, address account, uint256 bold) public {
    vm.prank(account);
    branch[branchIdx].stabilityPool.provideToSP(bold, true);
}
```

## External Calls

- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **UINT256_MAX** (`uint256`)
- **branch** (`struct TestDeployer.LiquityContractsDev[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelperTest.provideToSPs(address,uint256[3]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [bold[i], 0, boldToken.balanceOf(account) - 1]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: RedemptionHelperTest.provideToSP(uint256,address,uint256) (NodeID: 2)
      💬 Args: [i, account, bold[i]]
      👁️  Def: public
```
