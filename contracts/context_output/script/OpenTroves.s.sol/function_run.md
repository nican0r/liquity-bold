# Function: run()

**Contract**: [script/OpenTroves.s.sol/contract_OpenTroves.md]

## Metadata

- **Contract**: OpenTroves
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 2286:5032:120

## Implementation

```solidity
function run() external {
    vm.startBroadcast();
    string memory manifestJson;
    try vm.readFile("deployment-manifest.json") returns (string memory content) {
        manifestJson = content;
    } catch {}
    ICollateralRegistry collateralRegistry;
    try vm.envAddress("COLLATERAL_REGISTRY") returns (address value) {
        collateralRegistry = ICollateralRegistry(value);
    } catch {
        collateralRegistry = ICollateralRegistry(vm.parseJsonAddress(manifestJson, ".collateralRegistry"));
    }
    vm.label(address(collateralRegistry), "CollateralRegistry");
    IHintHelpers hintHelpers;
    try vm.envAddress("HINT_HELPERS") returns (address value) {
        hintHelpers = IHintHelpers(value);
    } catch {
        hintHelpers = IHintHelpers(vm.parseJsonAddress(manifestJson, ".hintHelpers"));
    }
    vm.label(address(hintHelpers), "HintHelpers");
    address proxyImplementation = address(new Proxy());
    vm.label(proxyImplementation, "ProxyImplementation");
    ERC20Faucet weth = ERC20Faucet(address(collateralRegistry.getToken(0)));
    uint256 numBranches = collateralRegistry.totalCollaterals();
    for (uint256 branch = 0; branch < numBranches; ++branch) {
        BranchContracts memory c;
        c.collateral = ERC20Faucet(address(collateralRegistry.getToken(branch)));
        vm.label(address(c.collateral), "ERC20Faucet");
        c.troveManager = collateralRegistry.getTroveManager(branch);
        vm.label(address(c.troveManager), "TroveManager");
        c.sortedTroves = c.troveManager.sortedTroves();
        vm.label(address(c.sortedTroves), "SortedTroves");
        c.borrowerOperations = c.troveManager.borrowerOperations();
        vm.label(address(c.borrowerOperations), "BorrowerOperations");
        c.nft = c.troveManager.troveNFT();
        vm.label(address(c.nft), "TroveNFT");
        if (c.borrowerOperations.getInterestBatchManager(msg.sender).maxInterestRate == 0) {
            c.borrowerOperations.registerBatchManager({minInterestRate: uint128(MIN_ANNUAL_INTEREST_RATE), maxInterestRate: uint128(MAX_ANNUAL_INTEREST_RATE), currentInterestRate: 0.025 ether, fee: 0.001 ether, minInterestRateChangePeriod: MIN_INTEREST_RATE_CHANGE_PERIOD});
        }
        for (uint256 i = 1; i <= 4; ++i) {
            Proxy proxy = Proxy(Clones.clone(proxyImplementation));
            vm.label(address(proxy), "Proxy");
            proxy.tap(c.collateral);
            uint256 ethAmount = c.collateral.tapAmount() / 2;
            if (branch == 0) {
                c.collateral.approve(address(c.borrowerOperations), ethAmount + ETH_GAS_COMPENSATION);
            } else {
                proxy.tap(weth);
                c.collateral.approve(address(c.borrowerOperations), ethAmount);
                weth.approve(address(c.borrowerOperations), ETH_GAS_COMPENSATION);
            }
            uint256 interestRate = i * 0.01 ether;
            (uint256 upperHint, uint256 lowerHint) = _findHints(hintHelpers, c, branch, interestRate);
            uint256 troveId = c.borrowerOperations.openTrove({_owner: address(proxy), _ownerIndex: 0, _ETHAmount: ethAmount, _boldAmount: 2_000 ether, _upperHint: upperHint, _lowerHint: lowerHint, _annualInterestRate: interestRate, _maxUpfrontFee: type(uint256).max, _addManager: address(0), _removeManager: address(0), _receiver: address(0)});
            proxy.sweepTrove(c.nft, troveId);
            c.collateral.transfer(address(0xdead), c.collateral.balanceOf(msg.sender));
            if (branch != 0) weth.transfer(address(0xdead), weth.balanceOf(msg.sender));
            if ((i % 2) == 0) {
                interestRate = c.troveManager.getLatestBatchData(msg.sender).annualInterestRate;
                (upperHint, lowerHint) = _findHints(hintHelpers, c, branch, interestRate);
                c.borrowerOperations.setInterestBatchManager({_troveId: troveId, _newBatchManager: msg.sender, _upperHint: upperHint, _lowerHint: lowerHint, _maxUpfrontFee: type(uint256).max});
            }
        }
    }
}
```

