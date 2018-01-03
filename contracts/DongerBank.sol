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

contract tokenRecipient {
    event receivedEther(address sender, uint amount);
    event receivedTokens(address _from, uint256 _value, address _token, bytes _extraData);

    function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public {
        Token t = Token(_token);
        require(t.transferFrom(_from, this, _value));
        receivedTokens(_from, _value, _token, _extraData);
    }

    function () payable  public {
        receivedEther(msg.sender, msg.value);
    }
}

interface Token {
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
}

contract DongerBank is owned, tokenRecepient { 
    event Voted(uint dongerId, bool position, address boardClient, string justification);

    struct DongerBoard {
        address boardClient;
        string name;
        // Start unicode sequence in solidity with \uNNNN
        uint memberSince;
    }

    struct Donger {
        string unicode;
        uint dongerId;
        unint ranking;
        Vote[] votes;
    }

    struct Vote {
        bool inSupport;
        address voter;
        string justification;
    }

}

