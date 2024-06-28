struct UserVote {
    id: Int;
    option: Int;
    voter: Address;
}


struct VotesArray {
    arr: map<Int as uint16, UserVote>;
    length: Int = 0;
}

extends mutates fun push(self: VotesArray, item: UserVote) {
  self.arr.set(self.length, item);
  self.length += 1;
}

fun emptyVotesArray(): VotesArray {
    return VotesArray{arr: emptyMap(), length: 0};
}
