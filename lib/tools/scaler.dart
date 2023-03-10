import '../models/monster.dart';

extension MonsterScaler on Monster {
  static const int basePartySize = 4;

  Monster scaleToPartySize(int partySize) {
    var mod = partySize/basePartySize;
    var newMonster = Monster.fromJson(toJson());
    newMonster.hitPoints = ((hitPoints!/basePartySize)*partySize).round();
    var ogMulti = multiattack ?? getAttackPerTurnCount();
    newMonster.multiattack = ogMulti*mod;
    newMonster.xp = (xp*mod).round();
    return newMonster;
  }

  Monster scaleToPartyLevel(int partyLevel, int designedLevel) {
    var newMonster = Monster.fromJson(toJson());
    var mod = partyLevel/designedLevel;
    var diff = partyLevel-designedLevel;

    newMonster.hitPoints = hitPoints! + diff*10;
    newMonster.armorClass = armorClass!+(diff~/2);
    newMonster.xp = (xp*mod).round();

    var saveModifier = diff~/2;
    newMonster.dexteritySave = dexteritySave! + saveModifier;
    newMonster.strengthSave = strengthSave! + saveModifier;
    newMonster.wisdomSave = wisdomSave! + saveModifier;
    newMonster.constitutionSave = constitutionSave! + saveModifier;
    newMonster.charismaSave = charismaSave! + saveModifier;
    newMonster.intelligenceSave = intelligenceSave! + saveModifier;

    newMonster.actions = _scaleActions(actions, diff);
    newMonster.legendaryActions = _scaleActions(legendaryActions, diff);
    newMonster.reactions = _scaleActions(reactions, diff);
    newMonster.legendaryActions = _scaleActions(specialAbilities, diff);

    return newMonster;
  }

  // static final List<int> _availableDice = <int>[4, 6, 8, 10, 12, 20];
  static final List<int> _availableDice = <int>[4, 6, 8, 10, 12];
  DiceRoll? calculateDamageDice(Action action, int diff) {
    var avgDmg = action.readAverageDamage();
    var avgDmg2 = action.computeAverageDamage();
    var targetDmg = avgDmg! + (diff*2);

    // action has 1 attack roll
    var values = action.damageDice!.values!;
    var ogbonus = action.damageBonus ?? action.damageDice?.modifier ?? 0;
    if (values.length == 1){
      DiceRoll lastBigger = action.damageDice!;
      for (int i=1;;i++) {
        try {
          // Bigger dice
          var diceQuantity = values[0].amount!;
          var diceIndex = _availableDice.indexOf(values[0].diceFaces!);
          var diceSize = _availableDice[diceIndex + i];
          var biggerDice = DiceRoll(
              values: [
                DiceValue(diceQuantity, diceSize)
              ],
              modifier: ogbonus
          );

          if (biggerDice.getAverageRoll()> targetDmg) {
            break;
          }
          lastBigger = biggerDice;
        } on RangeError {
          break;
        }
      }

      DiceRoll lastMore = action.damageDice!;
      // More of the same dice
      for (int i=0;;i++) {
        var diceQuantity = values[0].amount! + i;
        var moreDice = DiceRoll(
            values: [
              DiceValue(diceQuantity, values[0].diceFaces!)
            ],
            modifier: ogbonus
        );

        if (moreDice.getAverageRoll()> targetDmg) {
          break;
        }
        lastMore = moreDice;
      }

      DiceRoll dr;
      int bigger = (targetDmg - lastBigger.getAverageRoll()).abs();
      int more= (targetDmg - lastMore.getAverageRoll()).abs();
      if (bigger < more) {
        // bigger dice was closer to end res
        dr = lastBigger;
        dr.modifier = (lastBigger.modifier ?? 0) + bigger;
      } else {
        // more dice was closer
        dr = lastMore;
        dr.modifier = (lastMore.modifier ?? 0) + more;
      }

      print(targetDmg);
      print(dr.getAverageRoll());
      print("${dr.toString()}\n");

      return dr;

    }
    return null;
  }

  List<Action> _scaleActions(List<Action>? act, int diff) {
    var a = <Action>[];
    if (act == null) {
      return a;
    }

    for (var action in act){
      if (action.damageBonus == null && action.damageDice == null) continue;
      var newAction = Action(name: action.name);
      newAction.attackBonus = action.attackBonus! + (diff ~/ 4);

      var dmgDice = calculateDamageDice(action, diff);
      newAction.damageDice = dmgDice;

      newAction.desc = action.desc;
      a.add(newAction);
    }

    return a;
  }
}