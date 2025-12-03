# Function: constructor(contract Governance)

**Contract**: [script/Dependencies/GovernanceProxy.sol/contract_GovernanceProxy.md]

## Metadata

- **Contract**: GovernanceProxy
- **Signature**: `constructor(contract Governance)`
- **Visibility**: public
- **Source Range**: 733:342:110

## Implementation

```solidity
constructor(Governance _governance) {
    governance = _governance;
    lqty = _governance.lqty();
    bold = _governance.bold();
    address userProxy = _governance.deriveUserProxyAddress(address(this));
    lqty.approve(userProxy, type(uint256).max);
    bold.approve(address(_governance), type(uint256).max);
}
```

## External Calls

- **Governance::lqty()**
- **Governance::bold()**
- **Governance::deriveUserProxyAddress(address)**
- **IERC20::approve(address,uint256)**

## State Variable Reads

- **lqty** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **governance** (`contract Governance`) [lib/V2-gov/src/Governance.sol/contract_Governance.md]
- **lqty** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: GovernanceProxy.constructor(contract Governance) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: GovernanceProxy
```
