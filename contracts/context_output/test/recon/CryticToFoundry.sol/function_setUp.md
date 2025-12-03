# Function: setUp()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 561:88:315

## Implementation

```solidity
function setUp() public {
    setup();
    targetContract(address(this));
}
```

## Related Implementations

### setup()

- **Kind**: internal
- **Source**: 3600:10214:317
- **Link**: `test/recon/Setup.sol:Setup:setup()`

```solidity
/// === Setup === ///
///  This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
function setup() virtual override internal {
    _addActor(address(0x100));
    _addActor(address(0x200));
    collToken = new WETHTester(100 ether, 1 days);
    _addAsset(address(collToken));
    boldToken = new BoldToken(address(this));
    priceFeed = new PriceFeedTestnet();
    interestRouter = new MockInterestRouter();
    bytes4[] memory sigs = new bytes4[](0);
    FixedAssetReader.Asset[] memory assets = new FixedAssetReader.Asset[](0);
    FixedAssetReader assetReader = new FixedAssetReader(address(0), sigs, assets);
    metadataNFT = new MetadataNFT(assetReader);
    MockActivePool mockActivePool = new MockActivePool();
    MockDefaultPool mockDefaultPool = new MockDefaultPool();
    MockWETH mockWETH = new MockWETH();
    AddressesRegistry tempRegistry1 = new AddressesRegistry(address(this), CCR, MCR, BCR, SCR, LIQUIDATION_PENALTY_SP, LIQUIDATION_PENALTY_REDISTRIBUTION);
    IAddressesRegistry.AddressVars memory tempVars1 = IAddressesRegistry.AddressVars({collToken: IERC20Metadata(address(collToken)), borrowerOperations: IBorrowerOperations(address(1)), troveManager: ITroveManager(address(1)), troveNFT: ITroveNFT(address(0)), metadataNFT: IMetadataNFT(address(metadataNFT)), stabilityPool: IStabilityPool(address(0)), priceFeed: IPriceFeed(address(priceFeed)), activePool: IActivePool(address(mockActivePool)), defaultPool: IDefaultPool(address(mockDefaultPool)), gasPoolAddress: address(0), collSurplusPool: ICollSurplusPool(address(0)), sortedTroves: ISortedTroves(address(0)), interestRouter: IInterestRouter(address(interestRouter)), hintHelpers: IHintHelpers(address(0)), multiTroveGetter: IMultiTroveGetter(address(0)), collateralRegistry: ICollateralRegistry(address(0)), boldToken: IBoldToken(address(boldToken)), WETH: IWETH(address(mockWETH))});
    tempRegistry1.setAddresses(tempVars1);
    troveNFT = new TroveNFT(tempRegistry1);
    collSurplusPool = new CollSurplusPool(tempRegistry1);
    sortedTroves = new SortedTroves(tempRegistry1);
    gasPool = new GasPool(tempRegistry1);
    AddressesRegistry tempRegistry2 = new AddressesRegistry(address(this), CCR, MCR, BCR, SCR, LIQUIDATION_PENALTY_SP, LIQUIDATION_PENALTY_REDISTRIBUTION);
    IAddressesRegistry.AddressVars memory tempVars2 = IAddressesRegistry.AddressVars({collToken: IERC20Metadata(address(collToken)), borrowerOperations: IBorrowerOperations(address(0)), troveManager: ITroveManager(address(0)), troveNFT: ITroveNFT(address(troveNFT)), metadataNFT: IMetadataNFT(address(metadataNFT)), stabilityPool: IStabilityPool(address(0)), priceFeed: IPriceFeed(address(priceFeed)), activePool: IActivePool(address(mockActivePool)), defaultPool: IDefaultPool(address(mockDefaultPool)), gasPoolAddress: address(gasPool), collSurplusPool: ICollSurplusPool(address(collSurplusPool)), sortedTroves: ISortedTroves(address(sortedTroves)), interestRouter: IInterestRouter(address(interestRouter)), hintHelpers: IHintHelpers(address(0)), multiTroveGetter: IMultiTroveGetter(address(0)), collateralRegistry: ICollateralRegistry(address(0)), boldToken: IBoldToken(address(boldToken)), WETH: IWETH(address(collToken))});
    tempRegistry2.setAddresses(tempVars2);
    activePool = new ActivePool(tempRegistry2);
    defaultPool = new DefaultPool(tempRegistry2);
    AddressesRegistry tempRegistry = new AddressesRegistry(address(this), CCR, MCR, BCR, SCR, LIQUIDATION_PENALTY_SP, LIQUIDATION_PENALTY_REDISTRIBUTION);
    IAddressesRegistry.AddressVars memory tempVars = IAddressesRegistry.AddressVars({collToken: IERC20Metadata(address(collToken)), borrowerOperations: IBorrowerOperations(address(0)), troveManager: ITroveManager(address(0)), troveNFT: ITroveNFT(address(troveNFT)), metadataNFT: IMetadataNFT(address(metadataNFT)), stabilityPool: IStabilityPool(address(0)), priceFeed: IPriceFeed(address(priceFeed)), activePool: IActivePool(address(activePool)), defaultPool: IDefaultPool(address(defaultPool)), gasPoolAddress: address(gasPool), collSurplusPool: ICollSurplusPool(address(collSurplusPool)), sortedTroves: ISortedTroves(address(sortedTroves)), interestRouter: IInterestRouter(address(interestRouter)), hintHelpers: IHintHelpers(address(0)), multiTroveGetter: IMultiTroveGetter(address(0)), collateralRegistry: ICollateralRegistry(address(0)), boldToken: IBoldToken(address(boldToken)), WETH: IWETH(address(collToken))});
    tempRegistry.setAddresses(tempVars);
    borrowerOperations = new BorrowerOperationsTester(tempRegistry);
    troveManager = new TroveManagerTester(tempRegistry);
    stabilityPool = new StabilityPool(tempRegistry);
    IERC20Metadata[] memory collaterals = new IERC20Metadata[](1);
    collaterals[0] = IERC20Metadata(address(collToken));
    ITroveManager[] memory troveManagers = new ITroveManager[](1);
    troveManagers[0] = ITroveManager(address(troveManager));
    collateralRegistry = new CollateralRegistry(boldToken, collaterals, troveManagers);
    hintHelpers = new HintHelpers(collateralRegistry);
    multiTroveGetter = new MultiTroveGetter(collateralRegistry);
    IAddressesRegistry.AddressVars memory finalVars = IAddressesRegistry.AddressVars({collToken: IERC20Metadata(address(collToken)), borrowerOperations: IBorrowerOperations(address(borrowerOperations)), troveManager: ITroveManager(address(troveManager)), troveNFT: ITroveNFT(address(troveNFT)), metadataNFT: IMetadataNFT(address(metadataNFT)), stabilityPool: IStabilityPool(address(stabilityPool)), priceFeed: IPriceFeed(address(priceFeed)), activePool: IActivePool(address(activePool)), defaultPool: IDefaultPool(address(defaultPool)), gasPoolAddress: address(gasPool), collSurplusPool: ICollSurplusPool(address(collSurplusPool)), sortedTroves: ISortedTroves(address(sortedTroves)), interestRouter: IInterestRouter(address(interestRouter)), hintHelpers: IHintHelpers(address(hintHelpers)), multiTroveGetter: IMultiTroveGetter(address(multiTroveGetter)), collateralRegistry: ICollateralRegistry(address(collateralRegistry)), boldToken: IBoldToken(address(boldToken)), WETH: IWETH(address(collToken))});
    addressesRegistry.setAddresses(finalVars);
    boldToken.setBranchAddresses(address(troveManager), address(stabilityPool), address(borrowerOperations), address(activePool));
    boldToken.setCollateralRegistry(address(collateralRegistry));
    address[] memory approvalArray = new address[](4);
    approvalArray[0] = address(borrowerOperations);
    approvalArray[1] = address(activePool);
    approvalArray[2] = address(defaultPool);
    approvalArray[3] = address(stabilityPool);
    address[] memory actors = _getActors();
    uint256 mintAmount = type(uint88).max;
    for (uint256 i; i < actors.length; i++) {
        collToken.mint(actors[i], mintAmount);
        for (uint256 j; j < approvalArray.length; j++) {
            vm.prank(actors[i]);
            collToken.approve(approvalArray[j], type(uint256).max);
        }
    }
}
```

