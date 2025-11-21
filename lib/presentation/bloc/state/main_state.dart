import 'package:equatable/equatable.dart';
import 'package:solana_time/presentation/bloc/state/state_types.dart';


class MainState extends Equatable {
  final TimeSource timeState;
  final ConnectionStatus networkState;
  final ProcessStatus runningState;

  const MainState._({
    required this.timeState,
    required this.networkState,
    required this.runningState,
});

  factory MainState.init() => MainState._(
      timeState: TimeSource.local,
      networkState: ConnectionStatus.disconnected,
      runningState: ProcessStatus.stop);

  MainState copyWith({
    TimeSource? timeState,
    ConnectionStatus? networkState,
    ProcessStatus? runningState,
  }) =>
      MainState._(
          timeState: timeState ?? this.timeState,
          networkState: networkState ?? this.networkState,
          runningState: runningState ?? this.runningState
      );


  @override
  List<Object?> get props => [timeState, networkState, runningState];

}