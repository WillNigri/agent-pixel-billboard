const { ethers } = require("hardhat");
const fs = require("fs");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying with:", deployer.address);
  const bal = await ethers.provider.getBalance(deployer.address);
  console.log("Balance:", ethers.formatEther(bal), "ETH");

  const USDC_ADDRESS = "0x036CbD53842c5426634e7929541eC2318f3dCF7e"; // Base Sepolia USDC
  const PixelBillboard = await ethers.getContractFactory("PixelBillboard");
  const billboard = await PixelBillboard.deploy(USDC_ADDRESS);
  await billboard.waitForDeployment();
  const addr = await billboard.getAddress();
  console.log("PixelBillboard deployed to:", addr);
  
  fs.writeFileSync("deployment.json", JSON.stringify({
    network: "baseSepolia", contractAddress: addr,
    usdcAddress: USDC_ADDRESS, deployer: deployer.address,
    timestamp: new Date().toISOString(), chainId: 84532
  }, null, 2));
  console.log("Saved to deployment.json");
}
main().catch(e => { console.error(e); process.exit(1); });
