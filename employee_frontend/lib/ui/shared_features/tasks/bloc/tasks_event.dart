part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

class LoadTasks extends TasksEvent{}

class CompleteTask extends TasksEvent{}

