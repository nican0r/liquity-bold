# Function: testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve()`
- **Visibility**: external
- **Source Range**: 53808:245:338

## Implementation

```solidity
function testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve() external {
    for (uint256 i = 0; i < NUM_COLLATERALS; i++) {
        _testOnlyFlashLoanProviderCanCallLeverDownCallback(leverageZapperCurveArray[i]);
    }
}
```

## Related Implementations

### _testOnlyFlashLoanProviderCanCallLeverDownCallback(contract ILeverageZapper)

- **Kind**: internal
- **Source**: 54310:594:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testOnlyFlashLoanProviderCanCallLeverDownCallback(contract ILeverageZapper)`

```solidity
function _testOnlyFlashLoanProviderCanCallLeverDownCallback(ILeverageZapper _leverageZapper) internal {
    ILeverageZapper.LeverDownTroveParams memory params = ILeverageZapper.LeverDownTroveParams({troveId: addressToTroveIdThroughZapper(address(_leverageZapper), A), flashLoanAmount: 10 ether, minBoldAmount: 10000e18});
    vm.startPrank(A);
    vm.expectRevert("LZ: Caller not FlashLoan provider");
    IFlashLoanReceiver(address(_leverageZapper)).receiveFlashLoanOnLeverDownTrove(params, 10 ether);
    vm.stopPrank();
}
```

### addressToTroveIdThroughZapper(address,address)

- **Kind**: internal
- **Source**: 1156:175:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveIdThroughZapper(address,address)`

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner) public pure returns (uint256) {
    return addressToTroveIdThroughZapper(_zapper, _owner, 0);
}
```

### addressToTroveIdThroughZapper(address,address,uint256)

- **Kind**: internal
- **Source**: 908:242:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveIdThroughZapper(address,address,uint256)`

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    return addressToTroveIdThroughZapper(_zapper, _owner, _owner, _ownerIndex);
}
```

### addressToTroveIdThroughZapper(address,address,address,uint256)

- **Kind**: internal
- **Source**: 578:324:294
- **Link**: `test/Utils/TroveId.sol:TroveId:addressToTroveIdThroughZapper(address,address,address,uint256)`

```solidity
function addressToTroveIdThroughZapper(address _zapper, address _sender, address _owner, uint256 _ownerIndex) public pure returns (uint256) {
    uint256 index = uint256(keccak256(abi.encode(_sender, _ownerIndex)));
    return uint256(keccak256(abi.encode(_zapper, _owner, index)));
}
```

## State Variable Reads

- **NUM_COLLATERALS** (`uint256`)
- **leverageZapperCurveArray** (`contract ILeverageZapper[]`) [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testOnlyFlashLoanProviderCanCallLeverDownCallbackWithCurve() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testOnlyFlashLoanProviderCanCallLeverDownCallback(contract ILeverageZapper) (NodeID: 1)
      💬 Args: [leverageZapperCurveArray[i]]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address) (NodeID: 2)
        💬 Args: [address(_leverageZapper), A]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 3)
          💬 Args: [_zapper, _owner, 0]
          👁️  Def: public
        └─ [4] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 4)
            💬 Args: [_zapper, _owner, _owner, _ownerIndex]
            👁️  Def: public
```
