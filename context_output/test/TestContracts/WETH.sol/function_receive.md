# Function: receive()

**Contract**: [test/TestContracts/WETH.sol/contract_WETH9.md]

## Metadata

- **Contract**: WETH9
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1378:53:283

## Implementation

```solidity
receive() external payable {
    deposit();
}
```

## Related Implementations

### deposit()

- **Kind**: internal
- **Source**: 1437:130:283
- **Link**: `test/TestContracts/WETH.sol:WETH9:deposit()`

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
┌─ [0] ⚙️ FUNCTION: WETH9.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: WETH9.deposit() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```
