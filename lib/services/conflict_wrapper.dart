import 'package:plot_generator/services/plotto.dart';

import 'master_conflict.dart';

class ConflictWrapper {
  late final MasterConflict _conflict;
  ConflictWrapper({required conflict}) : _conflict = conflict;

  String get description {
    if (_conflict.description is String) {
      return _conflict.description;
    } else if (_conflict.description is List) {
      String desc = '';
      for (var element in _conflict.description) {
        if (element is String) {
          desc += element;
        } else if (element is List) {
          final plotto = Plotto.getInstance();
          String linkDesc = '';
          for (var link in element) {
            MasterConflict c = plotto.conflicts[link]!;
            ConflictWrapper w = ConflictWrapper(conflict: c);
            linkDesc += '\n' + w.description;
          }
          desc += '\n' + linkDesc;
        } else if (element is Map) {}
      }
      return desc;
    }
  }
}
