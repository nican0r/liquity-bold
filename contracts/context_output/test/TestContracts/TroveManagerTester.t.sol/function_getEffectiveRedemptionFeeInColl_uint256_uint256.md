# Function: getEffectiveRedemptionFeeInColl(uint256,uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getEffectiveRedemptionFeeInColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5361:230:282

## Implementation

```solidity
function getEffectiveRedemptionFeeInColl(uint256 _redeemAmount, uint256 _price) external view returns (uint256) {
    return (collateralRegistry.getEffectiveRedemptionFeeInBold(_redeemAmount) * DECIMAL_PRECISION) / _price;
}
```

## External Calls

- **ICollateralRegistry::getEffectiveRedemptionFeeInBold(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.getEffectiveRedemptionFeeInColl(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
