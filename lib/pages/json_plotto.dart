import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:plot_generator/pages/master_clause_b.dart';
import 'package:plot_generator/pages/master_conflict.dart';
import 'package:plot_generator/pages/random_mixin.dart';

class JsonPlotto with RandomMixin {
  JsonPlotto._private();
  static JsonPlotto _instance;
  factory JsonPlotto.getInstance() {
    _instance ??= JsonPlotto._private();
    return _instance;
  }

  List<String> masterClauseA;
  List<String> masterClauseC;
  Map<String, String> characters;
  List<MasterClauseB> masterClauseB;
  Map<String, MasterConflict> conflicts;

  Future<Map<String, dynamic>> loadJson() async {
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
    return json;
  }

  String get randomAClause {
    final int rnd = getRandom(15);
    return masterClauseA[rnd];
  }

  String get randomCClause {
    final int rnd = getRandom(15);
    return masterClauseC[rnd];
  }

  MasterClauseB get randomBClause {
    final int rnd = getRandom(15);
    return masterClauseB[rnd];
  }
}
