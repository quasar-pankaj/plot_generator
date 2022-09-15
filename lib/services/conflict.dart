import 'package:plot_generator/services/description_builder.dart';
import 'package:plot_generator/services/master_conflict.dart';
import 'package:plot_generator/services/node_builder.dart';
import 'package:plot_generator/services/plotto.dart';
import 'package:plot_generator/services/random_mixin.dart';

class Conflict with RandomMixin {
  late final String _description;
  late final List<dynamic> _leadins = [];
  late final List<dynamic> _carruons = [];

  String get description => _description;
  List<dynamic> get leadins => _leadins;
  List<dynamic> get carryons => _carruons;

  Conflict.fromLink(String conflictId, Plotto plotto) {
    final MasterConflict conflict = plotto.fetchConflictById(conflictId);
    final DescriptionBuilder builder = DescriptionBuilder(conflict: conflict);
    _description = builder.descriptiom;
    _leadins.add(conflict.leadins);
    _carruons.add(conflict.carryons);
  }

  Conflict.fromMap(Map<String, dynamic> node) {
    final NodeBuilder builder = NodeBuilder(node: node);
    _description = builder.description;
    _leadins.addAll(builder.leadins);
    _carruons.addAll(builder.carryons);
  }

  Conflict? get probeLeadin {
    if (_leadins.isEmpty) return null;
    final int rnd = getRandom(_leadins.length);
    Map<String, dynamic> node = _leadins[rnd];
    return Conflict.fromMap(node);
  }

  Conflict? get probeCarryon {
    if (_carruons.isEmpty) return null;
    final int rnd = getRandom(_carruons.length);
    Map<String, dynamic> node = _carruons[rnd];
    return Conflict.fromMap(node);
  }
}
