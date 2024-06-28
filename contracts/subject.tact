import "./option.tact";

struct Subject {
    id: Int;
    name: String;
    description: String;
}

struct SubjectsArray {
    arr: map<Int as uint16, Subject>;
    length: Int = 0;
}

extends mutates fun push(self: SubjectsArray, item: Subject) {
  self.arr.set(self.length, item);
  self.length += 1;
}

extends mutates fun pushOption(self: SubjectsArray, item: Subject) {
  self.arr.set(self.length, item);
  self.length += 1;
}

fun emptySubjectArray(): SubjectsArray {
    return SubjectsArray{arr: emptyMap(), length: 0};
}

extends fun getIdx(self: SubjectsArray, idx: Int): Subject {
    require(self.length > 0, "No items in the array!");
    require(idx >= 0, "Index of the item cannot be negative!");
    require(idx < self.length, "Index is out of array bounds!");
 
    // Note, that we use !! operator as we know for sure that the value would be there
    return self.arr.get(idx)!!;
}