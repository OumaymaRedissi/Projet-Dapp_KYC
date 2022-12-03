pragma solidity >=0.4.22 <0.7.0;
import "truffle/Assert.sol"; //asserts to be used later
import "truffle/DeployedAddresses.sol"; //this smart contract gets the adresse of the deployed contract
import "../contracts/KYC.sol"; //the smart contract we are working on 

contract TestKYC {
    KYC kyc = KYC(DeployedAddresses.KYC());   // DeployedAddresses.Adoption() get the adresse
    struct kycReq {
        uint256 id;
        uint256 cin;
        uint256 bankCode;
        uint timestamp;
        uint status;//Pending=0 , KYCVerified=1, KYCFailed=2
        string description; 
    }
    struct bank {
        string name;
        string email;
        uint256 bankCode;
        address bankAdress;
        uint16 kycCount; // How many KCY's did this bank completed so far
        uint status; // Active=1,Inactive=0 
    }

    function testRegisterNewBank() public {

        kyc.addBank(
            "ATTIJARI",
            "contact@attijari.tn",
            123,
            msg.sender);
    }    



 
}