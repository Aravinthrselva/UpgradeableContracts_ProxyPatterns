# UpgradeableContracts_ProxyPatterns
smart contracts are immutable - but proxy patterns can be used to modify functionality of main contracts

/* 
1. We first get the LW3NFT and LW3NFT2 instance using the getContractFactory 

2. hre.upgrades.deployProxy 
This function comes from the @openzeppelin/hardhat-upgrades library

2.1 It uses the upgrades class to call the deployProxy function and specifies the kind as uups
it deploys the Proxy Contract & the LW3NFT Contract (Implementation contract) and connects them both.
(Note that the initialize function can be named anything
its just that deployProxy calls the function with name initialize by default for the initializer --- but you can modify it by changing the defaults)

3. After deploying, we test that the contract actually gets deployed 
by calling the ownerOf function for Token ID 1 
and checking if the NFT was indeed minted.

4. hre.upgrades.upgradeProxy(proxyContract, LW3NFT2); 
Now the next part comes in where we deploy LW3NFT2 which is the upgraded contract of LW3NFT.
we execute the upgradeProxy method again from the @openzeppelin/hardhat-upgrades library 
which upgrades and replaces LW3NFT with LW3NFT2 without changing the state of the system

--To test if it was actually replaced we call the test() function, 
and ensured that it returned "upgraded" even though that function wasn't present in the original LW3NFT contract.

Read
Timelocks	https://blog.openzeppelin.com/protect-your-users-with-smart-contract-timelocks/
Access control	https://docs.openzeppelin.com/contracts/3.x/access-control
*/
