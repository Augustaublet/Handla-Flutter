import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemHandler extends ChangeNotifier {
  List<Item> _items = [];
  String url = "http://127.0.0.1:5000/api/shoppingList";
  String _mainUrl = "http://127.0.0.1:5000";
  String _myKey = "mklsUgFnJ2AaFGeWz-RjjQ";
  String _path = "/api/shoppingList";

  // Construktor
  ItemHandler() {
    newItemList();
  }

  List<Item> get items => _items; // getter för lista med items

  Future newItemList() async {
    http.Response response =
        await http.get(Uri.parse("${_mainUrl}${_path}?key=$_myKey"));
    _items = createList(jsonDecode(response.body));
    notifyListeners();
  }

  Future addItem(String newItemName) async {
    http.Response response = await http.post(
      Uri.parse("${_mainUrl}${_path}?key=$_myKey"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"title": newItemName}),
    );
    _items = createList(json.decode(response.body));
    notifyListeners();
  }

  Future updateItemIsDone(Item itemToUpdate) async {
    http.Response response = await http.put(
      Uri.parse("$_mainUrl$_path/${itemToUpdate.id}?key=$_myKey"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "title": itemToUpdate.name,
        "done": !itemToUpdate.isDone,
      }),
    );
    _items = createList(json.decode(response.body));
    notifyListeners();
  }

  Future removeItem(Item itemToRemove) async {
    http.Response response = await http
        .delete(Uri.parse("$_mainUrl$_path/${itemToRemove.id}?key=$_myKey"));
    _items = createList(json.decode(response.body));
    notifyListeners();
  }

  List<Item> createList(ObjData) {
    List<Item> newList = [];
    ObjData.forEach((item) {
      newList.add(Item(
        name: item["title"],
        id: item["id"],
        isDone: item["done"],
      ));
    });
    return newList;
  }
}

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
