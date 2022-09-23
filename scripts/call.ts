import { ethers } from "hardhat";

async function main() {
  const source = "0xBbCDb8F9753F1435930F9014eB8541Ce3904473B";
  const target = "0x957aAe3B133259bC0E4964EF1Fe25b1F8E3940FE";

  const Source = await ethers.getContractAt("Source", source);

  await Source.updateGreeting(target, "Hello, connext!", {gasLimit: 2000000});
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
