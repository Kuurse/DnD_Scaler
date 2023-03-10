import 'package:flutter/material.dart';
import '../models/monster.dart';

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
          name: "STR",
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
          name: "WIS",
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

