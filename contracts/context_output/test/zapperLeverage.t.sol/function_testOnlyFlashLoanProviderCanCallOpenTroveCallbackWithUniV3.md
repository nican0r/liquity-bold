# Function: testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3()`
- **Visibility**: external
- **Source Range**: 21435:245:338

## Implementation

```solidity
function testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3() external {
    for (uint256 i = 0; i < NUM_COLLATERALS; i++) {
        _testOnlyFlashLoanProviderCanCallOpenTroveCallback(leverageZapperUniV3Array[i]);
    }
}
```

## Related Implementations

### _testOnlyFlashLoanProviderCanCallOpenTroveCallback(contract ILeverageZapper)

- **Kind**: internal
- **Source**: 21686:1035:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testOnlyFlashLoanProviderCanCallOpenTroveCallback(contract ILeverageZapper)`

```solidity
function _testOnlyFlashLoanProviderCanCallOpenTroveCallback(ILeverageZapper _leverageZapper) internal {
    ILeverageZapper.OpenLeveragedTroveParams memory params = ILeverageZapper.OpenLeveragedTroveParams({owner: A, ownerIndex: 0, collAmount: 10 ether, flashLoanAmount: 10 ether, boldAmount: 10000e18, upperHint: 0, lowerHint: 0, annualInterestRate: 5e16, batchManager: address(0), maxUpfrontFee: 1000e18, addManager: address(0), removeManager: address(0), receiver: address(0)});
    vm.startPrank(A);
    vm.expectRevert("LZ: Caller not FlashLoan provider");
    IFlashLoanReceiver(address(_leverageZapper)).receiveFlashLoanOnOpenLeveragedTrove(params, 10 ether);
    vm.stopPrank();
    assertEq(address(_leverageZapper.flashLoanProvider().receiver()), address(0), "Receiver should be zero");
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## State Variable Reads

- **NUM_COLLATERALS** (`uint256`)
- **leverageZapperUniV3Array** (`contract ILeverageZapper[]`) [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testOnlyFlashLoanProviderCanCallOpenTroveCallbackWithUniV3() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testOnlyFlashLoanProviderCanCallOpenTroveCallback(contract ILeverageZapper) (NodeID: 1)
      💬 Args: [leverageZapperUniV3Array[i]]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
        💬 Args: [address(_leverageZapper.flashLoanProvider().receiver()), address(0), "Receiver should be zero"]
        👁️  Def: internal
```
