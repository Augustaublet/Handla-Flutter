import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './itemhandler.dart';
import './mainviwe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemHandler()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inlämningsupgift moment 1 TIG333',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainViwe(),
      ),
    );
  }
}
