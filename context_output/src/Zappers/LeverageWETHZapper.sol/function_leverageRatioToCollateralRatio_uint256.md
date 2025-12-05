# Function: leverageRatioToCollateralRatio(uint256)

**Contract**: [src/Zappers/LeverageWETHZapper.sol/contract_LeverageWETHZapper.md]

## Metadata

- **Contract**: LeverageWETHZapper
- **Signature**: `leverageRatioToCollateralRatio(uint256)`
- **Visibility**: external
- **Source Range**: 8642:184:206

## Implementation

```solidity
function leverageRatioToCollateralRatio(uint256 _inputRatio) external pure returns (uint256) {
    return (_inputRatio * DECIMAL_PRECISION) / (_inputRatio - DECIMAL_PRECISION);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageWETHZapper.leverageRatioToCollateralRatio(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
