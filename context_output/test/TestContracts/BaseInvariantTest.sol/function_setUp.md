# Function: setUp()

**Contract**: [test/TestContracts/BaseInvariantTest.sol/contract_BaseInvariantTest.md]

## Metadata

- **Contract**: BaseInvariantTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1174:206:252

## Implementation

```solidity
function setUp() virtual public {
    for (uint256 i = 0; i < actors.length; ++i) {
        vm.label(actors[i].account, actors[i].label);
        targetSender(actors[i].account);
    }
}
```

## Related Implementations

### targetSender(address)

- **Kind**: internal
- **Source**: 2065:117:52
- **Link**: `lib/forge-std/src/StdInvariant.sol:StdInvariant:targetSender(address)`

```solidity
function targetSender(address newTargetedSender_) internal {
    _targetedSenders.push(newTargetedSender_);
}
```

## External Calls

- **Vm::label(address,string)**

## State Variable Reads

- **actors** (`struct BaseInvariantTest.Actor[]`)

## State Variable Writes

- **_targetedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseInvariantTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdInvariant.targetSender(address) (NodeID: 1)
      💬 Args: [actors[i].account]
      👁️  Def: internal
```
