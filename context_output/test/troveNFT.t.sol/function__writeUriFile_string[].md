# Function: _writeUriFile(string[])

**Contract**: [test/troveNFT.t.sol/contract_troveNFTTest.md]

## Metadata

- **Contract**: troveNFTTest
- **Signature**: `_writeUriFile(string[])`
- **Visibility**: public
- **Source Range**: 6508:1444:336

## Implementation

```solidity
function _writeUriFile(string[] memory _uris) public {
    string memory pathClean = string.concat("utils/assets/test_output/uris.html");
    try vm.removeFile(pathClean) {} catch {}
    vm.writeLine(pathClean, topMulti);
    string memory uriCombined;
    uriCombined = "const encodedStrings=[";
    for (uint256 i = 0; i < _uris.length; i++) {
        uriCombined = string.concat(uriCombined, "\"", _uris[i], "\",");
    }
    uriCombined = string.concat(uriCombined, "];");
    vm.writeLine(pathClean, string.concat("function processEncodedString(encodedString) { const container = document.createElement(\"div\"); container.className = \"container\"; container.innerHTML = ` <img><pre></pre>`; const output = container.querySelector(\"pre\"); const image = container.querySelector(\"img\"); try { const base64Data = encodedString.split(\",\")[1]; const jsonData = JSON.parse(atob(base64Data)); output.innerText = JSON.stringify(jsonData.attributes, null, 2); image.src = jsonData.image || \"\"; } catch (error) { output.innerText = `Error decoding or parsing JSON: ${error.message}`; } document.body.appendChild(container); } ", uriCombined, "encodedStrings.forEach((encodedString) => { processEncodedString(encodedString); });"));
    vm.writeLine(pathClean, string.concat("</script></body></html>"));
}
```

## External Calls

- **Vm::removeFile(string)**
- **Vm::writeLine(string,string)**

## State Variable Reads

- **topMulti** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: troveNFTTest._writeUriFile(string[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
