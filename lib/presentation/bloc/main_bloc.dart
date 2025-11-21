

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/presentation/bloc/events/main_event.dart';
import 'package:solana_time/presentation/bloc/main_state.dart';



class MainBloc extends Bloc<MainEvents, MainState> {
  MainBloc() : super(MainState.init()) {
    on<StopEvent>(_onClickStop);
    on<RunEvent>(_onClickRun);

    on<SolanaTime>(_onClickSolana);
    on<ClientTime>(_onClickClient);
    on<BothTime>(_onClickBoth);

  }

  _onClickStop(StopEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(runEvent: StopEvent()));
  }

  _onClickRun(RunEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(runEvent: RunEvent()));
  }

  _onClickSolana(SolanaTime event, Emitter<MainState> emit) {
    emit(state.copyWith(runEvent: SolanaTime()));
  }

  _onClickClient(ClientTime event, Emitter<MainState> emit) {
    emit(state.copyWith(runEvent: ClientTime()));
  }

  _onClickBoth(BothTime event, Emitter<MainState> emit) {
    emit(state.copyWith(runEvent: BothTime()));
  }

}