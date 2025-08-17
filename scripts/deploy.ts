import { ethers } from "hardhat";

async function main() {
  const Token = await ethers.getContractFactory("BEBULL");
  const token = await Token.deploy();

  await token.waitForDeployment();

  console.log("BEBULL deployed to:", await token.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
