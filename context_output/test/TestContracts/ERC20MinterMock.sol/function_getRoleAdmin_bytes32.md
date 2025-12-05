# Function: getRoleAdmin(bytes32)

**Contract**: [test/TestContracts/ERC20MinterMock.sol/contract_ERC20MinterMock.md]

## Metadata

- **Contract**: ERC20MinterMock
- **Signature**: `getRoleAdmin(bytes32)`
- **Visibility**: public
- **Source Range**: 4504:129:70
- **Inherited From**: AccessControl

## Implementation

```solidity
///  @dev Returns the admin role that controls `role`. See {grantRole} and
///  {revokeRole}.
///  To change a role's admin, use {_setRoleAdmin}.
function getRoleAdmin(bytes32 role) virtual override public view returns (bytes32) {
    return _roles[role].adminRole;
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the admin role that controls `role`. See {grantRole} and
 {revokeRole}.
 To change a role's admin, use {_setRoleAdmin}.

### Interface Documentation

 @dev Returns the admin role that controls `role`. See {grantRole} and
 {revokeRole}.
 To change a role's admin, use {AccessControl-_setRoleAdmin}.
