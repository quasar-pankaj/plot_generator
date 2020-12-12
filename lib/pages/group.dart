import 'dart:collection';

import 'package:plot_generator/pages/plotto.dart';
import 'package:plot_generator/pages/random_mixin.dart';
import 'package:xml/xml.dart';

import 'conflict_reference.dart';

class Group extends ListBase<ConflictLink> with RandomMixin {
  List<ConflictLink> _references;
  Plotto _plotto;
  Mode mode;

  @override
  int get length => _references.length;
  @override
  set length(int length) {
    _references.length = length;
  }

  @override
  ConflictLink operator [](int index) {
    return _references[index];
  }

  @override
  void operator []=(int index, ConflictLink value) {
    _references[index] = value;
  }

  Group.fromXml(Plotto plotto, XmlNode node) : _plotto = plotto {
    mode = node.getAttribute("mode") == "include" ? Mode.include : Mode.choose;
    final confnodes = node.findElements("conflict-link");
    _references =
        confnodes.map((e) => ConflictLink.createFromXml(_plotto, e)).toList();
  }

  List<String> get referenceList {
    if (mode == Mode.include) {
      return _references.map((e) => e.ref).toList();
    } else {
      return [_references[getRandom(_references.length)].ref];
    }
  }

  List<String> get optionsList {
    return _references.map((e) => e.option).toList();
  }

  List<String> get permutationList {
    return _references.map((e) => e.permutation).toList();
  }
}

enum Mode { include, choose }
