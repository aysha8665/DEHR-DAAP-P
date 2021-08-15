pragma solidity ^0.8.0;

import "./Administered.sol";

contract DEHR is Administered{

enum BlodType{
  A_POSITIVE,
  A_NEGATIVE,
  B_POSITIVE,
  B_NEGATIVE,
  AB_POSITIVE,
  AB_NEGATIVE,
  O_POSITIVE,
  O_NEGATIVE
}
  struct UserInfo{
    uint date;
    string hashing;
  }
  enum OfferStatus
  {
    AVAILABLE,
    PENDING,
    ACCEPTED,
    REJECTED,
    Donated,
    CANCEL
  }

  struct DonateOffer{
    string gen;
    BlodType blodType;
    string someOtherInfo;
    bool done;
    OfferStatus offerStatus;
    address donnerAddress;
    address organapplicant;
  }


  mapping (uint => DonateOffer) private donateOffers; 
  mapping (uint => address)  private donners;
  mapping (uint => address)  private organapplicant;
  mapping (address => UserInfo[]) private userInfo; 

  int32 private donnersCount;
  int32 private totalDonateOffer;
  int32 private userCount;
  int32 private medicalStuffCount;


  constructor() public 
  {

    /* Here, set the owner as the person who instantiated the contract
       and set your idCount to 0. */
     _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    //_setupRole(MARKET_ADMIN_ROLE, msg.sender);
    _setRoleAdmin(USER_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(MEDICAL_STUFF_ROLE, DEFAULT_ADMIN_ROLE);
      
  }

    function AddInfo(string hash) public
    {
        userInfo[msg.sender].push(now, hash);

    }
    function GetGenHashInfo(string hash) public
    {
        return userInfo[msg.sender][0].hashing;
    }


    function CreateDonateOffer( string _gen, 
    BlodType _blodType, 
    string _someOtherInfo,
    OfferStatus _offerStatus
    ) public
    {
        DonateOffer donateOffer;
        donateOffer.gen=_gen;
        donateOffer.blodType=_blodType;
        donateOffer.someOtherInfo=_someOtherInfo;
        donateOffer.OfferStatus= _offerStatus;
    }

    function getDonateOffer() public returns(DonateOffer[])
    {
        return donateOffer[msg.sender];
    }

    function getDonateOffer() public
    {

    }


    function getMatchedDonateOffer() public returns(DonateOffer[])
    {

        UserInfo currentUserInfo=userInfo[msg.sender];
        // currentUserInfo.hashing read from ipfs

        for(int i=0; i< totalDonateOffer; i++ )
        {
          for(int j=0; i< donnersCount; j++ )
          {
              donateOffers[i][donners[j]];
              //moghayese
          }
        }
        //return null;
    }

  function DonateRequest(uint donateOfferId) public
  {
     donateOffers[donateOfferId].organapplicant=msg.sender;
     donateOffers[donateOfferId].offerStatus=OfferStatus.PENDING;
  }

  function AcceptOffer(uint donateOfferId) public
  {
      donateOffers[donateOfferId].offerStatus=OfferStatus.ACCEPTED;

  }

  function RejectOffer(uint donateOfferId) public
  {
      donateOffers[donateOfferId].offerStatus=OfferStatus.REJECTED;
  }

  function CancelOffer(uint donateOfferId) public
  {
      donateOffers[donateOfferId].offerStatus=OfferStatus.CANCEL;
  }
  function ReadUserInfo(address _userAddress)
  onlyPermitedUser
  public
  {
      //read from ipfs
  }

  
}