pragma solidity ^0.4.16;

contract owned {
    address public owner;

    function owned()  public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner  public {
        owner = newOwner;
    }

}

contract DongerBank is owned { 
    uint currentDongerId;
    Donger[] public dongers;
    mapping (address => uint) public dongerBoardId;
    DongerBoard[] public dongerBoards;

    event Voted(uint dongerId, address boardClient);
    event DongerAdded(string unicode, string commonName);

    struct DongerBoard {
        address boardClient;
        string name;
        uint memberSince;
    }

    struct Donger {
        string unicode;
        string commonName;
        uint recordedSince;
        uint numberOfVotes;
    }

    function DongerBank() payable public {
        currentDongerId = 0;
        addDonger(hex"C2AF5C5F28E38384295F2FC2AF", "shrug");
    }

    function addDonger(string unicode, string commonName) {
        currentDongerId = dongers.length++;
        Donger storage d = dongers[currentDongerId];
        d.unicode = unicode;
        d.commonName = commonName;
        d.recordedSince = now;
        d.numberOfVotes = 0;
        DongerAdded(unicode, commonName);
    }

    function voteDongers(uint dongerId) public returns (uint voteID) {
        Donger storage d = dongers[dongerId];
        // require(!d.voted[msg.sender]) TODO: not sure if needed/what does
        d.numberOfVotes++;
        Voted(dongerId, msg.sender);
        return d.numberOfVotes;
    }

    function getDongerById(uint id) constant returns (string commonName) {
        Donger storage d = dongers[id];
        return d.commonName;
    }
}

