

import 'package:dnd_helper/views/drawer.dart';
import 'package:flutter/material.dart';

class ScaleMonsterPage extends StatefulWidget {
  const ScaleMonsterPage({Key? key}) : super(key: key);

  @override
  State<ScaleMonsterPage> createState() => _ScaleMonsterPageState();
}

class _ScaleMonsterPageState extends State<ScaleMonsterPage> {
  final int normalPartySize = 4;
  final int ourPartySize = 7;
  String? text;

  // TextEditingController targetPartySizeController = TextEditingController();
  String? scaledHp;
  String? scaledMultiatt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SCALE IT BABY"),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              Text("HP: "),
              Expanded(
                child: TextFormField(
                  // controller: targetPartySizeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "HP",
                  ),
                  onChanged: scaleHp,
                  validator: validate,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Nombre d'attaques: "),
              Expanded(
                child: TextFormField(
                  // controller: targetPartySizeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nombre d'attaques",
                  ),
                  validator: validate,
                  onChanged: scaleMultiAtt,
                ),
              ),
            ],
          ),
          Text("Scaled HP: $scaledHp"),
          Text("Scaled multiatt : $scaledMultiatt"),
        ],
      ),
    );
  }

  void scaleHp(String input) {
    try {
      var hitPoints = int.parse(input);
      setState(() {
        scaledHp = ((hitPoints/4)*7).round().toString();
      });
    } on FormatException {
      setState(() {
        scaledHp = "";
      });
    }


  }

  void scaleMultiAtt(String input) {
    var mod = ourPartySize/normalPartySize;
    try {
      var multiattack = int.parse(input);
      setState(() {
        scaledMultiatt = (multiattack*mod).toString();
      });
    } on FormatException {
      setState(() {
        setState(() {
          scaledMultiatt = "";
        });
      });
    }

  }

  String? validate(String? value) {
    try {
      int.parse(value!);
      return null;
    } on  Exception {
      return "Entrée invalide";
    }
  }
}
