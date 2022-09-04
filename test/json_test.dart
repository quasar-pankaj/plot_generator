import 'package:flutter_test/flutter_test.dart';
import 'package:plot_generator/pages/json_plotto.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  JsonPlotto _plotto;

  setUp(() {
    _plotto = JsonPlotto.getInstance();
  });
  test('Plotto Inited', () {
    expect(_plotto, isNotNull);
  });

  test('Contains data', () async {
    final data = await _plotto.loadJson();
    expect(data, isNotNull);
    final Map<String, dynamic> p = data;
    expect(p, isNotNull);
    expect(_plotto.masterClauseA.length, 15);
    expect(_plotto.masterClauseC.length, 15);
    expect(_plotto.characters.length, 59);
    expect(_plotto.masterClauseB.length, 61);
    expect(_plotto.conflicts.length, 1928);
  });
}
