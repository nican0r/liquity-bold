# Function: setUp()

**Contract**: [test/RedemptionHelper.t.sol/contract_RedemptionHelperTest.md]

## Metadata

- **Contract**: RedemptionHelperTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1112:2326:245

## Implementation

```solidity
function setUp() override public {
    vm.warp(block.timestamp + 600);
    accounts = new Accounts();
    createAccounts();
    (A, B, C, D, E, F, G) = (accountsList[0], accountsList[1], accountsList[2], accountsList[3], accountsList[4], accountsList[5], accountsList[6]);
    params.push(TestDeployer.TroveManagerParams(1.5 ether, 1.1 ether, 0.1 ether, 1.1 ether, 0.05 ether, 0.1 ether));
    params.push(TestDeployer.TroveManagerParams(1.6 ether, 1.2 ether, 0.1 ether, 1.2 ether, 0.05 ether, 0.2 ether));
    params.push(TestDeployer.TroveManagerParams(1.6 ether, 1.2 ether, 0.1 ether, 1.2 ether, 0.05 ether, 0.2 ether));
    assertEq(NUM_BRANCHES, 3, "Must update params");
    TestDeployer.LiquityContractsDev[] memory tmpBranch;
    TestDeployer deployer = new TestDeployer();
    (tmpBranch, collateralRegistry, boldToken, hintHelpers, , WETH, ) = deployer.deployAndConnectContractsMultiColl(params);
    for (uint256 i = 0; i < tmpBranch.length; ++i) {
        branch.push(tmpBranch[i]);
    }
    branch[0].priceFeed.setPrice(2000e18);
    branch[1].priceFeed.setPrice(3000e18);
    branch[2].priceFeed.setPrice(4000e18);
    assertEq(NUM_BRANCHES, 3, "Must update initial prices");
    for (uint256 i = 0; i < branch.length; ++i) {
        for (uint256 j = 0; j < accountsList.length; ++j) {
            giveAndApproveCollateral(branch[i].collToken, accountsList[j], 10_000 ether, address(branch[i].borrowerOperations));
            vm.prank(accountsList[j]);
            WETH.approve(address(branch[i].borrowerOperations), type(uint256).max);
        }
    }
    IAddressesRegistry[] memory addresses = new IAddressesRegistry[](branch.length);
    for (uint256 i = 0; i < branch.length; ++i) {
        addresses[i] = branch[i].addressesRegistry;
    }
    redemptionHelper = new RedemptionHelper(collateralRegistry, addresses);
}
```

## Related Implementations

### createAccounts()

- **Kind**: internal
- **Source**: 1325:270:248
- **Link**: `test/TestContracts/Accounts.sol:TestAccounts:createAccounts()`

