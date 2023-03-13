import 'package:dnd_helper/views/scale_monster_page.dart';
import 'package:flutter/material.dart';
import 'Views/monsters_list.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
      ),
      home: const MonsterList(),
      // home: const ScaleMonsterPage()
    );
  }
}
