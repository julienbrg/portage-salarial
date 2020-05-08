# Portage Salarial

This contract allows a third-party company (`funder` aka the 'portage salarial' company) to pay a worker on behalf of its `customer`. The `worker` automatically receives his pay every day in cash. The `customer` has the possibility to hold the payment for 24 hours.

In [this example](https://goerli.etherscan.io/address/0xE9daA252B44B5d8b5CB099Eff25a43de1D155374#tokentxns), we can see that the `worker` got 4,000 EUR (500 per day) instead of 5,000 because the `customer` triggered the `hold()` function twice. The `funder` sweeped the remaining 1,000 EUR.

## Prepare

The `funder` decides:

- who is the `worker`
- who is the `customer`
- what's the total budget
- how many days the contract will last for
- how many times the `customer` can use the `hold()` function

In [Remix](http://remix.ethereum.org/), the arguments should look like this:

> 0xB2be6df007b69B00E18B84E8d7D6eb6C0AfdFdD1,0xcB5438e3B5d1433c9A3C027564C0eD04f2bFc4b6,5000,10,3

## Deploy

- The `funder` deploys the contract.
- The `funder` manually sends DAIs (`value`) to the contract.

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
