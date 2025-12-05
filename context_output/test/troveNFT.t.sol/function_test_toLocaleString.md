# Function: test_toLocaleString()

**Contract**: [test/troveNFT.t.sol/contract_troveNFTTest.md]

## Metadata

- **Contract**: troveNFTTest
- **Signature**: `test_toLocaleString()`
- **Visibility**: public
- **Source Range**: 11081:6213:336

## Implementation

```solidity
function test_toLocaleString() public pure {
    string memory result = numUtils.toLocaleString(123456789, 0, 2);
    assertEq(result, "123,456,789.00");
    result = numUtils.toLocaleString(123456789, 1, 2);
    assertEq(result, "12,345,678.90");
    result = numUtils.toLocaleString(123456789, 1, 3);
    assertEq(result, "12,345,678.900");
    result = numUtils.toLocaleString(123456789, 1, 0);
    assertEq(result, "12,345,678");
    result = numUtils.toLocaleString(123456789, 2, 0);
    assertEq(result, "1,234,567");
    result = numUtils.toLocaleString(123456789, 3, 0);
    assertEq(result, "123,456");
    result = numUtils.toLocaleString(123456789, 4, 0);
    assertEq(result, "12,345");
    result = numUtils.toLocaleString(123456789, 5, 0);
    assertEq(result, "1,234");
    result = numUtils.toLocaleString(123456789, 6, 0);
    assertEq(result, "123");
    result = numUtils.toLocaleString(123456789, 7, 0);
    assertEq(result, "12");
    result = numUtils.toLocaleString(123456789, 8, 0);
    assertEq(result, "1");
    result = numUtils.toLocaleString(123456789, 9, 0);
    assertEq(result, "0");
    result = numUtils.toLocaleString(123456789, 10, 0);
    assertEq(result, "0");
    result = numUtils.toLocaleString(123456789, 10, 1);
    assertEq(result, "0.1");
    result = numUtils.toLocaleString(123456789, 10, 2);
    assertEq(result, "0.12");
    result = numUtils.toLocaleString(123456789, 10, 3);
    assertEq(result, "0.123");
    result = numUtils.toLocaleString(123456789, 10, 4);
    assertEq(result, "0.1234");
    result = numUtils.toLocaleString(123456789, 12, 3);
    assertEq(result, "0.001", "12, 3");
    result = numUtils.toLocaleString(123456789, 3, 3);
    assertEq(result, "123,456.789", "3");
    result = numUtils.toLocaleString(123456789, 10, 10);
    assertEq(result, "0.1234567890", "10");
    result = numUtils.toLocaleString(123456789, 10, 11);
    assertEq(result, "0.12345678900", "10,11");
    result = numUtils.toLocaleString(123456789, 11, 11);
    assertEq(result, "0.01234567890", "11, 11");
    result = numUtils.toLocaleString(123456789, 11, 12);
    assertEq(result, "0.012345678900", "11, 12");
    result = numUtils.toLocaleString(123456789, 11, 13);
    assertEq(result, "0.0123456789000", "11, 13");
    result = numUtils.toLocaleString(123456789, 10, 18);
    assertEq(result, "0.123456789000000000", "11, 18");
    result = numUtils.toLocaleString(123456789, 1, 9);
    assertEq(result, "12,345,678.900000000");
    result = numUtils.toLocaleString(1234567890, 2, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(12345678900, 3, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(123456789000, 4, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(1234567890000, 5, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(12345678900000, 6, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(123456789000000, 7, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(1234567890000000, 8, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(12345678900000000, 9, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(123456789000000000, 10, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(123456789000000001, 10, 1);
    assertEq(result, "12,345,678.9");
    result = numUtils.toLocaleString(123456789000000001, 10, 2);
    assertEq(result, "12,345,678.90");
    result = numUtils.toLocaleString(123456789000000001, 10, 3);
    assertEq(result, "12,345,678.900");
    result = numUtils.toLocaleString(123456789000000001, 10, 4);
    assertEq(result, "12,345,678.9000");
    result = numUtils.toLocaleString(123456789000000001, 10, 5);
    assertEq(result, "12,345,678.90000");
    result = numUtils.toLocaleString(123456789000000001, 10, 6);
    assertEq(result, "12,345,678.900000");
    result = numUtils.toLocaleString(123456789000000001, 10, 7);
    assertEq(result, "12,345,678.9000000");
    result = numUtils.toLocaleString(123456789000000001, 10, 8);
    assertEq(result, "12,345,678.90000000");
    result = numUtils.toLocaleString(123456789000000001, 10, 9);
    assertEq(result, "12,345,678.900000000");
    result = numUtils.toLocaleString(123456789000000001, 10, 10);
    assertEq(result, "12,345,678.9000000001");
    result = numUtils.toLocaleString(123456789000000001, 10, 11);
    assertEq(result, "12,345,678.90000000010");
    result = numUtils.toLocaleString(10, 0, 0);
    assertEq(result, "10");
    result = numUtils.toLocaleString(10, 1, 0);
    assertEq(result, "1");
    result = numUtils.toLocaleString(10, 2, 1);
    assertEq(result, "0.1");
    result = numUtils.toLocaleString(1, 0, 0);
    assertEq(result, "1");
    result = numUtils.toLocaleString(1, 1, 1);
    assertEq(result, "0.1");
    result = numUtils.toLocaleString(1, 2, 2);
    assertEq(result, "0.01");
    result = numUtils.toLocaleString(1, 3, 3);
    assertEq(result, "0.001", "here");
    result = numUtils.toLocaleString(1, 4, 4);
    assertEq(result, "0.0001");
    result = numUtils.toLocaleString(1, 5, 5);
    assertEq(result, "0.00001");
    result = numUtils.toLocaleString(1, 6, 6);
    assertEq(result, "0.000001");
    result = numUtils.toLocaleString(1, 7, 7);
    assertEq(result, "0.0000001");
    result = numUtils.toLocaleString(1, 8, 8);
    assertEq(result, "0.00000001");
    result = numUtils.toLocaleString(1, 9, 9);
    assertEq(result, "0.000000001");
    result = numUtils.toLocaleString(1, 10, 10);
    assertEq(result, "0.0000000001");
}
```

