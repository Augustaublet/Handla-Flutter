import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './ToDoListclass.dart';
import './itemclass.dart';

class ItemHandler extends ChangeNotifier {
  final String APIKEY = "mklsUgFnJ2AaFGeWz-RjjQ";
  List<Item> _items = [];
  List<ToDoList> _ToDoLists = [
    ToDoList("lista1", "0v_DQMrr3Qk"),
    ToDoList("lista2", "KvSFI95gEtg")
  ];
  var _currentList;
  String _mainUrl = "http://127.0.0.1:5000";
  String _path = "/api/shoppingList";

  // Construktor
  ItemHandler() {
    _loadCurrentKey();
    newItemList();
  }

  List<Item> get items => _items; // getter för lista med items
  ToDoList get currentKey => _currentList;
  List<ToDoList> get allKeys => _ToDoLists;

  _loadCurrentKey() {
    _currentList = _ToDoLists[0];
  }

  Future getAllLists() async {
    http.Response response = await http
        .get(Uri.parse("${_mainUrl}/api/allshoppinglists?key=${APIKEY}"));
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
