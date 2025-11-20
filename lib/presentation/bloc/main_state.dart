import 'package:equatable/equatable.dart';
import 'package:solana_time/presentation/bloc/events/network_events.dart';
import 'events/process_events.dart';
import 'events/time_event.dart';

class MainState extends Equatable {
  final NetworkState networkState;
  final TimeEvents timeEvents;
  final ProcessEvents processEvents;

  const MainState._({
    required this.networkState,
    required this.timeEvents,
    required this.processEvents,
});



  @override
  List<Object?> get props => [networkState, timeEvents, processEvents];

}