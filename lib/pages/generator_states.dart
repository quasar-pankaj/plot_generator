import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  StartState(
      {group = "Group",
      subgroup = "Subgroup",
      description = "Description",
      generatedText = "Some Text",
      })
      : super(list: [
          group,
          subgroup,
          description,
          generatedText,
        ]);
}

class LoadingState extends GeneratorState {}

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
