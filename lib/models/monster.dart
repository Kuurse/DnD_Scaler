import 'package:dnd_helper/Tools/extensions.dart';

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
  List<DescribableAction>? legendaryActions;
  List<DescribableAction>? specialAbilities;
  List<dynamic>? spellList;
  String? imgMain;
  String? documentSlug;
  String? documentTitle;
  String? documentLicenseUrl;

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
    strength = json['strength'];
    dexterity = json['dexterity'];
    constitution = json['constitution'];
    intelligence = json['intelligence'];
    wisdom = json['wisdom'];
    charisma = json['charisma'];
    strengthSave = json['strength_save'];
    dexteritySave = json['dexterity_save'];
    constitutionSave = json['constitution_save'];
    intelligenceSave = json['intelligence_save'];
    wisdomSave = json['wisdom_save'];
    charismaSave = json['charisma_save'];
    perception = json['perception'];
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

    if (json['reactions'] != "") {
      reactions = <Action>[];
      json['reactions'].forEach((v) {
        reactions!.add(Action.fromJson(v));
      });
    }

    legendaryDesc = json['legendary_desc'];
    legendaryActions = <DescribableAction>[];
    if (json['legendary_actions'] != "") {
      json['legendary_actions'].forEach((v) {
        legendaryActions!.add(DescribableAction.fromJson(v));
      });
    }

    specialAbilities = <DescribableAction>[];
    if (json['special_abilities'] != "") {
      json['special_abilities'].forEach((v) {
        specialAbilities!.add(DescribableAction.fromJson(v));
      });
    }

    spellList = json['spell_list'];
    imgMain = json['img_main'];
    documentSlug = json['document__slug'];
    documentTitle = json['document__title'];
    documentLicenseUrl = json['document__license_url'];
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

class Action extends DescribableAction {
  int? attackBonus;
  DiceRoll? damageDice;
  int? damageBonus;

  Action(
      { String? name,
        String? desc,
        this.attackBonus,
        this.damageDice,
        this.damageBonus}) : super(name, desc);

  Action.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    attackBonus = json['attack_bonus'];
    damageBonus = json['damage_bonus'];
    if (json['damage_dice'] != null) {
      damageDice = DiceRoll.fromJson(json['damage_dice']);
    }
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

class DescribableAction {
  String? name;
  String? desc;

  DescribableAction(this.name, this.desc);

  DescribableAction.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['desc'] = desc;
    return data;
  }
}

class Value {
  static RegExp fullRegExp = RegExp(r'(\d+)d(\d+)(([+--](((\d+)d(\d+))|(\d+)))+)?');
  static RegExp numericRegExp = RegExp(r'\d+');
  static RegExp diceRegExp = RegExp(r'(\d+)d(\d+)');
  static RegExp operatorRegExp = RegExp(r'[+\-]');

  static Value? fromString(String string) {
    if (diceRegExp.hasMatch(string)) {
      return DiceValue.fromString(string);
    } else if (numericRegExp.hasMatch(string)) {
      return RawValue(int.parse(string));
    } else if (operatorRegExp.hasMatch(string)) {
      return Operator(string);
    } else {
      return null;
    }
  }
}

class Operator extends Value {
  String? operator;
  Operator(this.operator);

  @override
  String toString() {
    return operator!;
  }
}

class RawValue extends Value {
  int? value;
  RawValue(this.value);

  @override
  String toString() {
    return value!.toString();
  }
}

class DiceValue extends Value {
  int? amount;
  int? die;
  DiceValue(this.amount, this.die);

  DiceValue.fromString(String string) {
    var split = string.split('d');
    amount = int.parse(split.first);
    die = int.parse(split.last);
  }

  @override
  String toString() {
    return "${amount}d$die";
  }
}

class DiceRoll {
  List<Value>? values;
  DiceRoll(this.values);

  DiceRoll.fromJson(String json) {
    var uncomputedValues = json.splitWithDelim(RegExp(r'[+--]'));
    values = <Value>[];
    for (var element in uncomputedValues) {
      var value = Value.fromString(element);
      if (value != null) {
        values?.add(value);
      }
    }
  }

  @override
  String toString() {
    var buffer = StringBuffer();
    values?.forEach((element) {
      buffer.write(element.toString());
    });
    return buffer.toString();
  }
}
