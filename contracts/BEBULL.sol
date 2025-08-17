// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BEBULL is ERC20, Ownable {

    uint256 public maxTxAmount;
    uint256 public maxWalletAmount;

    constructor() ERC20("BEBULL", "BEBULL") {
        uint256 totalSupply = 200000000 * 10 ** decimals();
        _mint(msg.sender, totalSupply);

        maxTxAmount = totalSupply;
        maxWalletAmount = totalSupply;
    }

    function setMaxTxAmount(uint256 _maxTx) external onlyOwner {
        maxTxAmount = _maxTx;
    }

    function setMaxWalletAmount(uint256 _maxWallet) external onlyOwner {
        maxWalletAmount = _maxWallet;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override {
        require(amount <= maxTxAmount, "Exceeds max tx amount");
        require(balanceOf(recipient) + amount <= maxWalletAmount, "Exceeds max wallet amount");
        super._transfer(sender, recipient, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
