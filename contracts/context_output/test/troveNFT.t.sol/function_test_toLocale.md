# Function: test_toLocale()

**Contract**: [test/troveNFT.t.sol/contract_troveNFTTest.md]

## Metadata

- **Contract**: troveNFTTest
- **Signature**: `test_toLocale()`
- **Visibility**: public
- **Source Range**: 10896:179:336

## Implementation

```solidity
function test_toLocale() public pure {
    string memory result = numUtils.toLocale("123456789");
    assertEq(result, "123,456,789");
}
```

## Related Implementations

### toLocale(string)

- **Kind**: internal
- **Source**: 117:684:177
- **Link**: `src/NFTMetadata/utils/Utils.sol:numUtils:toLocale(string)`

```solidity
function toLocale(string memory _wholeNumber) internal pure returns (string memory) {
    bytes memory b = bytes(_wholeNumber);
    uint256 len = b.length;
    if (len < 4) return _wholeNumber;
    uint256 numCommas = (len - 1) / 3;
    bytes memory result = new bytes(len + numCommas);
    uint256 j = result.length - 1;
    uint256 k = len;
    for (uint256 i = 0; i < len; i++) {
        result[j] = b[k - 1];
        j = (j > 1) ? (j - 1) : 0;
        k--;
        if ((k > 0) && (((len - k) % 3) == 0)) {
            result[j] = ",";
            j = (j > 1) ? (j - 1) : 0;
        }
    }
    return string(result);
}
```

### assertEq(string,string)

- **Kind**: internal
- **Source**: 4220:122:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string)`

```solidity
function assertEq(string memory left, string memory right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: troveNFTTest.test_toLocale() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 1)
  │   💬 Args: ["123456789"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 2)
      💬 Args: [result, "123,456,789"]
      👁️  Def: internal
```
