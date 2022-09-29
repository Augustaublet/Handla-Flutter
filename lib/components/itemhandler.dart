import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ToDoListclass.dart';
import 'itemclass.dart';

class ItemHandler extends ChangeNotifier {
  final String APIKEY = "mklsUgFnJ2AaFGeWz-RjjQ";
  List<Item> _items = [];
  List<ToDoList> _ToDoLists = [];

  late ToDoList _currentList;
  String _mainUrl = "http://127.0.0.1:5000";
  // String _mainUrl = "http://192.168.1.168:5000";

  String _path = "/api/shoppingList";
  bool loading = false;
  // Construktor
  ItemHandler() {
    starterFunction();
  }

  List<Item> get items => _items; // getter för lista med items
  ToDoList get currentList => _currentList;
  List<ToDoList> get allLists => _ToDoLists;

  _loadCurrentList() {
    _currentList = _ToDoLists[0];
  }

  void setCurrentList(ToDoList switchToList) {
    _currentList = switchToList;
    newItemList();
    notifyListeners();
  }

  Future<void> starterFunction() async {
    loading = true;
    notifyListeners();
    http.Response response = await http
        .get(Uri.parse("${_mainUrl}/api/allshoppinglists?key=$APIKEY"));
    _ToDoLists = await createListOfLists(jsonDecode(response.body));
    loading = false;
    await _loadCurrentList();
    await newItemList();
    notifyListeners();
  }

  Future<void> getAllLists() async {
    http.Response response = await http
        .get(Uri.parse("${_mainUrl}/api/allshoppinglists?key=$APIKEY"));
    //print(jsonDecode(response.body));
    _ToDoLists = createListOfLists(jsonDecode(response.body));
    _loadCurrentList();
    notifyListeners();
  }

  Future newItemList() async {
    http.Response response = await http
        .get(Uri.parse("${_mainUrl}${_path}?listID=${_currentList.listID}"));
    _items = createList(jsonDecode(response.body));
    notifyListeners();
  }

  Future addItem(String newItemName) async {
    http.Response response = await http.post(
      Uri.parse("${_mainUrl}${_path}?listID=${_currentList.listID}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"title": newItemName}),
    );
    _items = createList(json.decode(response.body));
    notifyListeners();
  }

  Future updateItemIsDone(Item itemToUpdate) async {
    http.Response response = await http.put(
      Uri.parse(
          "$_mainUrl$_path/${itemToUpdate.id}?listID=${_currentList.listID}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "title": itemToUpdate.name,
        "done": !itemToUpdate.isDone,
      }),
    );
    _items = createList(json.decode(response.body));
    notifyListeners();
  }

  Future removeAllDone() async {
    _items.forEach(
      (item) async {
        if (item.isDone) {
          http.Response response = await http.delete(Uri.parse(
              "$_mainUrl$_path/${item.id}?listID=${_currentList.listID}"));
        }
      },
    );
    newItemList();
  }

  Future removeItem(Item itemToRemove) async {
    http.Response response = await http.delete(Uri.parse(
        "$_mainUrl$_path/${itemToRemove.id}?listID=${_currentList.listID}"));
    _items = createList(json.decode(response.body));
    notifyListeners();
  }

  List<ToDoList> createListOfLists(objData) {
    List<ToDoList> newList = [];
    objData.forEach((newToDo) {
      newList.add(ToDoList(
        listTitle: newToDo["listTitle"],
        listID: newToDo["listID"],
      ));
    });
    return newList;
  }

  List<Item> createList(objData) {
    List<Item> newList = [];
    objData.forEach((item) {
      newList.add(Item(
        name: item["title"],
        id: item["id"],
        isDone: item["done"],
      ));
    });
    return newList;
  }
}
