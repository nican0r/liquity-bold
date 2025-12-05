# Function: deposit()

**Contract**: [test/TestContracts/WETH.sol/contract_WETH9.md]

## Metadata

- **Contract**: WETH9
- **Signature**: `deposit()`
- **Visibility**: public
- **Source Range**: 1437:130:283

## Implementation

```solidity
function deposit() public payable {
    balanceOf[msg.sender] += msg.value;
    emit Deposit(msg.sender, msg.value);
}
```

## State Variable Writes

- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETH9.deposit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
