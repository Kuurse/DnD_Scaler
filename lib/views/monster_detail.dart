import 'package:dnd_helper/views/stat_block.dart';
import 'package:flutter/material.dart';
import '../models/monster.dart';

class MonsterDetailPage extends StatelessWidget {
  Monster? monster;
  MonsterDetailPage({this.monster, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(monster?.name ?? "Monstre"),
      ),
      body: Column(
        children: [
          StatBlock(monster),
          const Text("Haha"),
        ],
      )
    );
  }
}
