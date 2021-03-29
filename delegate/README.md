# How to Become a Delegate

This document guides you through the delegate registration process. In the end, you will be a delegate, you will have a running forger node and you can receive votes.

## Table of Contents <!-- omit in toc -->

-   [Prerequisites](#Prerequisites)
-   [Steps](#Steps)
    -   [1. Connect to Hydra Network](#1.-Connect-to-Hydra-Network)
    -   [2. Create a Profile](#2.-Create-a-Profile)
    -   [3. Create Delegate Address](#3.-Create-Delegate-Address)
    -   [4. Get Hydras](#4.-Get-Hydras)
    -   [5. Register Delegate](#5.-Register-Delegate)
    -   [6. Run Forger](#6.-Run-Forger)
    -   [7. Announce Yourself](#7.-Announce-Yourself-and-Receive-Votes)
-   [Maintainers](#Maintainers)
-   [Contributing](#Contributing)
-   [License](#License)

## Prerequisites

-   A running server (VPS) at a hoster of your choice. You should choose a dual-core machine with at least 8 GB of RAM.

## Steps

### 1. Connect to Hydra Network

Add the Hydra network in your [ARK desktop wallet](https://ark.io/wallet).

For server address use:

-   **devnet:** https://test.explorer.hydraledger.io:4705
-   **mainnet:** https://explorer.hydraledger.io:4705

If you have issues finding peers for some reason, you can connect to a custom peer from [this list](https://github.com/Internet-of-People/hydra-peers/blob/master/mainnet.json)

### 2. Create a Profile

Create a profile for the Hydra network.

**Be sure to select the Hydra network you just created**.

### 3. Create Two Addresses

You have to create an address that will function as your delegate. It is recommended to create at least two addresses, one as the delegate and one address as your "normal" address. The delegate passphrase will be live on an online server, so it is best to keep most of your money on another address

When generating an address, you can choose to encrypt the passphrase on your device by giving a secure password. **Still, do not forget to save your _passphrase_ at a safe place!** If your passphrase is lost, you cannot recover access in any way.

### 4. Get Hydras

To be able to register your address as a delegate, you need to send a registration transaction that costs up to 25 HYDs from it (13 HYD should be enough though).
You can get HYDs on exchanges, by voting for an already registered delegate that shares rewards or maybe even by asking nicely.

Continue when you have at least 13 HYD stored on the delegate address.

### 5. Register Delegate

Now we need to register the delegate name on the network. Click on the button with 3 vertical dots, next to the “Send” button on the delegate's wallet page. You will now see a new series of additional buttons. Click on “Register delegate” to open the form for delegate registrations.

![Registering Delegate](assets/register_delegate.png)

Enter a username and your passphrase (or encrypted password), adjust the fee slider to about 13 HYD (you might need to pay more if the chain is under load) and click “Next”.

![Registering Delegate](assets/register_delegate2.png)
![Registering Delegate](assets/register_delegate3.png)

Now if you head over to your Explorer, the most recent transaction for a delegate registration will be showing there. You can click the wallet name to view the wallet. At the top of the wallet, there will be an area specifically visible for registered delegates on the network.

![Registering Delegate](assets/register_delegate4.png)

### 6. Run Forger

At this point, you have a registered delegate who can now start forging. To do this, you have to start a forger node with your private key.

#### Prepare a Server

It's good if your forger runs 0-24/7, so you need a good server for that. We have a nice little tool called `core-control` shown to us by an ARK delegate, that will help us set up a forger node.

1. First, login to the new server as a non-root user.
1. install git: `sudo apt update && sudo apt install git`
1. clone the repository: `git clone https://github.com/Internet-of-People/core-control -b master`
1. change into the directory: `cd core-control`
1. install hydra-core: `NETWORK=[devnet|mainnet] ./ccontrol.sh install core`
1. enter your delegate passphrase: `NETWORK=[devnet|mainnet] ccontrol secret set word1 word2 ... word12`
1. start forging: `NETWORK=[devnet|mainnet] ccontrol start all`

#### Test Forger

You can check the status of the forger with commands
`NETWORK=[devnet|mainnet] ccontrol status [relay|all]` and `NETWORK=[devnet|mainnet] ccontrol logs [relay|all]`

#### Stop Forger

```bash
`NETWORK=[devnet|mainnet] ccontrol stop all`
```

More commands are listed [here](https://github.com/Internet-of-People/core-control)

### 7. Announce Yourself and Receive Votes

Now you are on the network as a registered delegate and you have a running forger. To become one of the top 53 delegates, you have to receive votes from the rest of the community.

Hence, you should announce your delegate name in forums or chats and ask people to vote on you, as standard dPoS works.

## Maintainers

-   [@mudlee](https://github.com/mudlee)
-   [@wigy_opensource_developer](https://github.com/wigy_opensource_developer)
-   [bartmoss](https://github.com/izolyomi)

## Contributing

PRs that are inline with our goals to the core IOP user experience are
more than welcome. To avoid losing precious time you spend on coding, you could
open an issue first and discuss what you are up to before forking and sending us
a PR.

Small note: If editing the README, please conform to the
[standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

[MIT](https://spdx.org/licenses/MIT)
© 2019 Decentralized Society Foundation, PA
