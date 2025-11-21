import 'package:equatable/equatable.dart';

import 'events/main_event.dart';

class MainState extends Equatable {
  final MainEvents timeEvent;
  final MainEvents networkEvent;
  final MainEvents runEvent;

  const MainState._({
    required this.timeEvent,
    required this.networkEvent,
    required this.runEvent,
});
  factory MainState.init() => MainState._(
      timeEvent: SolanaTime(),
      networkEvent: Disconnected(),
      runEvent: StopEvent());

  MainState copyWith(
      MainEvents? timeEvent,
      MainEvents? networkEvent,
      MainEvents? runEvent,
      ) =>
      MainState._(
      timeEvent: timeEvent ?? this.timeEvent,
      networkEvent: networkEvent ?? this.timeEvent,
      runEvent: runEvent ?? this.timeEvent
      );


  @override
  List<Object?> get props => [timeEvent, networkEvent, runEvent];

}