import 'dart:async';

import 'package:bloc/bloc.dart';
import 'character.dart';
import 'conflict_reference.dart';
import 'generator_events.dart';
import 'generator_states.dart';
import 'xml_plotto.dart';
import 'predicate.dart';
import 'subject.dart';

import 'outcome.dart';

class GeneratorBloc extends Bloc<GeneratorEvent, GeneratorState> {
  XmlPlotto _plotto = XmlPlotto();
  Subject _subject;
  Predicate _predicate;
  Outcome _outcome;
  List<ConflictLink> _links = [];

  GeneratorBloc() : super(LoadingState()) {
    // on<GeneratorEvents>(
    //     (event, emit) async => emit(await mapEventToState(event)));

    on<AppLoadRequested>((event, emit) async => await _onLoading(event, emit));
    on<SkeletonRequested>((event, emit) => emit(_onSkeletonGenerated(event)));
    on<ConflictsRequested>((event, emit) => emit(_onConflictRequested(event)));
    on<LeadInRequested>((event, emit) => emit(_onLeadinRequested(event)));
    on<CarryOnRequested>((event, emit) => emit(_onCarryOnRequested(event)));
    on<IncludeRequested>((event, emit) => emit(_onIncludeRequested(event)));
    on<SynopsisRequested>((event, emit) => emit(_onSynopsisRequested(event)));
  }

  Future<void> _onLoading(
    AppLoadRequested event,
    Emitter<GeneratorState> emit,
  ) async {
    emit(LoadingState());
    await _plotto.parse();
    emit(LoadedState());
  }

  SkeletonGeneratedState _onSkeletonGenerated(SkeletonRequested event) {
    final Subject subject = _plotto.randomSubject;
    final Predicate predicate = _plotto.randomPredicate;
    final Outcome outcome = _plotto.randomOutcome;

    return SkeletonGeneratedState(subject, predicate, outcome);
  }

  CarryOnFetchedState _onConflictRequested(ConflictsRequested event) {
    final ConflictLink link = _plotto.followupPredicate(event.predicate);

    return CarryOnFetchedState(_plotto.fetch(link));
  }

  LeadInFetchedState _onLeadinRequested(LeadInRequested event) {
    final conflicts = _plotto.followupLeadIns(event.conflict);
    final rnd = _plotto.getRandom(conflicts.length);

    return LeadInFetchedState(conflicts[rnd]);
  }

  CarryOnFetchedState _onCarryOnRequested(CarryOnRequested event) {
    final conflicts = _plotto.followupLeadIns(event.conflict);
    final rnd = _plotto.getRandom(conflicts.length);

    return CarryOnFetchedState(conflicts[rnd]);
  }

  IncludeFetchedState _onIncludeRequested(IncludeRequested event) {
    final conflicts = _plotto.followupLeadIns(event.conflict);
    final rnd = _plotto.getRandom(conflicts.length);

    return IncludeFetchedState(conflicts[rnd]);
  }

  SynopsisFetchedState _onSynopsisRequested(SynopsisRequested event) {
    String synopsis = event.subject.description.trim() + '\n';
    synopsis += event.predicate.description.trim() + '\n';
    for (var element in event.conflicts) {
      for (var perms in element.permutations) {
        synopsis += perms.description.trim() + '\n';
      }
    }
    synopsis += event.outcome.description;

    return SynopsisFetchedState(synopsis);
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
