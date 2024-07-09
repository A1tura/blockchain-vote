//0x4dcb333ed78515c6150042A469Bbf320A20ac14C

import { ethers } from "hardhat";
import "dotenv/config"

async function main() {
  const CounterContract = await ethers.getContractFactory("Vote")
  const contract = await CounterContract.attach(process.env["CONTACT_ADDRESS"] || "ff")

  console.log(await contract.userVote(Number(1)))
}

main()



