import 'dart:convert';
import 'package:flutter/material.dart';

class PlotGenerator {
  Map<String, dynamic> _data;

  // List<BClause> _masterClauseB;
  void load(BuildContext context) async {
    // var response =
    //     await DefaultAssetBundle.of(context).loadString('assets/plotto.json');
    // _data = json.decode(response).cast<Map<String, dynamic>>();
    // _masterClauseB = _data["masterClauseB"]
    //     .map<BClause>((json) => BClause.fromJson(json))
    //     .toList();
  }

  // List<String> get masterClauseA => _data["masterClauseA"];
  // List<BClause> get masterClauseB => _masterClauseB;
  // List<String> get masterClauseC => _data["masterClauseC"];
  // Map<String, String> get characters => _data["characters"];
  // Map<String, dynamic> get conflicts => _data["conflicts"];
}
