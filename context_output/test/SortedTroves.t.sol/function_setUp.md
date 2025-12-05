# Function: setUp()

**Contract**: [test/SortedTroves.t.sol/contract_SortedTrovesTest.md]

## Metadata

- **Contract**: SortedTrovesTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 15532:1112:247

## Implementation

```solidity
function setUp() public {
    bytes32 SALT = keccak256("LiquityV2");
    AddressesRegistry addressesRegistry = new AddressesRegistry(address(this), 150e16, 110e16, 10e16, 110e16, 5e16, 10e16);
    bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), SALT, keccak256(abi.encodePacked(type(SortedTroves).creationCode, abi.encode(address(addressesRegistry))))));
    address sortedTrovesAddress = address(uint160(uint256(hash)));
    tm = new MockTroveManager(SortedTroves(sortedTrovesAddress));
    IAddressesRegistry.AddressVars memory addressVars;
    addressVars.borrowerOperations = IBorrowerOperations(address(tm));
    addressVars.troveManager = ITroveManager(address(tm));
    addressesRegistry.setAddresses(addressVars);
    new SortedTroves{salt: SALT}(addressesRegistry);
}
```

## External Calls

- **AddressesRegistry::setAddresses(struct IAddressesRegistry.AddressVars)**
- **unknown::unknown**

## State Variable Reads

- **tm** (`contract MockTroveManager`) [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## State Variable Writes

- **tm** (`contract MockTroveManager`) [test/SortedTroves.t.sol/contract_MockTroveManager.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTrovesTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
