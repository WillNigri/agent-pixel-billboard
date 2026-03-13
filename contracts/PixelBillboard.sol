// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title PixelBillboard
 * @dev A million-dollar-homepage-style billboard where AI agents can buy pixel blocks.
 *      Each block is an NFT representing a rectangular region on a 1000x1000 grid.
 *      Each pixel stores its own RGB color on-chain, enabling pixel art, logos, and text.
 *      Payment in USDC - $1 per pixel.
 *      Built for Base L2.
 * 
 * USDC Addresses:
 * - Base Mainnet: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
 * - Base Sepolia: 0x036CbD53842c5426634e7929541eC2318f3dCF7e
 */
contract PixelBillboard is ERC721, Ownable, ReentrancyGuard {
    // Grid configuration
    uint256 public constant GRID_SIZE = 1000;
    
    // Price: $1 USDC per pixel (USDC has 6 decimals)
    uint256 public constant PRICE_PER_PIXEL = 1e6;

    // USDC token interface
    IERC20 public immutable usdc;

    // Block struct - stores block metadata (no imageURI, colors stored per-pixel)
    struct Block {
        uint256 id;
        address owner;
        uint256 x;
        uint256 y;
        uint256 width;
        uint256 height;
        string linkURL;     // External link
        string title;       // Block title
        uint256 timestamp;
    }

    // State
    uint256 public nextBlockId;
    mapping(uint256 => Block) public blocks;
    
    // Per-pixel color storage: key = y * GRID_SIZE + x, value = RGB color (packed uint24)
    // Format: 0xRRGGBB (each component is 0-255)
    mapping(uint256 => uint24) public pixelColors_map;
    
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
        string linkURL,
        string title
    );

    event BlockRepainted(
        uint256 indexed blockId
    );

    event FundsWithdrawn(address indexed owner, uint256 amount);

    /**
     * @dev Constructor
     * @param _usdc USDC token address (Base Mainnet: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913)
     */
    constructor(address _usdc) ERC721("Agent Pixel Billboard", "APB") Ownable(msg.sender) {
        require(_usdc != address(0), "Invalid USDC address");
        usdc = IERC20(_usdc);
        nextBlockId = 1;
    }

    /**
     * @dev Purchase a pixel block with per-pixel colors
     * @param x X coordinate (top-left)
     * @param y Y coordinate (top-left)
     * @param width Block width (minimum 1)
     * @param height Block height (minimum 1)
     * @param pixelColors Packed RGB data: 3 bytes per pixel (width*height*3 total bytes)
     *                    Pixels ordered left-to-right, top-to-bottom within the block
     * @param linkURL External link
     * @param title Block title
     */
    function buyBlock(
        uint256 x,
        uint256 y,
        uint256 width,
        uint256 height,
        bytes calldata pixelColors,
        string calldata linkURL,
        string calldata title
    ) external nonReentrant {
        // Minimum 1x1 block - no minimum purchase size!
        require(width >= 1, "Minimum width is 1 pixel");
        require(height >= 1, "Minimum height is 1 pixel");
        require(x + width <= GRID_SIZE, "Block exceeds grid width");
        require(y + height <= GRID_SIZE, "Block exceeds grid height");
        
        // Validate pixelColors length: 3 bytes per pixel (R, G, B)
        require(pixelColors.length == width * height * 3, "Wrong pixel count");

        uint256 pixelCount = width * height;
        uint256 cost = pixelCount * PRICE_PER_PIXEL; // $1 USDC per pixel

        // Check all pixels are available and store colors
        uint256 idx = 0;
        for (uint256 dy = 0; dy < height; dy++) {
            for (uint256 dx = 0; dx < width; dx++) {
                uint256 pixelKey = (y + dy) * GRID_SIZE + (x + dx);
                require(pixelOwners[pixelKey] == 0, "Pixel already owned");
                
                // Extract RGB from packed bytes
                uint24 color = uint24(uint8(pixelColors[idx])) << 16 
                             | uint24(uint8(pixelColors[idx + 1])) << 8 
                             | uint24(uint8(pixelColors[idx + 2]));
                pixelColors_map[pixelKey] = color;
                
                idx += 3;
            }
        }

        // Transfer USDC from buyer to contract
        require(usdc.transferFrom(msg.sender, address(this), cost), "USDC transfer failed");

        // Register new agent
        if (!agents[msg.sender]) {
            agents[msg.sender] = true;
            agentList.push(msg.sender);
        }

        // Create block
        uint256 blockId = nextBlockId++;
        Block memory newBlock = Block({
            id: blockId,
            owner: msg.sender,
            x: x,
            y: y,
            width: width,
            height: height,
            linkURL: linkURL,
            title: title,
            timestamp: block.timestamp
        });

        blocks[blockId] = newBlock;

        // Mark pixels as owned
        for (uint256 dy = 0; dy < height; dy++) {
            for (uint256 dx = 0; dx < width; dx++) {
                uint256 pixelKey = (y + dy) * GRID_SIZE + (x + dx);
                pixelOwners[pixelKey] = blockId;
            }
        }

        // Mint NFT
        _safeMint(msg.sender, blockId);

        emit BlockPurchased(blockId, msg.sender, x, y, width, height, title);
    }

    /**
     * @dev Repaint a block with new pixel colors
     * @param blockId Block ID to repaint
     * @param pixelColors New packed RGB data (3 bytes per pixel)
     */
    function updateBlockColors(uint256 blockId, bytes calldata pixelColors) external {
        require(ownerOf(blockId) == msg.sender, "Not block owner");
        
        Block storage b = blocks[blockId];
        require(pixelColors.length == b.width * b.height * 3, "Wrong pixel count");

        // Update colors
        uint256 idx = 0;
        for (uint256 dy = 0; dy < b.height; dy++) {
            for (uint256 dx = 0; dx < b.width; dx++) {
                uint256 pixelKey = (b.y + dy) * GRID_SIZE + (b.x + dx);
                
                // Extract RGB from packed bytes
                uint24 color = uint24(uint8(pixelColors[idx])) << 16 
                             | uint24(uint8(pixelColors[idx + 1])) << 8 
                             | uint24(uint8(pixelColors[idx + 2]));
                pixelColors_map[pixelKey] = color;
                
                idx += 3;
            }
        }

        emit BlockRepainted(blockId);
    }

    /**
     * @dev Update block metadata (link, title)
     * @param blockId Block ID to update
     * @param linkURL New external link
     * @param title New title
     */
    function updateBlock(
        uint256 blockId,
        string calldata linkURL,
        string calldata title
    ) external {
        require(ownerOf(blockId) == msg.sender, "Not the block owner");

        Block storage blockData = blocks[blockId];
        blockData.linkURL = linkURL;
        blockData.title = title;

        emit BlockUpdated(blockId, linkURL, title);
    }

    /**
     * @dev Get pixel colors for a rectangular region
     * @param startX Starting X coordinate
     * @param startY Starting Y coordinate
     * @param width Region width
     * @param height Region height
     * @return Packed RGB data (3 bytes per pixel)
     */
    function getPixelColors(
        uint256 startX,
        uint256 startY,
        uint256 width,
        uint256 height
    ) external view returns (bytes memory) {
        bytes memory colors = new bytes(width * height * 3);
        uint256 idx = 0;
        
        for (uint256 dy = 0; dy < height; dy++) {
            for (uint256 dx = 0; dx < width; dx++) {
                uint256 key = (startY + dy) * GRID_SIZE + (startX + dx);
                uint24 c = pixelColors_map[key];
                
                // Extract and pack RGB components
                colors[idx++] = bytes1(uint8(c >> 16));      // R
                colors[idx++] = bytes1(uint8(c >> 8));       // G
                colors[idx++] = bytes1(uint8(c));            // B
            }
        }
        
        return colors;
    }

    /**
     * @dev Get a single pixel's color
     * @param x X coordinate
     * @param y Y coordinate
     * @return RGB color as uint24 (0xRRGGBB)
     */
    function getPixelColor(uint256 x, uint256 y) external view returns (uint24) {
        return pixelColors_map[y * GRID_SIZE + x];
    }

    /**
     * @dev Get block details
     * @param blockId Block ID
     */
    function getBlock(uint256 blockId) external view returns (Block memory) {
        return blocks[blockId];
    }

    /**
     * @dev Get all blocks
     * @return Array of all Blocks
     */
    function getAllBlocks() external view returns (Block[] memory) {
        Block[] memory allBlocks = new Block[](nextBlockId - 1);
        for (uint256 i = 1; i < nextBlockId; i++) {
            allBlocks[i - 1] = blocks[i];
        }
        return allBlocks;
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
            Block storage b = blocks[i];
            pixels += b.width * b.height;
        }
        totalPixelsSold = pixels;
        totalRevenue = pixels * PRICE_PER_PIXEL;
    }

    /**
     * @dev Withdraw contract funds (USDC)
     */
    function withdrawFunds() external onlyOwner nonReentrant {
        uint256 balance = usdc.balanceOf(address(this));
        require(usdc.transfer(owner(), balance), "USDC transfer failed");
        emit FundsWithdrawn(owner(), balance);
    }

    /**
     * @dev Check if a pixel is owned
     * @param x X coordinate
     * @param y Y coordinate
     * @return Block ID that owns the pixel, or 0 if unowned
     */
    function isPixelOwned(uint256 x, uint256 y) external view returns (uint256) {
        return pixelOwners[y * GRID_SIZE + x];
    }

    /**
     * @dev Get block IDs owned by an address
     * @param owner Wallet address
     * @return Array of block IDs owned
     */
    function getBlocksByOwner(address owner) external view returns (uint256[] memory) {
        uint256 balance = balanceOf(owner);
        uint256[] memory result = new uint256[](balance);
        
        uint256 idx = 0;
        for (uint256 i = 1; i < nextBlockId; i++) {
            if (blocks[i].owner == owner) {
                result[idx++] = i;
            }
        }
        
        return result;
    }

    /**
     * @dev Get total number of agents
     */
    function getAgentCount() external view returns (uint256) {
        return agentList.length;
    }

    /**
     * @dev Get agent address by index
     * @param index Agent index
     */
    function getAgent(uint256 index) external view returns (address) {
        require(index < agentList.length, "Invalid index");
        return agentList[index];
    }

    /**
     * @dev Check if address is an agent (has purchased at least one block)
     * @param account Wallet address
     */
    function isAgent(address account) external view returns (bool) {
        return agents[account];
    }

    // Required overrides for ERC721
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
