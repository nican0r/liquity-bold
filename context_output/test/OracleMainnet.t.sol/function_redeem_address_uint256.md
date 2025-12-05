# Function: redeem(address,uint256)

**Contract**: [test/OracleMainnet.t.sol/contract_OraclesMainnet.md]

## Metadata

- **Contract**: OraclesMainnet
- **Signature**: `redeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 6831:197:244

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
- **CollateralRegistryTester::redeemCollateral(uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **collateralRegistry** (`contract CollateralRegistryTester`) [test/TestContracts/CollateralRegistryTester.sol/contract_CollateralRegistryTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OraclesMainnet.redeem(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
