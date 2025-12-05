# Function: withdraw(uint256)

**Contract**: [test/TestContracts/WETH.sol/contract_WETH9.md]

## Metadata

- **Contract**: WETH9
- **Signature**: `withdraw(uint256)`
- **Visibility**: public
- **Source Range**: 1573:215:283

## Implementation

```solidity
function withdraw(uint256 wad) public {
    require(balanceOf[msg.sender] >= wad);
    balanceOf[msg.sender] -= wad;
    payable(msg.sender).transfer(wad);
    emit Withdrawal(msg.sender, wad);
}
```

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETH9.withdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
