import 'package:flutter_test/flutter_test.dart';
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
}
