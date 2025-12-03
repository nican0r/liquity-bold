# Function: claimAllCollGains(address)

**Contract**: [test/criticalThreshold.t.sol/contract_CriticalThresholdTest.md]

## Metadata

- **Contract**: CriticalThresholdTest
- **Signature**: `claimAllCollGains(address)`
- **Visibility**: public
- **Source Range**: 11939:159:254
- **Inherited From**: BaseTest

## Implementation

```solidity
function claimAllCollGains(address _account) public {
    vm.startPrank(_account);
    stabilityPool.claimAllCollGains();
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IStabilityPool::claimAllCollGains()**
- **Vm::stopPrank()**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.claimAllCollGains(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
