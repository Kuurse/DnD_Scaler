import '../models/monster.dart';

extension MonsterScaler on Monster {
  static const int basePartySize = 4;

  Monster saleToPartySize(int partySize) {
    var newMonster = Monster.fromJson(toJson());

    var hp = ((hitPoints!/basePartySize)*partySize).round();
    newMonster.hitPoints = hp;

    var multiAttack = multiattack ?? getAttackPerTurnCount();
    newMonster.multiattack = multiAttack;

    var xp = this.xp;
    newMonster.xp = xp*(partySize/basePartySize).round();

    return newMonster;
  }
}