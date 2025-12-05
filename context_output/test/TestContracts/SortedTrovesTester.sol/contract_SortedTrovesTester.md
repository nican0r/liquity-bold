# Contract: SortedTrovesTester

## Metadata

- **Name**: SortedTrovesTester
- **Type**: Contract
- **Path**: test/TestContracts/SortedTrovesTester.sol

## State Variables

### sortedTroves

```solidity
ISortedTroves internal sortedTroves
```

**ISortedTroves**: [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

## Public/External Functions

### setSortedTroves(address)

- **Signature**: `setSortedTroves(address)`
- **Visibility**: external
- **Source Range**: 301:131:281
- **Details**: [function_setSortedTroves_address.md](./function_setSortedTroves_address.md)

**Signature:**
```solidity
function setSortedTroves(address _sortedTrovesAddress) external;
```

### insert(uint256,uint256,uint256,uint256)

- **Signature**: `insert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 438:181:281
- **Details**: [function_insert_uint256_uint256_uint256_uint256.md](./function_insert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) external;
```

### remove(uint256)

- **Signature**: `remove(uint256)`
- **Visibility**: external
- **Source Range**: 625:79:281
- **Details**: [function_remove_uint256.md](./function_remove_uint256.md)

**Signature:**
```solidity
function remove(uint256 _id) external;
```

### reInsert(uint256,uint256,uint256,uint256)

- **Signature**: `reInsert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 710:191:281
- **Details**: [function_reInsert_uint256_uint256_uint256_uint256.md](./function_reInsert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) external;
```

### getTroveAnnualInterestRate(uint256)

- **Signature**: `getTroveAnnualInterestRate(uint256)`
- **Visibility**: external
- **Source Range**: 950:102:281
- **Details**: [function_getTroveAnnualInterestRate_uint256.md](./function_getTroveAnnualInterestRate_uint256.md)

**Signature:**
```solidity
function getTroveAnnualInterestRate(uint256) external pure returns (uint256);
```
