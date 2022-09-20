import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/keyclass.dart';
import './itemclass.dart';

class ItemHandler extends ChangeNotifier {
  List<Item> _items = [];
  List<MyApiKey> _myApiKeys = [
    MyApiKey("lista1", "mklsUgFnJ2AaFGeWz-RjjQ"),
    MyApiKey("lista2", "SCzgKrYbsyQ7pjSRNzvwRA")
  ];
  var _currentKey;
  String _mainUrl = "http://127.0.0.1:5000";
  String _path = "/api/shoppingList";

  // Construktor
  ItemHandler() {
    _loadCurrentKey();
    newItemList();
  }

  List<Item> get items => _items; // getter för lista med items
  MyApiKey get currentKey => _currentKey;
  _loadCurrentKey() {
    _currentKey = _myApiKeys[0];
  }

  Future newItemList() async {
    http.Response response = await http
        .get(Uri.parse("${_mainUrl}${_path}?key=${_currentKey.apiKey}"));
    _items = createList(jsonDecode(response.body));
    notifyListeners();
  }

  Future addItem(String newItemName) async {
    http.Response response = await http.post(
      Uri.parse("${_mainUrl}${_path}?key=${_currentKey.apiKey}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"title": newItemName}),
    );
    _items = createList(json.decode(response.body));
    notifyListeners();
  }

  Future updateItemIsDone(Item itemToUpdate) async {
    http.Response response = await http.put(
      Uri.parse("$_mainUrl$_path/${itemToUpdate.id}?key=${_currentKey.apiKey}"),
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
              "$_mainUrl$_path/${item.id}?key=${_currentKey.apiKey}"));
        }
      },
    );
    newItemList();
  }

  Future removeItem(Item itemToRemove) async {
    http.Response response = await http.delete(Uri.parse(
        "$_mainUrl$_path/${itemToRemove.id}?key=${_currentKey.apiKey}"));
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
