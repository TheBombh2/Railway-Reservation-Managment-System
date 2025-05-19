import 'package:bloc/bloc.dart';
import 'package:customer_frontend/data/model/station.dart';
import 'package:customer_frontend/data/model/ticket.dart';
import 'package:customer_frontend/data/model/train.dart';
import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/data/repositories/reservation_repository.dart';
import 'package:customer_frontend/ui/reservation/trains/widgets/trains_list.dart';
import 'package:meta/meta.dart';

part 'trains_event.dart';
part 'trains_state.dart';

class TrainsBloc extends Bloc<TrainsEvent, TrainsState> {
  final ReservationRepository reservationRepository;
  final AuthenticationRepository authenticationRepository;
  Station? fromStation;
  Station? secondStation;
  TrainsBloc({
    required this.reservationRepository,
    required this.authenticationRepository,
  }) : super(TrainsInitial()) {
    on<LoadStations>(_onLoadStations);
    on<SelectStations>(_onSelectStations);
    on<LoadTrains>(_onLoadTrains);
    on<ReserveTicket>(_onReserveTicket);
  }

  Future<void> _onLoadStations(
    LoadStations event,
    Emitter<TrainsState> emit,
  ) async {
    emit(StationsLoading());
    try {
      final stationsList = await reservationRepository.getAllStations(
        authenticationRepository.getSessionToken(),
      );

      emit(StationsLoaded(stationsList));
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onReserveTicket(
    ReserveTicket event,
    Emitter<TrainsState> emit,
  ) async {
    emit(StationsLoading());
    try {
      await reservationRepository.reserveTrain(
        event.ticket,
        authenticationRepository.getSessionToken(),
      );

      emit(StationOperationSuccess());
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onLoadTrains(
    LoadTrains event,
    Emitter<TrainsState> emit,
  ) async {
    emit(TrainsLoading());
    try {
      final stationsList = await reservationRepository.getTrains(
        event.firstStation,
        event.secondStation,
        authenticationRepository.getSessionToken(),
      );

      emit(TrainsLoaded(stationsList, event.firstStation, event.secondStation));
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onSelectStations(
    SelectStations event,
    Emitter<TrainsState> emit,
  ) async {
    emit(StationsLoading());
    try {
      if (event.isFrom) {
        fromStation = event.station;
      } else {
        secondStation = event.station;
      }

      emit(StationOperationSuccess());

      emit(
        StationsSelected(
          fromStation ?? Station(name: "Not Selected"),
          secondStation ?? Station(name: "Not Selected"),
        ),
      );

      if (fromStation != null && secondStation != null) {
        add(LoadTrains(fromStation!, secondStation!));
      }
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }
}
