# Echidna Run Failure Fix

## Issue Identified

### Root Cause: Incompatible Cheatcode in TestDeployer

Echidna fails to deploy the CryticTester contract with the following error:

```
error BadCheatCode "Cannot understand cheatcode." 0xd930a0e6
error Revert 0x
```

### Analysis

The fuzzing setup (`test/recon/Setup.sol`) uses `TestDeployer` from `test/TestContracts/Deployment.t.sol` to deploy all protocol contracts. This was done intentionally to:
1. Avoid code duplication
2. Maintain consistency with unit tests  
3. Simplify maintenance

However, `TestDeployer` was written for **Foundry tests** and uses Foundry-specific cheatcodes that are **not supported by Echidna's Hevm implementation**.

### Configuration Issue Fixed

Before addressing the cheatcode issue, there was also a configuration problem with `echidna.yaml`:

**Original (Broken) Configuration:**
```yaml
cryticArgs: ["--compile-force-framework=foundry", "--foundry-out-dir=out", "--foundry-ignore-compile"]
```

**Problem:** The `--foundry-ignore-compile` flag tells crytic-compile to skip compilation and load pre-compiled artifacts from `out/`. However, crytic-compile 0.3.8 has a bug where it expects artifacts in a different JSON format than what Foundry produces, causing:
```
KeyError: 'output'
```

**Fixed Configuration:**
```yaml
cryticArgs: ["--compile-force-framework=foundry", "--foundry-compile-all"]
quiet: false
```

**Changes:**
1. Removed `--foundry-ignore-compile` (causes KeyError)
2. Added `--foundry-compile-all` (compiles everything, ~68 seconds)
3. Changed `quiet: false` to see verbose output during debugging

### Compilation Performance

With `--foundry-compile-all`:
- **Compilation time:** ~68 seconds
- **Slither analysis:** ~107 seconds
- **Total startup time:** ~175 seconds (acceptable for fuzzing campaigns)

This is much faster than the previous attempts with `--foundry-ignore-compile` which would hang indefinitely.

## Solution Options

### Option 1: Remove TestDeployer Dependency (Recommended)

Modify `test/recon/Setup.sol` to deploy contracts directly without using `TestDeployer`. This requires:

1. **Create a Minimal Deployment Function**
   - Deploy only the contracts needed for fuzzing
   - Avoid Foundry-specific cheatcodes (mockCall, expectEmit, etc.)
   - Use only Echidna-supported cheatcodes: `prank`, `deal`, `warp`, `roll`, `store`, `load`

2. **Identify Unsupported Cheatcodes in TestDeployer**
   ```bash
   grep -r "vm\." test/TestContracts/Deployment.t.sol | \
     grep -v "prank\|deal\|warp\|roll\|store\|load\|sign\|addr" 
   ```

3. **Rewrite Deployment Logic**
   - Extract deployment steps from TestDeployer
   - Remove test-specific logic (mocking, expectations)
   - Ensure compatibility with Echidna's Hevm

### Option 2: Conditional Deployment (Alternative)

Keep TestDeployer but add conditional logic to detect Echidna vs Foundry:

```solidity
contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    function setup() internal virtual override {
        // Check if running under Echidna
        bool isEchidna = _isEchidna();
        
        if (isEchidna) {
            // Use simplified deployment compatible with Echidna
            _deployForEchidna();
        } else {
            // Use TestDeployer for Foundry tests
            _deployWithTestDeployer();
        }
        
        // Common setup continues...
    }
    
    function _isEchidna() private view returns (bool) {
        // Echidna uses specific deployer addresses
        // Check if msg.sender matches Echidna's deployer
        return msg.sender == address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    }
}
```

### Option 3: Fork TestDeployer (Quick Fix)

Create `test/recon/EchidnaDeployer.sol` by copying TestDeployer and removing unsupported cheatcodes:

1. Copy `test/TestContracts/Deployment.t.sol` → `test/recon/EchidnaDeployer.sol`
2. Remove all `vm.mockCall`, `vm.expectEmit`, `vm.expectRevert`, etc.
3. Keep only `vm.prank`, `vm.deal`, `vm.warp`, `vm.roll`
4. Update Setup.sol to use EchidnaDeployer instead

## Echidna-Supported Cheatcodes

Based on `/lib/chimera/src/Hevm.sol`, Echidna supports:

