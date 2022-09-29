import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/myprovider.dart';

class AddListViwe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 20,
            ),
            AddList(),
          ],
        ),
      ),
    );
  }
}

class AddList extends StatelessWidget {
  TextEditingController userInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, MyProvider, _) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 70),
            child: TextField(
              onSubmitted: (value) {
                MyProvider.addNewList(value);
                Navigator.pop(context);
              },
              controller: userInput,
              decoration: const InputDecoration(
                hintText: "Namn på ny lista",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              MyProvider.addNewList(userInput.text);
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "+ ADD",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
