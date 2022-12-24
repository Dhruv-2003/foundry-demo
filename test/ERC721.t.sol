// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ERC721.sol";

contract CounterTest is Test {
    MyNFT public erc721;

    address bob = address(0x1);
    address alice = address(0x2);

    function setUp() public {
        erc721 = new MyNFT();
    }

    function testMintToken() public {
        erc721.mint(bob, 0);
        address owner_of = erc721.ownerOf(0);
        assertEq(bob, owner_of);
    }

    function testTransferToken() public {
        erc721.mint(bob, 1);

        vm.startPrank(bob);
        erc721.safeTransferFrom(bob, alice, 1);

        address owner_of = erc721.ownerOf(1);
        assertEq(alice, owner_of);
    }

    function testGetBalance() public {
        erc721.mint(bob, 2);
        erc721.mint(bob, 3);
        erc721.mint(bob, 4);
        erc721.mint(bob, 5);

        uint256 balance = erc721.balanceOf(bob);
        assertEq(balance, 4);
    }

    function testOnlyOwnerBurn() public {
        vm.startPrank(bob);
        erc721.burn(3);
    }
}
