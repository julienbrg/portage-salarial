pragma solidity ^0.6.0;

contract PortageSalarial {

    address payable worker;
    address public customer;
    address public funder;

    uint public value;
    uint public amount;
    uint public duration;
    uint public start;
    bool public active;
    uint public holdUntil;
    uint public paid;
    uint public delay;
    uint public lastPaid;

    constructor (
        address payable _worker, address _customer, uint _duration) public payable {
        funder = msg.sender;
        worker = _worker;
        customer = _customer;
        duration = _duration;
        active = true;
        start = now;
        value = msg.value;
        amount = value/duration;
        holdUntil = now;
        lastPaid = now;
    }

    function hold() public {
        require (active == true);
        require (msg.sender == customer);
        require (now >= holdUntil);
        holdUntil = now + 24 hours;
        delay += 1;
        if (paid+delay >= duration) {
            active = false;
        }
    }

    function pay() public {
        require (active == true);
        require (now >= holdUntil);
        require (now >= lastPaid + 23 hours);
        worker.transfer(amount);
        lastPaid = now;
        paid += 1;
        if (paid+delay >= duration) {
            active = false;
        }
    }

    function sweep() public {
        require (active == false);
        require (msg.sender == funder);
        msg.sender.transfer(address(this).balance);
    }
}
