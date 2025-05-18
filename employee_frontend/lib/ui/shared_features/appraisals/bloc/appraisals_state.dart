part of 'appraisals_bloc.dart';

@immutable
sealed class AppraisalsState {}

final class AppraisalsInitial extends AppraisalsState {}

final class AppraisalsLoaded extends AppraisalsState {
  final AppraisalsListModel list;
  AppraisalsLoaded(this.list);
}

final class AppraisalsLoading extends AppraisalsState {}

final class AppraisalsError extends AppraisalsState {
  final String message;
  AppraisalsError({required this.message});
  @override
  List<Object> get props => [message];
}
