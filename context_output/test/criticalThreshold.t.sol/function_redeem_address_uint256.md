# Function: redeem(address,uint256)

**Contract**: [test/criticalThreshold.t.sol/contract_CriticalThresholdTest.md]

## Metadata

- **Contract**: CriticalThresholdTest
- **Signature**: `redeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 13971:197:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function redeem(address _from, uint256 _boldAmount) public {
    vm.startPrank(_from);
    collateralRegistry.redeemCollateral(_boldAmount, MAX_UINT256, 1e18);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **ICollateralRegistry::redeemCollateral(uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.redeem(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
