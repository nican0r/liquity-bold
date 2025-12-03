# Function: test_Borrowing_InExistingDeployment()

**Contract**: [test/E2E.t.sol/contract_E2ETest.md]

## Metadata

- **Contract**: E2ETest
- **Signature**: `test_Borrowing_InExistingDeployment()`
- **Visibility**: external
- **Source Range**: 15995:1092:231

## Implementation

```solidity
function test_Borrowing_InExistingDeployment() external {
    for (uint256 i = 0; i < branches.length; ++i) {
        vm.skip(branches[i].troveManager.getTroveIdsCount() == 0);
    }
    address borrower = makeAddr("borrower");
    for (uint256 i = 0; i < branches.length; ++i) {
        _openTrove(i, borrower, 0, 10_000 ether);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        _closeTroveFromCollateral(i, borrower, 0, false);
    }
    address leverageSeeker = makeAddr("leverageSeeker");
    for (uint256 i = 0; i < branches.length; ++i) {
        _openLeveragedTrove(i, leverageSeeker, 0, 10_000 ether);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        _leverUpTrove(i, leverageSeeker, 0, 1_000 ether);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        _leverDownTrove(i, leverageSeeker, 0, 1_000 ether);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        _closeTroveFromCollateral(i, leverageSeeker, 0, true);
    }
}
```

## Related Implementations

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

### _openTrove(uint256,address,uint256,uint256)

- **Kind**: internal
- **Source**: 6518:1004:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_openTrove(uint256,address,uint256,uint256)`

```solidity
function _openTrove(uint256 i, address owner, uint256 ownerIndex, uint256 boldAmount) internal returns (uint256) {
    IZapper.OpenTroveParams memory p;
    p.owner = owner;
    p.ownerIndex = ownerIndex;
    p.boldAmount = boldAmount;
    p.collAmount = (boldAmount * 2 ether) / branches[i].priceFeed.getPrice();
    p.annualInterestRate = 0.05 ether;
    p.maxUpfrontFee = hintHelpers.predictOpenTroveUpfrontFee(i, boldAmount, p.annualInterestRate);
    (uint256 collTokenAmount, uint256 value) = (branches[i].collToken == weth) ? (0, p.collAmount + ETH_GAS_COMPENSATION) : (p.collAmount, ETH_GAS_COMPENSATION);
    deal(owner, value);
    deal(address(branches[i].collToken), owner, collTokenAmount);
    vm.startPrank(owner);
    branches[i].collToken.approve(address(branches[i].zapper), collTokenAmount);
    branches[i].zapper.openTroveWithRawETH{value: value}(p);
    vm.stopPrank();
    return boldAmount;
}
```

### deal(address,uint256)

- **Kind**: internal
- **Source**: 5544:305:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:deal(address,uint256)`

```solidity
function deal(address to, uint256 give) virtual override internal {
    if (to.balance < give) {
        vm.prank(ETH_WHALE);
        payable(to).transfer(give - to.balance);
    } else {
        vm.prank(to);
        payable(ETH_WHALE).transfer(to.balance - give);
    }
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 5855:526:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual override internal {
    uint256 balance = IERC20(token).balanceOf(to);
    address provider = providerOf[token];
    assertNotEq(provider, address(0), string.concat("No provider for ", IERC20(token).symbol()));
    if (balance < give) {
        vm.prank(provider);
        IERC20(token).transfer(to, give - balance);
    } else {
        vm.prank(to);
        IERC20(token).transfer(provider, balance - give);
    }
}
```

### assertNotEq(address,address,string)

- **Kind**: internal
- **Source**: 8568:140:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertNotEq(address,address,string)`

```solidity
function assertNotEq(address left, address right, string memory err) virtual internal pure {
    vm.assertNotEq(left, right, err);
}
```

### _closeTroveFromCollateral(uint256,address,uint256,bool)

- **Kind**: internal
- **Source**: 7528:961:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_closeTroveFromCollateral(uint256,address,uint256,bool)`

```solidity
function _closeTroveFromCollateral(uint256 i, address owner, uint256 ownerIndex, bool _leveraged) internal returns (uint256) {
    IZapper zapper;
    if (_leveraged) {
        zapper = branches[i].leverageZapper;
    } else {
        zapper = branches[i].zapper;
    }
    uint256 troveId = addressToTroveIdThroughZapper(address(zapper), owner, ownerIndex);
    uint256 debt = branches[i].troveManager.getLatestTroveData(troveId).entireDebt;
    uint256 coll = branches[i].troveManager.getLatestTroveData(troveId).entireColl;
    uint256 flashLoanAmount = (debt * (1 ether + PRICE_TOLERANCE)) / branches[i].priceFeed.getPrice();
    vm.startPrank(owner);
    zapper.closeTroveFromCollateral({_troveId: troveId, _flashLoanAmount: flashLoanAmount, _minExpectedCollateral: coll - flashLoanAmount});
    vm.stopPrank();
    return debt;
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

### _openLeveragedTrove(uint256,address,uint256,uint256)

- **Kind**: internal
- **Source**: 8495:1186:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_openLeveragedTrove(uint256,address,uint256,uint256)`

