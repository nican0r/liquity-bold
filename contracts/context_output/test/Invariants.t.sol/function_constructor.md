# Function: constructor()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 811:357:252
- **Inherited From**: BaseInvariantTest

## Implementation

```solidity
constructor() {
    actors.push(Actor("adam", adam));
    actors.push(Actor("barb", barb));
    actors.push(Actor("carl", carl));
    actors.push(Actor("dana", dana));
    actors.push(Actor("eric", eric));
    actors.push(Actor("fran", fran));
    actors.push(Actor("gabe", gabe));
    actors.push(Actor("hope", hope));
}
```

## State Variable Reads

- **adam** (`address`)
- **barb** (`address`)
- **carl** (`address`)
- **dana** (`address`)
- **eric** (`address`)
- **fran** (`address`)
- **gabe** (`address`)
- **hope** (`address`)

## State Variable Writes

- **actors** (`struct BaseInvariantTest.Actor[]`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BaseInvariantTest.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BaseInvariantTest
```
