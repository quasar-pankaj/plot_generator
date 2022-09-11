import 'package:plot_generator/services/description_builder.dart';
import 'package:plot_generator/services/master_conflict.dart';
import 'package:plot_generator/services/plotto.dart';
import 'package:plot_generator/services/random_mixin.dart';

class NodeBuilder with RandomMixin {
  String _description = '';
  List<dynamic> _leadins = [];
  List<dynamic> _carryons = [];

  String get description => _description;
  List<dynamic> get leadins => _leadins;
  List<dynamic> get carryons => _carryons;

  NodeBuilder({required Map<String, dynamic> node}) {
    _start(node);
  }

  void _start(Map<String, dynamic> node) {
    if (node.isEmpty) {
      return;
    } else if (node.containsKey('op')) {
      _processOp(node['op'], node);
    } else if (!node.containsKey('op') && node.containsKey('v')) {
      _processV(node['v']);
    } else if (node.containsKey('tfm')) {
      _processTfm(node['tfm']);
    } else if (node.containsKey('start')) {
      _processStart(node['start'], node);
    } else if (!node.containsKey('start') && node.containsKey('end')) {
      _processEnd(node['end']);
    }
  }

  void _processOp(String op, dynamic node) {
    switch (op) {
      case '+':
        _processJoin(List.from(['v']));
        break;
      case '?':
        _processChoose(List.from(['v']));
        break;
    }
  }

  void _processV(dynamic v) {
    if (v is String) {
      _processLink(v);
    } else if (v is List) {
      _processList(v);
    } else if (v is Map) {
      _processMap(Map.from(v));
    }
  }

  void _processTfm(Map<String, String> tfm) {
    // ceaser cipher replacement here on _description
  }

  void _processStart(String marker, Map<String, dynamic> node) {
    final int startIndex = _description.indexOf(marker);
    if (node.containsKey('end')) {
      String endMarker = node['end'];
      final int endIndex = _description.indexOf(endMarker);
      _description = _description.substring(startIndex, endIndex);
      return;
    }
    _description = _description.substring(startIndex);
  }

  void _processEnd(String marker) {
    final int startIndex = 0;
    final int endIndex = _description.indexOf(marker);
    _description = _description.substring(startIndex, endIndex);
  }

  void _processJoin(List<dynamic> nodes) {
    for (var element in nodes) {
      _processV(element);
    }
  }

  void _processChoose(List<dynamic> nodes) {
    final int rnd = getRandom(nodes.length);
    dynamic node = nodes[rnd];
    _processV(node);
  }

  void _processLink(String link) {
    final Plotto plotto = Plotto.getInstance();
    final MasterConflict conflict = plotto.fetchConflictById(link);
    final DescriptionBuilder builder = DescriptionBuilder(conflict: conflict);
    _description += ' ' + builder.descriptiom;
    _leadins.add(conflict.leadins);
    _carryons.add(conflict.carryons);
  }

  void _processList(List<dynamic> v) {
    _processChoose(v);
  }

  void _processMap(Map<String, dynamic> map) {
    final NodeBuilder builder = NodeBuilder(node: map);
    _description += ' ' + builder.description;
  }
}
