// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Vote {

    struct Subject {
        uint id;
        string name;
        string description;
    }

    struct Option {
        uint id;
        uint subjectId;
        string name;
        string description;
        uint votes;
    }

    struct UserVote {
        uint id;
        uint Option;
        uint Subject;
        address Voter;
    }

    Subject[] public subjects;
    Option[] public options;
    UserVote[] public votes;

    uint public subjectId;
    uint public optionId;
    uint votesId;

    constructor() {
        subjectId = 0;
        optionId = 0;
        votesId = 0;
    }

    event NewSubject(uint id, string name, string desciption);
    event NewOption(uint id, string name, string description, uint subjectId);
    event NewUserVote(uint id, uint optionId);

    function createSubject(string calldata _name, string calldata _description) public {
        for (uint i = 0; i < subjects.length; i++) {
            if (keccak256(abi.encodePacked(subjects[i].name)) == keccak256(abi.encodePacked(_name))) {
                revert("Subbject aldffready exist!");
            }
        }


        Subject memory subject;

        subject.id = subjectId;
        subject.description = _description;
        subject.name = _name;

        subjects.push(subject);
        emit NewSubject(subjectId, _name, _description);

        subjectId += 1;
    }

    function createOption(string calldata _name, string calldata _description, uint _subjectId) public {
        require(_subjectId < subjectId, "Subject do not exist!");


        for (uint i = 0; i < options.length; i++) {
            if (keccak256(abi.encodePacked(options[i].name)) == keccak256(abi.encodePacked(_name))) {
                if (keccak256(abi.encodePacked(options[i].subjectId)) == keccak256(abi.encodePacked(_subjectId))) {
                    revert("Option already exist");
                }
            }
        }


        Option memory option;

        option.id = optionId;
        option.description = _description;
        option.name = _name;
        option.subjectId = _subjectId;

        options.push(option);
        emit NewOption(optionId, _name, _description, _subjectId);

        optionId += 1;
    }

    function userVote(uint _optionId) public {
        require(_optionId < optionId, "Option do not exist");

        for (uint i = 0; i < votes.length; i++) {
            if (keccak256(abi.encodePacked(votes[i].Voter)) == keccak256(abi.encodePacked(msg.sender))) {
                if (keccak256(abi.encodePacked(getSubjectIdByOptionId(_optionId))) == keccak256(abi.encodePacked(votes[i].Subject))) {
                    revert("You already voted!");
                }
            }
        }

        options[_optionId].votes += 1;

        UserVote memory vote;

        vote.id = votesId;
        vote.Option = _optionId;
        vote.Voter = msg.sender;
        vote.Subject = getSubjectIdByOptionId(_optionId);

        votes.push(vote);
        emit NewUserVote(votesId, _optionId);
        
        votesId++;
    }

    function GetSubjects() view public returns (Subject[] memory) {
        return subjects;
    }

    function GetOptions() view public returns (Option[] memory) {
        return options;
    }

    function GetVotes() view public returns (UserVote[] memory) {
        return votes;
    }
    
    function GetOptionBySubjectID(uint256 _subjectId) view public returns (Option[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < options.length; i++) {
            if (options[i].subjectId == _subjectId) {
                count++;
            }
        }

        Option[] memory filteredOptions = new Option[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < options.length; i++) {
            if (options[i].subjectId == _subjectId) {
                filteredOptions[index] = options[i];
                index++;
            }
        }

        return filteredOptions;
    }

    function GetLastSubjectId() view public returns (uint) {
        return subjectId;
    }

    function GetLastOptionId() view public returns (uint) {
        return optionId;
    }

    function getSubjectIdByOptionId(uint id) view public returns (uint) {
        return options[id].subjectId;
    }
}