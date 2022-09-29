class ToDoList {
  var _listTitle;
  var _listID;
  ToDoList({String listTitle = "", required int listID}) {
    _listTitle = listTitle;
    _listID = listID;
  }

  factory ToDoList.fromJson(Map<dynamic, dynamic> json) {
    return ToDoList(
      listTitle: json['listTitle'],
      listID: json['id'],
    );
  }

  String get listTitle => _listTitle;
  int get listID => _listID;
}
