import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/data/myprovider.dart';
import 'package:template/views/Item_view.dart';
import 'package:template/data/ToDoListclass.dart';
import 'package:template/views/addNewList_view.dart';

class NavigationDrawer extends StatelessWidget {
  final List<ToDoList> toDolists;
  NavigationDrawer(this.toDolists);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenu(context),
            const Divider(color: Colors.black54),
            buildQuickSelectList(context, toDolists),
            addNewList(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => (Container(
      width: 200,
      height: 100,
      color: Colors.blue,
      child: const Center(
          child: Text(
        "ToDo App",
        style: TextStyle(fontSize: 32),
      )),
    ));

Widget addNewList(BuildContext context) => (Container(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.add,
              size: 30,
              color: Colors.green,
            ),
            title: const Text(
              "Lägg till ny lista",
              style: TextStyle(fontSize: 24),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddListViwe()),
              );
            },
          ),
        ],
      ),
    ));

Widget buildMenu(BuildContext context) => (Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.delete_forever_rounded,
            size: 30,
            color: Colors.blue,
          ),
          title: const Text(
            "Rensa avklarade",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            Provider.of<MyProvider>(context, listen: false).removeAllDone();
            Navigator.pop(context);
          },
        ),
      ],
    ));

// något är fel med hur objektet skickas skriv om och dubbelkolla hur det är gjort i itemview!

Widget buildQuickSelectList(BuildContext context, List<ToDoList> toDoLists) {
  return Column(
      children: toDoLists
          .map((listObj) => _selectListTile(context, listObj))
          .toList());
}

Widget _selectListTile(context, listObject) {
  return Container(
    padding: const EdgeInsets.only(top: 5, bottom: 5),
    child: ListTile(
      leading: listObject ==
              Provider.of<MyProvider>(context, listen: false).currentList
          ? Container(height: 100, width: 8, color: Colors.green)
          : Container(
              height: 100, width: 8, color: Color.fromARGB(255, 196, 193, 193)),
      title: Text(listObject.listTitle),
      onTap: () {
        Provider.of<MyProvider>(context, listen: false)
            .setCurrentList(listObject);
        Navigator.pop(context);
      },
      trailing: const Icon(Icons.more_vert),
    ),
  );
}
