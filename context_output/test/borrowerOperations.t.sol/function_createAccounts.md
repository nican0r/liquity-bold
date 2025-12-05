# Function: createAccounts()

**Contract**: [test/borrowerOperations.t.sol/contract_BorrowerOperationsTest.md]

## Metadata

- **Contract**: BorrowerOperationsTest
- **Signature**: `createAccounts()`
- **Visibility**: public
- **Source Range**: 1325:270:248
- **Inherited From**: TestAccounts

## Implementation

```solidity
function createAccounts() public {
    address[10] memory tempAccounts;
    for (uint256 i = 0; i < accounts.getAccountsCount(); i++) {
        tempAccounts[i] = vm.addr(uint256(accounts.accountsPks(i)));
    }
    accountsList = tempAccounts;
}
```

## External Calls

- **Accounts::getAccountsCount()**
- **Vm::addr(uint256)**
- **Accounts::accountsPks(uint256)**

## State Variable Reads

- **accounts** (`contract Accounts`) [test/TestContracts/Accounts.sol/contract_Accounts.md]

## State Variable Writes

- **accountsList** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestAccounts.createAccounts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