### _addActor(address)

- **Kind**: internal
- **Source**: 1411:250:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_addActor(address)`

```solidity
/// @notice Adds an actor to the list of actors
function _addActor(address target) internal {
    if (_actors.contains(target)) {
        revert ActorExists();
    }
    if (target == address(this)) {
        revert DefaultActor();
    }
    _actors.add(target);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8860:165:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2214:404:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _addAsset(address)

- **Kind**: internal
- **Source**: 1878:160:105
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_addAsset(address)`

```solidity
/// @notice Adds an asset to the list of assets
///  @param target The address of the asset to add
function _addAsset(address target) internal {
    if (_assets.contains(target)) {
        revert Exists();
    }
    _assets.add(target);
}
```

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:104
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:106
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
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

## State Variable Reads

- **collToken** (`contract WETHTester`) [test/TestContracts/WETHTester.sol/contract_WETHTester.md]
- **CCR** (`uint256`)
- **MCR** (`uint256`)
- **BCR** (`uint256`)
- **SCR** (`uint256`)
- **LIQUIDATION_PENALTY_SP** (`uint256`)
- **LIQUIDATION_PENALTY_REDISTRIBUTION** (`uint256`)
- **metadataNFT** (`contract MetadataNFT`) [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]
- **priceFeed** (`contract PriceFeedTestnet`) [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]
- **interestRouter** (`contract MockInterestRouter`) [test/TestContracts/MockInterestRouter.sol/contract_MockInterestRouter.md]
- **boldToken** (`contract BoldToken`) [src/BoldToken.sol/contract_BoldToken.md]
- **troveNFT** (`contract TroveNFT`) [src/TroveNFT.sol/contract_TroveNFT.md]
- **gasPool** (`contract GasPool`) [src/GasPool.sol/contract_GasPool.md]
- **collSurplusPool** (`contract CollSurplusPool`) [src/CollSurplusPool.sol/contract_CollSurplusPool.md]
- **sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]
- **activePool** (`contract ActivePool`) [src/ActivePool.sol/contract_ActivePool.md]
- **defaultPool** (`contract DefaultPool`) [src/DefaultPool.sol/contract_DefaultPool.md]
- **troveManager** (`contract TroveManagerTester`) [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]
- **collateralRegistry** (`contract CollateralRegistry`) [src/CollateralRegistry.sol/contract_CollateralRegistry.md]
- **borrowerOperations** (`contract BorrowerOperationsTester`) [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]
- **stabilityPool** (`contract StabilityPool`) [src/StabilityPool.sol/contract_StabilityPool.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **multiTroveGetter** (`contract MultiTroveGetter`) [src/MultiTroveGetter.sol/contract_MultiTroveGetter.md]
- **addressesRegistry** (`contract AddressesRegistry`) [src/AddressesRegistry.sol/contract_AddressesRegistry.md]
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **collToken** (`contract WETHTester`) [test/TestContracts/WETHTester.sol/contract_WETHTester.md]
- **boldToken** (`contract BoldToken`) [src/BoldToken.sol/contract_BoldToken.md]
- **priceFeed** (`contract PriceFeedTestnet`) [test/TestContracts/PriceFeedTestnet.sol/contract_PriceFeedTestnet.md]
- **interestRouter** (`contract MockInterestRouter`) [test/TestContracts/MockInterestRouter.sol/contract_MockInterestRouter.md]
- **metadataNFT** (`contract MetadataNFT`) [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]
- **troveNFT** (`contract TroveNFT`) [src/TroveNFT.sol/contract_TroveNFT.md]
- **collSurplusPool** (`contract CollSurplusPool`) [src/CollSurplusPool.sol/contract_CollSurplusPool.md]
- **sortedTroves** (`contract SortedTroves`) [src/SortedTroves.sol/contract_SortedTroves.md]
- **gasPool** (`contract GasPool`) [src/GasPool.sol/contract_GasPool.md]
- **activePool** (`contract ActivePool`) [src/ActivePool.sol/contract_ActivePool.md]
- **defaultPool** (`contract DefaultPool`) [src/DefaultPool.sol/contract_DefaultPool.md]
- **borrowerOperations** (`contract BorrowerOperationsTester`) [test/TestContracts/BorrowerOperationsTester.t.sol/contract_BorrowerOperationsTester.md]
- **troveManager** (`contract TroveManagerTester`) [test/TestContracts/TroveManagerTester.t.sol/contract_TroveManagerTester.md]
- **stabilityPool** (`contract StabilityPool`) [src/StabilityPool.sol/contract_StabilityPool.md]
- **collateralRegistry** (`contract CollateralRegistry`) [src/CollateralRegistry.sol/contract_CollateralRegistry.md]
- **hintHelpers** (`contract HintHelpers`) [src/HintHelpers.sol/contract_HintHelpers.md]
- **multiTroveGetter** (`contract MultiTroveGetter`) [src/MultiTroveGetter.sol/contract_MultiTroveGetter.md]
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)
- **_targetedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Setup.setup() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 2)
  │ │   💬 Args: [address(0x100)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 3)
  │ │ │   💬 Args: [_actors, target]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
  │ │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │ │     👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
  │ │     💬 Args: [_actors, target]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
  │ │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │       👁️  Def: private
  │ │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
  │ │         💬 Args: [set, value]
  │ │         👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 8)
  │ │   💬 Args: [address(0x200)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 9)
  │ │ │   💬 Args: [_actors, target]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 10)
  │ │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │ │     👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 11)
  │ │     💬 Args: [_actors, target]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 12)
  │ │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │       👁️  Def: private
  │ │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 13)
  │ │         💬 Args: [set, value]
  │ │         👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 14)
  │ │   💬 Args: [address(collToken)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 15)
  │ │ │   💬 Args: [_assets, target]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 16)
  │ │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │ │     👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 17)
  │ │     💬 Args: [_assets, target]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 18)
  │ │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │ │       👁️  Def: private
  │ │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 19)
  │ │         💬 Args: [set, value]
  │ │         👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 20)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 21)
  │       💬 Args: [_actors]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 22)
  │         💬 Args: [set._inner]
  │         👁️  Def: private
  └─ [1] ⚙️ FUNCTION: StdInvariant.targetContract(address) (NodeID: 23)
      💬 Args: [address(this)]
      👁️  Def: internal
```
