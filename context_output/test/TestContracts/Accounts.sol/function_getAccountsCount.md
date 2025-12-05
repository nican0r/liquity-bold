# Function: getAccountsCount()

**Contract**: [test/TestContracts/Accounts.sol/contract_Accounts.md]

## Metadata

- **Contract**: Accounts
- **Signature**: `getAccountsCount()`
- **Visibility**: external
- **Source Range**: 976:102:248

## Implementation

```solidity
function getAccountsCount() external view returns (uint256) {
    return accountsPks.length;
}
```

## State Variable Reads

- **accountsPks** (`uint256[10]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Accounts.getAccountsCount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
