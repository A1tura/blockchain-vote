import { ethers } from "hardhat";
import "dotenv/config"

async function main() {
  const CounterContract = await ethers.getContractFactory("Vote")
  const contract = await CounterContract.attach(process.env["CONTACT_ADDRESS"] || "ff")

  console.log(await contract.GetOptionBySubjectID(Number(0)));
}

main()

