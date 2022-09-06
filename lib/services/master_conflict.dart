class MasterConflict {
  late final String group;
  late final String subgroup;
  late final int bclause;
  late final String conflictid;
  late final dynamic leadins;
  late final dynamic carryons;
  late final dynamic description;

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
