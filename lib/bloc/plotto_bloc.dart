import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plotto_event.dart';
part 'plotto_state.dart';

class PlottoBloc extends Bloc<PlottoEvent, PlottoState> {
  PlottoBloc() : super(PlottoInitial()) {
    on<PlottoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
