# Function: testTroveURIAttributes()

**Contract**: [test/troveNFT.t.sol/contract_troveNFTTest.md]

## Metadata

- **Contract**: troveNFTTest
- **Signature**: `testTroveURIAttributes()`
- **Visibility**: public
- **Source Range**: 8526:2364:336

## Implementation

```solidity
function testTroveURIAttributes() public view {
    address collateral = address(contractsArray[0].collToken);
    string memory uri = troveNFTWETH.tokenURI(troveIds[0]);
    string memory uriSplit = LibString.slice(uri, 29, bytes(uri).length);
    string memory decodedUri = string(Base64.decode(uriSplit));
    assertTrue(LibString.contains(decodedUri, "\"name\": \"Liquity V2 - "), "NFT Name attribute missing");
    assertTrue(LibString.contains(decodedUri, "\"description\": \"Liquity V2 is a collateralized debt platform. Users can lock up"), "NFT description attribute missing");
    assertTrue(LibString.contains(decodedUri, "\"trait_type\": \"Collateral Token\""), "Collateral Token attribute missing");
    assertTrue(LibString.contains(decodedUri, "\"trait_type\": \"Collateral Amount\""), "Collateral Amount attribute missing");
    assertTrue(LibString.contains(decodedUri, "\"trait_type\": \"Debt Token\""), "Debt Token attribute missing");
    assertTrue(LibString.contains(decodedUri, "\"trait_type\": \"Debt Amount\""), "Debt Amount attribute missing");
    assertTrue(LibString.contains(decodedUri, "\"trait_type\": \"Interest Rate\""), "Interest Rate attribute missing");
    assertTrue(LibString.contains(decodedUri, "\"trait_type\": \"Status\""), "Status attribute missing");
    assertTrue(LibString.contains(decodedUri, string.concat("\"value\": \"", Strings.toHexString(collateral))), "Incorrect Collateral Token value");
    assertTrue(LibString.contains(decodedUri, "\"value\": \"10000000000000000000\""), "Incorrect Collateral Amount value");
    assertTrue(LibString.contains(decodedUri, string.concat("\"value\": \"", Strings.toHexString(address(boldToken)))), "Incorrect Debt Token value");
    assertTrue(LibString.contains(decodedUri, "\"value\": \"10009589041095890410958\""), "Incorrect Debt Amount value");
    assertTrue(LibString.contains(decodedUri, "\"value\": \"50000000000000000\""), "Incorrect Interest Rate value");
    assertTrue(LibString.contains(decodedUri, "\"value\": \"Active\""), "Incorrect Status value");
}
```

## Related Implementations

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

### decode(string)

- **Kind**: internal
- **Source**: 4705:2729:0
- **Link**: `lib/Solady/src/utils/Base64.sol:Base64:decode(string)`

```solidity
/// @dev Decodes base64 encoded `data`.
///  Supports:
///  - RFC 4648 (both standard and file-safe mode).
///  - RFC 3501 (63: ',').
///  Does not support:
///  - Line breaks.
///  Note: For performance reasons,
///  this function will NOT revert on invalid `data` inputs.
///  Outputs for invalid inputs will simply be undefined behaviour.
///  It is the user's responsibility to ensure that the `data`
///  is a valid base64 encoded string.
function decode(string memory data) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        let dataLength := mload(data)
        if dataLength {
            let decodedLength := mul(shr(2, dataLength), 3)
            for {} 1 {} {
                if iszero(and(dataLength, 3)) {
                    let t := xor(mload(add(data, dataLength)), 0x3d3d)
                    decodedLength := sub(decodedLength, add(iszero(byte(30, t)), iszero(byte(31, t))))
                    break
                }
                decodedLength := add(decodedLength, sub(and(dataLength, 3), 1))
                break
            }
            result := mload(0x40)
            mstore(result, decodedLength)
            let ptr := add(result, 0x20)
            let end := add(ptr, decodedLength)
            let m := 0xfc000000fc00686c7074787c8084888c9094989ca0a4a8acb0b4b8bcc0c4c8cc
            mstore(0x5b, m)
            mstore(0x3b, 0x04080c1014181c2024282c3034383c4044484c5054585c6064)
            mstore(0x1a, 0xf8fcf800fcd0d4d8dce0e4e8ecf0f4)
            for {} 1 {} {
                data := add(data, 4)
                let input := mload(data)
                mstore(ptr, or(and(m, mload(byte(28, input))), shr(6, or(and(m, mload(byte(29, input))), shr(6, or(and(m, mload(byte(30, input))), shr(6, mload(byte(31, input)))))))))
                ptr := add(ptr, 3)
                if iszero(lt(ptr, end)) {
                    break
                }
            }
            mstore(0x40, add(end, 0x20))
            mstore(end, 0)
            mstore(0x60, 0)
        }
    }
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1689:113:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    vm.assertTrue(data, err);
}
```

