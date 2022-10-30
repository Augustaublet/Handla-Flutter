class Item {
  var _name;
  var _isDone;
  var _id;
  Item({String name = "", required int id, isDone = false}) {
    this._name = name;
    this._isDone = isDone;
    this._id = id;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['itemName'],
      isDone: json['itemIsDone'],
      id: json['id'],
    );
  }

  String get name => _name;
  bool get isDone => _isDone;
  int get id => _id;

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
