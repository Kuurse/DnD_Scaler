import 'package:flutter/material.dart';
import '../models/monster.dart';


class StatBlock extends StatelessWidget {
  Monster? monster;
  StatBlock(this.monster, {super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const int itemHeight = 85;
    final double itemWidth = size.width / 3;

    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      childAspectRatio: (itemWidth / itemHeight),
      children: <Widget>[
        StatDetail(
          name: "STR",
          value: monster?.strength,
        ),
        StatDetail(
          name: "DEX",
          value: monster?.dexterity,
        ),
        StatDetail(
          name: "CON",
          value: monster?.constitution,
        ),
        StatDetail(
          name: "INT",
          value: monster?.intelligence,
        ),
        StatDetail(
          name: "WIS",
          value: monster?.wisdom,
        ),
        StatDetail(
          name: "CHA",
          value: monster?.charisma,
        ),
      ],
    );
  }
}

class StatDetail extends StatelessWidget {
  String? name;
  int? value;
  StatDetail({this.name, this.value, super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(top:15, bottom: 15),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.red,
        // ),
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        children: [
          Text(
            name ?? "?",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            )
          ),
          Text("$value"),
        ],
      ),
    );
  }
}

