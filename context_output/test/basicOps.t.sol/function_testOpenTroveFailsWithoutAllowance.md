# Function: testOpenTroveFailsWithoutAllowance()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `testOpenTroveFailsWithoutAllowance()`
- **Visibility**: public
- **Source Range**: 142:364:297

## Implementation

```solidity
function testOpenTroveFailsWithoutAllowance() public {
    priceFeed.setPrice(2000e18);
    vm.startPrank(G);
    vm.expectRevert("ERC20: insufficient allowance");
    borrowerOperations.openTrove(G, 0, 2e18, 2000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasicOps.testOpenTroveFailsWithoutAllowance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
