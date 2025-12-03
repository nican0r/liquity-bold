# Function: testInitiativeRegistrationAndClaim()

**Contract**: [test/InitiativeSmarDEX.t.sol/contract_InitiativeSmarDEX.md]

## Metadata

- **Contract**: InitiativeSmarDEX
- **Signature**: `testInitiativeRegistrationAndClaim()`
- **Visibility**: external
- **Source Range**: 724:2588:234

## Implementation

```solidity
function testInitiativeRegistrationAndClaim() external {
    address borrower = makeAddr("borrower");
    address registrant = GOVERNANCE_WHALE;
    uint256 donationAmount = 10_000 ether;
    _openTrove(0, borrower, 0, Math.max(REGISTRATION_FEE, MIN_DEBT) + donationAmount);
    vm.startPrank(borrower);
    boldToken.transfer(registrant, REGISTRATION_FEE);
    vm.stopPrank();
    address staker = makeAddr("staker");
    uint256 lqtyStake = 3_000_000 ether;
    _depositLQTY(staker, lqtyStake);
    skip(30 days);
    assertEq(governance.registeredInitiatives(INITIATIVE_ADDRESS), 0, "Initiative should not be registered");
    vm.startPrank(registrant);
    boldToken.approve(address(governance), REGISTRATION_FEE);
    governance.registerInitiative(INITIATIVE_ADDRESS);
    vm.stopPrank();
    assertGt(governance.registeredInitiatives(INITIATIVE_ADDRESS), 0, "Initiative should be registered");
    skip(7 days);
    _allocateLQTY_begin(staker);
    _allocateLQTY_vote(INITIATIVE_ADDRESS, int256(lqtyStake));
    _allocateLQTY_end();
    vm.startPrank(borrower);
    boldToken.transfer(address(governance), donationAmount);
    vm.stopPrank();
    skip(7 days);
    governance.claimForInitiative(INITIATIVE_ADDRESS);
    assertGt(boldToken.balanceOf(INITIATIVE_ADDRESS), 0, "Initiative should have received incentives");
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

### _depositLQTY(address,uint256)

- **Kind**: internal
- **Source**: 11631:271:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_depositLQTY(address,uint256)`

```solidity
function _depositLQTY(address voter, uint256 amount) internal {
    deal(LQTY, voter, amount);
    vm.startPrank(voter);
    lqty.approve(governance.deriveUserProxyAddress(voter), amount);
    governance.depositLQTY(amount);
    vm.stopPrank();
}
```

### skip(uint256)

- **Kind**: internal
- **Source**: 24925:100:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:skip(uint256)`

```solidity
function skip(uint256 time) virtual internal {
    vm.warp(vm.getBlockTimestamp() + time);
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### _allocateLQTY_begin(address)

- **Kind**: internal
- **Source**: 11908:90:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_allocateLQTY_begin(address)`

```solidity
function _allocateLQTY_begin(address voter) internal {
    vm.startPrank(voter);
}
```

### _allocateLQTY_vote(address,int256)

- **Kind**: internal
- **Source**: 12134:217:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_allocateLQTY_vote(address,int256)`

```solidity
function _allocateLQTY_vote(address initiative, int256 lqtyAmount) internal {
    _allocateLQTY_initiatives.push(initiative);
    _allocateLQTY_votes.push(lqtyAmount);
    _allocateLQTY_vetos.push();
}
```

### _allocateLQTY_end()

- **Kind**: internal
- **Source**: 12580:392:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_allocateLQTY_end()`

```solidity
function _allocateLQTY_end() internal {
    governance.allocateLQTY(_allocateLQTY_initiativesToReset, _allocateLQTY_initiatives, _allocateLQTY_votes, _allocateLQTY_vetos);
    delete _allocateLQTY_initiativesToReset;
    delete _allocateLQTY_initiatives;
    delete _allocateLQTY_votes;
    delete _allocateLQTY_vetos;
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **IBoldToken::transfer(address,uint256)**
- **Vm::stopPrank()**
- **Governance::registeredInitiatives(address)**
- **IBoldToken::approve(address,uint256)**
- **Governance::registerInitiative(address)**
- **Governance::claimForInitiative(address)**
- **IBoldToken::balanceOf(address)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **providerOf** (`mapping(address => address)`)
- **_allocateLQTY_initiativesToReset** (`address[]`)
- **_allocateLQTY_initiatives** (`address[]`)
- **_allocateLQTY_votes** (`int256[]`)
- **_allocateLQTY_vetos** (`int256[]`)

## State Variable Writes

- **_allocateLQTY_initiatives** (`address[]`)
- **_allocateLQTY_votes** (`int256[]`)
- **_allocateLQTY_vetos** (`int256[]`)
- **_allocateLQTY_initiativesToReset** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InitiativeSmarDEX.testInitiativeRegistrationAndClaim() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["borrower"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._openTrove(uint256,address,uint256,uint256) (NodeID: 3)
  │   💬 Args: [0, borrower, 0, Math.max(REGISTRATION_FEE, MIN_DEBT) + donationAmount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [REGISTRATION_FEE, MIN_DEBT]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 4)
  │ │   💬 Args: [owner, value]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 5)
  │     💬 Args: [address(branches[i].collToken), owner, collTokenAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 6)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 8)
  │   💬 Args: ["staker"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 9)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._depositLQTY(address,uint256) (NodeID: 10)
  │   💬 Args: [staker, lqtyStake]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 11)
  │     💬 Args: [LQTY, voter, amount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 12)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 13)
  │   💬 Args: [30 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 14)
  │   💬 Args: [governance.registeredInitiatives(INITIATIVE_ADDRESS), 0, "Initiative should not be registered"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 15)
  │   💬 Args: [governance.registeredInitiatives(INITIATIVE_ADDRESS), 0, "Initiative should be registered"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 16)
  │   💬 Args: [7 days]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._allocateLQTY_begin(address) (NodeID: 17)
  │   💬 Args: [staker]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._allocateLQTY_vote(address,int256) (NodeID: 18)
  │   💬 Args: [INITIATIVE_ADDRESS, int256(lqtyStake)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._allocateLQTY_end() (NodeID: 19)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 20)
  │   💬 Args: [7 days]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 21)
      💬 Args: [boldToken.balanceOf(INITIATIVE_ADDRESS), 0, "Initiative should have received incentives"]
      👁️  Def: internal
```
