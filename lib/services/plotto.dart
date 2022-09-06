import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'master_clause_b.dart';
import 'master_conflict.dart';
import 'random_mixin.dart';

class Plotto with RandomMixin {
  Plotto._private();
  static Plotto? _instance;
  factory Plotto.getInstance() {
    _instance ??= Plotto._private();
    return _instance!;
  }

  late final List<String> masterClauseA;
  late final List<String> masterClauseC;
  late final Map<String, String> characters;
  late final List<MasterClauseB> masterClauseB;
  late final Map<String, MasterConflict> conflicts;

  Future<void> loadJson() async {
    String data = await rootBundle.loadString("assets/plotto.json");
    final Map<String, dynamic> json = Map.from(jsonDecode(data));
    masterClauseA = List.from(json['masterClauseA']);
    masterClauseC = List.from(json['masterClauseC']);
    characters = Map.from(json['characters']);
    final List<dynamic> mcb = json['masterClauseB'];
    masterClauseB = mcb.map((e) => MasterClauseB.fromJson(e)).toList();
    final Map<String, dynamic> c = json['conflicts'];
    conflicts =
        c.map((key, value) => MapEntry(key, MasterConflict.fromJson(value)));
  }

  String get randomAClause {
    final int rnd = getRandom(masterClauseA.length);
    return masterClauseA[rnd];
  }

  String get randomCClause {
    final int rnd = getRandom(masterClauseC.length);
    return masterClauseC[rnd];
  }

  MasterClauseB get randomBClause {
    final int rnd = getRandom(masterClauseB.length);
    return masterClauseB[rnd];
  }

  MasterConflict fetchConflictById(String id) {
    return conflicts[id]!;
  }
}
