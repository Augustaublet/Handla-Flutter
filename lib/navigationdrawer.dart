import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/itemhandler.dart';
import 'package:template/ToDoListclass.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildHeader(context),
          buildMenu(context),
          //buildQuickSelectList(context),
        ],
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
        "ShoppingListan",
        style: TextStyle(fontSize: 32),
      )),
    ));

Widget buildMenu(BuildContext context) => (Container(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.delete_forever_rounded,
              size: 30,
              color: Colors.blue,
            ),
            title: const Text(
              "Rensa avklarade",
              style: TextStyle(fontSize: 24),
            ),
            onTap: () {
              Provider.of<ItemHandler>(context, listen: false).removeAllDone();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ));

// något är fel med hur objektet skickas skriv om och dubbelkolla hur det är gjort i itemview!

//Widget buildQuickSelectList(BuildContext context) =>  children: Provider.of<ItemHandler>(context, listen: false)
//           .allKeys
//          .map((key) => _selectListTile(context, key))
//        .toList();

Widget _selectListTile(context, keyObject) {
  print(keyObject);
  return ListTile(
      //title: Text(keyObject.tilte),
      );
}
