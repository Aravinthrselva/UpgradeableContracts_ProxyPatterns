// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";



contract LW3NFT is Initializable, ERC721Upgradeable, UUPSUpgradeable, OwnableUpgradeable {

    // we create an initialize function and then add the
    // initializer modifier which ensure that the
    // initialize function is only called once -- acting just like a constrcutor


    function initialize() public initializer {
        
        // Note how instead of using the ERC721() constructor, we have to manually initialize it
        // Same goes for the Ownable contract where we have to manually initialize it

        __ERC721_init("AvantG", "AG-NFT");
        __Ownable_init();
        _mint(msg.sender, 1);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

}


/* 

If you look at all the contracts which LW3NFT is importing, you will realize why they are important. 

1.First being the Initializable contract from Openzeppelin which provides us with the initializer modifier 
which ensures that the initialize function is only called once


2. The initialize function is needed because we cant have a constructor in the Implementation Contract,
 which in this case is the LW3NFT contract

3. It imports ERC721Upgradeable and OwnableUpgradeable because 
the original ERC721 and Ownable contracts have a constructor which CANNOT be used with proxy contracts.

4. Lastly we have the UUPSUpgradeable Contract which provides us with the upgradeTo(address) function 
which has to be put on the Implementation Contract in case of a UUPS proxy pattern.


5.  Also note that the new way in which we are initializing ERC721 and Ownable contract. 
This is the standard way of initializing upgradeable contracts

6. Another interesting function which we dont see in the normal ERC721 contract is the _authorizeUpgrade 
which is a function which needs to be implemented by the developer 
when they import the UUPSUpgradeable Contract from Openzeppelin

7. Now why this function has to be overwritten is intresting because 
it gives us the ability to add authorization on who can actually upgrade the given contract, 
it can be changed according to requirements but in our case we just added an onlyOwner modifier.



8. okay we are done with writing the Implementation Contract, 
do we now need to write the Proxy Contract as well?

Good news is nope, we dont need to write the Proxy Contract because 
Openzeppelin deploys and connects a Proxy Contract automatically when we use their library to deploy the Implementation Contract.

*/ 

