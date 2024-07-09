import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const VoteModule = buildModule("VoeModule", (m) => {
  const vote = m.contract("Vote");

  return { vote };
});

export default VoteModule;

