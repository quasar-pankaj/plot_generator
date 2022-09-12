import 'package:plot_generator/services/node_builder.dart';

import 'master_conflict.dart';
import 'plotto.dart';

class DescriptionBuilder {
  int _level = 0;
  String _description = '';

  String get descriptiom => _description;

  DescriptionBuilder({required MasterConflict conflict, int level = 0})
      : _level = level {
    if (level > 5) return; // dont't recurse more than 5 levels
    _start(conflict);
  }

  void _start(MasterConflict conflict) {
    if (conflict.description is String) {
      _description += conflict.description;
    } else {
      //if(_conflict.description is List)
      _parseList(List.from(conflict.description));
    }
  }

  void _parseList(List<dynamic> list) {
    for (var element in list) {
      if (element is String) {
        _description += element;
      } else {
        //if (element is List)
        _parseLinks(List.from(element));
      }
    }
  }

  void _parseLinks(List list) {
    for (var element in list) {
      if (element is String) {
        _parseId(element);
      } else {
        // if(element is Map)
        _parseMap(Map.from(element));
      }
    }
  }

  void _parseId(String id) {
    final Plotto plotto = Plotto.getInstance();
    final MasterConflict conflict = plotto.fetchConflictById(id);
    final DescriptionBuilder builder = DescriptionBuilder(
      conflict: conflict,
      level: _level + 1,
    );
    _description += ' ' + builder.descriptiom;
  }

  void _parseMap(Map<String, dynamic> map) {
    final NodeBuilder builder = NodeBuilder(node: map);
    _description += builder.description;
  }
}
