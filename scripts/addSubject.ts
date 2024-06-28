import { toNano } from '@ton/core';
import { Vote } from '../wrappers/Vote';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
  const vote = provider.open(await Vote.fromInit());

  await vote.send(
    provider.sender(),
    {
      value: toNano('0.02'),
    },
    {
      $$type: 'CreateSubject',
      name: "test",
      description: "test"
    }
  );
}

