# Function: makeSPDepositAndClaim(address,uint256)

**Contract**: [test/liquidations.t.sol/contract_LiquidationsTest.md]

## Metadata

- **Contract**: LiquidationsTest
- **Signature**: `makeSPDepositAndClaim(address,uint256)`
- **Visibility**: public
- **Source Range**: 11155:187:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function makeSPDepositAndClaim(address _account, uint256 _amount) public {
    vm.startPrank(_account);
    stabilityPool.provideToSP(_amount, true);
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
┌─ [0] ⚙️ FUNCTION: BaseTest.makeSPDepositAndClaim(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
