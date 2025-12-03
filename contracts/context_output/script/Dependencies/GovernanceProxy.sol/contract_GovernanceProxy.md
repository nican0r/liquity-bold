# Contract: GovernanceProxy

## Metadata

- **Name**: GovernanceProxy
- **Type**: Contract
- **Path**: script/Dependencies/GovernanceProxy.sol

## Implements Interfaces

- **IMultiDelegateCall** [lib/V2-gov/src/interfaces/IMultiDelegateCall.sol/interface_IMultiDelegateCall.md]
- **IUserProxyFactory** [lib/V2-gov/src/interfaces/IUserProxyFactory.sol/interface_IUserProxyFactory.md]
- **IGovernance** [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]

## State Variables

### governance

```solidity
Governance public immutable governance
```

**Governance**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

### lqty

```solidity
IERC20 public immutable lqty
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### bold

```solidity
IERC20 public immutable bold
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Structs

### Configuration (inherited from IGovernance)

```solidity
struct Configuration {
    uint256 registrationFee;
    uint256 registrationThresholdFactor;
    uint256 unregistrationThresholdFactor;
    uint256 unregistrationAfterEpochs;
    uint256 votingThresholdFactor;
    uint256 minClaim;
    uint256 minAccrual;
    uint256 epochStart;
    uint256 epochDuration;
    uint256 epochVotingCutoff;
}
```

### VoteSnapshot (inherited from IGovernance)

```solidity
struct VoteSnapshot {
    uint256 votes;
    uint256 forEpoch;
}
```

### InitiativeVoteSnapshot (inherited from IGovernance)

```solidity
struct InitiativeVoteSnapshot {
    uint256 votes;
    uint256 forEpoch;
    uint256 lastCountedEpoch;
    uint256 vetos;
}
```

### Allocation (inherited from IGovernance)

```solidity
struct Allocation {
    uint256 voteLQTY;
    uint256 voteOffset;
    uint256 vetoLQTY;
    uint256 vetoOffset;
    uint256 atEpoch;
}
```

### UserState (inherited from IGovernance)

```solidity
struct UserState {
    uint256 unallocatedLQTY;
    uint256 unallocatedOffset;
    uint256 allocatedLQTY;
    uint256 allocatedOffset;
}
```

### InitiativeState (inherited from IGovernance)

```solidity
struct InitiativeState {
    uint256 voteLQTY;
    uint256 voteOffset;
    uint256 vetoLQTY;
    uint256 vetoOffset;
    uint256 lastEpochClaim;
}
```

### GlobalState (inherited from IGovernance)

```solidity
struct GlobalState {
    uint256 countedVoteLQTY;
    uint256 countedVoteOffset;
}
```

## Events

### DepositLQTY (inherited from IGovernance)

```solidity
/// @notice Emitted when a user deposits LQTY
///  @param user The account depositing LQTY
///  @param rewardRecipient The account receiving the LUSD/ETH rewards earned from staking in V1, if claimed
///  @param lqtyAmount The amount of LQTY being deposited
///  @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
///  @return lusdSent Amount of LUSD tokens sent to `rewardRecipient` (may include previously received LUSD)
///  @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
///  @return ethSent Amount of ETH sent to `rewardRecipient` (may include previously received ETH)
event DepositLQTY(address indexed user, address rewardRecipient, uint256 lqtyAmount, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);
```

### WithdrawLQTY (inherited from IGovernance)

```solidity
/// @notice Emitted when a user withdraws LQTY or claims V1 staking rewards
///  @param user The account withdrawing LQTY or claiming V1 staking rewards
///  @param recipient The account receiving the LQTY withdrawn, and if claimed, the LUSD/ETH rewards earned from staking in V1
///  @return lqtyReceived Amount of LQTY tokens actually withdrawn (may be lower than the `_lqtyAmount` passed to `withdrawLQTY`)
///  @return lqtySent Amount of LQTY tokens sent to `recipient` (may include LQTY sent to the user's proxy from sources other than V1 staking)
///  @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
///  @return lusdSent Amount of LUSD tokens sent to `recipient` (may include previously received LUSD)
///  @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
///  @return ethSent Amount of ETH sent to `recipient` (may include previously received ETH)
event WithdrawLQTY(address indexed user, address recipient, uint256 lqtyReceived, uint256 lqtySent, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);
```

