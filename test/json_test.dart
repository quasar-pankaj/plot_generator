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
    final data = await _plotto.fetchJson();
    expect(data, isNotNull);
    final Map<String, dynamic> p = data as Map<String, dynamic>;
    expect(p, isNotNull);

    final List<String> masterClauseA = List<String>.from(p['masterClauseA']);
    expect(masterClauseA.length, 15);
  });
}
