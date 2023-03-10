import 'package:dnd_helper/views/stat_block.dart';
import 'package:flutter/material.dart';
import '../tools/scaler.dart';
import '../models/monster.dart';
import 'action_list.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0 ,6.0, 0, 0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Armor Class: ${monster?.armorClass}")
                      ),
                      const SizedBox(height: 4),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("HP: ${monster?.hitPoints} (${monster?.hitDice})")
                      ),
                      const SizedBox(height: 4),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(getInitiativeText())
                      ),
                      const SizedBox(
                        width: 0,
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: StatBlock(monster),
              ),
              Text("Skills"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${monster!.skills?[0]}"),
                  Text("${monster!.skills?[1]}"),
                ],
              ),
              ActionList("Action list", monster!.actions ?? []),
              ActionList("Legendary actions", monster!.legendaryActions ?? []),
              ActionList("Reactions", monster!.reactions ?? []),
              ActionList("Special ", monster!.specialAbilities ?? []),
              ElevatedButton(
                  onPressed: onPressed,
                  child: const Text("Scale")
              )
            ],
          ),
        ),
      )
    );
  }

  String getInitiativeText() {
    var dexBonus = (monster!.dexterity!-10)~/2;
    var plus = dexBonus >= 0 ? "+" : "";
    return "Initiative: $plus$dexBonus";
  }

  void onPressed() {
    // print(monster?.hitPoints);
    // var mon = monster?.scaleToPartySize(7);
    // print(mon?.toString());
    var mon2 = monster?.scaleToPartyLevel(10, 6);
    // print(mon2);
  }
}
