# Function: run()

**Contract**: [script/GenerateStakingRewards.s.sol/contract_GenerateStakingRewards.md]

## Metadata

- **Contract**: GenerateStakingRewards
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 3325:157:116

## Implementation

```solidity
function run() external {
    vm.startBroadcast();
    Runner runner = new Runner();
    runner.run{value: (msg.sender.balance * 9) / 10}();
}
```

## External Calls

- **Vm::startBroadcast()**
- **unknown::unknown**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GenerateStakingRewards.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
