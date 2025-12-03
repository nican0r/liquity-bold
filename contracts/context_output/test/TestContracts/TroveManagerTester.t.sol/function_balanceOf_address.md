# Function: balanceOf(address)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 5911:121:282

## Implementation

```solidity
function balanceOf(address _account) external view returns (uint256) {
    return troveNFT.balanceOf(_account);
}
```

## External Calls

- **ITroveNFT::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
