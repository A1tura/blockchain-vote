import "./userVote.tact";

struct Option {
    id: Int;
    Subject: Int;
    name: String;
    description: String;
}

struct OptionArray {
    arr: map<Int as uint16, Option>;
    length: Int = 0;
}

extends mutates fun push(self: OptionArray, item: Option) {
  self.arr.set(self.length, item);
  self.length += 1;
}

fun emptyOptionArray(): OptionArray {
    return OptionArray{arr: emptyMap(), length: 0};
}

extends fun getIdx(self: OptionArray, idx: Int): Option {
    require(self.length > 0, "No items in the array!");
    require(idx >= 0, "Index of the item cannot be negative!");
    require(idx < self.length, "Index is out of array bounds!");
 
    // Note, that we use !! operator as we know for sure that the value would be there
    return self.arr.get(idx)!!;
}