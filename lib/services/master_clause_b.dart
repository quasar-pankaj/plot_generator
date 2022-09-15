import 'package:plot_generator/services/plotto.dart';

import 'master_conflict.dart';
import 'random_mixin.dart';

class MasterClauseB with RandomMixin {
  late final List<String> nodes;
  late final String group;
  late final String subgroup;
  late final String description;

  MasterClauseB.fromJson(dynamic json) {
    nodes = List.from(json['nodes']);
    group = json['group'];
    subgroup = json['subgroup'];
    description = json['description'];
  }

  MasterConflict? get randomConflict {
    if (nodes.isEmpty) return null;
    int rnd = getRandom(nodes.length);
    String node = nodes[rnd];
    final plotto = Plotto.getInstance();
    return plotto.fetchConflictById(node);
  }
}