```solidity
function _openLeveragedTrove(uint256 i, address owner, uint256 ownerIndex, uint256 boldAmount) internal returns (uint256) {
    uint256 price = branches[i].priceFeed.getPrice();
    ILeverageZapper.OpenLeveragedTroveParams memory p;
    p.owner = owner;
    p.ownerIndex = ownerIndex;
    p.boldAmount = boldAmount;
    p.collAmount = (boldAmount * 0.5 ether) / price;
    p.flashLoanAmount = (boldAmount * (1 ether - PRICE_TOLERANCE)) / price;
    p.annualInterestRate = 0.1 ether;
    p.maxUpfrontFee = hintHelpers.predictOpenTroveUpfrontFee(i, boldAmount, p.annualInterestRate);
    (uint256 collTokenAmount, uint256 value) = (branches[i].collToken == weth) ? (0, p.collAmount + ETH_GAS_COMPENSATION) : (p.collAmount, ETH_GAS_COMPENSATION);
    deal(owner, value);
    deal(address(branches[i].collToken), owner, collTokenAmount);
    vm.startPrank(owner);
    branches[i].collToken.approve(address(branches[i].leverageZapper), collTokenAmount);
    branches[i].leverageZapper.openLeveragedTroveWithRawETH{value: value}(p);
    vm.stopPrank();
    return boldAmount;
}
```

### _leverUpTrove(uint256,address,uint256,uint256)

- **Kind**: internal
- **Source**: 9687:730:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_leverUpTrove(uint256,address,uint256,uint256)`

```solidity
function _leverUpTrove(uint256 i, address owner, uint256 ownerIndex, uint256 boldAmount) internal returns (uint256) {
    uint256 troveId = addressToTroveIdThroughZapper(address(branches[i].leverageZapper), owner, ownerIndex);
    ILeverageZapper.LeverUpTroveParams memory p = ILeverageZapper.LeverUpTroveParams({troveId: troveId, boldAmount: boldAmount, flashLoanAmount: (boldAmount * (1 ether - PRICE_TOLERANCE)) / branches[i].priceFeed.getPrice(), maxUpfrontFee: hintHelpers.predictAdjustTroveUpfrontFee(i, troveId, boldAmount)});
    vm.prank(owner);
    branches[i].leverageZapper.leverUpTrove(p);
    return boldAmount;
}
```

### _leverDownTrove(uint256,address,uint256,uint256)

- **Kind**: internal
- **Source**: 10423:808:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_leverDownTrove(uint256,address,uint256,uint256)`

```solidity
function _leverDownTrove(uint256 i, address owner, uint256 ownerIndex, uint256 boldAmount) internal returns (uint256) {
    uint256 troveId = addressToTroveIdThroughZapper(address(branches[i].leverageZapper), owner, ownerIndex);
    uint256 debtBefore = branches[i].troveManager.getLatestTroveData(troveId).entireDebt;
    ILeverageZapper.LeverDownTroveParams memory p = ILeverageZapper.LeverDownTroveParams({troveId: troveId, minBoldAmount: boldAmount, flashLoanAmount: (boldAmount * (1 ether + PRICE_TOLERANCE)) / branches[i].priceFeed.getPrice()});
    vm.prank(owner);
    branches[i].leverageZapper.leverDownTrove(p);
    return debtBefore - branches[i].troveManager.getLatestTroveData(troveId).entireDebt;
}
```

## External Calls

- **Vm::skip(bool)**
- **ITroveManager::getTroveIdsCount()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **providerOf** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: E2ETest.test_Borrowing_InExistingDeployment() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["borrower"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._openTrove(uint256,address,uint256,uint256) (NodeID: 3)
  │   💬 Args: [i, borrower, 0, 10_000 ether]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 4)
  │ │   💬 Args: [owner, value]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 5)
  │     💬 Args: [address(branches[i].collToken), owner, collTokenAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 6)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._closeTroveFromCollateral(uint256,address,uint256,bool) (NodeID: 7)
  │   💬 Args: [i, borrower, 0, false]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 8)
  │     💬 Args: [address(zapper), owner, ownerIndex]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 9)
  │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 10)
  │   💬 Args: ["leverageSeeker"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 11)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._openLeveragedTrove(uint256,address,uint256,uint256) (NodeID: 12)
  │   💬 Args: [i, leverageSeeker, 0, 10_000 ether]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 13)
  │ │   💬 Args: [owner, value]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 14)
  │     💬 Args: [address(branches[i].collToken), owner, collTokenAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 15)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._leverUpTrove(uint256,address,uint256,uint256) (NodeID: 16)
  │   💬 Args: [i, leverageSeeker, 0, 1_000 ether]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 17)
  │     💬 Args: [address(branches[i].leverageZapper), owner, ownerIndex]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 18)
  │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._leverDownTrove(uint256,address,uint256,uint256) (NodeID: 19)
  │   💬 Args: [i, leverageSeeker, 0, 1_000 ether]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 20)
  │     💬 Args: [address(branches[i].leverageZapper), owner, ownerIndex]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 21)
  │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
  │       👁️  Def: public
  └─ [1] ⚙️ FUNCTION: E2EHelpers._closeTroveFromCollateral(uint256,address,uint256,bool) (NodeID: 22)
      💬 Args: [i, leverageSeeker, 0, true]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 23)
        💬 Args: [address(zapper), owner, ownerIndex]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 24)
          💬 Args: [_zapper, _owner, _owner, _ownerIndex]
          👁️  Def: public
```