### SnapshotVotes (inherited from IGovernance)

```solidity
event SnapshotVotes(uint256 votes, uint256 forEpoch, uint256 boldAccrued);
```

### SnapshotVotesForInitiative (inherited from IGovernance)

```solidity
event SnapshotVotesForInitiative(address indexed initiative, uint256 votes, uint256 vetos, uint256 forEpoch);
```

### RegisterInitiative (inherited from IGovernance)

```solidity
event RegisterInitiative(address initiative, address registrant, uint256 atEpoch, HookStatus hookStatus);
```

### UnregisterInitiative (inherited from IGovernance)

```solidity
event UnregisterInitiative(address initiative, uint256 atEpoch, HookStatus hookStatus);
```

### AllocateLQTY (inherited from IGovernance)

```solidity
event AllocateLQTY(address indexed user, address indexed initiative, int256 deltaVoteLQTY, int256 deltaVetoLQTY, uint256 atEpoch, HookStatus hookStatus);
```

### ClaimForInitiative (inherited from IGovernance)

```solidity
event ClaimForInitiative(address indexed initiative, uint256 bold, uint256 forEpoch, HookStatus hookStatus);
```

### DeployUserProxy (inherited from IUserProxyFactory)

```solidity
event DeployUserProxy(address indexed user, address indexed userProxy);
```

## Enums

### HookStatus (inherited from IGovernance)

```solidity
enum HookStatus {
    Failed,
    Succeeded,
    NotCalled
}
```

### InitiativeStatus (inherited from IGovernance)

```solidity
enum InitiativeStatus {
    NONEXISTENT,
    WARM_UP,
    SKIP,
    CLAIMABLE,
    CLAIMED,
    UNREGISTERABLE,
    DISABLED
}
```

## Public/External Functions

### constructor(contract Governance)

- **Signature**: `constructor(contract Governance)`
- **Visibility**: public
- **Source Range**: 733:342:110
- **Details**: [function_constructor_contract_Governance.md](./function_constructor_contract_Governance.md)

**Signature:**
```solidity
constructor(Governance _governance);
```

### registerInitialInitiatives(address[])

- **Signature**: `registerInitialInitiatives(address[])`
- **Visibility**: external
- **Source Range**: 1081:136:110
- **Details**: [function_registerInitialInitiatives_address[].md](./function_registerInitialInitiatives_address[].md)

**Signature:**
```solidity
function registerInitialInitiatives(address[] memory) override external pure;
```

### stakingV1()

- **Signature**: `stakingV1()`
- **Visibility**: external
- **Source Range**: 1223:113:110
- **Details**: [function_stakingV1.md](./function_stakingV1.md)

**Signature:**
```solidity
function stakingV1() override external view returns (ILQTYStaking);
```

### EPOCH_START()

- **Signature**: `EPOCH_START()`
- **Visibility**: external
- **Source Range**: 1342:112:110
- **Details**: [function_EPOCH_START.md](./function_EPOCH_START.md)

**Signature:**
```solidity
function EPOCH_START() override external view returns (uint256);
```

### EPOCH_DURATION()

- **Signature**: `EPOCH_DURATION()`
- **Visibility**: external
- **Source Range**: 1460:118:110
- **Details**: [function_EPOCH_DURATION.md](./function_EPOCH_DURATION.md)

**Signature:**
```solidity
function EPOCH_DURATION() override external view returns (uint256);
```

### EPOCH_VOTING_CUTOFF()

- **Signature**: `EPOCH_VOTING_CUTOFF()`
- **Visibility**: external
- **Source Range**: 1584:128:110
- **Details**: [function_EPOCH_VOTING_CUTOFF.md](./function_EPOCH_VOTING_CUTOFF.md)

**Signature:**
```solidity
function EPOCH_VOTING_CUTOFF() override external view returns (uint256);
```

### MIN_CLAIM()

