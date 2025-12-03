# Function: testCannotRedeemZero()

**Contract**: [test/redemptions.t.sol/contract_Redemptions.md]

## Metadata

- **Contract**: Redemptions
- **Signature**: `testCannotRedeemZero()`
- **Visibility**: public
- **Source Range**: 335:185:332

## Implementation

```solidity
function testCannotRedeemZero() public {
    vm.expectRevert("CollateralRegistry: Amount must be greater than zero");
    collateralRegistry.redeemCollateral(0, 10, 1e18);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Redemptions.testCannotRedeemZero() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
