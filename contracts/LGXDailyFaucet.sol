// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title LGX Daily Faucet
/// @notice Old-school daily faucet for LiLGcoin (LGX) on BNB Smart Chain.
///         The owner funds the contract with LGX. Anyone can claim a fixed
///         amount once per cooldown period until the pool runs dry.
///         No game scores are trusted on-chain: the game runs in the browser,
///         so its balances could be edited. The faucet pays a fixed daily
///         amount instead, which cannot be gamed past the per-address cap.
/// @dev LGX has 16 decimals (verified on-chain: decimals() = 16,
///      totalSupply = 7,500,000 LGX). So 1 LGX = 1e16 base units.
///      Example: 500 LGX/day = 500 * 10**16 = 5000000000000000000.
///      Keep claimAmount high enough to beat BSC gas: at ~$0.000436/LGX,
///      a claim should be worth at least ~$0.20, i.e. 500+ LGX.
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract LGXDailyFaucet {
    IERC20 public immutable lgx;
    address public owner;

    /// @notice Amount paid per claim, in LGX base units (16 decimals).
    uint256 public claimAmount;
    /// @notice Seconds a wallet must wait between claims (86400 = 1 day).
    uint256 public cooldown;
    bool public paused;

    mapping(address => uint256) public lastClaim;
    uint256 public totalClaimed;
    uint256 public totalClaims;

    event Claimed(address indexed user, uint256 amount, uint256 timestamp);
    event Funded(address indexed from, uint256 amount);
    event ClaimAmountUpdated(uint256 newAmount);
    event CooldownUpdated(uint256 newCooldown);
    event Paused(bool paused);
    event Withdrawn(address indexed to, uint256 amount);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "LGXDailyFaucet: not owner");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "LGXDailyFaucet: paused");
        _;
    }

    constructor(address _lgx, uint256 _claimAmount, uint256 _cooldown) {
        require(_lgx != address(0), "LGXDailyFaucet: zero token address");
        lgx = IERC20(_lgx);
        owner = msg.sender;
        claimAmount = _claimAmount;
        cooldown = _cooldown;
    }

    /// @notice Claim the daily LGX. One claim per cooldown per wallet.
    function claim() external whenNotPaused {
        require(
            block.timestamp >= lastClaim[msg.sender] + cooldown,
            "LGXDailyFaucet: too soon, wait for the next day"
        );
        require(
            lgx.balanceOf(address(this)) >= claimAmount,
            "LGXDailyFaucet: faucet is empty"
        );
        lastClaim[msg.sender] = block.timestamp;
        totalClaimed += claimAmount;
        totalClaims += 1;
        require(lgx.transfer(msg.sender, claimAmount), "LGXDailyFaucet: transfer failed");
        emit Claimed(msg.sender, claimAmount, block.timestamp);
    }

    /// @notice LGX currently sitting in the faucet.
    function poolBalance() external view returns (uint256) {
        return lgx.balanceOf(address(this));
    }

    /// @notice Earliest timestamp `user` can claim again (now if already eligible).
    function nextClaimAt(address user) external view returns (uint256) {
        uint256 next = lastClaim[user] + cooldown;
        return next > block.timestamp ? next : block.timestamp;
    }

    /// @notice Owner: change the per-claim amount (base units, 16 decimals).
    function setClaimAmount(uint256 _amount) external onlyOwner {
        claimAmount = _amount;
        emit ClaimAmountUpdated(_amount);
    }

    /// @notice Owner: change the wait between claims, in seconds.
    function setCooldown(uint256 _seconds) external onlyOwner {
        cooldown = _seconds;
        emit CooldownUpdated(_seconds);
    }

    /// @notice Owner: pause or unpause claims (funding/withdraw still work).
    function setPaused(bool _paused) external onlyOwner {
        paused = _paused;
        emit Paused(_paused);
    }

    /// @notice Owner: take LGX back out of the faucet (e.g. to top up the pool elsewhere).
    function withdraw(uint256 _amount) external onlyOwner {
        require(lgx.transfer(owner, _amount), "LGXDailyFaucet: transfer failed");
        emit Withdrawn(owner, _amount);
    }

    /// @notice Owner: hand control to another wallet.
    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "LGXDailyFaucet: zero address");
        address oldOwner = owner;
        owner = _newOwner;
        emit OwnershipTransferred(oldOwner, _newOwner);
    }
}
