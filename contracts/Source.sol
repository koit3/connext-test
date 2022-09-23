pragma solidity ^0.8.14;

import {IConnextHandler} from "@connext/nxtp-contracts/contracts/core/connext/interfaces/IConnextHandler.sol";
import {CallParams, XCallArgs} from "@connext/nxtp-contracts/contracts/core/connext/libraries/LibConnextStorage.sol";

contract Source {
  // ConnextHandler contract on origin domain
  IConnextHandler public connext = IConnextHandler(0xB4C1340434920d70aD774309C75f9a4B679d801e); 

  // Function that the user will call
  function updateGreeting (address target, string memory newGreeting) external {
    // We're sending calldata, so encode the target function with its arguments
    bytes4 selector = bytes4(keccak256("updateGreeting(string)"));
    bytes memory callData = abi.encodeWithSelector(selector, newGreeting);

    CallParams memory callParams = CallParams({
      to: target, // address of the target contract
      callData: callData, // encoded calldata to execute on destination
      originDomain: 1735353714, // from Goerli
      destinationDomain: 1735356532, // to Optimism-Goerli
      agent: msg.sender, // address allowed to execute transaction on destination side in addition to relayers
      recovery: msg.sender, // fallback address to send funds to if execution fails on destination side
      forceSlow: false, // option to force slow path instead of paying 0.05% fee on fast liquidity transfers
      receiveLocal: false, // option to receive the local bridge-flavored asset instead of the adopted asset
      callback: address(0), // zero address because we're not using a callback
      callbackFee: 0, // fee paid to relayers for the callback; no fees on testnet
      relayerFee: 0, // fee paid to relayers for the forward call; no fees on testnet
      destinationMinOut: 0 // not sending funds so minimum can be 0
    });

    XCallArgs memory xcallArgs = XCallArgs({
      params: callParams,
      transactingAsset: address(0), // 0 address is the native gas token
      transactingAmount: 0, // not sending funds with this calldata-only xcall
      originMinOut: 0 // not sending funds so minimum can be 0
    });

    connext.xcall(xcallArgs);
  }
}
