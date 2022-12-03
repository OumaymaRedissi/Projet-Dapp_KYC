pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

contract KYC{
    address public owner = msg.sender;
    
    // ----------------------Structure-------------------------
    struct customer {
        uint256 cin;
        string name;
        string email;
        uint256 mobileNumber;
        string description; // description du customer
        uint timestamp; // horaire de l'enregistrement sur la blockchain
        uint status;//ok=1 ou no=0
    }
    struct bank {
        string name;
        string email;
        uint256 bankCode;
        address bankAddress;
        uint16 kycCount; // How many KCY's did this bank completed so far
        uint status; // Active=1,Inactive=0 
    }
    struct kycReq {
        uint256 id;
        uint256 cin;
        uint256 bankCode;
        uint timestamp;
        uint status;//Pending=0 , KYCVerified=1, KYCFailed=2
        string description; 
    }

    //---------------Listes-----------------------------------
    //--all customers
    customer[] all_customers ; 
    uint  number_customers ; 
    //--all banks
    bank[] all_banks ; 
    uint  number_banks ;
    //--all kycRequest
    kycReq[] all_kycReqs ; 
    uint  number_kycReqs ;
    


   //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
   constructor() public {
        number_customers=0 ; 
        number_banks=0 ; 

       
   }
    //*********************CUSTOMER*********************************************
    event addCustomerE(uint256 cin,string name,string email,uint256 mobileNumber,string description,uint timestamp, uint status);


    function addCustomer(uint256 cin,string memory name,string memory email,uint256 mobileNumber,string memory description) public{
        number_customers+=1;
        all_customers.push(customer(cin,name,email,mobileNumber,description,block.timestamp,1));
        emit addCustomerE(cin,name,email,mobileNumber,description,block.timestamp,1);
        }

    function getAllCustomers() public view returns(customer[] memory CS){
        return all_customers;
    }

    function getCustomerByCIN(uint256 c) public view returns(customer memory CS){
        for (uint256 i = 0; i < number_customers; i++) 
            if ( all_customers[i].cin == c ) {
                return all_customers[i];
            }       
        }

    function getStateOfCustomer(uint256 c) public view returns(uint stat){
        for (uint256 i = 0; i < number_customers; i++) 
            if ( all_customers[i].cin == c ) {
                stat = all_customers[i].status;
                return all_customers[i].status;
            }       
        }

    function getCustomersCount() public view returns(uint256){
        return number_customers;
    }
    //*********************BANK*********************************************

    event addBankE(string name,string email,uint256 bankCode,address bankAddress,uint16 kycCount,uint status);

    function addBank(string memory name,string memory email,uint256 bankCode,address bankAddress) public{
        number_banks+=1;
        all_banks.push(bank(name, email,bankCode,bankAddress,0,0));
        emit addBankE(name, email,bankCode,bankAddress,0,0);
        }

    function getAllBanks() public view returns(bank[] memory){
        return all_banks;
    }

    function getBankBybankCode(uint256 c) public view returns(bank memory BN){
        for (uint256 i = 0; i < number_banks; i++) 
            if ( all_banks[i].bankCode == c ) {
                return all_banks[i];
            }       
        }
    function getBankBybankAddress(address c) public view returns(bank memory BN){
        for (uint256 i = 0; i < number_banks; i++) 
            if ( all_banks[i].bankAddress == c ) {
                return all_banks[i];
            }       
        }
    function getStateOfBank( uint256 c) public view returns(uint stat){
        for (uint256 i = 0; i < number_banks; i++) 
            if ( all_banks[i].bankCode == c ) {
                return all_banks[i].status;
            }       
        }

    function getBanksCount() public view returns(uint256){
        return number_banks;
    }
    //*********************KYCRequest*********************************************
    event addKycReqE(uint256 id,uint256 cin,uint256 bankCode,uint timestamp,uint status,string description);


    function addKycReq(uint256 id,uint256 cin,uint256 bankCode,string memory description) public{
        number_kycReqs+=1;
        all_kycReqs.push(kycReq(id,cin,bankCode,block.timestamp,0,description));
        emit addKycReqE(id,cin,bankCode,block.timestamp,0,description);
        }

    function approvingKycReq(uint256 id) public view returns(kycReq memory kyc_temp ){        
        for (uint256 i = 0; i < number_kycReqs; i++) 
            if ( all_kycReqs[i].id == id ) {
                kyc_temp = all_kycReqs[i];
            }   
        if(getStateOfCustomer(kyc_temp.cin)==1){
            kyc_temp.status ==2;
        }
    }

    function getKycReqs() public view returns(kycReq[] memory kycreqs){
        return all_kycReqs;
    }

    function getKycReqByCIN(uint256 c) public view returns(kycReq memory kycreq){
        for (uint256 i = 0; i < number_kycReqs; i++) 
            if ( all_kycReqs[i].cin == c ) {
                return all_kycReqs[i];
            }       
        }
    function getKycReqByBankCode(uint256 c) public view returns(kycReq memory kycreq){
        for (uint256 i = 0; i < number_kycReqs; i++) 
            if ( all_kycReqs[i].bankCode == c ) {
                return all_kycReqs[i];
            }       
        }

    function getStateOfKycReq(uint256 c) public view returns(uint status){
        for (uint256 i = 0; i < number_kycReqs; i++) 
            if ( all_kycReqs[i].cin == c ) {
                return all_kycReqs[i].status;
            }       
        }

    function getKycReqCount() public view returns(uint256 nbr){
        return number_kycReqs;
    }


}