import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:template/views/ItemView.dart';
import 'addviwe.dart';
import '../components/itemclass.dart';
import 'navigationdrawer.dart';
import '../components/myprovider.dart';

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
          child: Consumer<MyProvider>(
            builder: (context, MyProvider, _) => MyProvider.loading
                ? const Text("loading")
                : Text(MyProvider.currentList.listTitle), //
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
      drawer: Consumer<MyProvider>(
        builder: (context, MyProvider, _) =>
            NavigationDrawer(MyProvider.allLists),
      ),
      body: Consumer<MyProvider>(
        builder: (context, MyProvider, _) =>
            ItemView(_filtreraLista(MyProvider.items, valtFilter)),
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
