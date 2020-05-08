pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract PortageSalarial {

    address public worker;
    address public customer;
    address public funder;

    bool public active;

    ERC20 public EUR;

    uint256 public value;
    uint256 public amount;
    uint256 public duration;
    uint256 public start;
    uint256 public holdUntil;
    uint256 public paid;
    uint256 public delay;
    uint256 public lastPaid;
    uint256 public maxDelay;

    constructor (
        address payable _worker, address _customer, uint256 _value, uint256 _duration, uint256 _maxDelay) public payable {
        EUR = ERC20(0xA3133F602FF612054025000eAA6E665cF1f78A60);
        funder = msg.sender;
        worker = _worker;
        customer = _customer;
        duration = _duration;
        maxDelay = _maxDelay;
        value = _value * 10 ** 18 ;
        amount = value / duration;
        active = true;
        start = now;
        lastPaid = now;
    }

    function hold() public {
        require (active == true);
        require (msg.sender == customer);
        require (now >= holdUntil);
        require (maxDelay > delay);
        holdUntil = now + 24 seconds;
        delay += 1;
        if (paid + delay >= duration) {
            active = false;
        }
    }

    function pay() public {
        require (active == true);
        require (now >= holdUntil);
        require (now >= lastPaid + 24 seconds);
        EUR.transfer(worker, amount);
        lastPaid = now;
        paid += 1;
        if (paid + delay >= duration) {
            active = false;
        }
    }

    function sweep() public {
        require (active == false);
        require (msg.sender == funder);
        EUR.transfer(funder, EUR.balanceOf(address(this)));
    }

    function timeLeft() public view returns(uint256) {
        return lastPaid + 24 seconds - now;
    }

    function checkHold() public view returns(uint256) {
        return holdUntil - now;
    }

    function EURbalance() public view returns (uint256) {
        return EUR.balanceOf(address(this));
    }
}
