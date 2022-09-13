import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plot_generator/bloc/plotto_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PlottoBloc', () {
    late final PlottoBloc bloc;
    setUp(() => bloc = PlottoBloc());
    blocTest<PlottoBloc, PlottoState>(
      'Bloc initial.',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadRequested()),
      wait: Duration(seconds: 2),
      expect: () => [PlottoLoading(), PlottoLoaded()],
    );

    blocTest<PlottoBloc, PlottoState>(
      'Bloc skeleton request.',
      build: () => bloc,
      act: (bloc) => bloc.add(SkeletonRequested()),
      wait: Duration(seconds: 2),
      expect: () => [isA<SkeletonGenerated>(), isA<PlottoGenerated>()],
    );
  });
}
