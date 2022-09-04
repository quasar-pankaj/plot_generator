import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:plot_generator/pages/conflict.dart';
import 'package:plot_generator/pages/outcome.dart';
import 'package:plot_generator/pages/predicate.dart';
import 'package:plot_generator/pages/subject.dart';

class GeneratorState extends Equatable {
  final String group;
  final String subgroup;
  final String description;
  final String generatedText;
  final List<Object> _list;

  GeneratorState(
      {this.group = "Group",
      this.subgroup = "Subgroup",
      this.description = "Description",
      this.generatedText = "Some Text",
      list = const []})
      : _list = list;

  @override
  List<Object> get props => _list;
}

class StartState extends GeneratorState {
  StartState({
    group = "Group",
    subgroup = "Subgroup",
    description = "Description",
    generatedText = "Some Text",
  }) : super(list: [
          group,
          subgroup,
          description,
          generatedText,
        ]);
}

class LoadingState extends GeneratorState {}

class LoadedState extends GeneratorState {}

class SkeletonGeneratedState extends GeneratorState {
  final Subject subject;
  final Predicate predicate;
  final Outcome outcome;

  SkeletonGeneratedState(this.subject, this.predicate, this.outcome)
      : super(list: [
          subject,
          predicate,
          outcome,
        ]);
}

class LeadInFetchedState extends GeneratorState {
  final Conflict leadin;

  LeadInFetchedState(this.leadin) : super(list: [leadin]);
}

class CarryOnFetchedState extends GeneratorState {
  final Conflict carryom;

  CarryOnFetchedState(this.carryom) : super(list: [carryom]);
}

class IncludeFetchedState extends GeneratorState {
  final Conflict include;

  IncludeFetchedState(this.include) : super(list: [include]);
}

class SynopsisFetchedState extends GeneratorState {
  final String lines;

  SynopsisFetchedState(this.lines) : super(list: [lines]);
}

class FilledState extends GeneratorState {
  FilledState({
    @required generatedText,
    @required group,
    @required subgroup,
    @required description,
  }) : super(
            generatedText: generatedText,
            group: group,
            subgroup: subgroup,
            description: description,
            list: [
              group,
              subgroup,
              description,
              generatedText,
            ]);
}
