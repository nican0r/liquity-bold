# Function: excludeSenders()

**Contract**: [test/TestContracts/Accounts.sol/contract_TestAccounts.md]

## Metadata

- **Contract**: TestAccounts
- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2907:134:52
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_) {
    excludedSenders_ = _excludedSenders;
}
```

## State Variable Reads

- **_excludedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
