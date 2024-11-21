# **Thorn protocol Audit Competition on Hats.finance** 


## Introduction to Hats.finance


Hats.finance builds autonomous security infrastructure for integration with major DeFi protocols to secure users' assets. 
It aims to be the decentralized choice for Web3 security, offering proactive security mechanisms like decentralized audit competitions and bug bounties. 
The protocol facilitates audit competitions to quickly secure smart contracts by having auditors compete, thereby reducing auditing costs and accelerating submissions. 
This aligns with their mission of fostering a robust, secure, and scalable Web3 ecosystem through decentralized security solutions​.

## About Hats Audit Competition


Hats Audit Competitions offer a unique and decentralized approach to enhancing the security of web3 projects. Leveraging the large collective expertise of hundreds of skilled auditors, these competitions foster a proactive bug hunting environment to fortify projects before their launch. Unlike traditional security assessments, Hats Audit Competitions operate on a time-based and results-driven model, ensuring that only successful auditors are rewarded for their contributions. This pay-for-results ethos not only allocates budgets more efficiently by paying exclusively for identified vulnerabilities but also retains funds if no issues are discovered. With a streamlined evaluation process, Hats prioritizes quality over quantity by rewarding the first submitter of a vulnerability, thus eliminating duplicate efforts and attracting top talent in web3 auditing. The process embodies Hats Finance's commitment to reducing fees, maintaining project control, and promoting high-quality security assessments, setting a new standard for decentralized security in the web3 space​​.

## Thorn protocol Overview

Privately Swap Stablecoins and Go Cross-chain with AI Wallet

## Competition Details


- Type: A public audit competition hosted by Thorn protocol
- Duration: 2 weeks
- Maximum Reward: $43,716.45
- Submissions: 115
- Total Payout: $32,581.87 distributed among 6 participants.

## Scope of Audit

## Project overview
Thorn Protocol is a specialized Stableswap built on Oasis Sapphire, designed to exchange stablecoins and similarly priced assets with minimal slippage and low transaction fees.

Our platform offers users a seamless, efficient trading experience with advanced functions while ensuring the highest level of privacy through Sapphire's confidential state features.

## Audit competition scope

The list of files included in the test scope is listed below.

```
|-- contracts/
     |-- StableSwapRouter.sol 
     |-- stableSwap/
          |-- StableSwapFactory.sol
          |-- StableSwapLP.sol
          |-- StableSwapLPFactory.sol
          |-- StableSwapThreePoolDeployer.sol
          |-- StableSwapTwoPoolDeployer.sol
               |-- plain-pools
                    |-- StableSwapThreePool.sol
                    |-- StableSwapTwoPool.sol
```

## High severity issues


