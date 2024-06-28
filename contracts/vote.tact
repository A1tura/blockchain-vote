import "@stdlib/deploy";
import "./messages.tact";
import "./option.tact";
import "./userVote.tact";
import "./subject.tact";


contract Vote with Deployable {
    subjectsArray: SubjectsArray;
    optionsArray: OptionArray;
    votesArray: VotesArray;

    optionId: Int;
    subjectId: Int;
    userVote: Int;

    init() {
        self.subjectsArray = emptySubjectArray();
        self.optionsArray = emptyOptionArray();
        self.votesArray = emptyVotesArray();

        self.optionId = 0;
        self.subjectId = 0;
        self.userVote = 0;
    }

    receive(msg: CreateSubject) {
        foreach(key, subject in self.subjectsArray.arr) {
            if (subject.name == msg.name) {
                require(msg.name != subject.name, "Subject alredy exist!");
            }
        }

        self.subjectsArray.push(Subject {
            id: self.subjectId,
            name: msg.name,
            description: msg.description
        });

        self.subjectId += 1;
    }

    receive(msg: CreateOption) {
        require(msg.Subject <= self.subjectId, "Subject do not exist");

        foreach(key, option in self.optionsArray.arr) {
            if (option.Subject == msg.Subject) {
                if (option.name == msg.name) {
                    require(msg.name != option.name, "Option alredy exist!");
                }
            }
        }

        self.optionsArray.push(Option {
            id: self.optionId,
            name: msg.name,
            Subject: msg.Subject,
            description: msg.description
        });

        self.optionId += 1;
    }

    receive(msg: CreateUserVote) {
        let ctx: Context = context();

        require(msg.option <= self.optionId, "Option do not exist!");

        foreach(key, vote in self.votesArray.arr) {
            if (vote.voter == ctx.sender) {
                if (vote.option == msg.option) {
                    require(msg.option != vote.option, "You already voted!");
                }
            }
        }

        self.votesArray.push(UserVote {
            id: self.userVote,
            option: msg.option,
            voter: ctx.sender
        });

        self.userVote += 1;
    }

    get fun Subjects(): map<Int as uint16, Subject> {
        return self.subjectsArray.arr;
    }

    get fun Options(): map<Int as uint16, Option> {
        return self.optionsArray.arr;
    }

    get fun allVotes(): map<Int as uint16, UserVote> {
        return self.votesArray.arr;
    }

    get fun optionVotes(optionId: Int): map<Int as uint16, UserVote> {
        let votes: map<Int as uint16, UserVote> = emptyMap();
        let votesLength: Int = 0;

        foreach(key, vote in self.votesArray.arr) {
            if (vote.option == optionId) {
                votes.set(votesLength, vote);
                votesLength += 1;
            }
        }

        return votes;
    }
}