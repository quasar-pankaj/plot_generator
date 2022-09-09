import 'description_builder.dart';
import 'master_conflict.dart';
import 'plotto.dart';
import 'random_mixin.dart';

class Parser with RandomMixin {
  String _description = '';
  List<dynamic> _leadins = [];
  List<dynamic> _carryons = [];

  String _processing = '';
  final _Stack _processingStack = _Stack();

  String get description => _description;
  List<dynamic> get leadins => _leadins;
  List<dynamic> get carryons => _carryons;

  void start(Map<String, dynamic> node) {
    _processMap(node);
  }

  void _processMap(Map<String, dynamic> node) {
    if (_processing.isNotEmpty) {
      _processingStack.push(_processing);
    }

    _processing = '';

    if (node.containsKey('op')) {
      _parseOp(node);
    }
    if (!node.containsKey('op') && node.containsKey('v')) {
      _processV(node['v']);
    }
    if (node.containsKey('tfm')) {
      _processTransform(Map.from(node));
    }
    if (node.containsKey('start')) {
      _processStart(node);
    }

    _description += _processing;

    if (_processingStack.canPop()) {
      _processing = _processingStack.pop();
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

  void _processV(dynamic v) {
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
      _processV(element);
    }
  }

  void _processString(String v) {
    final Plotto plotto = Plotto.getInstance();
    final MasterConflict conflict = plotto.fetchConflictById(v);
    final DescriptionBuilder wrapper = DescriptionBuilder(conflict: conflict);
    _processing += wrapper.description;
    List links = _processLinks(conflict.leadins);
    _leadins.addAll(links);
    links = _processLinks(conflict.carryons);
    _carryons.addAll(links);
  }

  void _processChoose(List<dynamic> v) {
    final rnd = getRandom(v.length);
    final chosen = v[rnd];
    _processV(chosen);
  }

  void _processInclude(List<dynamic> v) {
    for (var link in v) {
      _processV(link);
    }
  }

  void _processTransform(Map<String, String> node) {
    _processing = node.entries.fold(
      _processing,
      (previousValue, element) =>
          previousValue.replaceAll(element.key, element.value),
    );
  }

  void _processStart(Map<String, dynamic> node) {
    final String start = node['start'];
    late final String end;
    if (node.containsKey('end')) {
      end = node['end'];
    }
    final int startIndex = _processing.indexOf(start);
    final int endIndex = _processing.indexOf(end);
    _processing = _processing.substring(startIndex, endIndex);
  }

  void _raiseError() {}

  List _processLinks(links) {
    if (links is List) return links;
    return [links];
  }
}

class _Stack {
  int _index = -1;
  List<String> _list = [];

  void push(dynamic item) {
    _list[++_index] = item;
  }

  String pop() {
    return _list[_index--];
  }

  String peek() {
    return _list[_index];
  }

  bool canPop() {
    return _index > -1;
  }
}
