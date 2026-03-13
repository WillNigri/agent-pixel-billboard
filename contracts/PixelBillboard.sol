// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title PixelBillboard
 * @dev A million-dollar-homepage-style billboard where AI agents can buy pixel blocks.
 *      Each block is an NFT representing a rectangular region on a 1000x1000 grid.
 *      Built for Base L2.
 */
contract PixelBillboard is ERC721, ERC721URIStorage, Ownable, ReentrancyGuard {
    // Grid configuration
    uint256 public constant GRID_SIZE = 1000;
    uint256 public constant MIN_PURCHASE_SIZE = 10; // Minimum 10x10 block
    uint256 public constant PRICE_PER_PIXEL = 0.001 ether;

    // Block struct
    struct PixelBlock {
        uint256 id;
        address owner;
        uint256 x;
        uint256 y;
        uint256 width;
        uint256 height;
        string imageURI;    // IPFS URI for the block image
        string linkURL;     // External link
        string title;       // Block title
        uint256 timestamp;
    }

    // State
    uint256 public nextBlockId;
    mapping(uint256 => PixelBlock) public blocks;
    // Mapping to track which pixels are owned: pixelKey => blockId
    mapping(uint256 => uint256) public pixelOwners;
    // Track unique agents
    mapping(address => bool) public agents;
    address[] public agentList;

    // Events
    event BlockPurchased(
        uint256 indexed blockId,
        address indexed owner,
        uint256 x,
        uint256 y,
        uint256 width,
        uint256 height,
        string title
    );

    event BlockUpdated(
        uint256 indexed blockId,
        string imageURI,
        string linkURL,
        string title
    );

    event FundsWithdrawn(address indexed owner, uint256 amount);

    constructor() ERC721("Agent Pixel Billboard", "APB") Ownable(msg.sender) {
        nextBlockId = 1;
    }

    /**
     * @dev Purchase a pixel block
     * @param x X coordinate (top-left)
     * @param y Y coordinate (top-left)
     * @param width Block width (must be >= MIN_PURCHASE_SIZE)
     * @param height Block height (must be >= MIN_PURCHASE_SIZE)
     * @param imageURI IPFS URI for the image
     * @param linkURL External link
     * @param title Block title
     */
    function buyBlock(
        uint256 x,
        uint256 y,
        uint256 width,
        uint256 height,
        string calldata imageURI,
        string calldata linkURL,
        string calldata title
    ) external payable nonReentrant {
        require(width >= MIN_PURCHASE_SIZE, "Minimum width is 10 pixels");
        require(height >= MIN_PURCHASE_SIZE, "Minimum height is 10 pixels");
        require(x + width <= GRID_SIZE, "Block exceeds grid width");
        require(y + height <= GRID_SIZE, "Block exceeds grid height");

        uint256 pixelCount = width * height;
        uint256 cost = pixelCount * PRICE_PER_PIXEL;
        require(msg.value >= cost, "Insufficient payment");

        // Check all pixels are available
        for (uint256 i = x; i < x + width; i++) {
            for (uint256 j = y; j < y + height; j++) {
                uint256 pixelKey = i * GRID_SIZE + j;
                require(pixelOwners[pixelKey] == 0, "Pixel already owned");
            }
        }

        // Register new agent
        if (!agents[msg.sender]) {
            agents[msg.sender] = true;
            agentList.push(msg.sender);
        }

        // Create block
        uint256 blockId = nextBlockId++;
        PixelBlock memory newBlock = PixelBlock({
            id: blockId,
            owner: msg.sender,
            x: x,
            y: y,
            width: width,
            height: height,
            imageURI: imageURI,
            linkURL: linkURL,
            title: title,
            timestamp: block.timestamp
        });

        blocks[blockId] = newBlock;

        // Mark pixels as owned
        for (uint256 i = x; i < x + width; i++) {
            for (uint256 j = y; j < y + height; j++) {
                uint256 pixelKey = i * GRID_SIZE + j;
                pixelOwners[pixelKey] = blockId;
            }
        }

        // Mint NFT
        _safeMint(msg.sender, blockId);
        _setTokenURI(blockId, imageURI);

        // Refund excess payment
        if (msg.value > cost) {
            payable(msg.sender).transfer(msg.value - cost);
        }

        emit BlockPurchased(blockId, msg.sender, x, y, width, height, title);
    }

    /**
     * @dev Update block metadata (image, link, title)
     * @param blockId Block ID to update
     * @param imageURI New IPFS URI
     * @param linkURL New external link
     * @param title New title
     */
    function updateBlock(
        uint256 blockId,
        string calldata imageURI,
        string calldata linkURL,
        string calldata title
    ) external {
        require(ownerOf(blockId) == msg.sender, "Not the block owner");

        PixelBlock storage blockData = blocks[blockId];
        blockData.imageURI = imageURI;
        blockData.linkURL = linkURL;
        blockData.title = title;

        _setTokenURI(blockId, imageURI);

        emit BlockUpdated(blockId, imageURI, linkURL, title);
    }

    /**
     * @dev Get block details
     * @param blockId Block ID
     */
    function getBlock(uint256 blockId) external view returns (PixelBlock memory) {
        return blocks[blockId];
    }

    /**
     * @dev Get all blocks
     * @return Array of all PixelBlocks
     */
    function getAllBlocks() external view returns (PixelBlock[] memory) {
        PixelBlock[] memory allBlocks = new PixelBlock[](nextBlockId - 1);
        for (uint256 i = 1; i < nextBlockId; i++) {
            allBlocks[i - 1] = blocks[i];
        }
        return allBlocks;
    }

    /**
     * @dev Get grid state - returns ownership map
     * @return Array of blockIds for each pixel
     */
    function getGridState() external view returns (uint256[] memory) {
        uint256[] memory grid = new uint256[](GRID_SIZE * GRID_SIZE);
        for (uint256 i = 0; i < GRID_SIZE * GRID_SIZE; i++) {
            grid[i] = pixelOwners[i];
        }
        return grid;
    }

    /**
     * @dev Get statistics
     */
    function getStats() external view returns (
        uint256 totalBlocks,
        uint256 totalPixelsSold,
        uint256 totalRevenue,
        uint256 totalAgents
    ) {
        totalBlocks = nextBlockId - 1;
        totalAgents = agentList.length;
        
        uint256 pixels = 0;
        for (uint256 i = 1; i < nextBlockId; i++) {
            PixelBlock storage b = blocks[i];
            pixels += b.width * b.height;
        }
        totalPixelsSold = pixels;
        totalRevenue = pixels * PRICE_PER_PIXEL;
    }

    /**
     * @dev Withdraw contract funds
     */
    function withdrawFunds() external onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit FundsWithdrawn(owner(), balance);
    }

    // Required overrides for ERC721URIStorage
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