```solidity
function createAccounts() public {
    address[10] memory tempAccounts;
    for (uint256 i = 0; i < accounts.getAccountsCount(); i++) {
        tempAccounts[i] = vm.addr(uint256(accounts.accountsPks(i)));
    }
    accountsList = tempAccounts;
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### giveAndApproveCollateral(contract IERC20,address,uint256,address)

- **Kind**: internal
- **Source**: 359:640:261
- **Link**: `test/TestContracts/DevTestSetup.sol:DevTestSetup:giveAndApproveCollateral(contract IERC20,address,uint256,address)`

```solidity
function giveAndApproveCollateral(IERC20 _token, address _account, uint256 _amount, address _borrowerOperationsAddress) public {
    deal(address(_token), _account, _amount);
    assertEq(_token.balanceOf(_account), _amount);
    vm.startPrank(_account);
    _token.approve(_borrowerOperationsAddress, _amount);
    vm.stopPrank();
    assertEq(_token.allowance(_account, _borrowerOperationsAddress), _amount);
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 27270:117:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual internal {
    deal(token, to, give, false);
}
```

### deal(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 27666:837:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256,bool)`

```solidity
function deal(address token, address to, uint256 give, bool adjust) virtual internal {
    (, bytes memory balData) = token.staticcall(abi.encodeWithSelector(0x70a08231, to));
    uint256 prevBal = abi.decode(balData, (uint256));
    stdstore.target(token).sig(0x70a08231).with_key(to).checked_write(give);
    if (adjust) {
        (, bytes memory totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));
        if (give < prevBal) {
            totSup -= (prevBal - give);
        } else {
            totSup += (give - prevBal);
        }
        stdstore.target(token).sig(0x18160ddd).checked_write(totSup);
    }
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13258:156:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    return stdStorageSafe.target(self, _target);
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 6747:156:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    self._target = _target;
    return self;
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 13420:143:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    return stdStorageSafe.sig(self, _sig);
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 6909:143:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    self._sig = _sig;
    return self;
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13725:152:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    return stdStorageSafe.with_key(self, who);
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 7400:179:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    self._keys.push(bytes32(uint256(uint160(who))));
    return self;
}
```

### checked_write(struct StdStorage,uint256)

- **Kind**: internal
- **Source**: 14946:120:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,uint256)`

```solidity
function checked_write(StdStorage storage self, uint256 amt) internal {
    checked_write(self, bytes32(amt));
}
```

### checked_write(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 15438:1484:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,bytes32)`

```solidity
function checked_write(StdStorage storage self, bytes32 set) internal {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = stdStorageSafe.getCallParams(self);
    if (!self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        find(self, false);
    }
    FindData storage data = self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    if ((data.offsetLeft + data.offsetRight) > 0) {
        uint256 maxVal = 2 ** (256 - (data.offsetLeft + data.offsetRight));
        require(uint256(set) < maxVal, string(abi.encodePacked("stdStorage find(StdStorage): Packed slot. We can't fit value greater than ", vm.toString(maxVal))));
    }
    bytes32 curVal = vm.load(who, bytes32(data.slot));
    bytes32 valToSet = stdStorageSafe.getUpdatedSlotValue(curVal, uint256(set), data.offsetLeft, data.offsetRight);
    vm.store(who, bytes32(data.slot), valToSet);
    (bool success, bytes32 callResult) = stdStorageSafe.callTarget(self);
    if ((!success) || (callResult != set)) {
        vm.store(who, bytes32(data.slot), curVal);
        revert("stdStorage find(StdStorage): Failed to write value.");
    }
    clear(self);
}
```

### getCallParams(struct StdStorage)

- **Kind**: internal
- **Source**: 953:236:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getCallParams(struct StdStorage)`

```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory) {
    if (self._calldata.length == 0) {
        return flatten(self._keys);
    } else {
        return self._calldata;
    }
}
```

### flatten(bytes32[])

- **Kind**: internal
- **Source**: 11186:393:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:flatten(bytes32[])`

```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory) {
    bytes memory result = new bytes(b.length * 32);
    for (uint256 i = 0; i < b.length; i++) {
        bytes32 k = b[i];
        /// @solidity memory-safe-assembly
        assembly {
            mstore(add(result, add(32, mul(32, i))), k)
        }
    }
    return result;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 13111:141:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:find(struct StdStorage,bool)`

```solidity
function find(StdStorage storage self, bool _clear) internal returns (uint256) {
    return stdStorageSafe.find(self, _clear).slot;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 4249:2492:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:find(struct StdStorage,bool)`

