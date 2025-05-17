part of 'stations_bloc.dart';

@immutable
sealed class StationsState {}

final class StationsInitial extends StationsState {}

final class StationsLoading extends StationsState{}

class StationsLoaded extends StationsState{
  final StationsListModel stationsList;

  StationsLoaded({
    required this.stationsList
  });


}


class StationsOperationSuccess extends StationsState {}

class StationsError extends StationsState {
  final String message;
  StationsError({required this.message});
  @override
  List<Object> get props => [message];
}
