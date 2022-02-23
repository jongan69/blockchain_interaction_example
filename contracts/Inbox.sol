pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";


contract Inbox {

    using SafeMath for uint256;
    using Counters for Counters.Counter;
    using Strings for uint256;

    //Structure
    mapping(string => string) public ipfsInbox;
    //Events
    event ipfsSent(string _ipfsHash, string _address);

    event inboxResponse(string response);

    //Modifiers
    modifier notFull(string memory _string) {
        bytes memory stringTest = bytes(_string);
        require(stringTest.length == 0);
        _;
    }

    // An empty constructor that creates an instance of the contract
    constructor() {}

    //takes in receiver's address and IPFS hash. Places the IPFSadress in the receiver's inbox
    function sendIPFS(string memory _address, string memory _ipfsHash)
        public
        notFull(ipfsInbox[_address])
    {
        ipfsInbox[_address] = _ipfsHash;
        emit ipfsSent(_ipfsHash, _address);
    }

    // retrieves hash
    function getHash(string memory _address)
        public
        view
        returns (string memory)
    {
        string memory ipfs_hash = ipfsInbox[_address];
        //emit inboxResponse(ipfs_hash);
        return ipfs_hash;
    }
}
