import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plot_generator/bloc/plotto_bloc.dart';

void main() {
  group('PlottoBloc', () {
    PlottoBloc bloc = PlottoBloc();
    setUp(() {});
    tearDown(() {});
    blocTest<PlottoBloc, PlottoState>(
      'description',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadRequested()),
      expect: () => PlottoLoaded(),
    );
  });
}
