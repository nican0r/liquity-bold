# Function: test_E2E()

**Contract**: [test/E2E.t.sol/contract_E2ETest.md]

## Metadata

- **Contract**: E2ETest
- **Signature**: `test_E2E()`
- **Visibility**: external
- **Source Range**: 7682:8201:231

## Implementation

```solidity
function test_E2E() external {
    for (uint256 i = 0; i < branches.length; ++i) {
        vm.skip(branches[i].stabilityPool.getTotalBoldDeposits() != 0);
    }
    uint256 repaid;
    uint256 borrowed = boldToken.totalSupply() - boldToken.balanceOf(address(governance));
    for (uint256 i = 0; i < branches.length; ++i) {
        borrowed -= boldToken.balanceOf(address(branches[i].stabilityPool));
    }
    if (block.chainid == 1) {
        assertEqDecimal(borrowed, 0, 18, "Mainnet deployment script should not have borrowed anything");
        assertNotEq(address(curveUsdcBoldGauge), address(0), "Mainnet should have USDC-BOLD gauge");
        assertNotEq(address(curveUsdcBoldInitiative), address(0), "Mainnet should have USDC-BOLD initiative");
        assertNotEq(address(curveLusdBold), address(0), "Mainnet should have LUSD-BOLD pool");
        assertNotEq(address(curveLusdBoldGauge), address(0), "Mainnet should have LUSD-BOLD gauge");
        assertNotEq(address(curveLusdBoldInitiative), address(0), "Mainnet should have LUSD-BOLD initiative");
        assertNotEq(address(defiCollectiveInitiative), address(0), "Mainnet should have DeFi Collective initiative");
    }
    address borrower = providerOf[BOLD] = makeAddr("borrower");
    for (uint256 j = 0; j < 5; ++j) {
        for (uint256 i = 0; i < branches.length; ++i) {
            skip(5 minutes);
            borrowed += _openTrove(i, borrower, j, 20_000 ether);
        }
    }
    address liquidityProvider = makeAddr("liquidityProvider");
    {
        skip(5 minutes);
        uint256 boldAmount = (boldToken.balanceOf(borrower) * 2) / 5;
        uint256 usdcAmount = (boldAmount * (10 ** usdc.decimals())) / (10 ** boldToken.decimals());
        uint256 lusdAmount = boldAmount;
        _addCurveLiquidity(liquidityProvider, curveUsdcBold, boldAmount, BOLD, usdcAmount, USDC);
        if (address(curveLusdBold) != address(0)) {
            _addCurveLiquidity(liquidityProvider, curveLusdBold, boldAmount, BOLD, lusdAmount, LUSD);
        }
        if (address(curveUsdcBoldGauge) != address(0)) {
            _depositIntoCurveGauge(liquidityProvider, curveUsdcBoldGauge, curveUsdcBold.balanceOf(liquidityProvider));
        }
        if (address(curveLusdBoldGauge) != address(0)) {
            _depositIntoCurveGauge(liquidityProvider, curveLusdBoldGauge, curveLusdBold.balanceOf(liquidityProvider));
        }
    }
    address stabilityDepositor = makeAddr("stabilityDepositor");
    for (uint256 i = 0; i < branches.length; ++i) {
        skip(5 minutes);
        _provideToSP(i, stabilityDepositor, boldToken.balanceOf(borrower) / (branches.length - i));
    }
    address leverageSeeker = makeAddr("leverageSeeker");
    for (uint256 i = 0; i < branches.length; ++i) {
        skip(5 minutes);
        borrowed += _openLeveragedTrove(i, leverageSeeker, 0, 10_000 ether);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        skip(5 minutes);
        borrowed += _leverUpTrove(i, leverageSeeker, 0, 1_000 ether);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        skip(5 minutes);
        repaid += _leverDownTrove(i, leverageSeeker, 0, 1_000 ether);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        skip(5 minutes);
        repaid += _closeTroveFromCollateral(i, leverageSeeker, 0, true);
    }
    for (uint256 i = 0; i < branches.length; ++i) {
        skip(5 minutes);
        repaid += _closeTroveFromCollateral(i, borrower, 0, false);
    }
    skip(5 minutes);
    Initiative[] memory initiatives = new Initiative[](initialInitiatives.length);
    for (uint256 i = 0; i < initiatives.length; ++i) {
        initiatives[i].addr = initialInitiatives[i];
        if (initialInitiatives[i] == address(curveUsdcBoldInitiative)) initiatives[i].gauge = curveUsdcBoldGauge;
        if (initialInitiatives[i] == address(curveLusdBoldInitiative)) initiatives[i].gauge = curveLusdBoldGauge;
    }
    address staker = makeAddr("staker");
    {
        uint256 lqtyStake = 30_000 ether;
        _depositLQTY(staker, lqtyStake);
        skip(5 minutes);
        (uint256 lusdAmount, uint256 ethAmount) = _generateStakingRewards();
        uint256 totalLQTYStaked = governance.stakingV1().totalLQTYStaked();
        skip(5 minutes);
        vm.prank(staker);
        governance.claimFromStakingV1(staker);
        assertApproxEqAbsDecimal(lusd.balanceOf(staker), (lusdAmount * lqtyStake) / totalLQTYStaked, 1e5, 18, "LUSD reward");
        assertApproxEqAbsDecimal(staker.balance, (ethAmount * lqtyStake) / totalLQTYStaked, 1e5, 18, "ETH reward");
        skip(5 minutes);
        if (initiatives.length > 0) {
            uint256 votingStart = _epoch(2);
            if (block.timestamp < votingStart) vm.warp(votingStart);
            _allocateLQTY_begin(staker);
            for (uint256 i = 0; i < initiatives.length; ++i) {
                _allocateLQTY_vote(initiatives[i].addr, int256(lqtyStake / initiatives.length));
            }
            _allocateLQTY_end();
        }
    }
    skip(EPOCH_DURATION);
    for (uint256 i = 0; i < branches.length; ++i) {
        skip(5 minutes);
        _claimFromSP(i, stabilityDepositor);
    }
    uint256 interest = (boldToken.totalSupply() + repaid) - borrowed;
    uint256 spShareOfInterest = boldToken.balanceOf(stabilityDepositor);
    uint256 governanceShareOfInterest = boldToken.balanceOf(address(governance));
    assertApproxEqRelDecimal(interest, spShareOfInterest + governanceShareOfInterest, 1e-16 ether, 18, "Stability depositor and Governance should have received the interest");
    if (initiatives.length > 0) {
        uint256 initiativeShareOfInterest;
        for (uint256 i = 0; i < initiatives.length; ++i) {
            governance.claimForInitiative(initiatives[i].addr);
            initiativeShareOfInterest += boldToken.balanceOf(coalesce(address(initiatives[i].gauge), initiatives[i].addr));
        }
        assertApproxEqRelDecimal(governanceShareOfInterest, initiativeShareOfInterest, 1e-15 ether, 18, "Initiatives should have received the interest from Governance");
        uint256 numGauges;
        uint256 maxGaugeDuration;
        for (uint256 i = 0; i < initiatives.length; ++i) {
            if (address(initiatives[i].gauge) != address(0)) {
                maxGaugeDuration = Math.max(maxGaugeDuration, CurveV2GaugeRewards(initiatives[i].addr).duration());
                ++numGauges;
            }
        }
        skip(maxGaugeDuration);
        if (numGauges > 0) {
            uint256 gaugeShareOfInterest;
            for (uint256 i = 0; i < initiatives.length; ++i) {
                if (address(initiatives[i].gauge) != address(0)) {
                    gaugeShareOfInterest += boldToken.balanceOf(address(initiatives[i].gauge));
                    _claimRewardsFromCurveGauge(liquidityProvider, initiatives[i].gauge);
                }
            }
            assertApproxEqRelDecimal(boldToken.balanceOf(liquidityProvider), gaugeShareOfInterest, 1e-13 ether, 18, "Liquidity provider should have earned the rewards from the Curve gauges");
        }
    }
}
```

