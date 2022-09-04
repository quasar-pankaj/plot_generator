class MasterConflict {
  String group;
  String subgroup;
  int bclause;
  String conflictid;
  dynamic leadins;
  dynamic carryons;
  dynamic description;

  MasterConflict.fromJson(dynamic json) {
    group = json['group'];
    subgroup = json['subgroup'];
    bclause = json['bclause'];
    conflictid = json['conflictid'];
    leadins = json['leadins'];
    carryons = json['carryons'];
    description = json['description'];
  }
}
