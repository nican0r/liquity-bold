# Function: testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper()

**Contract**: [test/zapperLeverage.t.sol/contract_ZapperLeverageMainnet.md]

## Metadata

- **Contract**: ZapperLeverageMainnet
- **Signature**: `testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper()`
- **Visibility**: external
- **Source Range**: 73388:246:338

## Implementation

```solidity
function testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper() external {
    for (uint256 i = 0; i < NUM_COLLATERALS; i++) {
        _testOnlyFlashLoanProviderCanCallCloseTroveCallback(baseZapperArray[i], i);
    }
}
```

## Related Implementations

### _testOnlyFlashLoanProviderCanCallCloseTroveCallback(contract IZapper,uint256)

- **Kind**: internal
- **Source**: 74396:750:338
- **Link**: `test/zapperLeverage.t.sol:ZapperLeverageMainnet:_testOnlyFlashLoanProviderCanCallCloseTroveCallback(contract IZapper,uint256)`

```solidity
function _testOnlyFlashLoanProviderCanCallCloseTroveCallback(IZapper _zapper, uint256 _branch) internal {
    IZapper.CloseTroveParams memory params = IZapper.CloseTroveParams({troveId: addressToTroveIdThroughZapper(address(_zapper), A), flashLoanAmount: 10 ether, minExpectedCollateral: 0, receiver: address(0)});
    bool lst = _branch > 0;
    string memory revertReason = lst ? "GCZ: Caller not FlashLoan provider" : "WZ: Caller not FlashLoan provider";
    vm.startPrank(A);
    vm.expectRevert(bytes(revertReason));
    IFlashLoanReceiver(address(_zapper)).receiveFlashLoanOnCloseTroveFromCollateral(params, 10 ether);
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
- **baseZapperArray** (`contract IZapper[]`) [src/Zappers/Interfaces/IZapper.sol/interface_IZapper.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperLeverageMainnet.testOnlyFlashLoanProviderCanCallCloseTroveCallbackWithBaseZapper() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ZapperLeverageMainnet._testOnlyFlashLoanProviderCanCallCloseTroveCallback(contract IZapper,uint256) (NodeID: 1)
      💬 Args: [baseZapperArray[i], i]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address) (NodeID: 2)
        💬 Args: [address(_zapper), A]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 3)
          💬 Args: [_zapper, _owner, 0]
          👁️  Def: public
        └─ [4] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 4)
            💬 Args: [_zapper, _owner, _owner, _ownerIndex]
            👁️  Def: public
```