- **Signature**: `MIN_CLAIM()`
- **Visibility**: external
- **Source Range**: 1718:108:110
- **Details**: [function_MIN_CLAIM.md](./function_MIN_CLAIM.md)

**Signature:**
```solidity
function MIN_CLAIM() override external view returns (uint256);
```

### MIN_ACCRUAL()

- **Signature**: `MIN_ACCRUAL()`
- **Visibility**: external
- **Source Range**: 1832:112:110
- **Details**: [function_MIN_ACCRUAL.md](./function_MIN_ACCRUAL.md)

**Signature:**
```solidity
function MIN_ACCRUAL() override external view returns (uint256);
```

### REGISTRATION_FEE()

- **Signature**: `REGISTRATION_FEE()`
- **Visibility**: external
- **Source Range**: 1950:122:110
- **Details**: [function_REGISTRATION_FEE.md](./function_REGISTRATION_FEE.md)

**Signature:**
```solidity
function REGISTRATION_FEE() override external view returns (uint256);
```

### REGISTRATION_THRESHOLD_FACTOR()

- **Signature**: `REGISTRATION_THRESHOLD_FACTOR()`
- **Visibility**: external
- **Source Range**: 2078:148:110
- **Details**: [function_REGISTRATION_THRESHOLD_FACTOR.md](./function_REGISTRATION_THRESHOLD_FACTOR.md)

**Signature:**
```solidity
function REGISTRATION_THRESHOLD_FACTOR() override external view returns (uint256);
```

### UNREGISTRATION_THRESHOLD_FACTOR()

- **Signature**: `UNREGISTRATION_THRESHOLD_FACTOR()`
- **Visibility**: external
- **Source Range**: 2232:152:110
- **Details**: [function_UNREGISTRATION_THRESHOLD_FACTOR.md](./function_UNREGISTRATION_THRESHOLD_FACTOR.md)

**Signature:**
```solidity
function UNREGISTRATION_THRESHOLD_FACTOR() override external view returns (uint256);
```

### UNREGISTRATION_AFTER_EPOCHS()

- **Signature**: `UNREGISTRATION_AFTER_EPOCHS()`
- **Visibility**: external
- **Source Range**: 2390:144:110
- **Details**: [function_UNREGISTRATION_AFTER_EPOCHS.md](./function_UNREGISTRATION_AFTER_EPOCHS.md)

**Signature:**
```solidity
function UNREGISTRATION_AFTER_EPOCHS() override external view returns (uint256);
```

### VOTING_THRESHOLD_FACTOR()

- **Signature**: `VOTING_THRESHOLD_FACTOR()`
- **Visibility**: external
- **Source Range**: 2540:136:110
- **Details**: [function_VOTING_THRESHOLD_FACTOR.md](./function_VOTING_THRESHOLD_FACTOR.md)

**Signature:**
```solidity
function VOTING_THRESHOLD_FACTOR() override external view returns (uint256);
```

### boldAccrued()

- **Signature**: `boldAccrued()`
- **Visibility**: external
- **Source Range**: 2682:112:110
- **Details**: [function_boldAccrued.md](./function_boldAccrued.md)

**Signature:**
```solidity
function boldAccrued() override external view returns (uint256);
```

### votesSnapshot()

- **Signature**: `votesSnapshot()`
- **Visibility**: external
- **Source Range**: 2800:140:110
- **Details**: [function_votesSnapshot.md](./function_votesSnapshot.md)

**Signature:**
```solidity
function votesSnapshot() override external view returns (uint256 votes, uint256 forEpoch);
```

### votesForInitiativeSnapshot(address)

- **Signature**: `votesForInitiativeSnapshot(address)`
- **Visibility**: external
- **Source Range**: 2946:273:110
- **Details**: [function_votesForInitiativeSnapshot_address.md](./function_votesForInitiativeSnapshot_address.md)

**Signature:**
```solidity
function votesForInitiativeSnapshot(address _initiative) override external view returns (uint256 votes, uint256 forEpoch, uint256 lastCountedEpoch, uint256 vetos);
```

### userStates(address)

- **Signature**: `userStates(address)`
- **Visibility**: external
- **Source Range**: 3225:255:110
- **Details**: [function_userStates_address.md](./function_userStates_address.md)

