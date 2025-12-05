# Function: invariant_AllFundsClaimable()

**Contract**: [test/SPInvariants.t.sol/contract_SPInvariantsTest.md]

## Metadata

- **Contract**: SPInvariantsTest
- **Signature**: `invariant_AllFundsClaimable()`
- **Visibility**: external
- **Source Range**: 3076:96:246

## Implementation

```solidity
function invariant_AllFundsClaimable() external view {
    assert_AllFundsClaimable();
}
```

## Related Implementations

### assert_AllFundsClaimable()

- **Kind**: internal
- **Source**: 1611:1409:246
- **Link**: `test/SPInvariants.t.sol:SPInvariantsBase:assert_AllFundsClaimable()`

```solidity
function assert_AllFundsClaimable() internal view {
    uint256 stabilityPoolColl = stabilityPool.getCollBalance();
    uint256 stabilityPoolBold = stabilityPool.getTotalBoldDeposits();
    uint256 yieldGainsOwed = stabilityPool.getYieldGainsOwed();
    uint256 claimableColl = 0;
    uint256 claimableBold = 0;
    uint256 sumYieldGains = 0;
    for (uint256 i = 0; i < actors.length; ++i) {
        claimableColl += stabilityPool.getDepositorCollGain(actors[i].account);
        claimableBold += stabilityPool.getCompoundedBoldDeposit(actors[i].account);
        sumYieldGains += stabilityPool.getDepositorYieldGain(actors[i].account);
    }
    assertGeDecimal(stabilityPoolColl, claimableColl, 18, "SP coll insolvency");
    assertApproxEqAbsRelDecimal(stabilityPoolColl, claimableColl, 1e-5 ether, 1, 18, "SP coll loss");
    assertGeDecimal(stabilityPoolBold, claimableBold, 18, "SP BOLD insolvency");
    assertApproxEqAbsRelDecimal(stabilityPoolBold, claimableBold, 1e-7 ether, 1, 18, "SP BOLD loss");
    assertGeDecimal(yieldGainsOwed, sumYieldGains, 18, "SP yield insolvency");
    assertApproxEqAbsRelDecimal(yieldGainsOwed, sumYieldGains, 1 ether, 1, 18, "SP yield loss");
}
```

### assertGeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 15894:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGeDecimal(left, right, decimals, err);
}
```

### assertApproxEqAbsRelDecimal(uint256,uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 207:590:250
- **Link**: `test/TestContracts/Assertions.sol:Assertions:assertApproxEqAbsRelDecimal(uint256,uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsRelDecimal(uint256 a, uint256 b, uint256 maxAbs, uint256 maxRel, uint256 decimals, string memory err) internal pure {
    if (b == 0) {
        assertApproxEqAbsDecimal(a, b, maxAbs, decimals, err);
        return;
    }
    uint256 abs = stdMath.delta(a, b);
    uint256 rel = stdMath.percentDelta(a, b);
    if ((abs > maxAbs) && (rel > maxRel)) {
        assertApproxEqRelDecimal(a, b, maxRel, decimals, err);
        revert("Assertion should have failed");
    }
}
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
}
```

### delta(uint256,uint256)

- **Kind**: internal
- **Source**: 521:114:54
- **Link**: `lib/forge-std/src/StdMath.sol:stdMath:delta(uint256,uint256)`

```solidity
function delta(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? (a - b) : (b - a);
}
```

### percentDelta(uint256,uint256)

- **Kind**: internal
- **Source**: 999:160:54
- **Link**: `lib/forge-std/src/StdMath.sol:stdMath:percentDelta(uint256,uint256)`

```solidity
function percentDelta(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 absDelta = delta(a, b);
    return (absDelta * 1e18) / b;
}
```

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 19242:338:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqRelDecimal(left, right, maxPercentDelta, decimals, err);
}
```

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SPInvariantsTest.invariant_AllFundsClaimable() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SPInvariantsBase.assert_AllFundsClaimable() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 2)
    │   💬 Args: [stabilityPoolColl, claimableColl, 18, "SP coll insolvency"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Assertions.assertApproxEqAbsRelDecimal(uint256,uint256,uint256,uint256,uint256,string) (NodeID: 3)
    │   💬 Args: [stabilityPoolColl, claimableColl, 1e-5 ether, 1, 18, "SP coll loss"]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 4)
    │ │   💬 Args: [a, b, maxAbs, decimals, err]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: stdMath.delta(uint256,uint256) (NodeID: 5)
    │ │   💬 Args: [a, b]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: stdMath.percentDelta(uint256,uint256) (NodeID: 6)
    │ │   💬 Args: [a, b]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: stdMath.delta(uint256,uint256) (NodeID: 7)
    │ │     💬 Args: [a, b]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 8)
    │     💬 Args: [a, b, maxRel, decimals, err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 9)
    │   💬 Args: [stabilityPoolBold, claimableBold, 18, "SP BOLD insolvency"]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Assertions.assertApproxEqAbsRelDecimal(uint256,uint256,uint256,uint256,uint256,string) (NodeID: 10)
    │   💬 Args: [stabilityPoolBold, claimableBold, 1e-7 ether, 1, 18, "SP BOLD loss"]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 11)
    │ │   💬 Args: [a, b, maxAbs, decimals, err]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: stdMath.delta(uint256,uint256) (NodeID: 12)
    │ │   💬 Args: [a, b]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: stdMath.percentDelta(uint256,uint256) (NodeID: 13)
    │ │   💬 Args: [a, b]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: stdMath.delta(uint256,uint256) (NodeID: 14)
    │ │     💬 Args: [a, b]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 15)
    │     💬 Args: [a, b, maxRel, decimals, err]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 16)
    │   💬 Args: [yieldGainsOwed, sumYieldGains, 18, "SP yield insolvency"]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Assertions.assertApproxEqAbsRelDecimal(uint256,uint256,uint256,uint256,uint256,string) (NodeID: 17)
        💬 Args: [yieldGainsOwed, sumYieldGains, 1 ether, 1, 18, "SP yield loss"]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 18)
      │   💬 Args: [a, b, maxAbs, decimals, err]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdMath.delta(uint256,uint256) (NodeID: 19)
      │   💬 Args: [a, b]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdMath.percentDelta(uint256,uint256) (NodeID: 20)
      │   💬 Args: [a, b]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdMath.delta(uint256,uint256) (NodeID: 21)
      │     💬 Args: [a, b]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 22)
          💬 Args: [a, b, maxRel, decimals, err]
          👁️  Def: internal
```
