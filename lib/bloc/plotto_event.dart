part of 'plotto_bloc.dart';

abstract class PlottoEvent extends Equatable {
  const PlottoEvent();

  @override
  List<Object> get props => [];
}

class LeadInRequested extends PlottoEvent {
  final int index;

  const LeadInRequested({required this.index});
  @override
  List<Object> get props => [index];
}

class CarryOnRequested extends PlottoEvent {
  final int index;

  const CarryOnRequested({required this.index});
  @override
  List<Object> get props => [index];
}

class SkeletonRequested extends PlottoEvent {}

class LoadRequested extends PlottoEvent {}
