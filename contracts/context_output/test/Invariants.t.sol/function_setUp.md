# Function: setUp()

**Contract**: [test/Invariants.t.sol/contract_InvariantsTest.md]

## Metadata

- **Contract**: InvariantsTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 3046:1490:243

## Implementation

```solidity
function setUp() override public {
    super.setUp();
    uint256 n;
    try vm.envUint("NUM_BRANCHES") returns (uint256 value) {
        n = value;
    } catch {
        n = 4;
    }
    TestDeployer.TroveManagerParams[] memory p = new TestDeployer.TroveManagerParams[](n);
    if (n > 0) {
        p[0] = TestDeployer.TroveManagerParams(1.5 ether, 1.1 ether, 0.1 ether, 1.1 ether, 0.05 ether, 0.1 ether);
    }
    if (n > 1) {
        p[1] = TestDeployer.TroveManagerParams(1.6 ether, 1.2 ether, 0.1 ether, 1.2 ether, 0.05 ether, 0.2 ether);
    }
    if (n > 2) {
        p[2] = TestDeployer.TroveManagerParams(1.6 ether, 1.2 ether, 0.1 ether, 1.2 ether, 0.05 ether, 0.2 ether);
    }
    if (n > 3) {
        p[3] = TestDeployer.TroveManagerParams(1.6 ether, 1.25 ether, 0.1 ether, 1.01 ether, 0.05 ether, 0.1 ether);
    }
    TestDeployer deployer = new TestDeployer();
    Contracts memory contracts;
    (contracts.branches, contracts.collateralRegistry, contracts.boldToken, contracts.hintHelpers, , contracts.weth, ) = deployer.deployAndConnectContractsMultiColl(p);
    setupContracts(contracts);
    handler = new InvariantsTestHandler({contracts: contracts, assumeNoExpectedFailures: true});
    vm.label(address(handler), "handler");
    targetContract(address(handler));
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

### targetContract(address)

- **Kind**: internal
- **Source**: 1791:125:52
- **Link**: `lib/forge-std/src/StdInvariant.sol:StdInvariant:targetContract(address)`

```solidity
function targetContract(address newTargetedContract_) internal {
    _targetedContracts.push(newTargetedContract_);
}
```

## External Calls

- **Vm::envUint(string)**
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
- **_targetedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InvariantsTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseInvariantTest.setUp() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdInvariant.targetSender(address) (NodeID: 2)
  │     💬 Args: [actors[i].account]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseMultiCollateralTest.setupContracts(struct BaseMultiCollateralTest.Contracts) (NodeID: 3)
  │   💬 Args: [contracts]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdInvariant.targetContract(address) (NodeID: 4)
      💬 Args: [address(handler)]
      👁️  Def: internal
```
