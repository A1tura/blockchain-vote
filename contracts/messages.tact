message CreateSubject {
    name: String;
    description: String;
}

message CreateOption {
    name: String;
    description: String;
    Subject: Int;
}

message CreateUserVote {
    option: Int;
}