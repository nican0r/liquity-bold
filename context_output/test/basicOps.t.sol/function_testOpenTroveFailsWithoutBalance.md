# Function: testOpenTroveFailsWithoutBalance()

**Contract**: [test/basicOps.t.sol/contract_BasicOps.md]

## Metadata

- **Contract**: BasicOps
- **Signature**: `testOpenTroveFailsWithoutBalance()`
- **Visibility**: public
- **Source Range**: 512:433:297

## Implementation

```solidity
function testOpenTroveFailsWithoutBalance() public {
    priceFeed.setPrice(2000e18);
    vm.startPrank(G);
    collToken.approve(address(borrowerOperations), 2e18);
    vm.expectRevert("ERC20: transfer amount exceeds balance");
    borrowerOperations.openTrove(G, 0, 2e18, 2000e18, 0, 0, MIN_ANNUAL_INTEREST_RATE, 1000e18, address(0), address(0), address(0));
    vm.stopPrank();
}
```

## External Calls

- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **Vm::expectRevert(bytes)**
- **IBorrowerOperationsTester::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasicOps.testOpenTroveFailsWithoutBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
