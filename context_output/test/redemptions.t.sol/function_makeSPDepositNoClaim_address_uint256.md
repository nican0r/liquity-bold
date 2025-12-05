# Function: makeSPDepositNoClaim(address,uint256)

**Contract**: [test/redemptions.t.sol/contract_Redemptions.md]

## Metadata

- **Contract**: Redemptions
- **Signature**: `makeSPDepositNoClaim(address,uint256)`
- **Visibility**: public
- **Source Range**: 11348:187:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function makeSPDepositNoClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.provideToSP(_amount, false);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IStabilityPool::provideToSP(uint256,bool)**
- **Vm::stopPrank()**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.makeSPDepositNoClaim(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
