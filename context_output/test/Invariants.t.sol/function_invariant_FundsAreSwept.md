# Function: invariant_FundsAreSwept()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_FundsAreSwept()`
- **Visibility**: external
- **Source Range**: 4655:871:243

## Implementation

```solidity
function invariant_FundsAreSwept() external view {
    for (uint256 i = 0; i < actors.length; ++i) {
        address actor = actors[i].account;
        assertEqDecimal(boldToken.balanceOf(actor), 0, 18, "Incomplete BOLD sweep");
        assertEqDecimal(weth.balanceOf(actor), 0, 18, "Incomplete WETH sweep");
        for (uint256 j = 0; j < branches.length; ++j) {
            IERC20 collToken = branches[j].collToken;
            address borrowerOperations = address(branches[j].borrowerOperations);
            assertEqDecimal(weth.allowance(actor, borrowerOperations), 0, 18, "WETH allowance != 0");
            assertEqDecimal(collToken.balanceOf(actor), 0, 18, "Incomplete coll sweep");
            assertEqDecimal(collToken.allowance(actor, borrowerOperations), 0, 18, "Coll allowance != 0");
        }
    }
}
```

## Related Implementations

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **IBoldToken::balanceOf(address)**
- **IERC20::balanceOf(address)**
- **IERC20::allowance(address,address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_FundsAreSwept() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [boldToken.balanceOf(actor), 0, 18, "Incomplete BOLD sweep"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [weth.balanceOf(actor), 0, 18, "Incomplete WETH sweep"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [weth.allowance(actor, borrowerOperations), 0, 18, "WETH allowance != 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [collToken.balanceOf(actor), 0, 18, "Incomplete coll sweep"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 5)
      💬 Args: [collToken.allowance(actor, borrowerOperations), 0, 18, "Coll allowance != 0"]
      👁️  Def: internal
```
