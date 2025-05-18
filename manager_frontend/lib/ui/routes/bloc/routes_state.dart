part of 'routes_bloc.dart';

@immutable
sealed class RoutesState {}

final class RoutesInitial extends RoutesState {}

final class RoutesLoading extends RoutesState {}

final class RoutesLoaded extends RoutesState{
  final RoutesListModel routesList;
  RoutesLoaded({required this.routesList});
}

final class RoutesConnectionsLoaded extends RoutesState{
  final RouteConnectionsList connectionsList;
  RoutesConnectionsLoaded({required this.connectionsList});
}

final class RoutesConnectionsCreationLoaded extends RoutesState{
  final StationsListModel stations;
  RoutesConnectionsCreationLoaded({required this.stations});
}


final class RoutesOperationSuccess extends RoutesState{}


class RoutesError extends RoutesState {
  final String message;
  RoutesError({required this.message});
  @override
  List<Object> get props => [message];
}

