# Function: redeemCollateral(uint256,uint256,uint256,uint256[])

**Contract**: [src/RedemptionHelper.sol/contract_RedemptionHelper.md]

## Metadata

- **Contract**: RedemptionHelper
- **Signature**: `redeemCollateral(uint256,uint256,uint256,uint256[])`
- **Visibility**: external
- **Source Range**: 7038:1339:185

## Implementation

```solidity
function redeemCollateral(uint256 _bold, uint256 _maxIterationsPerCollateral, uint256 _maxFeePct, uint256[] memory _minCollRedeemed) external {
    require(_minCollRedeemed.length == numBranches, "Wrong _minCollRedeemed length");
    RedemptionContext[] memory branch = new RedemptionContext[](numBranches);
    for (uint256 i = 0; i < numBranches; ++i) {
        branch[i].collToken = collateralRegistry.getToken(i);
        branch[i].collBalanceBefore = branch[i].collToken.balanceOf(address(this));
    }
    uint256 boldBalanceBefore = boldToken.balanceOf(address(this));
    boldToken.transferFrom(msg.sender, address(this), _bold);
    collateralRegistry.redeemCollateral(_bold, _maxIterationsPerCollateral, _maxFeePct);
    for (uint256 i = 0; i < numBranches; ++i) {
        uint256 collRedeemed = branch[i].collToken.balanceOf(address(this)) - branch[i].collBalanceBefore;
        require(collRedeemed >= _minCollRedeemed[i], "Insufficient collateral redeemed");
        if (collRedeemed > 0) branch[i].collToken.safeTransfer(msg.sender, collRedeemed);
    }
    uint256 boldRemaining = boldToken.balanceOf(address(this)) - boldBalanceBefore;
    if (boldRemaining > 0) boldToken.transfer(msg.sender, boldRemaining);
}
```

## External Calls

- **ICollateralRegistry::getToken(uint256)**
- **IERC20::balanceOf(address)**
- **IBoldToken::balanceOf(address)**
- **IBoldToken::transferFrom(address,address,uint256)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IBoldToken::transfer(address,uint256)**

## Native Transfers

- **boldToken** (state variable) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## State Variable Reads

- **numBranches** (`uint256`)
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelper.redeemCollateral(uint256,uint256,uint256,uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
