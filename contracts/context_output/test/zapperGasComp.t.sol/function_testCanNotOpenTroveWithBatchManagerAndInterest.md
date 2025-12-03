# Function: testCanNotOpenTroveWithBatchManagerAndInterest()

**Contract**: [test/zapperGasComp.t.sol/contract_ZapperGasCompTest.md]

## Metadata

- **Contract**: ZapperGasCompTest
- **Signature**: `testCanNotOpenTroveWithBatchManagerAndInterest()`
- **Visibility**: external
- **Source Range**: 5521:862:337

## Implementation

```solidity
function testCanNotOpenTroveWithBatchManagerAndInterest() external {
    uint256 collAmount = 10 ether;
    uint256 boldAmount = 10000e18;
    registerBatchManager(B);
    IZapper.OpenTroveParams memory params = IZapper.OpenTroveParams({owner: A, ownerIndex: 0, collAmount: collAmount, boldAmount: boldAmount, upperHint: 0, lowerHint: 0, annualInterestRate: 5e16, batchManager: B, maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    vm.expectRevert("GCZ: Cannot choose interest if joining a batch");
    gasCompZapper.openTroveWithRawETH{value: ETH_GAS_COMPENSATION}(params);
    vm.stopPrank();
}
```

## Related Implementations

### registerBatchManager(address)

- **Kind**: internal
- **Source**: 14398:221:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:registerBatchManager(address)`

```solidity
function registerBatchManager(address _account) internal {
    registerBatchManager(_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD);
}
```

### registerBatchManager(address,uint128,uint128,uint128,uint128,uint128)

- **Kind**: internal
- **Source**: 14625:474:254
- **Link**: `test/TestContracts/BaseTest.sol:BaseTest:registerBatchManager(address,uint128,uint128,uint128,uint128,uint128)`

```solidity
function registerBatchManager(address _account, uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _fee, uint128 _minInterestRateChangePeriod) internal {
    vm.startPrank(_account);
    borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _fee, _minInterestRateChangePeriod);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes)**
- **unknown::unknown**
- **Vm::stopPrank()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperationsTester`) [test/TestContracts/Interfaces/IBorrowerOperationsTester.sol/interface_IBorrowerOperationsTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperGasCompTest.testCanNotOpenTroveWithBatchManagerAndInterest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BaseTest.registerBatchManager(address) (NodeID: 1)
      💬 Args: [B]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseTest.registerBatchManager(address,uint128,uint128,uint128,uint128,uint128) (NodeID: 2)
        💬 Args: [_account, uint128(1e16), uint128(20e16), uint128(5e16), uint128(25e14), MIN_INTEREST_RATE_CHANGE_PERIOD]
        👁️  Def: internal
```
