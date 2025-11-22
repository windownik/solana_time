import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/domain/repository/api.dart';
import 'package:solana_time/presentation/features/bloc/state/main_state.dart';
import 'package:solana_time/presentation/features/bloc/state/state_types.dart';

import 'events/main_event.dart';


class MainBloc extends Bloc<MainEvents, MainState> {
  final MainApi api;
  StreamSubscription<DateTime>? _localDateStream;
  StreamSubscription<DateTime>? _solanaDateStream;

  MainBloc({required this.api}) : super(MainState.init()) {
    on<StopEvent>(_onClickStop);
    on<RunEvent>(_onClickRun);

    on<SolanaTimeEvent>(_onClickSolana);
    on<ClientTimeEvent>(_onClickClient);
    on<BothTimeEvent>(_onClickBoth);

    on<LocalDateTimeEvent>(_onGetLocalDateTime);
    on<SolanaDateTimeEvent>(_onGetSolanaDateTime);
  }

  _onClickStop(StopEvent event, Emitter<MainState> emit) async {
    await _localDateStream?.cancel();
    api.closeLocalStream();
    api.closeSolanaStream();
    emit(
      state.copyWith(
        networkState: ConnectionStatus.disconnected,
        runningState: ProcessStatus.stop,
      ),
    );
  }

  _onClickRun(RunEvent event, Emitter<MainState> emit) async {
    if (state.processState == ProcessStatus.run) return;
    emit(
      state.copyWith(
        networkState: ConnectionStatus.connecting,
        runningState: ProcessStatus.run,
      ),
    );
    if (state.timeState == TimeSource.solana ||
        state.timeState == TimeSource.both) {
      _runSolana();
    }
    if (state.timeState == TimeSource.local ||
        state.timeState == TimeSource.both) {
      _runLocal();
    }
    // emit(state.copyWith(networkState: ConnectionStatus.connect,));
  }

  _onGetSolanaDateTime(SolanaDateTimeEvent event, Emitter<MainState> emit) {
    // print(["SolanaDateTimeEvent", event.time]);
    ConnectionStatus? networkState;
    if (state.solanaDateTime == null) {
      networkState = ConnectionStatus.connect;
    }
    if (state.timeState == TimeSource.both) {
      emit(
        state.copyWithForBoth(
          solanaDateTime: event.time,
          networkState: networkState,
        ),
      );
    } else {
      emit(
        state.copyWith(solanaDateTime: event.time, networkState: networkState),
      );
    }
  }

  _onGetLocalDateTime(LocalDateTimeEvent event, Emitter<MainState> emit) {
    // print(["LocalDateTime", event.time]);
    ConnectionStatus? networkState;
    if (state.localDateTime == null) {
      networkState = ConnectionStatus.connect;
    }
    if (state.timeState == TimeSource.both) {
      emit(
        state.copyWithForBoth(
          localDateTime: event.time,
          networkState: networkState,
        ),
      );
    } else {
      emit(
        state.copyWith(localDateTime: event.time, networkState: networkState),
      );
    }
  }

  _onClickSolana(SolanaTimeEvent event, Emitter<MainState> emit) async {
    if (state.timeState == TimeSource.solana) return;

    if (state.processState == ProcessStatus.run) {
      emit(state.copyWith(networkState: ConnectionStatus.connecting));
      await _localDateStream?.cancel();
      api.closeLocalStream();
      _runSolana();
    }
    emit(state.copyWith(timeState: TimeSource.solana));
  }

  _onClickClient(ClientTimeEvent event, Emitter<MainState> emit) {
    if (state.timeState == TimeSource.local) return;
    if (state.processState == ProcessStatus.run) {
      emit(state.copyWith(networkState: ConnectionStatus.connecting));
      api.closeSolanaStream();
      _runLocal();
    }
    emit(state.copyWith(timeState: TimeSource.local));
  }

  _onClickBoth(BothTimeEvent event, Emitter<MainState> emit) {
    if (state.processState == ProcessStatus.run) {
      emit(state.copyWith(networkState: ConnectionStatus.connecting));
      if (state.timeState == TimeSource.local) {
        _runSolana();
      }
      if (state.timeState == TimeSource.solana) {
        _runLocal();
      }
    }
    emit(state.copyWith(timeState: TimeSource.both));
  }

  _runLocal() {
    _localDateStream = api.startLocalStream().listen((value) {
      add(LocalDateTimeEvent(value));
    });
  }

  _runSolana() {
    _solanaDateStream = api.startSolanaStream().listen((value) {
      add(SolanaDateTimeEvent(value));
    });
  }

  @override
  Future<void> close() {
    _localDateStream?.cancel();
    _solanaDateStream?.cancel();

    api.dispose();
    return super.close();
  }
}
