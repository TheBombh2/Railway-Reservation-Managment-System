part of 'trains_bloc.dart';

@immutable
sealed class TrainsState {}

final class TrainsInitial extends TrainsState {}

final class TrainsLoading extends TrainsState {}

final class TrainCreationLoaded extends TrainsState {
  final RoutesListModel routesList;
  final TrainTypesList trainTypesList;
  TrainCreationLoaded(this.routesList, this.trainTypesList);
}

final class TrainsLoaded extends TrainsState {
  final TrainsList trainsList;
  TrainsLoaded(this.trainsList);
}

final class TrainsTypesLoaded extends TrainsState {
  final TrainTypesList typesList;
  TrainsTypesLoaded(this.typesList);
}

final class TrainOperationSuccess extends TrainsState {}

class TrainsError extends TrainsState {
  final String message;
  TrainsError({required this.message});
  @override
  List<Object> get props => [message];
}
