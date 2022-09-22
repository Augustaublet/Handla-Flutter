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
        title: 'Aublet ToDo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainViwe(),
      ),
    );
  }
}


// thing to do

// # ändra data struktur för att hantera flera listor
//    - Visa namn från listan(api)
//    - Välja vilken lista som skall visas i drawe menyn
//    - Testa på telefon och justera storlek för den skärmen
//    - Ändra så att man läger till nytt objekt på samma sida(längst ner) (ta bort knappen)
//    - Fixa så man kan svepa in menyn?
//    - Sida för att skapa ny lista? (behöver apifix)
//    - Ta bort lista(behöver apifix)
//    - Menyval för de båda.