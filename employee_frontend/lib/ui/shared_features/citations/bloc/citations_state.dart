part of 'citations_bloc.dart';

@immutable
sealed class CitationsState {}

final class CitationsInitial extends CitationsState {}

final class CitationsLoaded extends CitationsState {
  final CitationsListModel list;
  CitationsLoaded(this.list);
}

final class CitationsLoading extends CitationsState {}

final class CitationsError extends CitationsState {
  final String message;
  CitationsError({required this.message});
  @override
  List<Object> get props => [message];
}
