part of 'stations_bloc.dart';

abstract class StationsEvent {}

class LoadStations extends StationsEvent {
  LoadStations();
}

class CreateStation extends StationsEvent {
  final StationCreate stationData;

  CreateStation({required this.stationData});
}

class CreateStationConnection extends StationsEvent {
  final dynamic data;


  CreateStationConnection({
    required this.data
  });
}

class DeleteStation extends StationsEvent {
  final String stationID;

  DeleteStation({required this.stationID});
}
