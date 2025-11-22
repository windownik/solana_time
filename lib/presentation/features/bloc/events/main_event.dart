abstract class MainEvents {}

class SolanaTimeEvent extends MainEvents {}
class ClientTimeEvent extends MainEvents {}
class BothTimeEvent extends MainEvents {}



class DisconnectedEvent extends MainEvents {}
class ConnectingEvent extends MainEvents {}
class ConnectEvent extends MainEvents {}
class ConnectionErrorEvent extends MainEvents {}



class RunEvent extends MainEvents {}
class StopEvent extends MainEvents {}



class LocalDateTimeEvent extends MainEvents {
  final DateTime time;
  LocalDateTimeEvent(this.time);
}


class SolanaDateTimeEvent extends MainEvents {
  final DateTime time;
  SolanaDateTimeEvent(this.time);
}

