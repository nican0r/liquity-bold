# Function: test_ManagerOfCurveGauge_UnlessRenounced_CanReassignRewardDistributor()

**Contract**: [test/E2E.t.sol/contract_E2ETest.md]

## Metadata

- **Contract**: E2ETest
- **Signature**: `test_ManagerOfCurveGauge_UnlessRenounced_CanReassignRewardDistributor()`
- **Visibility**: external
- **Source Range**: 17093:971:231

## Implementation

```solidity
function test_ManagerOfCurveGauge_UnlessRenounced_CanReassignRewardDistributor() external {
    vm.skip(address(curveUsdcBoldGauge) == address(0));
    address manager = curveUsdcBoldGauge.manager();
    vm.skip(manager == address(0));
    vm.label(manager, "manager");
    address newRewardDistributor = makeAddr("newRewardDistributor");
    uint256 rewardAmount = 10_000 ether;
    _openTrove(0, newRewardDistributor, 0, rewardAmount);
    vm.startPrank(newRewardDistributor);
    boldToken.approve(address(curveUsdcBoldGauge), rewardAmount);
    vm.expectRevert();
    curveUsdcBoldGauge.deposit_reward_token(BOLD, rewardAmount, 7 days);
    vm.stopPrank();
    vm.prank(manager);
    curveUsdcBoldGauge.set_reward_distributor(BOLD, newRewardDistributor);
    vm.startPrank(newRewardDistributor);
    curveUsdcBoldGauge.deposit_reward_token(BOLD, rewardAmount, 7 days);
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

## External Calls

- **Vm::skip(bool)**
- **ILiquidityGaugeV6::manager()**
- **Vm::label(address,string)**
- **Vm::startPrank(address)**
- **IBoldToken::approve(address,uint256)**
- **Vm::expectRevert()**
- **ILiquidityGaugeV6::deposit_reward_token(address,uint256,uint256)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **ILiquidityGaugeV6::set_reward_distributor(address,address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **providerOf** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: E2ETest.test_ManagerOfCurveGauge_UnlessRenounced_CanReassignRewardDistributor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["newRewardDistributor"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: E2EHelpers._openTrove(uint256,address,uint256,uint256) (NodeID: 3)
      💬 Args: [0, newRewardDistributor, 0, rewardAmount]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 4)
    │   💬 Args: [owner, value]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 5)
        💬 Args: [address(branches[i].collToken), owner, collTokenAmount]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 6)
          💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
          👁️  Def: internal
```
