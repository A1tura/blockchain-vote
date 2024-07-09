import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers";


const config: HardhatUserConfig = {
  solidity: "0.8.26",
  defaultNetwork: "testnet",
  networks: {
    "testnet": {
      "url": "http://127.0.0.1:8545", // testnet-url
      "accounts": [""] // private-key array
    },
  }
};

export default config;

