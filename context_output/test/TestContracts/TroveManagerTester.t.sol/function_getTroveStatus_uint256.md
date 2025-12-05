# Function: getTroveStatus(uint256)

**Contract**: [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]

## Metadata

- **Contract**: TroveManagerTester
- **Signature**: `getTroveStatus(uint256)`
- **Visibility**: external
- **Source Range**: 53836:129:188
- **Inherited From**: TroveManager

## Implementation

```solidity
function getTroveStatus(uint256 _troveId) override external view returns (Status) {
    return Troves[_troveId].status;
}
```

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getTroveStatus(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
