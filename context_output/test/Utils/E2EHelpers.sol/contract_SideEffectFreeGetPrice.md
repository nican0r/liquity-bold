# Contract: SideEffectFreeGetPrice

## Metadata

- **Name**: SideEffectFreeGetPrice
- **Type**: Contract
- **Path**: test/Utils/E2EHelpers.sol

## State Variables

### vm

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### helperDeployer

```solidity
address private constant helperDeployer = 0x9C82588e2B9229168aDbb55E730e0d20c0581a3B
```

### helper

```solidity
SideEffectFreeGetPriceHelper private constant helper = SideEffectFreeGetPriceHelper(0xc583097AE39B039fA74bB5bd6479469290B7cDe5)
```

**SideEffectFreeGetPriceHelper**: [test/Utils/E2EHelpers.sol/contract_SideEffectFreeGetPriceHelper.md]
