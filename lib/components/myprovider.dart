import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../auth/secrets.dart';
import 'ToDoListclass.dart';
import 'itemclass.dart';

class MyProvider extends ChangeNotifier {
  List<Item> _items = [];
  List<ToDoList> _ToDoLists = [];
  late ToDoList _currentList;
  bool _loading = false;

  late String mainUrl;
  String listPathUrl = "/api/shoppinglist/";
  String itemPathUrl = "/api/shoppinglist/items/";

  List<Item> get items => _items;
  ToDoList get currentList => _currentList;
  bool get loading => _loading;
  List<ToDoList> get allLists => _ToDoLists;

  MyProvider() {
    var secrets = MySecrets();
    mainUrl = secrets.url;
    initLoadList();
  }

  void initLoadList() async {
    _loading = true;
    notifyListeners();
    http.Response answer = await http.get(Uri.parse('$mainUrl$listPathUrl'));
    if (answer.statusCode == 200) {
      List<dynamic> data = jsonDecode(answer.body);
      updateLists(data);
      _loading = false;
      _currentList = _ToDoLists[0];
      await getItems();
    }
  }

  void updateLists(List<dynamic> data) {
    _ToDoLists.clear();
    for (var newList in data) {
      _ToDoLists.add(ToDoList.fromJson(newList));
    }
  }
  // Future<void> getLists ()async{
  //   http.Response answer =
  //       await http.get(Uri.parse('$mainUrl$listPathUrl'));
  //   if (answer.statusCode == 200) {
  //     List<dynamic> data = jsonDecode(answer.body);
  //     updateLists(data);
  //   }
  // }

  Future<void> getItems() async {
    http.Response answer =
        await http.get(Uri.parse('$mainUrl$itemPathUrl${_currentList.listID}'));
    if (answer.statusCode == 200) {
      List<dynamic> data = jsonDecode(answer.body);
      updateItems(data);
    }
  }

  updateItems(List<dynamic> data) {
    _items.clear();
    for (var newItem in data) {
      _items.add(Item.fromJson(newItem));
    }
    notifyListeners();
  }

  Future<void> addItem(newItemName) async {
    http.Response answer = await http.post(
      Uri.parse("$mainUrl$itemPathUrl${_currentList.listID}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "newItemName": newItemName,
      }),
    );
    updateItems(json.decode(answer.body));
  }

  Future<void> addNewList(newListTitle) async {
    http.Response answer = await http.post(
      Uri.parse("$mainUrl$listPathUrl"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"newListTitle": newListTitle}),
    );
    updateLists(json.decode(answer.body));
    getItems();
  }

  Future<void> updateItemIsDone(listItem) async {
    http.Response answer = await http.put(
      Uri.parse("$mainUrl$itemPathUrl${_currentList.listID}/${listItem.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "newItemName": listItem.name,
        "itemIsDone": !listItem.isDone,
      }),
    );
    updateItems(json.decode(answer.body));
  }

  Future<void> removeAllDone() async {
    http.Response answer = await http.post(
      Uri.parse("$mainUrl$itemPathUrl${_currentList.listID}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "deleteAllDone": true,
      }),
    );
    updateItems(json.decode(answer.body));
  }

  Future removeItem(Item itemToRemove) async {
    http.Response answer = await http.delete(Uri.parse(
        "$mainUrl$itemPathUrl${_currentList.listID}/${itemToRemove.id}"));
    updateItems(json.decode(answer.body));
  }

  setCurrentList(ToDoList newListObj) {
    _currentList = newListObj;
    getItems();
    notifyListeners();
  }
}
