import 'master_conflict.dart';
import 'plotto.dart';

class DescriptionBuilder {
  final MasterConflict _conflict;
  String _description = '';

  String get descriptiom => _description;

  DescriptionBuilder({required MasterConflict conflict})
      : _conflict = conflict {
    _start();
  }

  void _start() {
    if (_conflict.description is String) {
      _description += _conflict.description;
    } else {
      //if(_conflict.description is List)
      _parseList(List.from(_conflict.description));
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
    final DescriptionBuilder builder = DescriptionBuilder(conflict: conflict);
    _description += builder.descriptiom;
  }

  void _parseMap(Map<String, dynamic> map) {}
}
