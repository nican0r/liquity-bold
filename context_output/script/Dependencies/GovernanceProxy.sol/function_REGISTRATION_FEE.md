# Function: REGISTRATION_FEE()

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `REGISTRATION_FEE()`
- **Visibility**: external
- **Source Range**: 1950:122:110

## Implementation

```solidity
function REGISTRATION_FEE() override external view returns (uint256) {
    return governance.REGISTRATION_FEE();
}
```

## External Calls

- **Governance::REGISTRATION_FEE()**

## State Variable Reads

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceProxy.REGISTRATION_FEE() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Amount of BOLD to be paid in order to register a new initiative
 @return registrationFee Registration fee
