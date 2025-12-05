# Function: tap(contract ERC20Faucet)

**Contract**: [script/OpenTroves.s.sol/contract_Proxy.md]

## Metadata

- **Contract**: Proxy
- **Signature**: `tap(contract ERC20Faucet)`
- **Visibility**: external
- **Source Range**: 1083:141:120

## Implementation

```solidity
function tap(ERC20Faucet faucet) external {
    faucet.tap();
    faucet.transfer(msg.sender, faucet.balanceOf(address(this)));
}
```

## External Calls

- **ERC20Faucet::tap()**
- **ERC20Faucet::transfer(address,uint256)**
- **ERC20Faucet::balanceOf(address)**

## Native Transfers

- **faucet** (function parameter)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Proxy.tap(contract ERC20Faucet) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