**Signature:**
```solidity
function userStates(address _user) override external view returns (uint256 unallocatedLQTY, uint256 unallocatedOffset, uint256 allocatedLQTY, uint256 allocatedOffset);
```

### initiativeStates(address)

- **Signature**: `initiativeStates(address)`
- **Visibility**: external
- **Source Range**: 3486:279:110
- **Details**: [function_initiativeStates_address.md](./function_initiativeStates_address.md)

**Signature:**
```solidity
function initiativeStates(address _initiative) override external view returns (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, uint256 lastEpochClaim);
```

### globalState()

- **Signature**: `globalState()`
- **Visibility**: external
- **Source Range**: 3771:155:110
- **Details**: [function_globalState.md](./function_globalState.md)

**Signature:**
```solidity
function globalState() override external view returns (uint256 countedVoteLQTY, uint256 countedVoteOffset);
```

### lqtyAllocatedByUserToInitiative(address,address)

- **Signature**: `lqtyAllocatedByUserToInitiative(address,address)`
- **Visibility**: external
- **Source Range**: 3932:324:110
- **Details**: [function_lqtyAllocatedByUserToInitiative_address_address.md](./function_lqtyAllocatedByUserToInitiative_address_address.md)

**Signature:**
```solidity
function lqtyAllocatedByUserToInitiative(address _user, address _initiative) override external view returns (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, uint256 atEpoch);
```

### registeredInitiatives(address)

- **Signature**: `registeredInitiatives(address)`
- **Visibility**: external
- **Source Range**: 4262:170:110
- **Details**: [function_registeredInitiatives_address.md](./function_registeredInitiatives_address.md)

**Signature:**
```solidity
function registeredInitiatives(address _initiative) override external view returns (uint256 atEpoch);
```

### depositLQTY(uint256)