### contains(string,string)

- **Kind**: internal
- **Source**: 30164:153:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:contains(string,string)`

```solidity
/// @dev Returns true if `search` is found in `subject`, false otherwise.
function contains(string memory subject, string memory search) internal pure returns (bool) {
    return indexOf(subject, search) != NOT_FOUND;
}
```

### indexOf(string,string)

- **Kind**: internal
- **Source**: 27910:182:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:indexOf(string,string)`

```solidity
/// @dev Returns the byte index of the first location of `search` in `subject`,
///  searching from left to right.
///  Returns `NOT_FOUND` (i.e. `type(uint256).max`) if the `search` is not found.
function indexOf(string memory subject, string memory search) internal pure returns (uint256 result) {
    result = indexOf(subject, search, 0);
}
```

### indexOf(string,string,uint256)

- **Kind**: internal
- **Source**: 25633:2064:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:indexOf(string,string,uint256)`

```solidity
/// @dev Returns the byte index of the first location of `search` in `subject`,
///  searching from left to right, starting from `from`.
///  Returns `NOT_FOUND` (i.e. `type(uint256).max`) if the `search` is not found.
function indexOf(string memory subject, string memory search, uint256 from) internal pure returns (uint256 result) {
    /// @solidity memory-safe-assembly
    assembly {
        for {
            let subjectLength := mload(subject)
        } 1 {} {
            if iszero(mload(search)) {
                if iszero(gt(from, subjectLength)) {
                    result := from
                    break
                }
                result := subjectLength
                break
            }
            let searchLength := mload(search)
            let subjectStart := add(subject, 0x20)
            result := not(0)
            subject := add(subjectStart, from)
            let end := add(sub(add(subjectStart, subjectLength), searchLength), 1)
            let m := shl(3, sub(0x20, and(searchLength, 0x1f)))
            let s := mload(add(search, 0x20))
            if iszero(and(lt(subject, end), lt(from, subjectLength))) {
                break
            }
            if iszero(lt(searchLength, 0x20)) {
                for {
                    let h := keccak256(add(search, 0x20), searchLength)
                } 1 {} {
                    if iszero(shr(m, xor(mload(subject), s))) {
                        if eq(keccak256(subject, searchLength), h) {
                            result := sub(subject, subjectStart)
                            break
                        }
                    }
                    subject := add(subject, 1)
                    if iszero(lt(subject, end)) {
                        break
                    }
                }
                break
            }
            for {} 1 {} {
                if iszero(shr(m, xor(mload(subject), s))) {
                    result := sub(subject, subjectStart)
                    break
                }
                subject := add(subject, 1)
                if iszero(lt(subject, end)) {
                    break
                }
            }
            break
        }
    }
}
```

### toHexString(address)

- **Kind**: internal
- **Source**: 2407:149:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toHexString(address)`

```solidity
///  @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal representation.
function toHexString(address addr) internal pure returns (string memory) {
    return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);
}
```

### toHexString(uint256,uint256)

