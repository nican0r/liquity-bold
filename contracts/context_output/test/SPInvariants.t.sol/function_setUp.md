# Function: setUp()

**Contract**: [test/SPInvariants.t.sol/contract_SPInvariantsTest.md]

## Metadata

- **Contract**: SPInvariantsTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1174:206:252
- **Inherited From**: BaseInvariantTest

## Implementation

```solidity
function setUp() virtual public {
    for (uint256 i = 0; i < actors.length; ++i) {
        vm.label(actors[i].account, actors[i].label);
        targetSender(actors[i].account);
    }
}
```

## External Calls

- **Vm::label(address,string)**

## Call Tree

```
No call tree available
```
