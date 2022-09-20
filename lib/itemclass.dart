class Item {
  var _name;
  var _isDone;
  var _id;
  Item({String name = "", String id = "", isDone = false}) {
    this._name = name;
    this._isDone = isDone;
    this._id = id;
  }

  String get name => _name;
  bool get isDone => _isDone;
  String get id => _id;

  set name(String newName) {
    _name = newName;
  }

  setIsDone() {
    _isDone = !_isDone;
  }

  // endast för att testa så classen byggts korrekt
  testPrint() {
    print("Item name: $_name");
    print("Item is done: $_isDone");
  }
}
