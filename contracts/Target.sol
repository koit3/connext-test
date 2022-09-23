pragma solidity ^0.8.14;

contract Target {
  string public greeting;

  function updateGreeting(string calldata newGreeting) external {
    greeting = newGreeting;
  }
}
