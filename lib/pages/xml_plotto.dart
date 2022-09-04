import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plot_generator/pages/character.dart';
import 'package:plot_generator/pages/conflict.dart';
import 'package:plot_generator/pages/conflict_reference.dart';
import 'package:plot_generator/pages/group.dart';
import 'package:plot_generator/pages/outcome.dart';
import 'package:plot_generator/pages/permutation.dart';
import 'package:plot_generator/pages/predicate.dart';
import 'package:plot_generator/pages/random_mixin.dart';
import 'package:plot_generator/pages/subject.dart';
import 'package:xml/xml.dart';

class XmlPlotto with RandomMixin {
  BuildContext context;

  XmlPlotto({this.context});

  List<Character> characters;
  List<Subject> subjects;
  List<Predicate> predicates;
  List<Outcome> outcomes;
  List<Conflict> conflicts;

  Future parse() async {
    XmlDocument document = await loadDocument();

    setup(document);
  }

  Future<XmlDocument> loadData() async {
    var text =
        await DefaultAssetBundle.of(context).loadString('assets/plotto.xml');
    final document = XmlDocument.parse(text);
    return document;
  }

  Future<XmlDocument> loadDocument() async {
    final text = await rootBundle.loadString('assets/plotto.xml');
    final document = XmlDocument.parse(text);
    return document;
  }

  Future<XmlDocument> loadXml() async {
    final file = File('assets/plotto.xml');
    final text = await file.readAsString();
    return XmlDocument.parse(text);
  }

  void setup(XmlDocument document) {
    final plottoNode = document.getElement("plotto");

    loadCharacters(plottoNode);
    loadSubjects(plottoNode);
    loadPredicates(plottoNode);
    loadOutcomes(plottoNode);
    loadConflicts(plottoNode);
  }

  void loadConflicts(XmlElement element) {
    final conflictsNode = element.getElement("conflicts");
    final children = conflictsNode.findElements("conflict");
    conflicts = children.map((node) => Conflict.fromXml(this, node)).toList();
  }

  void loadOutcomes(XmlElement element) {
    final outcomesNode = element.getElement("outcomes");
    final children = outcomesNode.findElements("outcome");
    outcomes = children.map((node) => Outcome.fromXml(this, node)).toList();
  }

  void loadPredicates(XmlElement element) {
    final predicatesNode = element.getElement("predicates");
    final children = predicatesNode.findElements("predicate");
    predicates = children.map((node) => Predicate.fromXml(this, node)).toList();
  }

  void loadSubjects(XmlElement element) {
    final subjectsNode = element.getElement("subjects");
    final children = subjectsNode.findElements("subject");
    subjects = children.map((node) => Subject.fromXml(this, node)).toList();
  }

  void loadCharacters(XmlElement element) {
    final charactersNode = element.getElement("characters");
    final children = charactersNode.findElements("character");
    characters = children.map((node) => Character.fromXml(this, node)).toList();
  }

  Subject get randomSubject {
    final n = getRandom(subjects.length);
    return subjects[n];
  }

  Predicate get randomPredicate {
    final n = getRandom(predicates.length);
    return predicates[n];
  }

  Outcome get randomOutcome {
    final n = getRandom(outcomes.length);
    return outcomes[n];
  }

  Conflict get randomConflict {
    final n = getRandom(conflicts.length);
    return conflicts[n];
  }

  List<Conflict> getAlternativeConflicts(Group group) {
    if (group.mode == Mode.include) {
      return conflicts
          .where((e) => group.referenceList.contains(e.id))
          .toList();
    } else {
      final n = getRandom(group.length);
      final conflict = conflicts
          .singleWhere((element) => group.referenceList[n] == element.id);
      return [conflict];
    }
  }

  ConflictLink followupPredicate(Predicate predicate) {
    final n = getRandom(predicate.links.length);
    final link = predicate.links[n];
    return link;
  }

  Conflict fetch(ConflictLink link) {
    return conflicts.singleWhere((element) => element.id == link.ref);
  }

  String describeConflict(ConflictLink link) {
    Conflict conflict = fetch(link);
    Permutation selected;
    String desc;

    if (conflict.permutations.length == 1 || link.permutation == null) {
      selected = conflict.permutations.first;
    } else {
      selected = conflict.permutations
          .singleWhere((element) => element.number == link.permutation);
    }
    if (selected.options.isNotEmpty) {
      if (link.option != null && link.option.isNotEmpty) {
        desc = selected.getOption(link.option);
      } else {
        desc = selected.description;
      }
    } else {
      desc = selected.description;
    }

    return desc;
  }

  String transform(TransformableLink link) {
    String desc = describeConflict(link);
    return link.rectify(desc);
  }

  List<Conflict> getConflicts(List<String> links) {
    return conflicts.where((element) => links.contains(element.id)).toList();
  }

  List<Character> getCharacters(List<String> charSymbols) {
    return characters
        .where((element) => charSymbols.contains(element.designation))
        .toList();
  }

  Conflict followupIncludes(Permutation permutation) {
    List<Conflict> conflicts = [];
    for (Group g in permutation.includes) {
      for (ConflictLink link in g) {
        conflicts.add(
            this.conflicts.firstWhere((element) => element.id == link.ref));
      }
    }
    final n = getRandom(conflicts.length);
    return conflicts[n];
  }

  List<Conflict> followupLeadIns(Conflict conflict) {
    final n = getRandom(conflict.leadups.length);
    final conflicts = getAlternativeConflicts(conflict.leadups[n]);
    return conflicts;
  }

  List<Conflict> followupCarryOns(Conflict conflict) {
    final n = getRandom(conflict.carryons.length);
    final conflicts = getAlternativeConflicts(conflict.carryons[n]);
    return conflicts;
  }
}
