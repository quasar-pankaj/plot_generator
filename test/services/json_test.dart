import 'package:flutter_test/flutter_test.dart';
import 'package:plot_generator/services/description_builder.dart';
import 'package:plot_generator/services/node_builder.dart';
import 'package:plot_generator/services/plotto.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Plotto _plotto;

  setUp(() async {
    _plotto = Plotto.getInstance();
    await _plotto.loadJson();
  });

  test('Plotto Inited', () {
    expect(_plotto, isNotNull);
  });

  test('Contains data', () async {
    expect(_plotto.masterClauseA.length, 15);
    expect(_plotto.masterClauseC.length, 15);
    expect(_plotto.characters.length, 59);
    expect(_plotto.masterClauseB.length, 61);
    expect(_plotto.conflicts.length, 1928);
  });

  test('fetches random A clause', () async {
    final aClause = _plotto.randomAClause;
    expect(aClause, isNotNull);
    expect(aClause, isNotEmpty);
  });

  test('fetches random B clause', () async {
    final bClause = _plotto.randomBClause;
    expect(bClause, isNotNull);
  });

  test('fetches random C clause', () async {
    final cClause = _plotto.randomCClause;
    expect(cClause, isNotNull);
    expect(cClause, isNotEmpty);
  });

  test('Fetches random related conflict', () {
    final bClause = _plotto.randomBClause;
    final conflict = bClause.randomConflict;
    expect(conflict, isNotNull);
  });

  test('Parses leadins correctly', () {
    final conflict = _plotto.conflicts['59'];
    final leadins = conflict!.leadins;
    expect(leadins, isNotNull);
  });

  test('Fetches strange conflicts leadins', () {
    final conflict = _plotto.conflicts['851-6'];
    final leadins = conflict!.leadins;
    expect(leadins, isNotNull);
  });

  test('Fetches strange conflicts carryons', () {
    final conflict = _plotto.conflicts['851-6'];
    final carryons = conflict!.carryons;
    expect(carryons, isNotNull);
  });

  test('Parses the json 60', () {
    final conflict = _plotto.conflicts['60'];
    expect(conflict, isNotNull);
    final leadins = conflict!.leadins;
    expect(leadins, isNotNull);
    final NodeBuilder parser = NodeBuilder(node: leadins);
    final description = parser.description;
    expect(description, isNotNull);
    expect(description, isNotEmpty);

    expect(parser.carryons.length, isNonZero);
    expect(parser.leadins.length, isNonZero);
  });

  test('Parses the json 296', () {
    final conflict = _plotto.conflicts['296'];
    expect(conflict, isNotNull);
    final leadins = conflict!.leadins;
    expect(leadins, isNotNull);
    final NodeBuilder parser = NodeBuilder(node: leadins);
    final description = parser.description;
    expect(description, isNotNull);
    expect(description, isNotEmpty);

    expect(parser.carryons.length, isNonZero);
    expect(parser.leadins.length, isNonZero);
  });

  test('Parses the json 537', () {
    final conflict = _plotto.conflicts['537'];
    expect(conflict, isNotNull);
    final leadins = conflict!.leadins;
    expect(leadins, isNotNull);
    final NodeBuilder parser = NodeBuilder(node: leadins);
    final description = parser.description;
    expect(description, isNotNull);
    expect(description, isNotEmpty);

    expect(parser.carryons.length, isNonZero);
    expect(parser.leadins.length, isNonZero);
  });

  test('Parses the json 5', () {
    final conflict = _plotto.conflicts['5'];
    expect(conflict, isNotNull);
    final leadins = conflict!.leadins;
    expect(leadins, isNotNull);
    final NodeBuilder parser = NodeBuilder(node: leadins);
    final description = parser.description;
    expect(description, isNotNull);
    expect(description, isNotEmpty);

    expect(parser.carryons.length, isNonZero);
    expect(parser.leadins.length, isNonZero);
  });

  test('description builder', () {
    final conflict = _plotto.conflicts['5']!;
    expect(conflict, isNotNull);
    final DescriptionBuilder builder = DescriptionBuilder(conflict: conflict);
    expect(builder.descriptiom, isNotNull);
    expect(builder.descriptiom, isNotEmpty);
  });
}
