import { ethers } from "hardhat";

async function main() {
  const source = "0xBbCDb8F9753F1435930F9014eB8541Ce3904473B";
  const target = "0xEb4E22adc01c435b13424EF9F559E024C4Dc35A0";

  const Source = await ethers.getContractAt("Source", source);

  await Source.updateGreeting(target, "Hello, connext!", {gasLimit: 2000000});
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