## Related Implementations

### toLocaleString(uint256,uint8,uint8)

- **Kind**: internal
- **Source**: 910:1824:177
- **Link**: `src/NFTMetadata/utils/Utils.sol:numUtils:toLocaleString(uint256,uint8,uint8)`

```solidity
function toLocaleString(uint256 _value, uint8 _divisor, uint8 _precision) internal pure returns (string memory) {
    uint256 whole;
    uint256 fraction;
    if (_divisor > 0) {
        whole = _value / (10 ** _divisor);
        if (_divisor <= _precision) {
            fraction = (_value % (10 ** _divisor));
            fraction = fraction * (10 ** (_precision - _divisor));
            fraction = ((whole == 0) && (_value != 1)) ? (fraction * 10) : fraction;
        } else {
            fraction = (_value % (10 ** _divisor)) / (10 ** ((_divisor - _precision) - 1));
        }
    } else {
        whole = _value;
    }
    string memory wholeStr = toLocale(LibString.toString(whole));
    if (fraction == 0) {
        if ((whole > 0) && (_precision > 0)) wholeStr = string.concat(wholeStr, ".");
        for (uint8 i = 0; i < _precision; i++) {
            wholeStr = string.concat(wholeStr, "0");
        }
        return wholeStr;
    }
    string memory fractionStr = LibString.slice(LibString.toString(fraction), 0, _precision);
    if (_precision > bytes(fractionStr).length) {
        uint256 len = _precision - bytes(fractionStr).length;
        string memory zeroStr = "";
        for (uint8 i = 0; i < len; i++) {
            zeroStr = string.concat(zeroStr, "0");
        }
        fractionStr = string.concat(zeroStr, fractionStr);
    }
    return string.concat(wholeStr, (_precision > 0) ? "." : "", fractionStr);
}
```

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