**Fully Supported:**
- `vm.prank(address)` - Impersonate sender for next call
- `vm.deal(address, uint256)` - Set ETH balance
- `vm.warp(uint256)` - Set block.timestamp
- `vm.roll(uint256)` - Set block.number
- `vm.store(address, bytes32, bytes32)` - Set storage slot
- `vm.load(address, bytes32)` - Read storage slot
- `vm.sign(uint256, bytes32)` - Sign message with private key
- `vm.addr(uint256)` - Get address from private key
- `vm.assume(bool)` - Add fuzzing assumption
- `vm.label(address, string)` - Label address for output
- `vm.etch(address, bytes)` - Set contract bytecode
- `vm.createFork(string)` - Create fork (limited support)
- `vm.selectFork(uint256)` - Select active fork

**NOT Supported (will cause "BadCheatCode" error):**
- `vm.mockCall()` - Mock function calls
- `vm.expectEmit()` - Expect event emission  
- `vm.expectRevert()` - Expect revert
- `vm.expectCall()` - Expect function call
- `vm.startPrank()` - Start persistent prank
- `vm.stopPrank()` - Stop persistent prank
- `vm.recordLogs()` - Record emitted logs
- `vm.getRecordedLogs()` - Get recorded logs
- Any other advanced Foundry cheatcodes

## Recommended Next Steps

1. **Immediate Action:** Implement Option 3 (Fork TestDeployer)
   - Fastest path to get Echidna running
   - Minimal changes to existing setup
   - Can refactor later

2. **Steps to Implement:**
   ```bash
   # 1. Create EchidnaDeployer
   cp test/TestContracts/Deployment.t.sol test/recon/EchidnaDeployer.sol
   
   # 2. Edit EchidnaDeployer.sol - remove unsupported cheatcodes
   # (Manual editing required)
   
   # 3. Update Setup.sol
   # Replace: import {TestDeployer} from "test/TestContracts/Deployment.t.sol";
   # With: import {EchidnaDeployer} from "./EchidnaDeployer.sol";
   
   # 4. Test compilation
   forge build
   
   # 5. Test Echidna
   echidna . --contract CryticTester --config echidna.yaml
   ```

3. **Verification:**
   - Echidna should complete deployment without cheatcode errors
   - Contract initialization should succeed
   - Fuzzing campaign should begin

## Current echidna.yaml Configuration

```yaml
testMode: "assertion"
prefix: "echidna_"
coverage: true
corpusDir: "echidna"
balanceAddr: 0x1043561a8829300000
balanceContract: 0x1043561a8829300000
filterFunctions: []
cryticArgs: ["--compile-force-framework=foundry", "--foundry-compile-all"]
deployer: "0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38"
contractAddr: "0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496"
shrinkLimit: 100000
solcArgs: "--optimize --optimize-runs 200"
quiet: false
```

## Summary

**Status:** Configuration fixed, but deployment fails due to unsupported cheatcodes in TestDeployer

**Root Cause:** TestDeployer uses Foundry-specific cheatcodes not supported by Echidna

**Solution:** Create EchidnaDeployer that only uses Echidna-supported cheatcodes

**Progress:**
- ✅ Fixed compilation issue (removed `--foundry-ignore-compile`)
- ✅ Echidna compiles contracts successfully (~68 seconds)
- ✅ Echidna completes Slither analysis (~107 seconds)
- ✅ Echidna finds CryticTester contract
- ❌ Deployment fails with BadCheatCode error
- ⏳ Need to implement EchidnaDeployer

**Next Action:** Implement Option 3 - Fork TestDeployer to create EchidnaDeployer

---

## Technical Details

### Error Output
```
[2025-12-05 12:58:58.66] Compiling .... Done! (67.281538s)
Analyzing contract: /path/to/CryticTester.sol:CryticTester
[2025-12-05 13:00:08.14] Running slither on .... Done! (107.249608s)
echidna: Deploying the contract 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496 failed (revert, out-of-gas, sending ether to an non-payable constructor, etc.):
OwnershipTransferred() from: 0xffd4505b3452dc22f8473616d50503ba9e1710ac
OwnershipTransferred() from: 0xab51e03ffe3144d97837db7b929bafd16fd94fe8
OwnershipTransferred() from: 0x3c8ca53ee5661d29d3d3c0732689a4b86947eaf0
BaseRateUpdated(1000000000000000000) from: 0x76006c4471fb6add17728e9c9c8b67d5af06cda0
error BadCheatCode "Cannot understand cheatcode." 0xd930a0e6
error Revert 0x
```

### Environment
- **Echidna Version:** 2.2.6
- **crytic-compile Version:** 0.3.8
- **Forge Version:** 1.2.3-stable
- **Platform:** macOS
- **Project:** Liquity Bold (283 contracts)

### Related Files
- `echidna.yaml` - Fixed configuration
- `test/recon/Setup.sol` - Calls TestDeployer (needs EchidnaDeployer)
- `test/TestContracts/Deployment.t.sol` - Contains unsupported cheatcodes
- `lib/chimera/src/Hevm.sol` - Defines supported cheatcodes
