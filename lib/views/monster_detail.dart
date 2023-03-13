import 'package:flutter/material.dart';
import '../tools/scaler.dart';
import '../models/monster.dart';
import 'package:dnd_helper/models/monster.dart' as mon;

class MonsterDetailPage extends StatelessWidget {
  Monster? monster;
  MonsterDetailPage({this.monster, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(monster?.name ?? "Monstre"),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.scale_sharp),
              itemBuilder: (context){
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Taille du groupe"),
                  ),

                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Niveau du groupe"),
                  ),
                ];
              },
              onSelected:(value){
                switch (value) {
                  case 0:
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return PartySizeScalingDialog(monster!);
                        }
                    );
                    break;
                  case 1:
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return LevelScalingDialog(monster!);
                      }
                    );
                    break;
                }
              }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MonsterHeader(monster!),
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: StatBlock(monster),
              ),
              SkillsList(monster!.skills!),
              Row(
                children: [
                  const Text("Senses:  "),
                  Flexible(
                    child: Text(
                        monster!.senses!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height:4),
              Row(
                children: [
                  const Text("Immunités:  "),
                  Text(monster!.damageImmunities!),
                ],
              ),
              ActionList("Actions", monster!.actions ?? []),
              ActionList("Legendary actions", monster!.legendaryActions ?? []),
              ActionList("Reactions", monster!.reactions ?? []),
              ActionList("Special", monster!.specialAbilities ?? []),
            ],
          ),
        ),
      )
    );
  }
}

class ActionList extends StatelessWidget {
  final List<mon.Action> actions;
  final String title;
  const ActionList(this.title, this.actions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ListView.builder(
          itemCount: actions.length,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
                    title: Column(
                      children: [
                        Text(actions[index].name!),
                        Text(actions[index].desc!),
                      ],
                    )
                )
            );
          },
        ),
      ],
    );
  }
}

class MonsterHeader extends StatelessWidget {
  final Monster monster;
  const MonsterHeader(this.monster, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Text("Classe d'armure: ${monster.armorClass}")
            ),
            const SizedBox(height: 4),
            Align(
                alignment: Alignment.topLeft,
                child: Text("HP: ${monster.hitPoints} (${monster.hitDice})")
            ),
            const SizedBox(height: 4),
            Align(
                alignment: Alignment.topLeft,
                child: Text(getInitiativeText())
            ),
            const SizedBox(height: 4),
            Align(
                alignment: Alignment.topLeft,
                child: Text("Facteur de puissance: ${monster.challengeRating}"),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Bonus de maitrise: ${monster.proficiencyBonus}"),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  String getInitiativeText() {
    var dexBonus = (monster.dexterity!-10)~/2;
    var plus = dexBonus >= 0 ? "+" : "";
    return "Initiative: $plus$dexBonus";
  }
}

class SkillsList extends StatelessWidget {
  List<Stat> skills;
  SkillsList(this.skills, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const columns = 2;
    final double itemWidth = size.width / columns;
    const double height = 20.0;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Skills",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height:4),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisCount: columns,
              childAspectRatio: (itemWidth / height),
              children: List<Widget>.generate(
                  skills.length,
                      (index) => Row(
                      children: [
                        Text("${skills[index].name} : "),
                        Text("${skills[index].value}"),
                      ]
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const double height = 90;

class StatBlock extends StatelessWidget {
  final Monster? monster;
  const StatBlock(this.monster, {super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;

    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      childAspectRatio: (itemWidth / height),
      children: <Widget>[
        StatDetail(
            name: "FOR",
            value: monster?.strength,
            save: monster?.strengthSave
        ),
        StatDetail(
          name: "DEX",
          value: monster?.dexterity,
          save: monster?.dexteritySave,
        ),
        StatDetail(
          name: "CON",
          value: monster?.constitution,
          save: monster?.constitutionSave,
        ),
        StatDetail(
          name: "INT",
          value: monster?.intelligence,
          save: monster?.intelligenceSave,
        ),
        StatDetail(
          name: "SAG",
          value: monster?.wisdom,
          save: monster?.wisdomSave,
        ),
        StatDetail(
          name: "CHA",
          value: monster?.charisma,
          save: monster?.charismaSave,
        ),
      ],
    );
  }
}

class StatDetail extends StatelessWidget {
  final String? name;
  final int? value;
  final int? save;
  const StatDetail({this.name, this.value, this.save, super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      padding: const EdgeInsets.only(top:10, bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: Column(
          children: [
            Text(
                name ?? "?",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                )
            ),
            const SizedBox(height: 4),
            Text("$value (${getValueBonus(value)})"),
            Text(
              "${save! >= 0 ? "+$save" : save}",
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getValueBonus(int? value){
    if (value == null) return "+0";
    int bonus = (value-10) ~/ 2;
    String plusMinus = bonus > 0 ? "+" : "";
    return "$plusMinus$bonus";
  }
}

class LevelScalingDialog extends StatelessWidget {

  Monster monster;
  LevelScalingDialog(this.monster, {super.key}){
    designedLevelController.text = 6.toString();
    targetLevelController.text = 1.toString();
  }
  String? text;

  TextEditingController designedLevelController = TextEditingController();
  TextEditingController targetLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Title'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GridView.count(
            crossAxisCount: 2,
            primary:false,
            shrinkWrap: true,
            children: [
              const Text("Designed party level"),
              TextField(
                controller: designedLevelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "5",
                ),
                onChanged: (text) => this.text = text,
              ),
              const Text("Target party level"),
              TextField(
                controller: targetLevelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Target party level",
                ),
                onChanged: (text) => this.text = text,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              var designedLevel = int.parse(designedLevelController.text);
              var targetLevel = int.parse(targetLevelController.text);
              var scaled = monster.scaleToPartyLevel(targetLevel, designedLevel);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>
                      MonsterDetailPage(monster: scaled)
                  )
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text("OK"),
          ),
        ]
    );
  }
}

class PartySizeScalingDialog extends StatelessWidget {

  Monster monster;
  PartySizeScalingDialog(this.monster, {super.key}){
    targetPartySizeController.text = 7.toString();
  }
  String? text;

  TextEditingController targetPartySizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Title'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GridView.count(
            crossAxisCount: 2,
            primary:false,
            shrinkWrap: true,
            children: [
              const Text("Target party size"),
              TextField(
                controller: targetPartySizeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Target party size",
                ),
                onChanged: (text) => this.text = text,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              var targetPartySize = int.parse(targetPartySizeController.text);
              var scaled = monster.scaleToPartySize(targetPartySize);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>
                      MonsterDetailPage(monster: scaled)
                  )
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text("OK"),
          ),
        ]
    );
  }
}

