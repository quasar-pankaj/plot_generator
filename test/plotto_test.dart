import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:plot_generator/pages/xml_plotto.dart';
import 'package:xml/xml.dart';

void main() {
  XmlPlotto plotto = XmlPlotto();
  XmlDocument document;
  XmlElement root;

  setUp(() async {
    final file = File('assets/plotto.xml');
    final text = await file.readAsString();
    document = XmlDocument.parse(text);
    root = document.rootElement;
  });

  test("Load Characters from Xml", () {
    plotto.loadCharacters(root);
    expect(plotto.characters.length, equals(54));
  });

  test("Load Subjects from Xml", () {
    plotto.loadSubjects(root);
    expect(plotto.subjects.length, equals(15));
  });

  test("Load Predicates from Xml", () {
    plotto.loadPredicates(root);
    expect(plotto.predicates.length, equals(62));
  });

  test("Load Outcomes from Xml", () {
    plotto.loadOutcomes(root);
    expect(plotto.outcomes.length, equals(15));
  });

  test("Load Conflicts from Xml", () {
    plotto.loadConflicts(root);
    expect(plotto.conflicts.length, greaterThan(1462));
  });

  test("Load Complete Xml", () async {
    await plotto.parse();
    expect(plotto.characters.length, equals(54));
    expect(plotto.subjects.length, equals(15));
    expect(plotto.predicates.length, equals(62));
    expect(plotto.outcomes.length, equals(15));
    expect(plotto.conflicts.length, greaterThan(1462));
  });

  tearDown(() {
    root = null;
    document = null;
    plotto = null;
  });
}
