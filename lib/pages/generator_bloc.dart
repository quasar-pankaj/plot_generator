import 'dart:async';

import 'package:bloc/bloc.dart';
import 'character.dart';
import 'conflict_reference.dart';
import 'generator_events.dart';
import 'generator_states.dart';
import 'plotto.dart';
import 'predicate.dart';
import 'subject.dart';

import 'outcome.dart';

class GeneratorBloc extends Bloc<GeneratorEvents, GeneratorState> {
  Plotto _plotto = Plotto();
  Subject _subject;
  Predicate _predicate;
  Outcome _outcome;
  List<ConflictLink> _links = [];

  GeneratorBloc() : super(LoadingState()) {
    on<GeneratorEvents>(
        (event, emit) async => emit(await mapEventToState(event)));
  }

  FutureOr<GeneratorState> mapEventToState(GeneratorEvents event) async {
    switch (event) {
      case GeneratorEvents.load:
        await _plotto.parse();
        return StartState();
        break;
      case GeneratorEvents.generate:
        _subject = _plotto.randomSubject;
        _predicate = _plotto.randomPredicate;
        _outcome = _plotto.randomOutcome;
        ConflictLink link = _plotto.followupPredicate(_predicate);
        _links.clear();
        _links.add(link);

        String description;
        if (link is TransformableLink) {
          description = _plotto.transform(link);
        } else {
          description = _plotto.describeConflict(link);
        }

        description = normalize(description);

        return FilledState(
            generatedText: description,
            group: "Undefined",
            subgroup: "Undefined",
            description:
                "${_subject.description}\n${_predicate.description}\n${_outcome.description}");
        break;
      case GeneratorEvents.lead_in:
        final link = _links.first;
        final conflict =
            _plotto.conflicts.singleWhere((element) => element.id == link.ref);
        final group =
            conflict.leadups[_plotto.getRandom(conflict.leadups.length)];
        final ref = group[_plotto.getRandom(group.length)];
        _links.insert(0, ref);
        final list = _links.map((e) => _plotto.describeConflict(e)).toList();
        String text = list.reduce((value, element) => value + "\n" + element);
        text = normalize(text);
        return FilledState(
            generatedText: text,
            group: "None",
            subgroup: "None",
            description:
                "${_subject.description}\n${_predicate.description}\n${_outcome.description}");
        break;
      case GeneratorEvents.carry_on:
        final link = _links.first;
        final conflict =
            _plotto.conflicts.singleWhere((element) => element.id == link.ref);
        final group =
            conflict.carryons[_plotto.getRandom(conflict.carryons.length)];
        final ref = group[_plotto.getRandom(group.length)];
        _links.add(ref);
        final list = _links.map((e) => _plotto.describeConflict(e)).toList();
        String text = list.reduce((value, element) => value + "\n" + element);
        text = normalize(text);
        return FilledState(
            generatedText: text,
            group: "None",
            subgroup: "None",
            description:
                "${_subject.description}\n${_predicate.description}\n${_outcome.description}");
        break;
      default:
        return StartState();
        break;
    }
  }

  String normalize(String description) {
    for (Character c in _plotto.characters.reversed) {
      description = description.replaceAll(c.designation, c.description);
    }
    return description;
  }
}
