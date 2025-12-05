# Interface: IWeightedPoolFactory

## Metadata

- **Name**: IWeightedPoolFactory
- **Type**: Interface
- **Path**: script/Interfaces/Balancer/IWeightedPool.sol

## Public/External Functions

### create(string,string,contract IERC20[],uint256[],contract IRateProvider[],uint256,address,bytes32)

- **Signature**: `create(string,string,contract IERC20[],uint256[],contract IRateProvider[],uint256,address,bytes32)`
- **Visibility**: external
- **Source Range**: 203:315:118

**Signature:**
```solidity
function create(string memory name, string memory symbol, IERC20[] memory tokens, uint256[] memory normalizedWeights, IRateProvider[] memory rateProviders, uint256 swapFeePercentage, address owner, bytes32 salt) external returns (IWeightedPool);;
```
