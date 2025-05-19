part of 'trains_bloc.dart';

@immutable
sealed class TrainsState {}

final class TrainsInitial extends TrainsState {}

final class StationsLoading extends TrainsState {}

final class TrainsLoading extends TrainsState {}


final class TrainsLoaded extends TrainsState{
  final Station firstStation;
  final Station secondStation;
  final TrainsListModel trainsList;
  TrainsLoaded(this.trainsList,this.firstStation,this.secondStation);
}


final class StationsLoaded extends TrainsState {
  final StationsListModel stationsList;
  StationsLoaded(this.stationsList);
}

final class StationsSelected extends TrainsState {
  final Station fromStation;
  final Station toStation;
  StationsSelected(this.fromStation,this.toStation);
}


final class StationOperationSuccess extends TrainsState{
  
}

class TrainsError extends TrainsState {
  final String message;
  TrainsError({required this.message});
  @override
  List<Object> get props => [message];
}