import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:template/ItemViwe.dart';
import 'package:template/itemhandler.dart';
import './addviwe.dart';
import './itemclass.dart';
import "./navigationdrawer.dart";

class MainViwe extends StatefulWidget {
  @override
  State<MainViwe> createState() => _MainViweState();
}

class _MainViweState extends State<MainViwe> {
  String valtFilter = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Consumer<ItemHandler>(
            builder: (context, ItemHandler, _) =>
                Text(ItemHandler.currentList.listTitle), //
          ),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButton(
                    icon: Icon(Icons.more_vert),
                    items: [
                      filterVal("All"),
                      filterVal("Done"),
                      filterVal("Undone")
                    ],
                    onChanged: (value) {
                      setState(() {
                        valtFilter = value.toString();
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
      drawer: Consumer<ItemHandler>(
        builder: (context, ItemHandler, _) =>
            NavigationDrawer(ItemHandler.allLists),
      ),
      body: Consumer<ItemHandler>(
        builder: (context, ItemHandler, _) =>
            ItemViwe(_filtreraLista(ItemHandler.items, valtFilter)),
      ),
      // body: ItemRow(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemViwe()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  DropdownMenuItem<String> filterVal(String value) {
    return DropdownMenuItem(value: value, child: Text(value));
  }

  List<Item> _filtreraLista(lista, valtFiler) {
    if (valtFiler == "Done") {
      List<Item> newList = [];
      lista.forEach(
        (item) {
          if (item.isDone) {
            newList.add(item);
          }
        },
      );
      return newList;
    } else if (valtFiler == "Undone") {
      List<Item> newList = [];
      lista.forEach(
        (item) {
          if (!item.isDone) {
            newList.add(item);
          }
        },
      );
      return newList;
    } else {
      return lista;
    }
  }
}
