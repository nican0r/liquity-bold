# Function: testTroveNFTMetadata()

**Contract**: [test/troveNFT.t.sol/contract_troveNFTTest.md]

## Metadata

- **Contract**: troveNFTTest
- **Signature**: `testTroveNFTMetadata()`
- **Visibility**: public
- **Source Range**: 5650:579:336

## Implementation

```solidity
function testTroveNFTMetadata() public view {
    assertEq(troveNFTWETH.name(), "Liquity V2 - Wrapped Ether Tester", "Invalid Trove Name");
    assertEq(troveNFTWETH.symbol(), "LV2_WETH", "Invalid Trove Symbol");
    assertEq(troveNFTWstETH.name(), "Liquity V2 - Wrapped Staked Ether", "Invalid Trove Name");
    assertEq(troveNFTWstETH.symbol(), "LV2_wstETH", "Invalid Trove Symbol");
    assertEq(troveNFTRETH.name(), "Liquity V2 - Rocket Pool ETH", "Invalid Trove Name");
    assertEq(troveNFTRETH.symbol(), "LV2_rETH", "Invalid Trove Symbol");
}
```

## Related Implementations

### assertEq(string,string,string)

- **Kind**: internal
- **Source**: 4348:146:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string,string)`

```solidity
function assertEq(string memory left, string memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **TroveNFT::name()**
- **TroveNFT::symbol()**

## State Variable Reads

- **troveNFTWETH** (`contract TroveNFT`) [src/TroveNFT.sol/contract_TroveNFT.md]
- **troveNFTWstETH** (`contract TroveNFT`) [src/TroveNFT.sol/contract_TroveNFT.md]
- **troveNFTRETH** (`contract TroveNFT`) [src/TroveNFT.sol/contract_TroveNFT.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: troveNFTTest.testTroveNFTMetadata() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 1)
  │   💬 Args: [troveNFTWETH.name(), "Liquity V2 - Wrapped Ether Tester", "Invalid Trove Name"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 2)
  │   💬 Args: [troveNFTWETH.symbol(), "LV2_WETH", "Invalid Trove Symbol"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 3)
  │   💬 Args: [troveNFTWstETH.name(), "Liquity V2 - Wrapped Staked Ether", "Invalid Trove Name"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 4)
  │   💬 Args: [troveNFTWstETH.symbol(), "LV2_wstETH", "Invalid Trove Symbol"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 5)
  │   💬 Args: [troveNFTRETH.name(), "Liquity V2 - Rocket Pool ETH", "Invalid Trove Name"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string,string) (NodeID: 6)
      💬 Args: [troveNFTRETH.symbol(), "LV2_rETH", "Invalid Trove Symbol"]
      👁️  Def: internal
```
