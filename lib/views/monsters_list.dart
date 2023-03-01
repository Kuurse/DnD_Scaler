import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/monster.dart';

class MonsterList extends StatefulWidget {
  const MonsterList({Key? key}) : super(key: key);

  @override
  State<MonsterList> createState() => _MonsterListState();
}

class _MonsterListState extends State<MonsterList> {
  List<Monster>? monsters = <Monster>[];
  List<Monster>? filteredMonsters = <Monster>[];
  bool _searchBoolean = false;


  @override
  void initState() {
    super.initState();
    fetchMonsters();
  }

  Future<void> fetchMonsters() async {
    var json = await http.get(Uri.parse('https://raw.githubusercontent.com/Kuurse/DnD_Scaler/main/assets/monsters.json'));
    monsters = Response.fromJson(jsonDecode(json.body)).results;
    setState(() {
      monsters = Response.fromJson(jsonDecode(json.body)).results;
      filteredMonsters = List.from(monsters!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: !_searchBoolean ? const Text("Monstrueux") : _searchTextField(),
            actions: !_searchBoolean ? [
              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = true;
                    });
                  })
            ] : [
              IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = false;
                    });
                  }
              )
            ]
        ),
        drawer: const Drawer(),
        body: !_searchBoolean ? _defaultListView() : _searchListView()
    );
  }


  Widget _defaultListView() {
    return ListView.builder(
        itemCount: monsters!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
                  title: Text(monsters![index].name ?? "")
              )
          );
        }
    );
  }

  Widget _searchListView() { //add
    return ListView.builder(
        itemCount: filteredMonsters!.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(filteredMonsters![index].name ?? "")
              )
          );
        }
    );
  }

  Widget _searchTextField() {
    return TextField(
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search, //Specify the action button on the keyboard
      decoration: const InputDecoration( //Style of TextField
        enabledBorder: UnderlineInputBorder( //Default TextField border
            borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: UnderlineInputBorder( //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)
        ),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle( //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
      onChanged: onChanged,
    );
  }

  void onChanged(String string){
    // filteredMonsters = List.from(monsters!);
    setState(() {
      filteredMonsters = List.from(monsters!);
      monsters?.forEach((monster) {
        if (!monster.name!.toLowerCase().contains(string.toLowerCase())){
          filteredMonsters?.remove(monster);
        }
      });
    });
  }
}