## Related Implementations

### clone(address)

- **Kind**: internal
- **Source**: 973:759:76
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/Clones.sol:Clones:clone(address)`

```solidity
///  @dev Deploys and returns the address of a clone that mimics the behaviour of `implementation`.
///  This function uses the create opcode, which should never revert.
function clone(address implementation) internal returns (address instance) {
    /// @solidity memory-safe-assembly
    assembly {
        mstore(0x00, or(shr(0xe8, shl(0x60, implementation)), 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000))
        mstore(0x20, or(shl(0x78, implementation), 0x5af43d82803e903d91602b57fd5bf3))
        instance := create(0, 0x09, 0x37)
    }
    require(instance != address(0), "ERC1167: create failed");
}
```

### _findHints(contract IHintHelpers,struct OpenTroves.BranchContracts,uint256,uint256)

- **Kind**: internal
- **Source**: 1611:669:120
- **Link**: `script/OpenTroves.s.sol:OpenTroves:_findHints(contract IHintHelpers,struct OpenTroves.BranchContracts,uint256,uint256)`

```solidity
function _findHints(IHintHelpers hintHelpers, BranchContracts memory c, uint256 branch, uint256 interestRate) internal view returns (uint256 upperHint, uint256 lowerHint) {
    (uint256 approxHint, , ) = hintHelpers.getApproxHint({_collIndex: branch, _interestRate: interestRate, _numTrials: sqrt(100 * c.troveManager.getTroveIdsCount()), _inputRandomSeed: block.timestamp});
    (upperHint, lowerHint) = c.sortedTroves.findInsertPosition(interestRate, approxHint, approxHint);
}
```

### sqrt(uint256)

- **Kind**: free-function
- **Source**: 812:248:120
- **Link**: `script/OpenTroves.s.sol:sqrt(uint256)`

```solidity
function sqrt(uint256 y) pure returns (uint256 z) {
    if (y > 3) {
        z = y;
        uint256 x = (y / 2) + 1;
        while (x < z) {
            z = x;
            x = ((y / x) + x) / 2;
        }
    } else if (y != 0) {
        z = 1;
    }
}
```

## External Calls

- **Vm::startBroadcast()**
- **Vm::readFile(string)**
- **Vm::envAddress(string)**
- **Vm::parseJsonAddress(string,string)**
- **Vm::label(address,string)**
- **ICollateralRegistry::getToken(uint256)**
- **ICollateralRegistry::totalCollaterals()**
- **ICollateralRegistry::getTroveManager(uint256)**
- **ITroveManager::sortedTroves()**
- **ITroveManager::borrowerOperations()**
- **ITroveManager::troveNFT()**
- **IBorrowerOperations::getInterestBatchManager(address)**
- **IBorrowerOperations::registerBatchManager(uint128,uint128,uint128,uint128,uint128)**
- **Proxy::tap(contract ERC20Faucet)**
- **ERC20Faucet::tapAmount()**
- **ERC20Faucet::approve(address,uint256)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **Proxy::sweepTrove(contract ITroveNFT,uint256)**
- **ERC20Faucet::transfer(address,uint256)**
- **ERC20Faucet::balanceOf(address)**
- **ITroveManager::getLatestBatchData(address)**
- **IBorrowerOperations::setInterestBatchManager(uint256,address,uint256,uint256,uint256)**

## Native Transfers

- **unknown** (computed)
- **weth** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: OpenTroves.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Clones.clone(address) (NodeID: 1)
  │   💬 Args: [proxyImplementation]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: OpenTroves._findHints(contract IHintHelpers,struct OpenTroves.BranchContracts,uint256,uint256) (NodeID: 2)
  │   💬 Args: [hintHelpers, c, branch, interestRate]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.sqrt(uint256) (NodeID: 3)
  │     💬 Args: [100 * c.troveManager.getTroveIdsCount()]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: OpenTroves._findHints(contract IHintHelpers,struct OpenTroves.BranchContracts,uint256,uint256) (NodeID: 4)
      💬 Args: [hintHelpers, c, branch, interestRate]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Unknown.sqrt(uint256) (NodeID: 5)
        💬 Args: [100 * c.troveManager.getTroveIdsCount()]
        👁️  Def: internal
```
