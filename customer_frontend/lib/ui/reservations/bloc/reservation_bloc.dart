import 'package:bloc/bloc.dart';
import 'package:customer_frontend/data/model/reservation.dart';
import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/data/repositories/reservation_repository.dart';
import 'package:meta/meta.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final ReservationRepository reservationRepository;
  final AuthenticationRepository authenticationRepository;
  ReservationsBloc({
    required this.reservationRepository,
    required this.authenticationRepository,
  }) : super(ReservationsInitial()) {
    on<LoadReservations>(_onLoadReservations);
  }

  Future<void> _onLoadReservations(
    LoadReservations event,
    Emitter<ReservationsState> emit,
  ) async {
    emit(ReservationsLoading());
    try {
      var list = await reservationRepository.getCustomerReservations(
        authenticationRepository.getSessionToken(),
      );
      emit(ReservationsLoaded(list));
    } catch (e) {
      emit(ReservationsError(message: e.toString()));
    }
  }
}
