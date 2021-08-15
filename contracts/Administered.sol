pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Administered is AccessControl{

  bytes32 public constant ORGAN_DONNER_ROLE = keccak256("ORGAN_DONNER");
  bytes32 public constant ORGAN_APPLICANT_ROLE = keccak256("ORGAN_APPLICANT");
  bytes32 public constant MEDICAL_STUFF_ROLE = keccak256("MEDICAL-STUFF");


  /// @dev Add `root` to the admin role as a member.
  constructor ()
    public
  {
    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _setRoleAdmin(ORGAN_DONNER_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(ORGAN_APPLICANT_ROLE, DEFAULT_ADMIN_ROLE);
    _setRoleAdmin(MEDICAL_STUFF_ROLE, DEFAULT_ADMIN_ROLE);
  }
  
  /// @dev Restricted to members of the admin role.
  modifier onlyAdmin()
  {
    require(isAdmin(msg.sender), "Restricted to admins.");
    _;
  }

  /// @dev Restricted to members of the OrganDonner role.
  modifier onlyOrganDonner()
  {
    require(isOrganDonner(msg.sender), "Restricted to OrganDonner.");
    _;
  }

  /// @dev Restricted to members of the OrganApplicant role.
  modifier onlyOrganApplicant()
  {
    require(isOrganApplicant(msg.sender), "Restricted to OrganApplicant.");
    _;
  }

  /// @dev Restricted to members of the MedicalStuff role.
  modifier onlyMedicalStuff()
  {
    require(isMedicalStuff(msg.sender), "Restricted to MedicalStuff.");
    _;
  }

  modifier onlyPermitedUser()
  {
    require(isMedicalStuff(msg.sender) || isOrganDonner(msg.sender) , "Restricted to MedicalStuff or User.");
    _;
  }


  /// @dev Return `true` if the account belongs to the admin role.
  /// @param account address of account to check is admin.
  function isAdmin(address account) 
    public virtual view returns (bool)
  {
    return hasRole(DEFAULT_ADMIN_ROLE, account);
  }

  /// @dev Return `true` if the account belongs to the OrganDonner role.
  /// @param account address of account to check is OrganDonner.
  function isOrganDonner(address account)
    public virtual view returns (bool)
  {
    return hasRole(ORGAN_DONNER_ROLE, account);
  }

  /// @dev Return `true` if the account belongs to the OrganApplicant role.
  /// @param account address of account to check is OrganApplicant.
  function isOrganApplicant(address account)
    public virtual view returns (bool)
  {
    return hasRole(ORGAN_APPLICANT_ROLE, account);
  }

  /// @dev Return `true` if the account belongs to the MedicalStuff role.
  /// @param account address of account to check is MedicalStuff.
  function isMedicalStuff(address account)
    public virtual view returns (bool)
  {
    return hasRole(MEDICAL_STUFF_ROLE, account);
  }

 
  /// @dev Add an account to the admin role. Restricted to admins.
  /// @param account address of account to Add as Admin.
  function addAdmin(address account)
    public virtual 
    onlyAdmin
  {
    grantRole(DEFAULT_ADMIN_ROLE, account);
  }

  /// @dev Add an account to the OrganDonner role. 
  /// @param account address of account to to Add as OrganDonner.
  function addOrganDonner(address account)
    public virtual 
  {
    grantRole(ORGAN_DONNER_ROLE, account);
  }

  /// @dev Add an account to the OrganApplicant role. Restricted to admins.
  /// @param account address of account to to Add as OrganApplicant.
  function addOrganApplicant(address account)
    public virtual 
  {
    grantRole(ORGAN_APPLICANT_ROLE, account);
  }

   /// @dev Add an account to the MedicalStuff role.
   /// @param account address of account to Add as MedicalStuff.
  function addMedicalStuff(address account)
    public virtual 
  {
    grantRole(MEDICAL_STUFF_ROLE, account);
  }

  
  /// @dev Remove oneself from the admin role.
  function renounceAdmin()
    public virtual
  {
    renounceRole(DEFAULT_ADMIN_ROLE, msg.sender);
  }

  /// @dev Remove an account from the OrganDonner role. Restricted to admins.
  /// @param account address of account to Remove.
  function removeOrganDonner(address account)
    public virtual 
  {
    revokeRole(ORGAN_DONNER_ROLE, account);
  }

  /// @dev Remove an account from the OrganApplicant role. Restricted to admins.
  /// @param account address of account to Remove.
  function removeOrganApplicant(address account)
    public virtual 
  {
    revokeRole(ORGAN_APPLICANT_ROLE, account);
  }

  /// @dev Remove an account from the MedicalStuff role.
  /// @param account address of account to Remove.
  function removeMedicalStuff(address account)
    public virtual 
  {
    revokeRole(MEDICAL_STUFF_ROLE, account);
  }

  /// @dev get OrganDonnerCount. Restricted to Admins.
  /// @return OrganDonner Count.
  function getOrganDonnerCount()
  public virtual view 
  returns (uint)
  {
    return getRoleMemberCount(ORGAN_DONNER_ROLE);
  }

  /// @dev get OrganApplicantCount. Restricted to Admins.
  /// @return OrganApplicant Count.
  function getOrganApplicantCount()
  public virtual view 
  returns (uint)
  {
    return getRoleMemberCount(ORGAN_APPLICANT_ROLE);
  }

  /// @return MedicalStuff Count.
  function getMedicalStuffCount()
  public virtual view 
  returns (uint)
  {
    return getRoleMemberCount(MEDICAL_STUFF_ROLE);
  }

  /// @return OrganDonner Member.
  function getOrganDonner(uint256 index)
  public virtual view
  returns (address)
  {
    return getRoleMember(ORGAN_DONNER_ROLE,index);
  }

  /// @return OrganApplicant Member.
  function getOrganApplicant(uint256 index)
  public virtual view
  returns (address)
  {
    return getRoleMember(ORGAN_APPLICANT_ROLE,index);
  }

  /// @dev get MedicalStuff.
  /// @return MedicalStuff Member.
  function getMedicalStuff(uint256 index)
  public virtual view 
  returns (address)
  {
    return getRoleMember(MEDICAL_STUFF_ROLE,index);
  }
}
