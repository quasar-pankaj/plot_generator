import 'package:plot_generator/services/parser.dart';
import 'package:plot_generator/services/plotto.dart';

import 'master_conflict.dart';

class ConflictWrapper {
  late final MasterConflict _conflict;
  ConflictWrapper({required conflict}) : _conflict = conflict;

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
    final Parser parser = Parser();
    parser.start(Map.from(element));
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
    final ConflictWrapper wrapper = ConflictWrapper(conflict: conflict);
    return wrapper.description;
  }
}
