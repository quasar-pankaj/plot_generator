import 'conflict.dart';
import 'plotto.dart';
import 'master_conflict.dart';

class ConflictBuilder {
  late final MasterConflict _conflict;
  late final List<dynamic> leadins = [];
  late final List<dynamic> carryons = [];

  ConflictBuilder({required MasterConflict conflict}) : _conflict = conflict {
    leadins.addAll(conflict.leadins);
    carryons.addAll(conflict.carryons);
  }

  String get description {
    if (_conflict.description is String) {
      return _conflict.description;
    } else if (_conflict.description is List) {
      return _processList(_conflict.description);
    } else {
      _throwError();
    }
    return '';
  }

  String _processList(List<dynamic> descriptions) {
    String desc = '';
    for (var element in descriptions) {
      if (element is String) {
        desc += element;
      } else if (element is List) {
        return _processLinks(List.from(element));
      } else {
        _throwError();
      }
    }

    return desc;
  }

  String _processMap(Map<dynamic, dynamic> element) {
    final Conflict parser = Conflict(Map.from(element));
    return parser.description;
  }

  void _throwError() {}

  String _processLinks(List<dynamic> element) {
    String desc = '';
    for (var node in element) {
      if (node is List) {
      } else if (node is String) {
        desc += _fetchConflict(node);
      } else if (node is Map) {
        desc += _processMap(node);
      } else {
        _throwError();
      }
    }
    return desc;
  }

  String _fetchConflict(String node) {
    final Plotto plotto = Plotto.getInstance();
    final MasterConflict conflict = plotto.fetchConflictById(node);
    final ConflictBuilder wrapper = ConflictBuilder(conflict: conflict);

    return wrapper.description;
  }
}
