# Function: provideToSP(uint256,address,uint256)

**Contract**: [test/RedemptionHelper.t.sol/contract_RedemptionHelperTest.md]

## Metadata

- **Contract**: RedemptionHelperTest
- **Signature**: `provideToSP(uint256,address,uint256)`
- **Visibility**: public
- **Source Range**: 5704:177:245

## Implementation

```solidity
function provideToSP(uint256 branchIdx, address account, uint256 bold) public {
    vm.prank(account);
    branch[branchIdx].stabilityPool.provideToSP(bold, true);
}
```

## External Calls

- **Vm::prank(address)**
- **IStabilityPool::provideToSP(uint256,bool)**

## State Variable Reads

- **branch** (`struct TestDeployer.LiquityContractsDev[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelperTest.provideToSP(uint256,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
