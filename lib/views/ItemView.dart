import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/itemclass.dart';

import '../data/myprovider.dart';

class ItemView extends StatelessWidget {
  final List<Item> items;

  ItemView(this.items);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildItemTileList(context),
          addNewItemTile(context),
        ],
      ),
    );
  }

  Widget buildItemTileList(context) {
    return Column(
        children: items.map((item) => _itemListTile(context, item)).toList());
  }

  Widget _itemListTile(context, item) {
    return ListTile(
      leading: Checkbox(
        value: item.isDone,
        onChanged: (bool? newValue) {
          Provider.of<MyProvider>(context, listen: false)
              .updateItemIsDone(item);
        },
      ),
      title: Text(
        item.name,
        // overflow: TextOverflow.ellipsis,
        style: item.isDone
            ? const TextStyle(
                fontSize: 18, decoration: TextDecoration.lineThrough)
            : const TextStyle(fontSize: 18),
      ),
      trailing: IconButton(
        onPressed: () {
          Provider.of<MyProvider>(context, listen: false).removeItem(item);
        },
        padding: EdgeInsets.all(20.0),
        icon: Icon(Icons.delete_outline),
      ),
    );
  }

  Widget addNewItemTile(context) {
    TextEditingController _userInput = TextEditingController();
    return ListTile(
      title: TextField(
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        cursorHeight: 24,
        cursorColor: Colors.grey,
        textCapitalization: TextCapitalization.sentences,
        controller: _userInput,
        onSubmitted: ((value) {
          Provider.of<MyProvider>(context, listen: false).addItem(value);
          _userInput.clear();
        }),
      ),
      trailing: const Icon(
        Icons.add_circle_outline_rounded,
        size: 30,
        color: Colors.green,
      ),
      onTap: () => Provider.of<MyProvider>(context, listen: false)
          .addItem(_userInput.text),
    );
  }
}
