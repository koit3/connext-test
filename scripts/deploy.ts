import { ethers } from "hardhat";

async function main() {
/*
  const Source = await ethers.getContractFactory("Source");
  const source = await Source.deploy();
  await source.deployed();
  console.log(`Source deployed to ${source.address}`);
*/
  const Target = await ethers.getContractFactory("Target");
  const target = await Target.deploy();
  await target.deployed();
  console.log(`Target deployed to ${target.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
