# Function: receiveColl(uint256)

**Contract**: [test/TestContracts/NonPayableSwitch.sol/contract_NonPayableSwitch.md]

## Metadata

- **Contract**: NonPayableSwitch
- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 840:166:276

## Implementation

```solidity
function receiveColl(uint256 _amount) external {
    collToken.safeTransferFrom(msg.sender, address(this), _amount);
}
```

## External Calls

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NonPayableSwitch.receiveColl(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
