//0x4dcb333ed78515c6150042A469Bbf320A20ac14C

import { ethers } from "hardhat";

async function main() {
  const CounterContract = await ethers.getContractFactory("Counter")
  const contract = await CounterContract.attach("0x3E94354c7CE719ff08dDA9EA07CeE329BCFAD519")

  console.log(await contract.get());
}

main()
