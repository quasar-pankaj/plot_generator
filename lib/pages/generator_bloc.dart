import 'package:bloc/bloc.dart';
import 'package:plot_generator/pages/character.dart';
import 'package:plot_generator/pages/conflict_reference.dart';
import 'package:plot_generator/pages/generator_events.dart';
import 'package:plot_generator/pages/generator_states.dart';
import 'package:plot_generator/pages/plotto.dart';
import 'package:plot_generator/pages/predicate.dart';
import 'package:plot_generator/pages/subject.dart';

import 'outcome.dart';

class GeneratorBloc extends Bloc<GeneratorEvents, GeneratorState> {
  Plotto _plotto = Plotto();
  Subject _subject;
  Predicate _predicate;
  Outcome _outcome;
  List<ConflictLink> _links = [];

  GeneratorBloc() : super(LoadingState());

  @override
  Stream<GeneratorState> mapEventToState(GeneratorEvents event) async* {
    switch (event) {
      case GeneratorEvents.load:
        await _plotto.parse();
        yield StartState();
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

        yield FilledState(
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
        yield FilledState(
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
        yield FilledState(
            generatedText: text,
            group: "None",
            subgroup: "None",
            description:
                "${_subject.description}\n${_predicate.description}\n${_outcome.description}");
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
