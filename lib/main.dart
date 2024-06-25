import 'package:flutter/material.dart';
import 'package:software_con/model/item.dart';
import 'package:software_con/providers/items_providers.dart';
import 'package:software_con/screens/item_screen_list.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: MaterialApp(
        title: 'Flutter CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: ItemListScreen(),
      ),
    );
  }
}