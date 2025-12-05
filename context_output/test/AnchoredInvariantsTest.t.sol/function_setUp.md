# Function: setUp()

**Contract**: [test/AnchoredInvariantsTest.t.sol/contract_AnchoredInvariantsTest.md]

## Metadata

- **Contract**: AnchoredInvariantsTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 744:1534:227

## Implementation

```solidity
function setUp() override public {
    super.setUp();
    TestDeployer.TroveManagerParams[] memory p = new TestDeployer.TroveManagerParams[](4);
    p[0] = TestDeployer.TroveManagerParams(1.5 ether, 1.1 ether, 0.1 ether, 1.01 ether, 0.05 ether, 0.1 ether);
    p[1] = TestDeployer.TroveManagerParams(1.6 ether, 1.2 ether, 0.1 ether, 1.01 ether, 0.05 ether, 0.1 ether);
    p[2] = TestDeployer.TroveManagerParams(1.6 ether, 1.2 ether, 0.1 ether, 1.01 ether, 0.05 ether, 0.1 ether);
    p[3] = TestDeployer.TroveManagerParams(1.6 ether, 1.25 ether, 0.1 ether, 1.01 ether, 0.05 ether, 0.1 ether);
    TestDeployer deployer = new TestDeployer();
    Contracts memory contracts;
    (contracts.branches, contracts.collateralRegistry, contracts.boldToken, contracts.hintHelpers, , contracts.weth, ) = deployer.deployAndConnectContractsMultiColl(p);
    setupContracts(contracts);
    handler = new InvariantsTestHandler({contracts: contracts, assumeNoExpectedFailures: true});
    vm.label(address(handler), "handler");
    actors.push(Actor("adam", adam));
    actors.push(Actor("barb", barb));
    actors.push(Actor("carl", carl));
    actors.push(Actor("dana", dana));
    actors.push(Actor("eric", eric));
    actors.push(Actor("fran", fran));
    actors.push(Actor("gabe", gabe));
    actors.push(Actor("hope", hope));
    for (uint256 i = 0; i < actors.length; ++i) {
        vm.label(actors[i].account, actors[i].label);
    }
}
```

## Related Implementations

### setUp()

- **Kind**: internal
- **Source**: 1174:206:252
- **Link**: `test/TestContracts/BaseInvariantTest.sol:BaseInvariantTest:setUp()`

```solidity
function setUp() virtual public {
    for (uint256 i = 0; i < actors.length; ++i) {
        vm.label(actors[i].account, actors[i].label);
        targetSender(actors[i].account);
    }
}
```

### targetSender(address)

- **Kind**: internal
- **Source**: 2065:117:52
- **Link**: `lib/forge-std/src/StdInvariant.sol:StdInvariant:targetSender(address)`

```solidity
function targetSender(address newTargetedSender_) internal {
    _targetedSenders.push(newTargetedSender_);
}
```

### setupContracts(struct BaseMultiCollateralTest.Contracts)

- **Kind**: internal
- **Source**: 837:371:253
- **Link**: `test/TestContracts/BaseMultiCollateralTest.sol:BaseMultiCollateralTest:setupContracts(struct BaseMultiCollateralTest.Contracts)`

```solidity
function setupContracts(Contracts memory contracts) internal {
    weth = contracts.weth;
    collateralRegistry = contracts.collateralRegistry;
    boldToken = contracts.boldToken;
    hintHelpers = contracts.hintHelpers;
    for (uint256 i = 0; i < contracts.branches.length; ++i) {
        branches.push(contracts.branches[i]);
    }
}
```

## External Calls

- **TestDeployer::deployAndConnectContractsMultiColl(struct TestDeployer.TroveManagerParams[])**
- **Vm::label(address,string)**

## State Variable Reads

- **handler** (`contract InvariantsTestHandler`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]
- **actors** (`struct BaseInvariantTest.Actor[]`)

## State Variable Writes

- **handler** (`contract InvariantsTestHandler`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]
- **_targetedSenders** (`address[]`)
- **weth** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **branches** (`struct TestDeployer.LiquityContractsDev[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AnchoredInvariantsTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseInvariantTest.setUp() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdInvariant.targetSender(address) (NodeID: 2)
  │     💬 Args: [actors[i].account]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseMultiCollateralTest.setupContracts(struct BaseMultiCollateralTest.Contracts) (NodeID: 3)
      💬 Args: [contracts]
      👁️  Def: internal
```
