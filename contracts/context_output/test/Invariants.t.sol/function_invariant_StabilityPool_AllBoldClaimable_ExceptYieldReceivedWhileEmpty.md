# Function: invariant_StabilityPool_AllBoldClaimable_ExceptYieldReceivedWhileEmpty()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_StabilityPool_AllBoldClaimable_ExceptYieldReceivedWhileEmpty()`
- **Visibility**: external
- **Source Range**: 13195:1264:243

## Implementation

```solidity
function invariant_StabilityPool_AllBoldClaimable_ExceptYieldReceivedWhileEmpty() external view {
    for (uint256 j = 0; j < branches.length; ++j) {
        IStabilityPool stabilityPool = branches[j].stabilityPool;
        uint256 sumBoldDeposit = 0;
        uint256 sumYieldGain = 0;
        uint256 yieldGainsPending = stabilityPool.getYieldGainsPending();
        for (uint256 i = 0; i < actors.length; ++i) {
            sumBoldDeposit += stabilityPool.getCompoundedBoldDeposit(actors[i].account);
            sumYieldGain += stabilityPool.getDepositorYieldGain(actors[i].account);
        }
        assertLt(stabilityPool.getTotalBoldDeposits() - sumBoldDeposit, 1000, "totalBoldDeposits !~= sum(boldDeposit)");
        assertLt(stabilityPool.getYieldGainsOwed() - sumYieldGain, 1000, "yieldGainsOwed !~= sum(yieldGain)");
        assertLt(((boldToken.balanceOf(address(stabilityPool)) - sumBoldDeposit) - sumYieldGain) - yieldGainsPending, 1000, "SP BOLD balance !~= claimable + pending");
    }
}
```

## Related Implementations

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
}
```

## External Calls

- **IStabilityPool::getYieldGainsPending()**
- **IStabilityPool::getCompoundedBoldDeposit(address)**
- **IStabilityPool::getDepositorYieldGain(address)**
- **IStabilityPool::getTotalBoldDeposits()**
- **IStabilityPool::getYieldGainsOwed()**
- **IBoldToken::balanceOf(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_StabilityPool_AllBoldClaimable_ExceptYieldReceivedWhileEmpty() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [stabilityPool.getTotalBoldDeposits() - sumBoldDeposit, 1000, "totalBoldDeposits !~= sum(boldDeposit)"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [stabilityPool.getYieldGainsOwed() - sumYieldGain, 1000, "yieldGainsOwed !~= sum(yieldGain)"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 3)
      💬 Args: [((boldToken.balanceOf(address(stabilityPool)) - sumBoldDeposit) - sumYieldGain) - yieldGainsPending, 1000, "SP BOLD balance !~= claimable + pending"]
      👁️  Def: internal
```
