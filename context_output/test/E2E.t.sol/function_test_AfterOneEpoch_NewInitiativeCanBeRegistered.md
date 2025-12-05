# Function: test_AfterOneEpoch_NewInitiativeCanBeRegistered()

**Contract**: [test/E2E.t.sol/contract_E2ETest.md]

## Metadata

- **Contract**: E2ETest
- **Signature**: `test_AfterOneEpoch_NewInitiativeCanBeRegistered()`
- **Visibility**: external
- **Source Range**: 7070:606:231

## Implementation

```solidity
function test_AfterOneEpoch_NewInitiativeCanBeRegistered() external {
    vm.skip(governance.epoch() > 2);
    address registrant = makeAddr("registrant");
    address newInitiative = makeAddr("newInitiative");
    _openTrove(0, registrant, 0, Math.max(REGISTRATION_FEE, MIN_DEBT));
    uint256 epoch3 = _epoch(3);
    if (block.timestamp < epoch3) vm.warp(epoch3);
    vm.startPrank(registrant);
    {
        boldToken.approve(address(governance), REGISTRATION_FEE);
        governance.registerInitiative(newInitiative);
    }
    vm.stopPrank();
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

### max(uint256,uint256)

- **Kind**: internal
- **Source**: 413:104:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:max(uint256,uint256)`

```solidity
///  @dev Returns the largest of two numbers.
function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? a : b;
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

### _epoch(uint256)

- **Kind**: internal
- **Source**: 6259:121:231
- **Link**: `test/E2E.t.sol:E2ETest:_epoch(uint256)`

```solidity
function _epoch(uint256 n) internal view returns (uint256) {
    return EPOCH_START + ((n - 1) * EPOCH_DURATION);
}
```

## External Calls

- **Vm::skip(bool)**
- **Governance::epoch()**
- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **IBoldToken::approve(address,uint256)**
- **Governance::registerInitiative(address)**
- **Vm::stopPrank()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **providerOf** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: E2ETest.test_AfterOneEpoch_NewInitiativeCanBeRegistered() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["registrant"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
  │   💬 Args: ["newInitiative"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._openTrove(uint256,address,uint256,uint256) (NodeID: 5)
  │   💬 Args: [0, registrant, 0, Math.max(REGISTRATION_FEE, MIN_DEBT)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 9)
  │ │   💬 Args: [REGISTRATION_FEE, MIN_DEBT]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 6)
  │ │   💬 Args: [owner, value]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 7)
  │     💬 Args: [address(branches[i].collToken), owner, collTokenAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 8)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: E2ETest._epoch(uint256) (NodeID: 10)
      💬 Args: [3]
      👁️  Def: internal
```
