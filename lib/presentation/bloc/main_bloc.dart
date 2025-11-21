

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/domain/repository/api.dart';
import 'package:solana_time/presentation/bloc/events/main_event.dart';
import 'package:solana_time/presentation/bloc/state/main_state.dart';
import 'package:solana_time/presentation/bloc/state/state_types.dart';



class MainBloc extends Bloc<MainEvents, MainState> {
  final MainApi api;

  MainBloc({required this.api}) : super(MainState.init()) {
    on<StopEventEvent>(_onClickStop);
    on<RunEventEvent>(_onClickRun);

    on<SolanaTimeEvent>(_onClickSolana);
    on<ClientTimeEvent>(_onClickClient);
    on<BothTimeEvent>(_onClickBoth);

  }

  _onClickStop(StopEventEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(runningState: ProcessStatus.stop));
  }

  _onClickRun(RunEventEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(networkState: ConnectionStatus.connecting));
    emit(state.copyWith(runningState: ProcessStatus.run));
    emit(state.copyWith(networkState: ConnectionStatus.connect));
  }

  _onClickSolana(SolanaTimeEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(timeState: TimeSource.solana));
  }

  _onClickClient(ClientTimeEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(timeState: TimeSource.local));
  }

  _onClickBoth(BothTimeEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(timeState: TimeSource.both));
  }

}