class MasterClauseB {
  List<String> nodes;
  String group;
  String subgroup;
  String description;

  MasterClauseB.fromJson(dynamic json) {
    nodes = List.from(json['nodes']);
    group = json['group'];
    subgroup = json['subgroup'];
    description = json['description'];
  }
}