- **Vulnerability in StableSwapFactory allows unauthorized admin takeover through repeated initialization**

  The contract `StableSwapFactory.sol` has a critical flaw allowing anyone to assume the admin role. The flaw lies in the `initialize()` function, which can be called multiple times by any user, each time altering the admin and other critical settings without restriction. This oversight permits an attacker to seize admin privileges, thereby gaining control over functions restricted to the admin. With this unauthorized access, the attacker can create swap pairs with arbitrarily set parameters like exchange fees, and mint an unlimited amount of `StableSwapLP` tokens by setting up their own addresses within deploying contracts. The vulnerability further extends to permitting unauthorized access to deployers and factories intended only for admin use, potentially compromising the entire framework of deployed pools and liquidity tokens. A potential mitigation involves modifying the `initialize()` function to include a check that ensures it can only be executed once, securing the admin role against unauthorized reassignment. Despite arguments regarding the severity of the issue, the ability for the rightful owner to reclaim the admin role doesn't diminish the initial security risk posed by an unauthorized takeover, especially if it leads to the redirection of user assets and disruption of normal operations within the protocol.


  **Link**: [Issue #1](https://github.com/hats-finance/Thorn-protocol-0x1286ecdac50215a366458a14968fbca4bd95067d/issues/1)

## Medium severity issues


- **Lack of Convergence Check in StableSwapTwoPool's get_D Function Can Break Pool**

  The `get_D` function in the StableSwapTwoPool contract is vulnerable because it does not verify if Newton's method converges when calculating the pool's invariant. This can result in an inaccurate invariant, potentially breaking the pool and leading to a loss of funds for liquidity providers (LPs). Although non-convergence of Newton's method is rare, its occurrence could severely impact the pool's functionality. An improved implementation from Curve's team could be referenced to address this issue. The revised code now includes a check to prevent execution if the method fails to converge. The importance level of the issue was raised to medium after considering the potential impact, despite its low likelihood. Additional proof of the potential non-convergence is being sought for further validation.


  **Link**: [Issue #52](https://github.com/hats-finance/Thorn-protocol-0x1286ecdac50215a366458a14968fbca4bd95067d/issues/52)

## Low severity issues


- **StableSwapRouter event emits incorrect amountIn parameter value during swaps**

  The `exactInputStableSwap` function in the StableSwapRouter contract emits the `StableExchange` event with an incorrect `amountIn` value. The function takes the balance of the contract for swaps, leading to discrepancies when the input value differs from the contract's balance. The event should reflect the actual `msg.value` provided. A code change to update `amountIn` to match `msg.value` is recommended. This inconsistency may arise from accidental ether transfers to the router. The development team recognizes this as a bug.


  **Link**: [Issue #35](https://github.com/hats-finance/Thorn-protocol-0x1286ecdac50215a366458a14968fbca4bd95067d/issues/35)


- **Undefined pause functionality in StableSwap deployers and recommended mitigation steps**

  `StableSwapTwoPoolDeployer` and `StableSwapThreePoolDeployer` contracts are designed to be pausable, but lack the necessary functions in the `StableSwapFactory` to actually pause or unpause them. This missing functionality could lead to an exploit, preventing the contracts from being paused as intended. It is recommended to add the required pause/unpause functions to the factory contract. The debate centers around whether this constitutes a vulnerability or simply incomplete functionality, with no apparent immediate security risk.


  **Link**: [Issue #14](https://github.com/hats-finance/Thorn-protocol-0x1286ecdac50215a366458a14968fbca4bd95067d/issues/14)


- **Missing `whenNotPaused` Modifier in SwapTwoPoolDeployer and StableSwapLPFactory Functions**

  The contracts `SwapTwoPoolDeployer` and `StableSwapLPFactory` lack the `whenNotPaused` modifier, unlike `SwapThreePoolDeployer`, leading to potential deployment of pairs and LPs even when paused. This inconsistency undermines the pausable feature's intent, allowing certain actions despite being paused. It was debated if this oversight should be considered a bug, given the owner's exclusive control over affected functions. Nonetheless, recommendations suggest modifying these contracts or potentially removing the irrelevant `Pausable` contract.


  **Link**: [Issue #11](https://github.com/hats-finance/Thorn-protocol-0x1286ecdac50215a366458a14968fbca4bd95067d/issues/11)



## Conclusion

The audit of the Thorn Protocol conducted under the Hats.finance framework reveals a decentralized and effective approach to identifying vulnerabilities in smart contracts. The competition, which ran for two weeks, attracted 115 submissions, resulting in a total payout of $32,581.87. Critical issues identified include a major vulnerability in the StableSwapFactory contract allowing unauthorized admin takeover through repeated initialization. Medium severity issues involved a lack of convergence checks in the StableSwapTwoPool's get_D function, posing potential risks to liquidity pools. Several low-severity issues were noted, such as incorrect event emission in the StableSwapRouter and incomplete pausing functionality in various deployer contracts. These findings underscore the effectiveness of decentralized audit competitions in uncovering vulnerabilities, aligning with Hats.finance's goal to enhance Web3 security. Adaptations to address these risks, such as enhancing function convergence checks and event parameter accuracy, were recommended to fortify the protocol, reflecting Hats' commitment to setting new standards for quality and security in decentralized environments.

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts.


The Thorn protocol audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.


Hats.finance does not provide any guarantee or warranty regarding the security of this project. Smart contract software should be used at the sole risk and responsibility of users.

