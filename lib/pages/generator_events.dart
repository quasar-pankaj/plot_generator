import 'package:equatable/equatable.dart';
import 'package:plot_generator/pages/conflict.dart';
import 'package:plot_generator/pages/outcome.dart';
import 'package:plot_generator/pages/predicate.dart';
import 'package:plot_generator/pages/subject.dart';

enum GeneratorEvents { load, generate, lead_in, carry_on }

abstract class GeneratorEvent extends Equatable {}

class AppLoadRequested extends GeneratorEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SkeletonRequested extends GeneratorEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ConflictsRequested extends GeneratorEvent {
  final Predicate predicate;

  ConflictsRequested(this.predicate);
  @override
  List<Object> get props => [predicate];
}

class LeadInRequested extends GeneratorEvent {
  final Conflict conflict;

  LeadInRequested(this.conflict);
  @override
  List<Object> get props => [conflict];
}

class CarryOnRequested extends GeneratorEvent {
  final Conflict conflict;

  CarryOnRequested(this.conflict);
  @override
  List<Object> get props => [conflict];
}

class IncludeRequested extends GeneratorEvent {
  final Conflict conflict;

  IncludeRequested(this.conflict);
  @override
  List<Object> get props => [conflict];
}

class SynopsisRequested extends GeneratorEvent {
  final Subject subject;
  final Predicate predicate;
  final Outcome outcome;
  final List<Conflict> conflicts;

  SynopsisRequested(this.subject, this.predicate, this.outcome, this.conflicts);

  @override
  List<Object> get props => [subject, predicate, outcome, conflicts];
}
