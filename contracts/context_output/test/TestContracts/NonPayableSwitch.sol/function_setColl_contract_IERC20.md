# Function: setColl(contract IERC20)

**Contract**: [test/TestContracts/NonPayableSwitch.sol/contract_NonPayableSwitch.md]

## Metadata

- **Contract**: NonPayableSwitch
- **Signature**: `setColl(contract IERC20)`
- **Visibility**: external
- **Source Range**: 285:72:276

## Implementation

```solidity
function setColl(IERC20 _eth) external {
    collToken = _eth;
}
```

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NonPayableSwitch.setColl(contract IERC20) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
