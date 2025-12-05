# Function: invariant_StabilityPool_AllCollClaimable()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `invariant_StabilityPool_AllCollClaimable()`
- **Visibility**: external
- **Source Range**: 14465:648:243

## Implementation

```solidity
function invariant_StabilityPool_AllCollClaimable() external view {
    for (uint256 j = 0; j < branches.length; ++j) {
        IStabilityPool stabilityPool = branches[j].stabilityPool;
        uint256 stabilityPoolEth = stabilityPool.getCollBalance();
        uint256 claimableEth = 0;
        for (uint256 i = 0; i < actors.length; ++i) {
            claimableEth += stabilityPool.getDepositorCollGain(actors[i].account);
            claimableEth += stabilityPool.stashedColl(actors[i].account);
        }
        assertLt(stabilityPoolEth - claimableEth, 1000, "SP Coll !~= claimable Coll");
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

- **IStabilityPool::getCollBalance()**
- **IStabilityPool::getDepositorCollGain(address)**
- **IStabilityPool::stashedColl(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.invariant_StabilityPool_AllCollClaimable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [stabilityPoolEth - claimableEth, 1000, "SP Coll !~= claimable Coll"]
      👁️  Def: internal
```
