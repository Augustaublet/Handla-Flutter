import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/data/myprovider.dart';
import 'package:template/views/main_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aublet ToDo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainViwe(),
      ),
    );
  }
}
