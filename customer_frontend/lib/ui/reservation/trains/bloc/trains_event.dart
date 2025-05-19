part of 'trains_bloc.dart';

@immutable
sealed class TrainsEvent {}

final class LoadStations extends TrainsEvent {}

final class ReserveTicket extends TrainsEvent {
  final Ticket ticket;
  ReserveTicket(this.ticket);
}

final class LoadTrains extends TrainsEvent {
  final Station firstStation;
  final Station secondStation;
  LoadTrains(this.firstStation, this.secondStation);
}

final class SelectStations extends TrainsEvent {
  final Station station;
  final bool isFrom;
  SelectStations({required this.station, required this.isFrom});
}
