import { toNano } from '@ton/core';
import { Vote } from '../wrappers/Vote';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
  const vote = provider.open(await Vote.fromInit());

  console.log(await vote.getOptions());
}


