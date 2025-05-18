part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TasksLoaded extends TasksState {
  final TasksListModel tasksList;
  TasksLoaded(this.tasksList);
}

final class TasksOperationSuccess extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksError extends TasksState {
  final String message;
  TasksError({required this.message});
  @override
  List<Object> get props => [message];
}