- **Signature**: `depositLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 4438:112:110
- **Details**: [function_depositLQTY_uint256.md](./function_depositLQTY_uint256.md)

**Signature:**
```solidity
function depositLQTY(uint256 _lqtyAmount) override external;
```

### depositLQTY(uint256,bool,address)

- **Signature**: `depositLQTY(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 4556:181:110
- **Details**: [function_depositLQTY_uint256_bool_address.md](./function_depositLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) override external;
```

### depositLQTYViaPermit(uint256,struct PermitParams)

- **Signature**: `depositLQTYViaPermit(uint256,struct PermitParams)`
- **Visibility**: external
- **Source Range**: 4743:144:110
- **Details**: [function_depositLQTYViaPermit_uint256_struct_PermitParams.md](./function_depositLQTYViaPermit_uint256_struct_PermitParams.md)

**Signature:**
```solidity
function depositLQTYViaPermit(uint256, PermitParams calldata) override external pure;
```

### depositLQTYViaPermit(uint256,struct PermitParams,bool,address)

- **Signature**: `depositLQTYViaPermit(uint256,struct PermitParams,bool,address)`
- **Visibility**: external
- **Source Range**: 4893:159:110
- **Details**: [function_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md](./function_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md)

**Signature:**
```solidity
function depositLQTYViaPermit(uint256, PermitParams calldata, bool, address) override external pure;
```

### withdrawLQTY(uint256)

- **Signature**: `withdrawLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 5058:114:110
- **Details**: [function_withdrawLQTY_uint256.md](./function_withdrawLQTY_uint256.md)

**Signature:**
```solidity
function withdrawLQTY(uint256 _lqtyAmount) override external;
```

### withdrawLQTY(uint256,bool,address)

- **Signature**: `withdrawLQTY(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 5178:183:110
- **Details**: [function_withdrawLQTY_uint256_bool_address.md](./function_withdrawLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) override external;
```

### claimFromStakingV1(address)

- **Signature**: `claimFromStakingV1(address)`
- **Visibility**: external
- **Source Range**: 5367:215:110
- **Details**: [function_claimFromStakingV1_address.md](./function_claimFromStakingV1_address.md)

**Signature:**
```solidity
function claimFromStakingV1(address _rewardRecipient) override external returns (uint256 lusdSent, uint256 ethSent);
```

### epoch()

- **Signature**: `epoch()`
- **Visibility**: external
- **Source Range**: 5588:100:110
- **Details**: [function_epoch.md](./function_epoch.md)

**Signature:**
```solidity
function epoch() override external view returns (uint256);
```

### epochStart()

- **Signature**: `epochStart()`
- **Visibility**: external
- **Source Range**: 5694:110:110
- **Details**: [function_epochStart.md](./function_epochStart.md)

**Signature:**
```solidity
function epochStart() override external view returns (uint256);
```

### secondsWithinEpoch()

- **Signature**: `secondsWithinEpoch()`
- **Visibility**: external
- **Source Range**: 5810:126:110
- **Details**: [function_secondsWithinEpoch.md](./function_secondsWithinEpoch.md)

**Signature:**
```solidity
function secondsWithinEpoch() override external view returns (uint256);
```

### lqtyToVotes(uint256,uint256,uint256)

- **Signature**: `lqtyToVotes(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5942:264:110
- **Details**: [function_lqtyToVotes_uint256_uint256_uint256.md](./function_lqtyToVotes_uint256_uint256_uint256.md)

**Signature:**
```solidity
function lqtyToVotes(uint256 _lqtyAmount, uint256 _timestamp, uint256 _offset) override external pure returns (uint256);
```

### calculateVotingThreshold()

- **Signature**: `calculateVotingThreshold()`
- **Visibility**: external
- **Source Range**: 6212:133:110
- **Details**: [function_calculateVotingThreshold.md](./function_calculateVotingThreshold.md)

**Signature:**
```solidity
function calculateVotingThreshold() override external returns (uint256);
```

### calculateVotingThreshold(uint256)

- **Signature**: `calculateVotingThreshold(uint256)`
- **Visibility**: external
- **Source Range**: 6351:158:110
- **Details**: [function_calculateVotingThreshold_uint256.md](./function_calculateVotingThreshold_uint256.md)

**Signature:**
```solidity
function calculateVotingThreshold(uint256 _votes) override external view returns (uint256);
```

### getTotalVotesAndState()

- **Signature**: `getTotalVotesAndState()`
- **Visibility**: external
- **Source Range**: 6515:234:110
- **Details**: [function_getTotalVotesAndState.md](./function_getTotalVotesAndState.md)

**Signature:**
```solidity
function getTotalVotesAndState() override external view returns (VoteSnapshot memory snapshot, GlobalState memory state, bool shouldUpdate);
```

### getInitiativeSnapshotAndState(address)

- **Signature**: `getInitiativeSnapshotAndState(address)`
- **Visibility**: external
- **Source Range**: 6755:360:110
- **Details**: [function_getInitiativeSnapshotAndState_address.md](./function_getInitiativeSnapshotAndState_address.md)

**Signature:**
```solidity
function getInitiativeSnapshotAndState(address _initiative) override external view returns (InitiativeVoteSnapshot memory initiativeSnapshot, InitiativeState memory initiativeState, bool shouldUpdate);
```

### getLatestVotingThreshold()

- **Signature**: `getLatestVotingThreshold()`
- **Visibility**: external
- **Source Range**: 7121:138:110
- **Details**: [function_getLatestVotingThreshold.md](./function_getLatestVotingThreshold.md)

**Signature:**
```solidity
function getLatestVotingThreshold() override external view returns (uint256);
```

### snapshotVotesForInitiative(address)

- **Signature**: `snapshotVotesForInitiative(address)`
- **Visibility**: external
- **Source Range**: 7265:274:110
- **Details**: [function_snapshotVotesForInitiative_address.md](./function_snapshotVotesForInitiative_address.md)

**Signature:**
```solidity
function snapshotVotesForInitiative(address _initiative) override external returns (VoteSnapshot memory voteSnapshot, InitiativeVoteSnapshot memory initiativeVoteSnapshot);
```

### getInitiativeState(address)

- **Signature**: `getInitiativeState(address)`
- **Visibility**: external
- **Source Range**: 7545:244:110
- **Details**: [function_getInitiativeState_address.md](./function_getInitiativeState_address.md)

**Signature:**
```solidity
function getInitiativeState(address _initiative) override external returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount);
```

### getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)

- **Signature**: `getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 7795:458:110
- **Details**: [function_getInitiativeState_address_struct_IGovernance.VoteSnapshot_struct_IGovernance.InitiativeVoteSnapshot_struct_IGovernance.InitiativeState.md](./function_getInitiativeState_address_struct_IGovernance.VoteSnapshot_struct_IGovernance.InitiativeVoteSnapshot_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
function getInitiativeState(address _initiative, VoteSnapshot memory _votesSnapshot, InitiativeVoteSnapshot memory _votesForInitiativeSnapshot, InitiativeState memory _initiativeState) override external view returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount);
```

### registerInitiative(address)

- **Signature**: `registerInitiative(address)`
- **Visibility**: external
- **Source Range**: 8259:126:110
- **Details**: [function_registerInitiative_address.md](./function_registerInitiative_address.md)

**Signature:**
```solidity
function registerInitiative(address _initiative) override external;
```

### unregisterInitiative(address)

- **Signature**: `unregisterInitiative(address)`
- **Visibility**: external
- **Source Range**: 8391:130:110
- **Details**: [function_unregisterInitiative_address.md](./function_unregisterInitiative_address.md)

**Signature:**
```solidity
function unregisterInitiative(address _initiative) override external;
```

### allocateLQTY(address[],address[],int256[],int256[])

- **Signature**: `allocateLQTY(address[],address[],int256[],int256[])`
- **Visibility**: external
- **Source Range**: 8527:330:110
- **Details**: [function_allocateLQTY_address[]_address[]_int256[]_int256[].md](./function_allocateLQTY_address[]_address[]_int256[]_int256[].md)

**Signature:**
```solidity
function allocateLQTY(address[] calldata _resetInitiatives, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory absoluteLQTYVetos) override external;
```

### resetAllocations(address[],bool)

- **Signature**: `resetAllocations(address[],bool)`
- **Visibility**: external
- **Source Range**: 8863:167:110
- **Details**: [function_resetAllocations_address[]_bool.md](./function_resetAllocations_address[]_bool.md)

**Signature:**
```solidity
function resetAllocations(address[] calldata _initiativesToReset, bool _checkAll) external;
```

### claimForInitiative(address)

- **Signature**: `claimForInitiative(address)`
- **Visibility**: external
- **Source Range**: 9036:159:110
- **Details**: [function_claimForInitiative_address.md](./function_claimForInitiative_address.md)

**Signature:**
```solidity
function claimForInitiative(address _initiative) override external returns (uint256 claimed);
```

### userProxyImplementation()

- **Signature**: `userProxyImplementation()`
- **Visibility**: external
- **Source Range**: 9201:136:110
- **Details**: [function_userProxyImplementation.md](./function_userProxyImplementation.md)

**Signature:**
```solidity
function userProxyImplementation() override external view returns (address);
```

### deriveUserProxyAddress(address)

- **Signature**: `deriveUserProxyAddress(address)`
- **Visibility**: external
- **Source Range**: 9343:152:110
- **Details**: [function_deriveUserProxyAddress_address.md](./function_deriveUserProxyAddress_address.md)

**Signature:**
```solidity
function deriveUserProxyAddress(address _user) override external view returns (address);
```

### deployUserProxy()

- **Signature**: `deployUserProxy()`
- **Visibility**: external
- **Source Range**: 9501:132:110
- **Details**: [function_deployUserProxy.md](./function_deployUserProxy.md)

**Signature:**
```solidity
function deployUserProxy() override external returns (address userProxyAddress);
```

### multiDelegateCall(bytes[])

- **Signature**: `multiDelegateCall(bytes[])`
- **Visibility**: external
- **Source Range**: 9639:168:110
- **Details**: [function_multiDelegateCall_bytes[].md](./function_multiDelegateCall_bytes[].md)

**Signature:**
```solidity
function multiDelegateCall(bytes[] calldata inputs) override external returns (bytes[] memory returnValues);
```
