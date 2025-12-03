# Function: testRETHExchangeRateBetween1And2()

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `testRETHExchangeRateBetween1And2()`
- **Visibility**: public
- **Source Range**: 15828:170:244

## Implementation

```solidity
function testRETHExchangeRateBetween1And2() public {
    uint256 rate = rethToken.getExchangeRate();
    assertGt(rate, 1e18);
    assertLt(rate, 2e18);
}
```

## Related Implementations

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
}
```

### assertLt(uint256,uint256)

- **Kind**: internal
- **Source**: 11928:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256)`

```solidity
function assertLt(uint256 left, uint256 right) virtual internal pure {
    vm.assertLt(left, right);
}
```

## External Calls

- **IRETHToken::getExchangeRate()**

## State Variable Reads

- **rethToken** (`contract IRETHToken`) [src/Interfaces/IRETHToken.sol/interface_IRETHToken.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.testRETHExchangeRateBetween1And2() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 1)
  │   💬 Args: [rate, 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256) (NodeID: 2)
      💬 Args: [rate, 2e18]
      👁️  Def: internal
```
