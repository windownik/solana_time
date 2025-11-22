import 'package:equatable/equatable.dart';
import 'package:solana_time/presentation/features/bloc/state/state_types.dart';



class MainState extends Equatable {
  final TimeSource timeState;
  final ConnectionStatus connectionState;
  final ProcessStatus processState;
  final DateTime? localDateTime;
  final DateTime? solanaDateTime;

  const MainState._({
    required this.timeState,
    required this.connectionState,
    required this.processState,
    this.localDateTime,
    this.solanaDateTime,
  });

  factory MainState.init() => MainState._(
      timeState: TimeSource.local,
      connectionState: ConnectionStatus.disconnected,
      processState: ProcessStatus.stop,
  );

  MainState copyWith({
    TimeSource? timeState,
    ConnectionStatus? networkState,
    ProcessStatus? runningState,
    DateTime? localDateTime,
    DateTime? solanaDateTime
  }) =>
      MainState._(
          timeState: timeState ?? this.timeState,
          connectionState: networkState ?? this.connectionState,
          processState: runningState ?? this.processState,
          localDateTime: localDateTime,
          solanaDateTime: solanaDateTime,
      );

  MainState copyWithForBoth({
    ConnectionStatus? networkState,
    DateTime? localDateTime,
    DateTime? solanaDateTime
  }) =>
      MainState._(
        timeState: this.timeState,
        connectionState: networkState ?? this.connectionState,
        processState: this.processState,
        localDateTime: localDateTime ?? this.localDateTime,
        solanaDateTime: solanaDateTime ?? this.solanaDateTime,
      );


  @override
  List<Object?> get props => [timeState, connectionState, processState, localDateTime, solanaDateTime];

}