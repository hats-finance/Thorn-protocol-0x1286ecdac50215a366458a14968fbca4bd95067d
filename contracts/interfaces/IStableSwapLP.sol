// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IStableSwapLP {
    /**
     * @dev Returns the amount of tokens in existence.
     */

    function balanceOf(address account) external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function mint(address _to, uint256 _amount) external;

    function burnFrom(address _to, uint256 _amount) external;

    function setMinter(address _newMinter) external;
}
