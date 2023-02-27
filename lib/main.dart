import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Models/monster.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Monster>? monsters = <Monster>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String j = await rootBundle.loadString('assets/lone_monster.json');
    Map<String, dynamic> data = await json.decode(j);
    var response = Response.fromJson(data);
    setState(() {
      monsters = response.results;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        // Define the default font family.
        // fontFamily: 'Arial',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Monstrueux"),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: monsters!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child:  Text(monsters![index].name ?? "noname"),
                );
              }
          )
        )
      )
    );
  }
}
