class ToDoList {
  var _listTitle;
  var _listID;
  ToDoList({String listTitle = "", String listID = ""}) {
    _listTitle = listTitle;
    _listID = listID;
  }

  String get listTitle => _listTitle;
  String get listID => _listID;
}
