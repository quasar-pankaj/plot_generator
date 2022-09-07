import 'package:plot_generator/services/conflict_wrapper.dart';
import 'package:plot_generator/services/master_conflict.dart';
import 'package:plot_generator/services/plotto.dart';
import 'package:plot_generator/services/random_mixin.dart';

class Parser with RandomMixin {
  String _description = '';
  List<String> _links = [];

  String get description => _description;
  List<String> get links => _links;

  void start(Map<String, dynamic> node) {
    _processMap(node);
  }

  void _processMap(Map<String, dynamic> node) {
    if (node.containsKey('op')) {
      _parseOp(node);
    }
    if (!node.containsKey('op') && node.containsKey('v')) {
      _parseV(node['v']);
    }
    if (node.containsKey('tfm')) {
      _processTransform(Map.from(node));
    }
    if (node.containsKey('start')) {
      _processStart(node);
    }
  }

  void _parseOp(Map<String, dynamic> node) {
    String op = node['op'];
    dynamic v = node['v'];
    switch (op) {
      case '?':
        _processChoose(v as List<dynamic>);
        break;
      case '+':
        _processInclude(v);
        break;
    }
  }

  void _parseV(dynamic v) {
    if (v is List) {
      _processList(v);
    } else if (v is String) {
      _processString(v);
    } else if (v is Map) {
      _processMap(Map.from(v));
    } else {
      _raiseError();
    }
  }

  void _processList(List v) {
    for (var element in v) {
      _parseV(element);
    }
  }

  void _processString(String v) {
    final Plotto plotto = Plotto.getInstance();
    final MasterConflict conflict = plotto.fetchConflictById(v);
    final ConflictWrapper wrapper = ConflictWrapper(conflict: conflict);
    _description += wrapper.description;
  }

  void _processChoose(List<dynamic> v) {
    final rnd = getRandom(v.length);
    final chosen = v[rnd];
    _parseV(chosen);
  }

  void _processInclude(List<dynamic> v) {
    for (var link in v) {
      _parseV(link);
    }
  }

  void _processTransform(Map<String, String> node) {}

  void _processStart(Map<String, dynamic> node) {
    final String start = node['start'];
    late final String end;
    if (node.containsKey('end')) {
      end = node['end'];
    }
  }

  void _raiseError() {}
}
