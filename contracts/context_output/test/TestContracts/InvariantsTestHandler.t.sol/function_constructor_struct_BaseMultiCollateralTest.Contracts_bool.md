# Function: constructor(struct BaseMultiCollateralTest.Contracts,bool)

**Contract**: [test/TestContracts/InvariantsTestHandler.t.sol/contract_InvariantsTestHandler.md]

## Metadata

- **Contract**: InvariantsTestHandler
- **Signature**: `constructor(struct BaseMultiCollateralTest.Contracts,bool)`
- **Visibility**: public
- **Source Range**: 13070:765:270

## Implementation

```solidity
constructor(Contracts memory contracts, bool assumeNoExpectedFailures) {
    _functionCaller = new FunctionCaller();
    _assumeNoExpectedFailures = assumeNoExpectedFailures;
    setupContracts(contracts);
    for (uint256 i = 0; i < branches.length; ++i) {
        TestDeployer.LiquityContractsDev memory c = branches[i];
        CCR[i] = c.troveManager.get_CCR();
        BCR[i] = c.troveManager.get_BCR();
        MCR[i] = c.troveManager.get_MCR();
        SCR[i] = c.troveManager.get_SCR();
        LIQ_PENALTY_SP[i] = c.troveManager.get_LIQUIDATION_PENALTY_SP();
        LIQ_PENALTY_REDIST[i] = c.troveManager.get_LIQUIDATION_PENALTY_REDISTRIBUTION();
        _price[i] = c.priceFeed.getPrice();
    }
}
```

## Related Implementations

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

- **ITroveManagerTester::get_CCR()**
- **ITroveManagerTester::get_BCR()**
- **ITroveManagerTester::get_MCR()**
- **ITroveManagerTester::get_SCR()**
- **ITroveManagerTester::get_LIQUIDATION_PENALTY_SP()**
- **ITroveManagerTester::get_LIQUIDATION_PENALTY_REDISTRIBUTION()**
- **IPriceFeedTestnet::getPrice()**

## State Variable Writes

- **_functionCaller** (`contract FunctionCaller`) [test/TestContracts/InvariantsTestHandler.t.sol/contract_FunctionCaller.md]
- **_assumeNoExpectedFailures** (`bool`)
- **CCR** (`mapping(uint256 => uint256)`)
- **BCR** (`mapping(uint256 => uint256)`)
- **MCR** (`mapping(uint256 => uint256)`)
- **SCR** (`mapping(uint256 => uint256)`)
- **LIQ_PENALTY_SP** (`mapping(uint256 => uint256)`)
- **LIQ_PENALTY_REDIST** (`mapping(uint256 => uint256)`)
- **_price** (`mapping(uint256 => uint256)`)
- **weth** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **branches** (`struct TestDeployer.LiquityContractsDev[]`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: InvariantsTestHandler.constructor(struct BaseMultiCollateralTest.Contracts,bool) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: InvariantsTestHandler
  └─ [1] ⚙️ FUNCTION: BaseMultiCollateralTest.setupContracts(struct BaseMultiCollateralTest.Contracts) (NodeID: 1)
      💬 Args: [contracts]
      👁️  Def: internal
```