- **Kind**: internal
- **Source**: 1818:437:96
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toHexString(uint256,uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
    bytes memory buffer = new bytes((2 * length) + 2);
    buffer[0] = "0";
    buffer[1] = "x";
    for (uint256 i = (2 * length) + 1; i > 1; --i) {
        buffer[i] = _SYMBOLS[value & 0xf];
        value >>= 4;
    }
    require(value == 0, "Strings: hex length insufficient");
    return string(buffer);
}
```

## External Calls

- **TroveNFT::tokenURI(uint256)**

## State Variable Reads

- **contractsArray** (`struct TestDeployer.LiquityContractsDev[]`)
- **troveNFTWETH** (`contract TroveNFT`) [src/TroveNFT.sol/contract_TroveNFT.md]
- **troveIds** (`uint256[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **NOT_FOUND** (`uint256`)
- **_ADDRESS_LENGTH** (`uint8`)
- **_SYMBOLS** (`bytes16`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: troveNFTTest.testTroveURIAttributes() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 1)
  │   💬 Args: [uri, 29, bytes(uri).length]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Base64.decode(string) (NodeID: 2)
  │   💬 Args: [uriSplit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [LibString.contains(decodedUri, "\"name\": \"Liquity V2 - "), "NFT Name attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 4)
  │     💬 Args: [decodedUri, "\"name\": \"Liquity V2 - "]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 5)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 6)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 7)
  │   💬 Args: [LibString.contains(decodedUri, "\"description\": \"Liquity V2 is a collateralized debt platform. Users can lock up"), "NFT description attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 8)
  │     💬 Args: [decodedUri, "\"description\": \"Liquity V2 is a collateralized debt platform. Users can lock up"]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 9)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 10)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 11)
  │   💬 Args: [LibString.contains(decodedUri, "\"trait_type\": \"Collateral Token\""), "Collateral Token attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 12)
  │     💬 Args: [decodedUri, "\"trait_type\": \"Collateral Token\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 13)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 14)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 15)
  │   💬 Args: [LibString.contains(decodedUri, "\"trait_type\": \"Collateral Amount\""), "Collateral Amount attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 16)
  │     💬 Args: [decodedUri, "\"trait_type\": \"Collateral Amount\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 17)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 18)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 19)
  │   💬 Args: [LibString.contains(decodedUri, "\"trait_type\": \"Debt Token\""), "Debt Token attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 20)
  │     💬 Args: [decodedUri, "\"trait_type\": \"Debt Token\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 21)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 22)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 23)
  │   💬 Args: [LibString.contains(decodedUri, "\"trait_type\": \"Debt Amount\""), "Debt Amount attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 24)
  │     💬 Args: [decodedUri, "\"trait_type\": \"Debt Amount\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 25)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 26)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 27)
  │   💬 Args: [LibString.contains(decodedUri, "\"trait_type\": \"Interest Rate\""), "Interest Rate attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 28)
  │     💬 Args: [decodedUri, "\"trait_type\": \"Interest Rate\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 29)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 30)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 31)
  │   💬 Args: [LibString.contains(decodedUri, "\"trait_type\": \"Status\""), "Status attribute missing"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 32)
  │     💬 Args: [decodedUri, "\"trait_type\": \"Status\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 33)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 34)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 35)
  │   💬 Args: [LibString.contains(decodedUri, string.concat("\"value\": \"", Strings.toHexString(collateral))), "Incorrect Collateral Token value"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 36)
  │     💬 Args: [decodedUri, string.concat("\"value\": \"", Strings.toHexString(collateral))]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Strings.toHexString(address) (NodeID: 39)
  │   │   💬 Args: [collateral]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 40)
  │   │     💬 Args: [uint256(uint160(addr)), _ADDRESS_LENGTH]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 37)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 38)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 41)
  │   💬 Args: [LibString.contains(decodedUri, "\"value\": \"10000000000000000000\""), "Incorrect Collateral Amount value"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 42)
  │     💬 Args: [decodedUri, "\"value\": \"10000000000000000000\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 43)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 44)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 45)
  │   💬 Args: [LibString.contains(decodedUri, string.concat("\"value\": \"", Strings.toHexString(address(boldToken)))), "Incorrect Debt Token value"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 46)
  │     💬 Args: [decodedUri, string.concat("\"value\": \"", Strings.toHexString(address(boldToken)))]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Strings.toHexString(address) (NodeID: 49)
  │   │   💬 Args: [address(boldToken)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 50)
  │   │     💬 Args: [uint256(uint160(addr)), _ADDRESS_LENGTH]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 47)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 48)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 51)
  │   💬 Args: [LibString.contains(decodedUri, "\"value\": \"10009589041095890410958\""), "Incorrect Debt Amount value"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 52)
  │     💬 Args: [decodedUri, "\"value\": \"10009589041095890410958\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 53)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 54)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 55)
  │   💬 Args: [LibString.contains(decodedUri, "\"value\": \"50000000000000000\""), "Incorrect Interest Rate value"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 56)
  │     💬 Args: [decodedUri, "\"value\": \"50000000000000000\""]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 57)
  │       💬 Args: [subject, search]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 58)
  │         💬 Args: [subject, search, 0]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 59)
      💬 Args: [LibString.contains(decodedUri, "\"value\": \"Active\""), "Incorrect Status value"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LibString.contains(string,string) (NodeID: 60)
        💬 Args: [decodedUri, "\"value\": \"Active\""]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: LibString.indexOf(string,string) (NodeID: 61)
          💬 Args: [subject, search]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: LibString.indexOf(string,string,uint256) (NodeID: 62)
            💬 Args: [subject, search, 0]
            👁️  Def: internal
```
