import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plot_generator/services/master_clause_b.dart';
import 'package:plot_generator/services/plotto.dart';
import 'package:plot_generator/services/random_mixin.dart';

part 'plotto_event.dart';
part 'plotto_state.dart';

class PlottoBloc extends Bloc<PlottoEvent, PlottoState> with RandomMixin {
  final _plotto = Plotto.getInstance();

  late String _masterClauseA;
  late MasterClauseB _masterClauseB;
  late String _masterClauseC;

  // late List<Conflict> _conflicts = [];

  PlottoBloc() : super(PlottoInitial()) {
    on<LoadRequested>((event, emit) async => await _onLoadRequested(emit));
    on<SkeletonRequested>((event, emit) => _onSkeletonRequested(emit));
    on<CarryOnRequested>((event, emit) => _onCarryOnRequested(event, emit));
    on<LeadInRequested>((event, emit) => _onLeadInRequested(event, emit));
  }

  void _onSkeletonRequested(Emitter<PlottoState> emit) {
    // _conflicts.clear();
    _masterClauseA = _plotto.randomAClause;
    _masterClauseB = _plotto.randomBClause;
    _masterClauseC = _plotto.randomCClause;

    emit(SkeletonGenerated(
      masterClauseA: _masterClauseA,
      masterClauseB: _masterClauseB.description,
      masterClauseC: _masterClauseC,
    ));

    final int len = _masterClauseB.nodes.length;
    String node = _masterClauseB.nodes[getRandom(len)];
    final conflict = _plotto.fetchConflictById(node);
    // final NodeBuilder wrapper = NodeBuilder(node: conflict);
  }

  void _onCarryOnRequested(CarryOnRequested event, Emitter<PlottoState> emit) {
    final int index = event.index;
    // final Conflict conflict = _conflicts[index];
  }

  void _onLeadInRequested(LeadInRequested event, Emitter<PlottoState> emit) {}

  Future<void> _onLoadRequested(Emitter<PlottoState> emit) async {
    emit(PlottoLoading());
    await _plotto.loadJson();
    emit(PlottoLoaded());
  }
}
