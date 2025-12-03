# Function: setUp()

**Contract**: [test/zapperWETH.t.sol/contract_ZapperWETHTest.md]

## Metadata

- **Contract**: ZapperWETHTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 221:1697:339

## Implementation

```solidity
function setUp() override public {
    vm.warp(block.timestamp + 600);
    accounts = new Accounts();
    createAccounts();
    (A, B, C, D, E, F, G) = (accountsList[0], accountsList[1], accountsList[2], accountsList[3], accountsList[4], accountsList[5], accountsList[6]);
    WETH = new WETH9();
    TestDeployer.TroveManagerParams[] memory troveManagerParams = new TestDeployer.TroveManagerParams[](1);
    troveManagerParams[0] = TestDeployer.TroveManagerParams(150e16, 110e16, 10e16, 110e16, 5e16, 10e16);
    TestDeployer deployer = new TestDeployer();
    TestDeployer.LiquityContractsDev[] memory contractsArray;
    TestDeployer.Zappers[] memory zappersArray;
    (contractsArray, collateralRegistry, boldToken, , , zappersArray) = deployer.deployAndConnectContracts(troveManagerParams, WETH);
    contractsArray[0].priceFeed.setPrice(2000e18);
    uint256 initialCollateralAmount = 10_000e18;
    for (uint256 i = 0; i < 6; i++) {
        deal(accountsList[i], initialCollateralAmount);
    }
    addressesRegistry = contractsArray[0].addressesRegistry;
    borrowerOperations = contractsArray[0].borrowerOperations;
    troveManager = contractsArray[0].troveManager;
    troveNFT = contractsArray[0].troveNFT;
    wethZapper = zappersArray[0].wethZapper;
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

### deal(address,uint256)

- **Kind**: internal
- **Source**: 27055:91:50
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,uint256)`

```solidity
function deal(address to, uint256 give) virtual internal {
    vm.deal(to, give);
}
```

## External Calls

- **Vm::warp(uint256)**
- **TestDeployer::deployAndConnectContracts(struct TestDeployer.TroveManagerParams[],contract IWETH)**
- **IPriceFeedTestnet::setPrice(uint256)**

## State Variable Reads

- **accounts** (`contract Accounts`) [test/TestContracts/Accounts.sol/contract_Accounts.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **accountsList** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ZapperWETHTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TestAccounts.createAccounts() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 2)
      💬 Args: [accountsList[i], initialCollateralAmount]
      👁️  Def: internal
```
