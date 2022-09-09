part of 'plotto_bloc.dart';

abstract class PlottoState extends Equatable {
  const PlottoState();

  @override
  List<Object> get props => [];
}

class PlottoInitial extends PlottoState {}

class PlottoLoading extends PlottoState {}

class PlottoLoaded extends PlottoState {}

class PlottoGenerated extends PlottoState {
  final List<String> conflicts;
  const PlottoGenerated({required this.conflicts});
  @override
  List<Object> get props => [conflicts];
}

class SkeletonGenerated extends PlottoState {
  final String masterClauseA;
  final String masterClauseB;
  final String masterClauseC;

  SkeletonGenerated({
    required this.masterClauseA,
    required this.masterClauseB,
    required this.masterClauseC,
  });
  @override
  List<Object> get props => [masterClauseA, masterClauseB, masterClauseC];
}
