# Function: ownerOf(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `ownerOf(uint256)`
- **Visibility**: external
- **Source Range**: 5788:117:282

## Implementation

```solidity
function ownerOf(uint256 _troveId) external view returns (address) {
    return troveNFT.ownerOf(_troveId);
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManagerTester.ownerOf(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
