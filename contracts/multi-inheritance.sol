// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

abstract contract ERC20_STD {
    function balanceOf(address _owner)
        public
        view
        virtual
        returns (uint256 balance);

    function transfer(address _to, uint256 _value)
        public
        virtual
        returns (bool success);

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public virtual returns (bool success);

    function approve(address _spender, uint256 _value)
        public
        virtual
        returns (bool success);

    function allowance(address _owner, address _spender)
        public
        view
        virtual
        returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

contract Ownership {
    address public contractOwner;
    address public newOwner;

    event TransferOwnerShip(address indexed _from, address indexed _to);

    constructor() {
        contractOwner = msg.sender;
    }

    //change owner
    function changeOwner(address _to) public {
        require(
            msg.sender == contractOwner,
            "Only onwer can change the ownership"
        );
        newOwner = _to;
    }

    //accept ownership
    function acceptOwner() public {
        require(
            msg.sender == newOwner,
            "Only new assigned owner can accept it"
        );
        emit TransferOwnerShip(contractOwner, newOwner);
        contractOwner = newOwner;
        newOwner = address(0);
    }
}

contract MyERC20 is ERC20_STD, Ownership {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint8 public decimals;
    address public minter;
    mapping(address => uint256) tokenBalances;
    mapping(address => mapping(address => uint256)) allowed;

    constructor(address minter_) {
        name = "Azadi Token";
        symbol = "AZT";
        decimals=14;
        totalSupply = 10000000*10**decimals;
        minter = minter_;
        tokenBalances[minter] = totalSupply;
    }

    function balanceOf(address _owner)
        public
        view
        override
        returns (uint256 balance)
    {
        return tokenBalances[_owner];
    }

    function transfer(address _to, uint256 _value)
        public
        override
        returns (bool success)
    {
        require(tokenBalances[msg.sender] >= _value, "Insufficient Token");
        tokenBalances[msg.sender] -= _value;
        tokenBalances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override returns (bool success) {
        uint256 allowedBal = allowed[_from][msg.sender];
        require(allowedBal >= _value, "Insufficient Token");
        tokenBalances[_from] -= _value;
        tokenBalances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        override
        returns (bool success)
    {
        require(tokenBalances[msg.sender] >= _value, "Insufficient Token");
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        override
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }
}