```solidity
/// @notice find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against
function find(StdStorage storage self, bool _clear) internal returns (FindData storage) {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = getCallParams(self);
    if (self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        if (_clear) {
            clear(self);
        }
        return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    }
    vm.record();
    (, bytes32 callResult) = callTarget(self);
    (bytes32[] memory reads, ) = vm.accesses(address(who));
    if (reads.length == 0) {
        revert("stdStorage find(StdStorage): No storage use detected for target.");
    } else {
        for (uint256 i = reads.length; (--i) >= 0; ) {
            bytes32 prev = vm.load(who, reads[i]);
            if (prev == bytes32(0)) {
                emit WARNING_UninitedSlot(who, uint256(reads[i]));
            }
            if (!checkSlotMutatesCall(self, reads[i])) {
                continue;
            }
            (uint256 offsetLeft, uint256 offsetRight) = (0, 0);
            if (self._enable_packed_slots) {
                bool found;
                (found, offsetLeft, offsetRight) = findOffsets(self, reads[i]);
                if (!found) {
                    continue;
                }
            }
            uint256 curVal = (uint256(prev) & getMaskByOffsets(offsetLeft, offsetRight)) >> offsetRight;
            if (uint256(callResult) != curVal) {
                continue;
            }
            emit SlotFound(who, fsig, keccak256(abi.encodePacked(params, field_depth)), uint256(reads[i]));
            self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))] = FindData(uint256(reads[i]), offsetLeft, offsetRight, true);
            break;
        }
    }
    require(self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found, "stdStorage find(StdStorage): Slot(s) not found.");
    if (_clear) {
        clear(self);
    }
    return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 11585:239:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    delete self._target;
    delete self._sig;
    delete self._keys;
    delete self._depth;
    delete self._enable_packed_slots;
    delete self._calldata;
}
```

### callTarget(struct StdStorage)

- **Kind**: internal
- **Source**: 1251:343:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:callTarget(struct StdStorage)`

```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32) {
    bytes memory cald = abi.encodePacked(self._sig, getCallParams(self));
    (bool success, bytes memory rdat) = self._target.staticcall(cald);
    bytes32 result = bytesToBytes32(rdat, 32 * self._depth);
    return (success, result);
}
```

### bytesToBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 10876:304:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:bytesToBytes32(bytes,uint256)`

```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32) {
    bytes32 out;
    uint256 max = (b.length > 32) ? 32 : b.length;
    for (uint256 i = 0; i < max; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
}
```

### checkSlotMutatesCall(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 1851:546:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:checkSlotMutatesCall(struct StdStorage,bytes32)`

```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool success, bytes32 prevReturnValue) = callTarget(self);
    bytes32 testVal = (prevReturnValue == bytes32(0)) ? bytes32(UINT256_MAX) : bytes32(0);
    vm.store(self._target, slot, testVal);
    (, bytes32 newReturnValue) = callTarget(self);
    vm.store(self._target, slot, prevSlotValue);
    return (success && (prevReturnValue != newReturnValue));
}
```

### findOffsets(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 3080:534:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffsets(struct StdStorage,bytes32)`

```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool foundLeft, uint256 offsetLeft) = findOffset(self, slot, true);
    (bool foundRight, uint256 offsetRight) = findOffset(self, slot, false);
    vm.store(self._target, slot, prevSlotValue);
    return (foundLeft && foundRight, offsetLeft, offsetRight);
}
```

### findOffset(struct StdStorage,bytes32,bool)

- **Kind**: internal
- **Source**: 2560:514:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffset(struct StdStorage,bytes32,bool)`

```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256) {
    for (uint256 offset = 0; offset < 256; offset++) {
        uint256 valueToPut = left ? (1 << (255 - offset)) : (1 << offset);
        vm.store(self._target, slot, bytes32(valueToPut));
        (bool success, bytes32 data) = callTarget(self);
        if (success && (uint256(data) > 0)) {
            return (true, offset);
        }
    }
    return (false, 0);
}
```

### getMaskByOffsets(uint256,uint256)

- **Kind**: internal
- **Source**: 12017:376:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getMaskByOffsets(uint256,uint256)`

```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask) {
    assembly {
        mask := shl(offsetRight, sub(shl(sub(256, add(offsetRight, offsetLeft)), 1), 1))
    }
}
```

### getUpdatedSlotValue(bytes32,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12455:300:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getUpdatedSlotValue(bytes32,uint256,uint256,uint256)`

