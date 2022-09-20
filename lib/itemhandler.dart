import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './itemclass.dart';

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