### toString(uint256)

- **Kind**: internal
- **Source**: 3513:1535:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:toString(uint256)`

```solidity
/// @dev Returns the base 10 decimal representation of `value`.
function toString(uint256 value) internal pure returns (string memory str) {
    /// @solidity memory-safe-assembly
    assembly {
        str := add(mload(0x40), 0x80)
        mstore(0x40, add(str, 0x20))
        mstore(str, 0)
        let end := str
        let w := not(0)
        for {
            let temp := value
        } 1 {} {
            str := add(str, w)
            mstore8(str, add(48, mod(temp, 10)))
            temp := div(temp, 10)
            if iszero(temp) {
                break
            }
        }
        let length := sub(end, str)
        str := sub(str, 0x20)
        mstore(str, length)
    }
}
```

### slice(string,uint256,uint256)

- **Kind**: internal
- **Source**: 33520:1207:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:slice(string,uint256,uint256)`

```solidity
/// @dev Returns a copy of `subject` sliced from `start` to `end` (exclusive).
///  `start` and `end` are byte offsets.
function slice(string memory subject, uint256 start, uint256 end) internal pure returns (string memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        let subjectLength := mload(subject)
        if iszero(gt(subjectLength, end)) {
            end := subjectLength
        }
        if iszero(gt(subjectLength, start)) {
            start := subjectLength
        }
        if lt(start, end) {
            result := mload(0x40)
            let resultLength := sub(end, start)
            mstore(result, resultLength)
            subject := add(subject, start)
            let w := not(0x1f)
            for {
                let o := and(add(resultLength, 0x1f), w)
            } 1 {} {
                mstore(add(result, o), mload(add(subject, o)))
                o := add(o, w)
                if iszero(o) {
                    break
                }
            }
            mstore(add(add(result, 0x20), resultLength), 0)
            mstore(0x40, add(result, add(resultLength, 0x40)))
        }
    }
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

### assertEq(string,string,string)

- **Kind**: internal
- **Source**: 4348:146:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string,string)`