```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight) internal pure returns (bytes32 newValue) {
    return bytes32((uint256(curValue) & (~getMaskByOffsets(offsetLeft, offsetRight))) | (varValue << offsetRight));
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 14704:92:55
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    stdStorageSafe.clear(self);
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **Vm::warp(uint256)**
- **TestDeployer::deployAndConnectContractsMultiColl(struct TestDeployer.TroveManagerParams[])**
- **IPriceFeedTestnet::setPrice(uint256)**
- **Vm::prank(address)**
- **IWETH::approve(address,uint256)**

## State Variable Reads

- **params** (`struct TestDeployer.TroveManagerParams[]`)
- **branch** (`struct TestDeployer.LiquityContractsDev[]`)
- **accounts** (`contract Accounts`) [test/TestContracts/Accounts.sol/contract_Accounts.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)

## State Variable Writes

- **params** (`struct TestDeployer.TroveManagerParams[]`)
- **branch** (`struct TestDeployer.LiquityContractsDev[]`)
- **redemptionHelper** (`contract IRedemptionHelper`) [src/Interfaces/IRedemptionHelper.sol/interface_IRedemptionHelper.md]
- **accountsList** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RedemptionHelperTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TestAccounts.createAccounts() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [NUM_BRANCHES, 3, "Must update params"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [NUM_BRANCHES, 3, "Must update initial prices"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: DevTestSetup.giveAndApproveCollateral(contract IERC20,address,uint256,address) (NodeID: 4)
      💬 Args: [branch[i].collToken, accountsList[j], 10_000 ether, address(branch[i].borrowerOperations)]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 5)
    │   💬 Args: [address(_token), _account, _amount]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 6)
    │     💬 Args: [token, to, give, false]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 7)
    │   │   💬 Args: [stdstore, token]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 8)
    │   │     💬 Args: [self, _target]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 9)
    │   │   💬 Args: [stdstore.target(token), 0x70a08231]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 10)
    │   │     💬 Args: [self, _sig]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 11)
    │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 12)
    │   │     💬 Args: [self, who]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 13)
    │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 14)
    │   │     💬 Args: [self, bytes32(amt)]
    │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 15)
    │   │   │   💬 Args: [self]
    │   │   │   👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 16)
    │   │   │     💬 Args: [self._keys]
    │   │   │     👁️  Def: private
    │   │   ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 17)
    │   │   │   💬 Args: [self, false]
    │   │   │   👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 18)
    │   │   │     💬 Args: [self, _clear]
    │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 19)
    │   │   │   │   💬 Args: [self]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 20)
    │   │   │   │     💬 Args: [self._keys]
    │   │   │   │     👁️  Def: private
    │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 21)
    │   │   │   │   💬 Args: [self]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 22)
    │   │   │   │   💬 Args: [self]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 23)
    │   │   │   │ │   💬 Args: [self]
    │   │   │   │ │   👁️  Def: internal
    │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 24)
    │   │   │   │ │     💬 Args: [self._keys]
    │   │   │   │ │     👁️  Def: private
    │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 25)
    │   │   │   │     💬 Args: [rdat, 32 * self._depth]
    │   │   │   │     👁️  Def: private
    │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 26)
    │   │   │   │   💬 Args: [self, reads[i]]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 27)
    │   │   │   │ │   💬 Args: [self]
    │   │   │   │ │   👁️  Def: internal
    │   │   │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 28)
    │   │   │   │ │ │   💬 Args: [self]
    │   │   │   │ │ │   👁️  Def: internal
    │   │   │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 29)
    │   │   │   │ │ │     💬 Args: [self._keys]
    │   │   │   │ │ │     👁️  Def: private
    │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 30)
    │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
    │   │   │   │ │     👁️  Def: private
    │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 31)
    │   │   │   │     💬 Args: [self]
    │   │   │   │     👁️  Def: internal
    │   │   │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 32)
    │   │   │   │   │   💬 Args: [self]
    │   │   │   │   │   👁️  Def: internal
    │   │   │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 33)
    │   │   │   │   │     💬 Args: [self._keys]
    │   │   │   │   │     👁️  Def: private
    │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 34)
    │   │   │   │       💬 Args: [rdat, 32 * self._depth]
    │   │   │   │       👁️  Def: private
    │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 35)
    │   │   │   │   💬 Args: [self, reads[i]]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 36)
    │   │   │   │ │   💬 Args: [self, slot, true]
    │   │   │   │ │   👁️  Def: internal
    │   │   │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 37)
    │   │   │   │ │     💬 Args: [self]
    │   │   │   │ │     👁️  Def: internal
    │   │   │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 38)
    │   │   │   │ │   │   💬 Args: [self]
    │   │   │   │ │   │   👁️  Def: internal
    │   │   │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 39)
    │   │   │   │ │   │     💬 Args: [self._keys]
    │   │   │   │ │   │     👁️  Def: private
    │   │   │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 40)
    │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
    │   │   │   │ │       👁️  Def: private
    │   │   │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 41)
    │   │   │   │     💬 Args: [self, slot, false]
    │   │   │   │     👁️  Def: internal
    │   │   │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 42)
    │   │   │   │       💬 Args: [self]
    │   │   │   │       👁️  Def: internal
    │   │   │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 43)
    │   │   │   │     │   💬 Args: [self]
    │   │   │   │     │   👁️  Def: internal
    │   │   │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 44)
    │   │   │   │     │     💬 Args: [self._keys]
    │   │   │   │     │     👁️  Def: private
    │   │   │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 45)
    │   │   │   │         💬 Args: [rdat, 32 * self._depth]
    │   │   │   │         👁️  Def: private
    │   │   │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 46)
    │   │   │   │   💬 Args: [offsetLeft, offsetRight]
    │   │   │   │   👁️  Def: internal
    │   │   │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 47)
    │   │   │       💬 Args: [self]
    │   │   │       👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 48)
    │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
    │   │   │   👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 49)
    │   │   │     💬 Args: [offsetLeft, offsetRight]
    │   │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 50)
    │   │   │   💬 Args: [self]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 51)
    │   │   │ │   💬 Args: [self]
    │   │   │ │   👁️  Def: internal
    │   │   │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 52)
    │   │   │ │     💬 Args: [self._keys]
    │   │   │ │     👁️  Def: private
    │   │   │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 53)
    │   │   │     💬 Args: [rdat, 32 * self._depth]
    │   │   │     👁️  Def: private
    │   │   └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 54)
    │   │       💬 Args: [self]
    │   │       👁️  Def: internal
    │   │     └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 55)
    │   │         💬 Args: [self]
    │   │         👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 56)
    │   │   💬 Args: [stdstore, token]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 57)
    │   │     💬 Args: [self, _target]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 58)
    │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 59)
    │   │     💬 Args: [self, _sig]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 60)
    │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 61)
    │         💬 Args: [self, bytes32(amt)]
    │         👁️  Def: internal
    │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 62)
    │       │   💬 Args: [self]
    │       │   👁️  Def: internal
    │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 63)
    │       │     💬 Args: [self._keys]
    │       │     👁️  Def: private
    │       ├─ [6] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 64)
    │       │   💬 Args: [self, false]
    │       │   👁️  Def: internal
    │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 65)
    │       │     💬 Args: [self, _clear]
    │       │     👁️  Def: internal
    │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 66)
    │       │   │   💬 Args: [self]
    │       │   │   👁️  Def: internal
    │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 67)
    │       │   │     💬 Args: [self._keys]
    │       │   │     👁️  Def: private
    │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 68)
    │       │   │   💬 Args: [self]
    │       │   │   👁️  Def: internal
    │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 69)
    │       │   │   💬 Args: [self]
    │       │   │   👁️  Def: internal
    │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 70)
    │       │   │ │   💬 Args: [self]
    │       │   │ │   👁️  Def: internal
    │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 71)
    │       │   │ │     💬 Args: [self._keys]
    │       │   │ │     👁️  Def: private
    │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 72)
    │       │   │     💬 Args: [rdat, 32 * self._depth]
    │       │   │     👁️  Def: private
    │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 73)
    │       │   │   💬 Args: [self, reads[i]]
    │       │   │   👁️  Def: internal
    │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 74)
    │       │   │ │   💬 Args: [self]
    │       │   │ │   👁️  Def: internal
    │       │   │ │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 75)
    │       │   │ │ │   💬 Args: [self]
    │       │   │ │ │   👁️  Def: internal
    │       │   │ │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 76)
    │       │   │ │ │     💬 Args: [self._keys]
    │       │   │ │ │     👁️  Def: private
    │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 77)
    │       │   │ │     💬 Args: [rdat, 32 * self._depth]
    │       │   │ │     👁️  Def: private
    │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 78)
    │       │   │     💬 Args: [self]
    │       │   │     👁️  Def: internal
    │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 79)
    │       │   │   │   💬 Args: [self]
    │       │   │   │   👁️  Def: internal
    │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 80)
    │       │   │   │     💬 Args: [self._keys]
    │       │   │   │     👁️  Def: private
    │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 81)
    │       │   │       💬 Args: [rdat, 32 * self._depth]
    │       │   │       👁️  Def: private
    │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 82)
    │       │   │   💬 Args: [self, reads[i]]
    │       │   │   👁️  Def: internal
    │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 83)
    │       │   │ │   💬 Args: [self, slot, true]
    │       │   │ │   👁️  Def: internal
    │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 84)
    │       │   │ │     💬 Args: [self]
    │       │   │ │     👁️  Def: internal
    │       │   │ │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 85)
    │       │   │ │   │   💬 Args: [self]
    │       │   │ │   │   👁️  Def: internal
    │       │   │ │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 86)
    │       │   │ │   │     💬 Args: [self._keys]
    │       │   │ │   │     👁️  Def: private
    │       │   │ │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 87)
    │       │   │ │       💬 Args: [rdat, 32 * self._depth]
    │       │   │ │       👁️  Def: private
    │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 88)
    │       │   │     💬 Args: [self, slot, false]
    │       │   │     👁️  Def: internal
    │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 89)
    │       │   │       💬 Args: [self]
    │       │   │       👁️  Def: internal
    │       │   │     ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 90)
    │       │   │     │   💬 Args: [self]
    │       │   │     │   👁️  Def: internal
    │       │   │     │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 91)
    │       │   │     │     💬 Args: [self._keys]
    │       │   │     │     👁️  Def: private
    │       │   │     └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 92)
    │       │   │         💬 Args: [rdat, 32 * self._depth]
    │       │   │         👁️  Def: private
    │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 93)
    │       │   │   💬 Args: [offsetLeft, offsetRight]
    │       │   │   👁️  Def: internal
    │       │   └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 94)
    │       │       💬 Args: [self]
    │       │       👁️  Def: internal
    │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 95)
    │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
    │       │   👁️  Def: internal
    │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 96)
    │       │     💬 Args: [offsetLeft, offsetRight]
    │       │     👁️  Def: internal
    │       ├─ [6] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 97)
    │       │   💬 Args: [self]
    │       │   👁️  Def: internal
    │       │ ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 98)
    │       │ │   💬 Args: [self]
    │       │ │   👁️  Def: internal
    │       │ │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 99)
    │       │ │     💬 Args: [self._keys]
    │       │ │     👁️  Def: private
    │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 100)
    │       │     💬 Args: [rdat, 32 * self._depth]
    │       │     👁️  Def: private
    │       └─ [6] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 101)
    │           💬 Args: [self]
    │           👁️  Def: internal
    │         └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 102)
    │             💬 Args: [self]
    │             👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 103)
    │   💬 Args: [_token.balanceOf(_account), _amount]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 104)
        💬 Args: [_token.allowance(_account, _borrowerOperationsAddress), _amount]
        👁️  Def: internal
```
