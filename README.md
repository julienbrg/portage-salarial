# Portage Salarial

This contract allows a third-party company (`funder`) to pay a worker on behalf of its `customer`. The `worker` automatically receives his pay every day in cash (DAI). The `customer` has the possibility to hold the payment for 24 hours.

## Before deployment

The `funder` decides:

- who is the `worker`
- who is the `customer`
- what's the total budget
- what's the duration (in days)
- how many times the `customer` can use the `hold()` function

## Deploy

- The `funder` deploys the contract.
- The `funder` manually sends DAIs to the contract.

## Use

Anyone can trigger the `pay()` function at anytime.

#### Funder

- The `funder` can trigger the `pay()` function every day (this can be done automatically).
- The `funder` can't sweep the funds until `active` is false.

#### Worker

- The `worker` doesn't need to do anything.
- The `worker` can trigger the `pay()` function if he needs to. 

#### Customer

- The `customer` can hold the payment for 24 hours using the `hold()` function.
