import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './itemhandler.dart';

class ItemViwe extends StatelessWidget {
  final List<Item> items;

  ItemViwe(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: items.map((item) => _itemListTile(context, item)).toList());
  }

  Widget _itemListTile(context, item) {
    return ListTile(
      leading: Checkbox(
        value: item.isDone,
        onChanged: (bool? newValue) {
          Provider.of<ItemHandler>(context, listen: false)
              .updateItemIsDone(item);
        },
      ),
      title: Text(
        item.name,
        overflow: TextOverflow.ellipsis,
        style: item.isDone
            ? const TextStyle(
                fontSize: 24, decoration: TextDecoration.lineThrough)
            : const TextStyle(fontSize: 24),
      ),
      trailing: IconButton(
        onPressed: () {
          Provider.of<ItemHandler>(context, listen: false).removeItem(item);
        },
        padding: EdgeInsets.all(20.0),
        icon: Icon(Icons.delete_outline),
      ),
    );
  }
}
