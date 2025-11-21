

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/domain/repository/api.dart';
import 'package:solana_time/presentation/bloc/events/main_event.dart';
import 'package:solana_time/presentation/bloc/state/main_state.dart';
import 'package:solana_time/presentation/bloc/state/state_types.dart';



class MainBloc extends Bloc<MainEvents, MainState> {
  final MainApi api;
  StreamSubscription<DateTime>? _localDateStream;

  MainBloc({required this.api}) : super(MainState.init()) {
    on<StopEventEvent>(_onClickStop);
    on<RunEventEvent>(_onClickRun);

    on<SolanaTimeEvent>(_onClickSolana);
    on<ClientTimeEvent>(_onClickClient);
    on<BothTimeEvent>(_onClickBoth);

    on<LocalDateTimeEvent>(_onGetLocalDateTime);

  }

  _onClickStop(StopEventEvent event, Emitter<MainState> emit) async {
    await _localDateStream?.cancel();
    api.closeLocalStream();
    emit(state.copyWith(networkState: ConnectionStatus.disconnected, runningState: ProcessStatus.stop));
  }

  _onClickRun(RunEventEvent event, Emitter<MainState> emit) async {
    if (state.runningState == ProcessStatus.run) return;
    emit(state.copyWith(networkState: ConnectionStatus.connecting, runningState: ProcessStatus.run));
    _localDateStream = api.startLocalStream().listen((value) {
      print(["value", value]);
      add(LocalDateTimeEvent(value));
    });
    emit(state.copyWith(networkState: ConnectionStatus.connect,));
  }

  _onGetLocalDateTime(LocalDateTimeEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(localDateTime: event.time));
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

  @override
  Future<void> close() {
    _localDateStream?.cancel();
    api.dispose();
    return super.close();
  }

}