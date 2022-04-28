pragma solidity >=0.4.22 <0.7.0;

contract CoinFlipGame {
    address owner;

    mapping(address => uint256) public balances;

    struct Bet {
        bool finalresult;
        bool completed;
        uint256 betamount;
        uint256 bet;
        uint256 winningprice;
    }

    event Win(address user, uint256 amount);

    mapping(address => Bet) public allbets;

    function FlipGame() public payable {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (owner != msg.sender) {
            revert();
        } else {
            _;
        }
    }

    function AddBalance() public payable {
        msg.sender.transfer(1);
        balances[msg.sender] = 1;
    }

    function AllowBet(uint256 _amount, uint256 _bet) public payable {
        _amount = msg.value;
        if (allbets[msg.sender].completed == false) {
            revert();
        }
        if (_amount > balances[msg.sender]) {
            revert();
        } else {
            Bet memory newBet;
            newBet.betamount = _amount;
            newBet.bet = _bet;
            newBet.winningprice = 0;
            newBet.finalresult = false;
            newBet.completed = false;
            allbets[msg.sender] = newBet;
            balances[msg.sender] -= _amount;
            msg.sender.call.value(_amount);
        }
    }

    function vrf() public view returns (bytes32 finalresult) {
        uint256[1] memory bn;
        bn[0] = block.number;
        assembly {
            let memPtr := mload(0x40)
            if iszero(staticcall(not(0), 0xff, bn, 0x20, memPtr, 0x20)) {
                invalid()
            }
            finalresult := mload(memPtr)
        }
    }

    function RewardBets() public payable {
        uint256 randomBet = uint256(this.vrf());

        if (
            ((randomBet % 2) == 0 && allbets[msg.sender].bet == 0) ||
            ((randomBet % 2) == 1 && allbets[msg.sender].bet == 1)
        ) {
            if (address(this).balance < (allbets[msg.sender].betamount * 2)) {
                // Emit event at win
                emit Win(msg.sender, allbets[msg.sender].betamount);
                msg.sender.transfer(address(this).balance);
                allbets[msg.sender].winningprice = address(this).balance;
                allbets[msg.sender].finalresult = true;
                allbets[msg.sender].completed = true;
                balances[msg.sender] += address(this).balance;
                // If there are sufficient funds present
            } else {
                uint256 _winningprice = allbets[msg.sender].betamount * 2;
                emit Win(msg.sender, allbets[msg.sender].betamount);
                msg.sender.transfer(_winningprice);
                allbets[msg.sender].winningprice = _winningprice;
                allbets[msg.sender].finalresult = true;
                allbets[msg.sender].completed = true;
                balances[msg.sender] += _winningprice;
            }
            // If the user has lost the best
        } else {
            allbets[msg.sender].winningprice = 0;
            allbets[msg.sender].finalresult = false;
            allbets[msg.sender].completed = true;
        }
    }
}
