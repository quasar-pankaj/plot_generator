import 'package:flutter_test/flutter_test.dart';
import 'package:plot_generator/services/conflict.dart';
import 'package:plot_generator/services/master_conflict.dart';
import 'package:plot_generator/services/plotto.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final Plotto _plotto;

  setUp(() async {
    _plotto = Plotto.getInstance();
    await _plotto.loadJson();
  });

  test('builds conflict from id', () {
    final Conflict conflict = Conflict.fromLink('32', _plotto);

    expect(conflict, isNotNull);
    expect(conflict.description,
        'B, desiring love, has never had a lover, and feels the misfortune keenly');
    expect(conflict.leadins.length, 1);
    expect(conflict.carryons.length, 1);
  });

  test('Conflict builds from leadin', () {
    final MasterConflict masterConflict = _plotto.fetchConflictById('861');
    final Conflict conflict = Conflict.fromMap(masterConflict.leadins);
    expect(conflict, isNotNull);
    expect(conflict.description, isNotEmpty);
    expect(conflict.leadins.length, greaterThan(0));
    expect(conflict.carryons.length, greaterThan(0));
  });

  test('Conflict builds from carryons', () {
    final MasterConflict masterConflict = _plotto.fetchConflictById('861');
    final Conflict conflict = Conflict.fromMap(masterConflict.carryons);
    expect(conflict, isNotNull);
    expect(conflict.description, isNotEmpty);
    expect(conflict.leadins.length, greaterThan(0));
    expect(conflict.carryons.length, greaterThan(0));
  });
}
