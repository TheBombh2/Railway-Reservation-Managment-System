import 'package:bloc/bloc.dart';
import 'package:manager_frontend/data/model/station.dart';
import 'package:manager_frontend/data/repositories/authentication_repository.dart';
import 'package:manager_frontend/data/repositories/reservation_repository.dart';
import 'package:meta/meta.dart';

part 'stations_event.dart';
part 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final ReservationRepository reservationRepository;
  final AuthenticationRepository authenticationRepository;

  StationsBloc({
    required this.reservationRepository,
    required this.authenticationRepository,
  }) : super(StationsInitial()) {
    on<LoadStations>(_onLoadStations);
    on<CreateStation>(_onCreateStation);
    on<DeleteStation>(_onDeleteStation);
    on<CreateStationConnection>(_onCeateConnection);
  }

  Future<void> _onLoadStations(
    LoadStations event,
    Emitter<StationsState> emit,
  ) async {
    emit(StationsLoading());
    try {
      final stationsList =await  reservationRepository.getAllStations(
        authenticationRepository.getSessionToken(),
      );

      emit(
        StationsLoaded(
         stationsList: stationsList
        ),
      );
    } catch (e) {
      emit(StationsError(message: e.toString()));
    }
  }

  Future<void> _onCreateStation(
    CreateStation event,
    Emitter<StationsState> emit,
  ) async {
    if (state is StationsLoaded) {
      final currentState = state as StationsLoaded;
      try {
        await reservationRepository.createNewStation(
          event.stationData,
          authenticationRepository.getSessionToken(),
        );
        emit(StationsOperationSuccess());
        add(LoadStations());
      } catch (e) {
        emit(StationsError(message: e.toString()));
        emit(currentState);
      }
    }
  }

   Future<void> _onCeateConnection(
    CreateStationConnection event,
    Emitter<StationsState> emit,
  ) async {
    if (state is StationsLoaded) {
      final currentState = state as StationsLoaded;
      try {
        await reservationRepository.createNewStationConnection(
          event.data,
          authenticationRepository.getSessionToken()
        );
        emit(StationsOperationSuccess());
        add(LoadStations());
      } catch (e) {
        emit(StationsError(message: e.toString()));
        emit(currentState);
      }
    }
  }


   Future<void> _onDeleteStation(
    DeleteStation event,
    Emitter<StationsState> emit,
  ) async {
    if (state is StationsLoaded) {
      final currentState = state as StationsLoaded;
      try {
        await reservationRepository.deleteStation(
          event.stationID,
          authenticationRepository.getSessionToken(),
        );
        emit(StationsOperationSuccess());
        add(LoadStations());
      } catch (e) {
        emit(StationsError(message: e.toString()));
        emit(currentState);
      }
    }
  }
}