## Related Implementations

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
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

### skip(uint256)

- **Kind**: internal
- **Source**: 24925:100:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:skip(uint256)`

```solidity
function skip(uint256 time) virtual internal {
    vm.warp(vm.getBlockTimestamp() + time);
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

### _addCurveLiquidity(address,contract ICurveStableSwapNG,uint256,address,uint256,address)

- **Kind**: internal
- **Source**: 754:724:231
- **Link**: `test/E2E.t.sol:E2ETest:_addCurveLiquidity(address,contract ICurveStableSwapNG,uint256,address,uint256,address)`

```solidity
function _addCurveLiquidity(address liquidityProvider, ICurveStableSwapNG pool, uint256 coin0Amount, address coin0, uint256 coin1Amount, address coin1) internal {
    uint256[] memory amounts = new uint256[](2);
    (amounts[0], amounts[1]) = (pool.coins(0) == coin0) ? (coin0Amount, coin1Amount) : (coin1Amount, coin0Amount);
    deal(coin0, liquidityProvider, coin0Amount);
    deal(coin1, liquidityProvider, coin1Amount);
    vm.startPrank(liquidityProvider);
    IERC20(coin0).approve(address(pool), coin0Amount);
    IERC20(coin1).approve(address(pool), coin1Amount);
    pool.add_liquidity(amounts, 0);
    vm.stopPrank();
}
```

### _depositIntoCurveGauge(address,contract ILiquidityGaugeV6,uint256)

- **Kind**: internal
- **Source**: 1484:271:231
- **Link**: `test/E2E.t.sol:E2ETest:_depositIntoCurveGauge(address,contract ILiquidityGaugeV6,uint256)`

```solidity
function _depositIntoCurveGauge(address liquidityProvider, ILiquidityGaugeV6 gauge, uint256 amount) internal {
    vm.startPrank(liquidityProvider);
    gauge.lp_token().approve(address(gauge), amount);
    gauge.deposit(amount);
    vm.stopPrank();
}
```

### _provideToSP(uint256,address,uint256)

- **Kind**: internal
- **Source**: 11237:226:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_provideToSP(uint256,address,uint256)`

```solidity
function _provideToSP(uint256 i, address depositor, uint256 boldAmount) internal {
    deal(BOLD, depositor, boldAmount);
    vm.prank(depositor);
    branches[i].stabilityPool.provideToSP(boldAmount, false);
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

### _generateStakingRewards()

- **Kind**: internal
- **Source**: 4394:977:231
- **Link**: `test/E2E.t.sol:E2ETest:_generateStakingRewards()`

```solidity
function _generateStakingRewards() internal returns (uint256 lusdAmount, uint256 ethAmount) {
    if (block.chainid == 1) {
        address stakingRewardGenerator = makeAddr("stakingRewardGenerator");
        lusdAmount = _mainnet_V1_openTroveAtTail(stakingRewardGenerator, 1e6 ether);
        ethAmount = _mainnet_V1_redeemCollateralFromTroveAtTail(stakingRewardGenerator, 1_000 ether);
    } else {
        lusdAmount = 10_000 ether;
        ethAmount = 1 ether;
        MockStakingV1 stakingV1 = MockStakingV1(address(governance.stakingV1()));
        address owner = stakingV1.owner();
        deal(LUSD, owner, lusdAmount);
        deal(owner, ethAmount);
        vm.startPrank(owner);
        lusd.approve(address(stakingV1), lusdAmount);
        stakingV1.mock_addLUSDGain(lusdAmount);
        stakingV1.mock_addETHGain{value: ethAmount}();
        vm.stopPrank();
    }
}
```

### _mainnet_V1_openTroveAtTail(address,uint256)

- **Kind**: internal
- **Source**: 1940:1041:231
- **Link**: `test/E2E.t.sol:E2ETest:_mainnet_V1_openTroveAtTail(address,uint256)`

```solidity
function _mainnet_V1_openTroveAtTail(address owner, uint256 lusdAmount) internal returns (uint256 borrowingFee) {
    uint256 price = mainnet_V1_priceFeed.getPrice();
    address lastTrove = mainnet_V1_sortedTroves.getLast();
    assertGeDecimal(mainnet_V1_troveManager.getCurrentICR(lastTrove, price), 1.1 ether, 18, "last ICR < MCR");
    uint256 borrowingRate = mainnet_V1_troveManager.getBorrowingRateWithDecay();
    borrowingFee = (lusdAmount * borrowingRate) / 1 ether;
    uint256 debt = (lusdAmount + borrowingFee) + 200 ether;
    uint256 collAmount = Math.ceilDiv(debt * 1.1 ether, price);
    deal(owner, collAmount);
    vm.startPrank(owner);
    mainnet_V1_borrowerOperations.openTrove{value: collAmount}({_LUSDAmount: lusdAmount, _maxFeePercentage: borrowingRate, _upperHint: lastTrove, _lowerHint: address(0)});
    vm.stopPrank();
    assertEq(mainnet_V1_sortedTroves.getLast(), owner, "last Trove != new Trove");
}
```

### assertGeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 15894:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertGeDecimal(left, right, decimals, err);
}
```

### ceilDiv(uint256,uint256)

- **Kind**: internal
- **Source**: 1157:194:101
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ceilDiv(uint256,uint256)`

```solidity
///  @dev Returns the ceiling of the division of two numbers.
///  This differs from standard division with `/` in that it rounds up instead
///  of rounding down.
function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a == 0) ? 0 : (((a - 1) / b) + 1);
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

### _mainnet_V1_redeemCollateralFromTroveAtTail(address,uint256)

- **Kind**: internal
- **Source**: 2987:1401:231
- **Link**: `test/E2E.t.sol:E2ETest:_mainnet_V1_redeemCollateralFromTroveAtTail(address,uint256)`

```solidity
function _mainnet_V1_redeemCollateralFromTroveAtTail(address redeemer, uint256 lusdAmount) internal returns (uint256 redemptionFee) {
    address lastTrove = mainnet_V1_sortedTroves.getLast();
    address prevTrove = mainnet_V1_sortedTroves.getPrev(lastTrove);
    (uint256 lastTroveDebt, uint256 lastTroveColl, , ) = mainnet_V1_troveManager.getEntireDebtAndColl(lastTrove);
    assertLeDecimal(lusdAmount, lastTroveDebt - 2_000 ether, 18, "lusdAmount > redeemable from last Trove");
    uint256 price = mainnet_V1_priceFeed.getPrice();
    uint256 collAmount = (lusdAmount * 1 ether) / price;
    uint256 balanceBefore = redeemer.balance;
    vm.startPrank(redeemer);
    mainnet_V1_troveManager.redeemCollateral({_LUSDamount: lusdAmount, _maxFeePercentage: 1 ether, _maxIterations: 1, _firstRedemptionHint: lastTrove, _upperPartialRedemptionHint: prevTrove, _lowerPartialRedemptionHint: prevTrove, _partialRedemptionHintNICR: ((lastTroveColl - collAmount) * 100 ether) / (lastTroveDebt - lusdAmount)});
    vm.stopPrank();
    redemptionFee = (collAmount * mainnet_V1_troveManager.getBorrowingRateWithDecay()) / 1 ether;
    assertEqDecimal(redeemer.balance - balanceBefore, collAmount - redemptionFee, 18, "coll received != expected");
}
```

### assertLeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 14710:176:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
}
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 17272:268:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqAbsDecimal(left, right, maxDelta, decimals, err);
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

### _claimFromSP(uint256,address)

- **Kind**: internal
- **Source**: 11469:156:287
- **Link**: `test/Utils/E2EHelpers.sol:E2EHelpers:_claimFromSP(uint256,address)`

```solidity
function _claimFromSP(uint256 i, address depositor) internal {
    vm.prank(depositor);
    branches[i].stabilityPool.withdrawFromSP(0, true);
}
```

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 19242:338:48
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)`

```solidity
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals, string memory err) virtual internal pure {
    vm.assertApproxEqRelDecimal(left, right, maxPercentDelta, decimals, err);
}
```

### coalesce(address,address)

- **Kind**: free-function
- **Source**: 438:102:231
- **Link**: `test/E2E.t.sol:coalesce(address,address)`

```solidity
function coalesce(address a, address b) pure returns (address) {
    return (a != address(0)) ? a : b;
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

### _claimRewardsFromCurveGauge(address,contract ILiquidityGaugeV6)

- **Kind**: internal
- **Source**: 1761:173:231
- **Link**: `test/E2E.t.sol:E2ETest:_claimRewardsFromCurveGauge(address,contract ILiquidityGaugeV6)`

```solidity
function _claimRewardsFromCurveGauge(address liquidityProvider, ILiquidityGaugeV6 gauge) internal {
    vm.prank(liquidityProvider);
    gauge.claim_rewards();
}
```

## External Calls

- **Vm::skip(bool)**
- **IStabilityPool::getTotalBoldDeposits()**
- **IBoldToken::totalSupply()**
- **IBoldToken::balanceOf(address)**
- **IERC20Metadata::decimals()**
- **IBoldToken::decimals()**
- **ICurveStableSwapNG::balanceOf(address)**
- **ILQTYStaking::totalLQTYStaked()**
- **Governance::stakingV1()**
- **Vm::prank(address)**
- **Governance::claimFromStakingV1(address)**
- **IERC20Metadata::balanceOf(address)**
- **Vm::warp(uint256)**
- **Governance::claimForInitiative(address)**
- **CurveV2GaugeRewards::duration()**

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
┌─ [0] ⚙️ FUNCTION: E2ETest.test_E2E() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [borrowed, 0, 18, "Mainnet deployment script should not have borrowed anything"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 2)
  │   💬 Args: [address(curveUsdcBoldGauge), address(0), "Mainnet should have USDC-BOLD gauge"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 3)
  │   💬 Args: [address(curveUsdcBoldInitiative), address(0), "Mainnet should have USDC-BOLD initiative"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 4)
  │   💬 Args: [address(curveLusdBold), address(0), "Mainnet should have LUSD-BOLD pool"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 5)
  │   💬 Args: [address(curveLusdBoldGauge), address(0), "Mainnet should have LUSD-BOLD gauge"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 6)
  │   💬 Args: [address(curveLusdBoldInitiative), address(0), "Mainnet should have LUSD-BOLD initiative"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 7)
  │   💬 Args: [address(defiCollectiveInitiative), address(0), "Mainnet should have DeFi Collective initiative"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 8)
  │   💬 Args: ["borrower"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 9)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 10)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._openTrove(uint256,address,uint256,uint256) (NodeID: 11)
  │   💬 Args: [i, borrower, j, 20_000 ether]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 12)
  │ │   💬 Args: [owner, value]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 13)
  │     💬 Args: [address(branches[i].collToken), owner, collTokenAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 14)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 15)
  │   💬 Args: ["liquidityProvider"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 16)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 17)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2ETest._addCurveLiquidity(address,contract ICurveStableSwapNG,uint256,address,uint256,address) (NodeID: 18)
  │   💬 Args: [liquidityProvider, curveUsdcBold, boldAmount, BOLD, usdcAmount, USDC]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 19)
  │ │   💬 Args: [coin0, liquidityProvider, coin0Amount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 20)
  │ │     💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 21)
  │     💬 Args: [coin1, liquidityProvider, coin1Amount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 22)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2ETest._addCurveLiquidity(address,contract ICurveStableSwapNG,uint256,address,uint256,address) (NodeID: 23)
  │   💬 Args: [liquidityProvider, curveLusdBold, boldAmount, BOLD, lusdAmount, LUSD]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 24)
  │ │   💬 Args: [coin0, liquidityProvider, coin0Amount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 25)
  │ │     💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 26)
  │     💬 Args: [coin1, liquidityProvider, coin1Amount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 27)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2ETest._depositIntoCurveGauge(address,contract ILiquidityGaugeV6,uint256) (NodeID: 28)
  │   💬 Args: [liquidityProvider, curveUsdcBoldGauge, curveUsdcBold.balanceOf(liquidityProvider)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2ETest._depositIntoCurveGauge(address,contract ILiquidityGaugeV6,uint256) (NodeID: 29)
  │   💬 Args: [liquidityProvider, curveLusdBoldGauge, curveLusdBold.balanceOf(liquidityProvider)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 30)
  │   💬 Args: ["stabilityDepositor"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 31)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 32)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._provideToSP(uint256,address,uint256) (NodeID: 33)
  │   💬 Args: [i, stabilityDepositor, boldToken.balanceOf(borrower) / (branches.length - i)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 34)
  │     💬 Args: [BOLD, depositor, boldAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 35)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 36)
  │   💬 Args: ["leverageSeeker"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 37)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 38)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._openLeveragedTrove(uint256,address,uint256,uint256) (NodeID: 39)
  │   💬 Args: [i, leverageSeeker, 0, 10_000 ether]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 40)
  │ │   💬 Args: [owner, value]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 41)
  │     💬 Args: [address(branches[i].collToken), owner, collTokenAmount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 42)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 43)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._leverUpTrove(uint256,address,uint256,uint256) (NodeID: 44)
  │   💬 Args: [i, leverageSeeker, 0, 1_000 ether]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 45)
  │     💬 Args: [address(branches[i].leverageZapper), owner, ownerIndex]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 46)
  │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 47)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._leverDownTrove(uint256,address,uint256,uint256) (NodeID: 48)
  │   💬 Args: [i, leverageSeeker, 0, 1_000 ether]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 49)
  │     💬 Args: [address(branches[i].leverageZapper), owner, ownerIndex]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 50)
  │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 51)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._closeTroveFromCollateral(uint256,address,uint256,bool) (NodeID: 52)
  │   💬 Args: [i, leverageSeeker, 0, true]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 53)
  │     💬 Args: [address(zapper), owner, ownerIndex]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 54)
  │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 55)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._closeTroveFromCollateral(uint256,address,uint256,bool) (NodeID: 56)
  │   💬 Args: [i, borrower, 0, false]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,uint256) (NodeID: 57)
  │     💬 Args: [address(zapper), owner, ownerIndex]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: TroveId.addressToTroveIdThroughZapper(address,address,address,uint256) (NodeID: 58)
  │       💬 Args: [_zapper, _owner, _owner, _ownerIndex]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 59)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 60)
  │   💬 Args: ["staker"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 61)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._depositLQTY(address,uint256) (NodeID: 62)
  │   💬 Args: [staker, lqtyStake]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 63)
  │     💬 Args: [LQTY, voter, amount]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 64)
  │       💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 65)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2ETest._generateStakingRewards() (NodeID: 66)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 67)
  │ │   💬 Args: ["stakingRewardGenerator"]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 68)
  │ │     💬 Args: [name]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2ETest._mainnet_V1_openTroveAtTail(address,uint256) (NodeID: 69)
  │ │   💬 Args: [stakingRewardGenerator, 1e6 ether]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertGeDecimal(uint256,uint256,uint256,string) (NodeID: 70)
  │ │ │   💬 Args: [mainnet_V1_troveManager.getCurrentICR(lastTrove, price), 1.1 ether, 18, "last ICR < MCR"]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 71)
  │ │ │   💬 Args: [debt * 1.1 ether, price]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 72)
  │ │ │   💬 Args: [owner, collAmount]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 73)
  │ │     💬 Args: [mainnet_V1_sortedTroves.getLast(), owner, "last Trove != new Trove"]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2ETest._mainnet_V1_redeemCollateralFromTroveAtTail(address,uint256) (NodeID: 74)
  │ │   💬 Args: [stakingRewardGenerator, 1_000 ether]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 75)
  │ │ │   💬 Args: [lusdAmount, lastTroveDebt - 2_000 ether, 18, "lusdAmount > redeemable from last Trove"]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 76)
  │ │     💬 Args: [redeemer.balance - balanceBefore, collAmount - redemptionFee, 18, "coll received != expected"]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,address,uint256) (NodeID: 77)
  │ │   💬 Args: [LUSD, owner, lusdAmount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdAssertions.assertNotEq(address,address,string) (NodeID: 78)
  │ │     💬 Args: [provider, address(0), string.concat("No provider for ", IERC20(token).symbol())]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: E2EHelpers.deal(address,uint256) (NodeID: 79)
  │     💬 Args: [owner, ethAmount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 80)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 81)
  │   💬 Args: [lusd.balanceOf(staker), (lusdAmount * lqtyStake) / totalLQTYStaked, 1e5, 18, "LUSD reward"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 82)
  │   💬 Args: [staker.balance, (ethAmount * lqtyStake) / totalLQTYStaked, 1e5, 18, "ETH reward"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 83)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2ETest._epoch(uint256) (NodeID: 84)
  │   💬 Args: [2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._allocateLQTY_begin(address) (NodeID: 85)
  │   💬 Args: [staker]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._allocateLQTY_vote(address,int256) (NodeID: 86)
  │   💬 Args: [initiatives[i].addr, int256(lqtyStake / initiatives.length)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._allocateLQTY_end() (NodeID: 87)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 88)
  │   💬 Args: [EPOCH_DURATION]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 89)
  │   💬 Args: [5 minutes]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2EHelpers._claimFromSP(uint256,address) (NodeID: 90)
  │   💬 Args: [i, stabilityDepositor]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 91)
  │   💬 Args: [interest, spShareOfInterest + governanceShareOfInterest, 1e-16 ether, 18, "Stability depositor and Governance should have received the interest"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.coalesce(address,address) (NodeID: 92)
  │   💬 Args: [address(initiatives[i].gauge), initiatives[i].addr]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 93)
  │   💬 Args: [governanceShareOfInterest, initiativeShareOfInterest, 1e-15 ether, 18, "Initiatives should have received the interest from Governance"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.max(uint256,uint256) (NodeID: 94)
  │   💬 Args: [maxGaugeDuration, CurveV2GaugeRewards(initiatives[i].addr).duration()]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.skip(uint256) (NodeID: 95)
  │   💬 Args: [maxGaugeDuration]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: E2ETest._claimRewardsFromCurveGauge(address,contract ILiquidityGaugeV6) (NodeID: 96)
  │   💬 Args: [liquidityProvider, initiatives[i].gauge]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (NodeID: 97)
      💬 Args: [boldToken.balanceOf(liquidityProvider), gaugeShareOfInterest, 1e-13 ether, 18, "Liquidity provider should have earned the rewards from the Curve gauges"]
      👁️  Def: internal
```