```solidity
function assertEq(string memory left, string memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: troveNFTTest.test_toLocaleString() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 1)
  │   💬 Args: [123456789, 0, 2]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 2)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 3)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 4)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 5)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 6)
  │   💬 Args: [result, "123,456,789.00"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 7)
  │   💬 Args: [123456789, 1, 2]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 8)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 9)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 10)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 11)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 12)
  │   💬 Args: [result, "12,345,678.90"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 13)
  │   💬 Args: [123456789, 1, 3]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 14)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 15)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 16)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 17)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 18)
  │   💬 Args: [result, "12,345,678.900"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 19)
  │   💬 Args: [123456789, 1, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 20)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 21)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 22)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 23)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 24)
  │   💬 Args: [result, "12,345,678"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 25)
  │   💬 Args: [123456789, 2, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 26)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 27)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 28)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 29)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 30)
  │   💬 Args: [result, "1,234,567"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 31)
  │   💬 Args: [123456789, 3, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 32)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 33)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 34)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 35)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 36)
  │   💬 Args: [result, "123,456"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 37)
  │   💬 Args: [123456789, 4, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 38)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 39)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 40)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 41)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 42)
  │   💬 Args: [result, "12,345"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 43)
  │   💬 Args: [123456789, 5, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 44)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 45)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 46)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 47)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 48)
  │   💬 Args: [result, "1,234"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 49)
  │   💬 Args: [123456789, 6, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 50)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 51)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 52)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 53)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 54)
  │   💬 Args: [result, "123"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 55)
  │   💬 Args: [123456789, 7, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 56)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 57)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 58)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 59)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 60)
  │   💬 Args: [result, "12"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 61)
  │   💬 Args: [123456789, 8, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 62)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 63)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 64)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 65)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 66)
  │   💬 Args: [result, "1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 67)
  │   💬 Args: [123456789, 9, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 68)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 69)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 70)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 71)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 72)
  │   💬 Args: [result, "0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 73)
  │   💬 Args: [123456789, 10, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 74)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 75)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 76)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 77)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 78)
  │   💬 Args: [result, "0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 79)
  │   💬 Args: [123456789, 10, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 80)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 81)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 82)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 83)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 84)
  │   💬 Args: [result, "0.1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 85)
  │   💬 Args: [123456789, 10, 2]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 86)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 87)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 88)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 89)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 90)
  │   💬 Args: [result, "0.12"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 91)
  │   💬 Args: [123456789, 10, 3]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 92)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 93)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 94)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 95)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 96)
  │   💬 Args: [result, "0.123"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 97)
  │   💬 Args: [123456789, 10, 4]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 98)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 99)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 100)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 101)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 102)
  │   💬 Args: [result, "0.1234"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 103)
  │   💬 Args: [123456789, 12, 3]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 104)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 105)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 106)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 107)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 108)
  │   💬 Args: [result, "0.001", "12, 3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 109)
  │   💬 Args: [123456789, 3, 3]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 110)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 111)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 112)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 113)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 114)
  │   💬 Args: [result, "123,456.789", "3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 115)
  │   💬 Args: [123456789, 10, 10]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 116)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 117)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 118)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 119)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 120)
  │   💬 Args: [result, "0.1234567890", "10"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 121)
  │   💬 Args: [123456789, 10, 11]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 122)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 123)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 124)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 125)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 126)
  │   💬 Args: [result, "0.12345678900", "10,11"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 127)
  │   💬 Args: [123456789, 11, 11]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 128)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 129)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 130)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 131)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 132)
  │   💬 Args: [result, "0.01234567890", "11, 11"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 133)
  │   💬 Args: [123456789, 11, 12]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 134)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 135)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 136)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 137)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 138)
  │   💬 Args: [result, "0.012345678900", "11, 12"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 139)
  │   💬 Args: [123456789, 11, 13]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 140)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 141)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 142)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 143)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 144)
  │   💬 Args: [result, "0.0123456789000", "11, 13"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 145)
  │   💬 Args: [123456789, 10, 18]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 146)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 147)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 148)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 149)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 150)
  │   💬 Args: [result, "0.123456789000000000", "11, 18"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 151)
  │   💬 Args: [123456789, 1, 9]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 152)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 153)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 154)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 155)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 156)
  │   💬 Args: [result, "12,345,678.900000000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 157)
  │   💬 Args: [1234567890, 2, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 158)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 159)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 160)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 161)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 162)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 163)
  │   💬 Args: [12345678900, 3, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 164)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 165)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 166)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 167)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 168)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 169)
  │   💬 Args: [123456789000, 4, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 170)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 171)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 172)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 173)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 174)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 175)
  │   💬 Args: [1234567890000, 5, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 176)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 177)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 178)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 179)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 180)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 181)
  │   💬 Args: [12345678900000, 6, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 182)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 183)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 184)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 185)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 186)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 187)
  │   💬 Args: [123456789000000, 7, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 188)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 189)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 190)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 191)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 192)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 193)
  │   💬 Args: [1234567890000000, 8, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 194)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 195)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 196)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 197)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 198)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 199)
  │   💬 Args: [12345678900000000, 9, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 200)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 201)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 202)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 203)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 204)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 205)
  │   💬 Args: [123456789000000000, 10, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 206)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 207)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 208)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 209)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 210)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 211)
  │   💬 Args: [123456789000000001, 10, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 212)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 213)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 214)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 215)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 216)
  │   💬 Args: [result, "12,345,678.9"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 217)
  │   💬 Args: [123456789000000001, 10, 2]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 218)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 219)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 220)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 221)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 222)
  │   💬 Args: [result, "12,345,678.90"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 223)
  │   💬 Args: [123456789000000001, 10, 3]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 224)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 225)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 226)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 227)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 228)
  │   💬 Args: [result, "12,345,678.900"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 229)
  │   💬 Args: [123456789000000001, 10, 4]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 230)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 231)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 232)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 233)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 234)
  │   💬 Args: [result, "12,345,678.9000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 235)
  │   💬 Args: [123456789000000001, 10, 5]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 236)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 237)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 238)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 239)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 240)
  │   💬 Args: [result, "12,345,678.90000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 241)
  │   💬 Args: [123456789000000001, 10, 6]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 242)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 243)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 244)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 245)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 246)
  │   💬 Args: [result, "12,345,678.900000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 247)
  │   💬 Args: [123456789000000001, 10, 7]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 248)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 249)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 250)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 251)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 252)
  │   💬 Args: [result, "12,345,678.9000000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 253)
  │   💬 Args: [123456789000000001, 10, 8]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 254)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 255)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 256)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 257)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 258)
  │   💬 Args: [result, "12,345,678.90000000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 259)
  │   💬 Args: [123456789000000001, 10, 9]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 260)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 261)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 262)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 263)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 264)
  │   💬 Args: [result, "12,345,678.900000000"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 265)
  │   💬 Args: [123456789000000001, 10, 10]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 266)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 267)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 268)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 269)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 270)
  │   💬 Args: [result, "12,345,678.9000000001"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 271)
  │   💬 Args: [123456789000000001, 10, 11]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 272)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 273)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 274)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 275)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 276)
  │   💬 Args: [result, "12,345,678.90000000010"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 277)
  │   💬 Args: [10, 0, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 278)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 279)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 280)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 281)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 282)
  │   💬 Args: [result, "10"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 283)
  │   💬 Args: [10, 1, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 284)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 285)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 286)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 287)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 288)
  │   💬 Args: [result, "1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 289)
  │   💬 Args: [10, 2, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 290)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 291)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 292)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 293)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 294)
  │   💬 Args: [result, "0.1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 295)
  │   💬 Args: [1, 0, 0]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 296)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 297)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 298)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 299)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 300)
  │   💬 Args: [result, "1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 301)
  │   💬 Args: [1, 1, 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 302)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 303)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 304)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 305)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 306)
  │   💬 Args: [result, "0.1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 307)
  │   💬 Args: [1, 2, 2]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 308)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 309)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 310)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 311)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 312)
  │   💬 Args: [result, "0.01"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 313)
  │   💬 Args: [1, 3, 3]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 314)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 315)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 316)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 317)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 318)
  │   💬 Args: [result, "0.001", "here"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 319)
  │   💬 Args: [1, 4, 4]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 320)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 321)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 322)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 323)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 324)
  │   💬 Args: [result, "0.0001"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 325)
  │   💬 Args: [1, 5, 5]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 326)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 327)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 328)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 329)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 330)
  │   💬 Args: [result, "0.00001"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 331)
  │   💬 Args: [1, 6, 6]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 332)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 333)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 334)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 335)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 336)
  │   💬 Args: [result, "0.000001"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 337)
  │   💬 Args: [1, 7, 7]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 338)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 339)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 340)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 341)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 342)
  │   💬 Args: [result, "0.0000001"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 343)
  │   💬 Args: [1, 8, 8]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 344)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 345)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 346)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 347)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 348)
  │   💬 Args: [result, "0.00000001"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 349)
  │   💬 Args: [1, 9, 9]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 350)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 351)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 352)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 353)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 354)
  │   💬 Args: [result, "0.000000001"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 355)
  │   💬 Args: [1, 10, 10]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 356)
  │ │   💬 Args: [LibString.toString(whole)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 357)
  │ │     💬 Args: [whole]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 358)
  │     💬 Args: [LibString.toString(fraction), 0, _precision]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 359)
  │       💬 Args: [fraction]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 360)
      💬 Args: [result, "0.0000000001"]
      👁️  Def: internal
```
