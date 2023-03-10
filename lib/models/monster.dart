import 'package:dnd_helper/tools/extensions.dart';
import 'dart:math';

import 'operator.dart';

/**
RegExp fullRegExp = RegExp(r'(\d+)d(\d+)(([+--](((\d+)d(\d+))|(\d+)))+)?');
RegExp numericRegExp = RegExp(r'\d+');
RegExp diceRegExp = RegExp(r'(\d+)d(\d+)');
RegExp operatorRegExp = RegExp(r'[+\-]');
 */

class Response {
  int? count;
  String? next;
  String? previous;
  List<Monster>? results;

  Response({this.count, this.next, this.previous, this.results});

  Response.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Monster>[];
      json['results'].forEach((v) {
        results!.add(Monster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Monster {
  String? slug;
  String? name;
  String? size;
  String? type;
  String? subtype;
  String? group;
  String? alignment;
  int? armorClass;
  String? armorDesc;
  int? hitPoints;
  DiceRoll? hitDice;
  Speed? speed;
  int? strength;
  int? dexterity;
  int? constitution;
  int? intelligence;
  int? wisdom;
  int? charisma;
  int? strengthSave;
  int? dexteritySave;
  int? constitutionSave;
  int? intelligenceSave;
  int? wisdomSave;
  int? charismaSave;
  int? perception;
  Map<String, dynamic>? skills;
  String? damageVulnerabilities;
  String? damageResistances;
  String? damageImmunities;
  String? conditionImmunities;
  String? senses;
  String? languages;
  String? challengeRating;
  List<Action>? actions;
  List<Action>? reactions;
  String? legendaryDesc;
  List<Action>? legendaryActions;
  List<Action>? specialAbilities;
  List<dynamic>? spellList;
  String? imgMain;
  String? documentSlug;
  String? documentTitle;
  String? documentLicenseUrl;
  num? multiattack;
  int xp = 0;

  Monster(
      {this.slug,
        this.name,
        this.size,
        this.type,
        this.subtype,
        this.group,
        this.alignment,
        this.armorClass,
        this.armorDesc,
        this.hitPoints,
        this.hitDice,
        this.speed,
        this.strength,
        this.dexterity,
        this.constitution,
        this.intelligence,
        this.wisdom,
        this.charisma,
        this.strengthSave,
        this.dexteritySave,
        this.constitutionSave,
        this.intelligenceSave,
        this.wisdomSave,
        this.charismaSave,
        this.perception,
        this.skills,
        this.damageVulnerabilities,
        this.damageResistances,
        this.damageImmunities,
        this.conditionImmunities,
        this.senses,
        this.languages,
        this.challengeRating,
        this.actions,
        this.reactions,
        this.legendaryDesc,
        this.legendaryActions,
        this.specialAbilities,
        this.spellList,
        this.imgMain,
        this.documentSlug,
        this.documentTitle,
        this.documentLicenseUrl});

  Monster.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    size = json['size'];
    type = json['type'];
    subtype = json['subtype'];
    group = json['group'];
    alignment = json['alignment'];
    armorClass = json['armor_class'];
    armorDesc = json['armor_desc'];
    hitPoints = json['hit_points'];
    hitDice = DiceRoll.fromJson(json['hit_dice']);
    speed = json['speed'] != null ? Speed.fromJson(json['speed']) : null;
    strength = json['strength'] ?? 0;
    dexterity = json['dexterity'] ?? 0;
    constitution = json['constitution'] ?? 0;
    intelligence = json['intelligence'] ?? 0;
    wisdom = json['wisdom'] ?? 0;
    charisma = json['charisma'] ?? 0;
    strengthSave = json['strength_save'] ?? 0;
    dexteritySave = json['dexterity_save'] ?? 0;
    constitutionSave = json['constitution_save'] ?? 0;
    intelligenceSave = json['intelligence_save'] ?? 0;
    wisdomSave = json['wisdom_save'] ?? 0;
    charismaSave = json['charisma_save'] ?? 0;
    perception = json['perception'] ?? 0;
    skills = json['skills'];
    damageVulnerabilities = json['damage_vulnerabilities'];
    damageResistances = json['damage_resistances'];
    damageImmunities = json['damage_immunities'];
    conditionImmunities = json['condition_immunities'];
    senses = json['senses'];
    languages = json['languages'];
    challengeRating = json['challenge_rating'];

    actions = <Action>[];
    if (json['actions'] != "") {
      json['actions'].forEach((v) {
        actions!.add(Action.fromJson(v));
      });
    }

    if (json['reactions'] != "" && json['reactions'] != null) {
      reactions = <Action>[];
      json['reactions'].forEach((v) {
        reactions!.add(Action.fromJson(v));
      });
    }

    legendaryDesc = json['legendary_desc'];
    legendaryActions = <Action>[];
    if (json['legendary_actions'] != "") {
      json['legendary_actions'].forEach((v) {
        legendaryActions!.add(Action.fromJson(v));
      });
    }

    specialAbilities = <Action>[];
    if (json['special_abilities'] != "") {
      json['special_abilities'].forEach((v) {
        specialAbilities!.add(Action.fromJson(v));
      });
    }

    spellList = json['spell_list'];
    imgMain = json['img_main'];
    documentSlug = json['document__slug'];
    documentTitle = json['document__title'];
    documentLicenseUrl = json['document__license_url'];
  }

  int getAttackPerTurnCount() {
    Action? multiatt = actions?.where((action) => action.name!.contains("Multiattack")).first;
    int multi = 1;

    if (multiatt != null){
      var textNum = multiatt.desc!.valueBetween("makes", "attacks");
      multi = IntExtension.fromPlainEnglish(textNum!);
    }

    multiattack = multi;
    return multi;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['size'] = size;
    data['type'] = type;
    data['subtype'] = subtype;
    data['group'] = group;
    data['alignment'] = alignment;
    data['armor_class'] = armorClass;
    data['armor_desc'] = armorDesc;
    data['hit_points'] = hitPoints;
    data['hit_dice'] = hitDice.toString();
    if (speed != null) {
      data['speed'] = speed!.toJson();
    }
    data['strength'] = strength;
    data['dexterity'] = dexterity;
    data['constitution'] = constitution;
    data['intelligence'] = intelligence;
    data['wisdom'] = wisdom;
    data['charisma'] = charisma;
    data['strength_save'] = strengthSave;
    data['dexterity_save'] = dexteritySave;
    data['constitution_save'] = constitutionSave;
    data['intelligence_save'] = intelligenceSave;
    data['wisdom_save'] = wisdomSave;
    data['charisma_save'] = charismaSave;
    data['perception'] = perception;
    data['skills'] = skills;
    data['damage_vulnerabilities'] = damageVulnerabilities;
    data['damage_resistances'] = damageResistances;
    data['damage_immunities'] = damageImmunities;
    data['condition_immunities'] = conditionImmunities;
    data['senses'] = senses;
    data['languages'] = languages;
    data['challenge_rating'] = challengeRating;
    if (actions != null) {
      data['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    data['reactions'] = reactions;
    data['legendary_desc'] = legendaryDesc;
    if (legendaryActions != null) {
      data['legendary_actions'] =
          legendaryActions!.map((v) => v.toJson()).toList();
    }
    if (specialAbilities != null) {
      data['special_abilities'] =
          specialAbilities!.map((v) => v.toJson()).toList();
    }
    data['spell_list'] = spellList;
    data['img_main'] = imgMain;
    data['document__slug'] = documentSlug;
    data['document__title'] = documentTitle;
    data['document__license_url'] = documentLicenseUrl;
    return data;
  }

  @override
  String toString() {
    var sb = StringBuffer();
    toJson().forEach((key, value) {
      sb.writeln('$key : ${value.toString()}');
    });
    return sb.toString();
  }
}

class Speed {
  int? walk;
  int? fly;
  int? swim;
  int? burrow;
  int? climb;

  Speed({this.walk, this.fly, this.swim, this.burrow});

  Speed.fromJson(Map<String, dynamic> json) {
    walk = json['walk'];
    fly = json['fly'];
    swim = json['swim'];
    burrow = json['burrow'];
    climb = json['climb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walk'] = walk;
    data['fly'] = fly;
    data['swim'] = swim;
    data['burrow'] = burrow;
    data['climb'] = climb;
    return data;
  }
}

class Action {
  String? name;
  String? desc;
  int? attackBonus;
  DiceRoll? damageDice;
  int? avgDamage;
  int? damageBonus;

  Action(
      { this.name,
        this.desc,
        this.attackBonus,
        this.damageDice}){
    // int? read = readAverageDamage();
    // int? compute = computeAverageDamage();
    // print("$read $compute");
  }

  int? readAverageDamage() {
    var regex = RegExp(r'Hit: \d+');

    int avg = 0;
    if (regex.hasMatch(desc!)) {
      var match = regex.firstMatch(desc!)?.group(0)?.replaceAll("Hit: ", "");
      if (match != null) {
        avg += int.parse(match);
      }
    }

    regex = RegExp(r'plus \d+ \(');
    if (regex.hasMatch(desc!)) {
      var match = regex.firstMatch(desc!)?.group(0)?.replaceAll("plus ", "").replaceAll(" (", "");
      if (match != null) {
        avg += int.parse(match);
      }
    }

    return avg == 0 ? null : avg;
  }



  int? computeAverageDamage() {
    if (damageDice == null && damageBonus == null) return 0;
    int avg = 0;
    if (damageDice != null)
    {
      avg += damageDice!.getAverageRoll();
    }
    if (damageBonus != null) {
      avg += damageBonus!;
    }

    return avg;
  }

  Action.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'].replaceAll(" + ", "+");
    attackBonus = json['attack_bonus'];
    damageBonus = json['damage_bonus'];
    if (json['damage_dice'] != null) {
      damageDice = DiceRoll.fromJson(json['damage_dice']);
    }
    avgDamage = readAverageDamage();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['desc'] = desc;
    data['attack_bonus'] = attackBonus;
    data['damage_dice'] = damageDice.toString();
    data['damage_bonus'] = damageBonus;
    return data;
  }
}

class DiceValue {
  int? amount;
  int? diceFaces;
  DiceValue(this.amount, this.diceFaces);

  DiceValue.fromString(String string) {
    var split = string.split('d');
    amount = int.parse(split.first);
    diceFaces = int.parse(split.last);
  }

  @override
  String toString() {
    return "${amount}d$diceFaces";
  }

  int getAverageRoll() {
    return ((amount! + (amount!*diceFaces!))~/2);
  }
}

class DiceRoll {
  List<DiceValue>? values;
  int? modifier;

  DiceRoll({this.values, this.modifier});

  DiceRoll.fromJson(String json) {
    if (json == null || json == "null") return;
    var splits = json.splitAtIndexes(getOperatorIndexes(json));
    values = <DiceValue>[];
    for (var split in splits) {
      if (!split.contains("d")) {
        try {
          modifier = int.parse(split);
        } on FormatException {
          print(split);
        }
      } else {
        values!.add(DiceValue.fromString(split));
      }
    }
    if (values!.isEmpty) values = null;
  }

  List<int> getOperatorIndexes(String str) {
    var operatorIndexes = <int>[];
    var indexCounter = 0;
    for (var rune in str.runes) {
      var character= String.fromCharCode(rune);
      var operator = parseOperator(character);
      if (operator != Operator.unknown){
        operatorIndexes.add(indexCounter);
      }
      ++indexCounter;
    }

    return operatorIndexes;
  }

  int getAverageRoll(){
    if (values == null) return 0;
    int sum = 0;
    for (int i=0; i<values!.length; i++) {
      var value = values!.elementAt(i);
      sum += value.getAverageRoll();
    }
    if (modifier != null) {
      sum += modifier!;
    }

    return sum;
  }

  @override
  String toString() {
    var buffer = StringBuffer();
    values?.forEach((element) {
      buffer.write(element.toString());
      buffer.write("+");
    });
    buffer.write(modifier.toString());
    return buffer.toString();
  }
}
