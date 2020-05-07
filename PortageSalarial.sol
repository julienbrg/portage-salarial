pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract PortageSalarial {

    address public worker;
    address public customer;
    address public funder;

    bool public active;

    ERC20 public DAI;

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
        funder = msg.sender;
        worker = _worker;
        customer = _customer;
        duration = _duration;
        active = true;
        start = now;
        value = _value * 10 ** 18 ;
        amount = value / duration;
        lastPaid = now;
        maxDelay = _maxDelay;
        DAI = ERC20(0x7cc7E7D8547a813077CD97DC00848C81F4d8bD0e);
    }

    function hold() public {
        require (active == true);
        require (msg.sender == customer);
        require (now >= holdUntil);
        require (maxDelay > delay);
        holdUntil = now + 24 hours;
        delay += 1;
        if (paid + delay >= duration) {
            active = false;
        }
    }

    function pay() public {
        require (active == true);
        require (now >= holdUntil);
        require (now >= lastPaid + 24 hours);
        DAI.transfer(worker, amount);
        lastPaid = now;
        paid += 1;
        if (paid + delay >= duration) {
            active = false;
        }
    }

    function sweep() public {
        require (active == false);
        require (msg.sender == funder);
        DAI.transfer(funder, address(this).balance);
    }

    function timeLeft() public view returns(uint256) {
        return lastPaid + 24 hours - now;
    }

    function checkHold() public view returns(uint256) {
        return holdUntil - now;
    }

    function daiBalance() public view returns (uint256) {
        return DAI.balanceOf(address(this));
    }
}
