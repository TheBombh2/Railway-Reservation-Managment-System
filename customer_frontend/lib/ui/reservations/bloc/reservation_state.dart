part of 'reservation_bloc.dart';

@immutable
sealed class ReservationsState {}

final class ReservationsInitial extends ReservationsState {}

final class ReservationsLoaded extends ReservationsState {
  final Reservations list;
  ReservationsLoaded(this.list);
}

final class ReservationsLoading extends ReservationsState {}

final class ReservationsError extends ReservationsState {
  final String message;
  ReservationsError({required this.message});
  @override
  List<Object> get props => [message];
}
