import 'package:bloc/bloc.dart';
import 'package:manager_frontend/data/model/route.dart';
import 'package:manager_frontend/data/model/train.dart';
import 'package:manager_frontend/data/repositories/authentication_repository.dart';
import 'package:manager_frontend/data/repositories/reservation_repository.dart';
import 'package:meta/meta.dart';

part 'trains_event.dart';
part 'trains_state.dart';

class TrainsBloc extends Bloc<TrainsEvent, TrainsState> {
  final ReservationRepository reservationRepository;
  final AuthenticationRepository authenticationRepository;
  TrainsBloc({
    required this.reservationRepository,
    required this.authenticationRepository,
  }) : super(TrainsInitial()) {
    on<LoadTrains>(_onLoadTrains);
    on<CreateTrainType>(_onCreateTrainType);
    on<CreateTrain>(_onCreateTrain);
    on<DeleteTrain>(_onDeleteTrain);
    on<StartTrain>(_onStartTrain);
    on<StopTrain>(_onStopTrain);
    on<LoadTrainCreation>(_onLoadTrainCreation);
  }

  Future<void> _onLoadTrains(
    LoadTrains event,
    Emitter<TrainsState> emit,
  ) async {
    emit(TrainsLoading());
    try {
      var trainsList = await reservationRepository.getAllTrainsInfo(
        authenticationRepository.getSessionToken(),
      );

      for (var train in trainsList.trains!) {
        train.state = await reservationRepository.getTrainState(
          train.id!,
          authenticationRepository.getSessionToken(),
        );
      }

      emit(TrainsLoaded(trainsList));
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onLoadTrainCreation(
    LoadTrainCreation event,
    Emitter<TrainsState> emit,
  ) async {
    emit(TrainsLoading());
    try {
      final trainTypes = await reservationRepository.getAllTrainTypes(
        authenticationRepository.getSessionToken(),
      );

      final routesList = await reservationRepository.getAllRoutes(
        authenticationRepository.getSessionToken(),
      );

      emit(TrainCreationLoaded(routesList, trainTypes));
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onCreateTrain(
    CreateTrain event,
    Emitter<TrainsState> emit,
  ) async {
    emit(TrainsLoading());

    try {
      await reservationRepository.createNewTrain(
        event.data,
        authenticationRepository.getSessionToken(),
      );

      emit(TrainOperationSuccess());
      add(LoadTrains());
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onCreateTrainType(
    CreateTrainType event,
    Emitter<TrainsState> emit,
  ) async {
    emit(TrainsLoading());

    try {
      await reservationRepository.createNewTrainType(
        event.data,
        authenticationRepository.getSessionToken(),
      );

      emit(TrainOperationSuccess());
      add(LoadTrains());
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTrain(
    DeleteTrain event,
    Emitter<TrainsState> emit,
  ) async {
    if (state is TrainsLoaded) {
      final currentState = state as TrainsLoaded;
      try {
        await reservationRepository.deleteTrain(
          event.trainID,
          authenticationRepository.getSessionToken(),
        );
        emit(TrainOperationSuccess());
        add(LoadTrains());
      } catch (e) {
        emit(TrainsError(message: e.toString()));
        emit(currentState);
      }
    }
  }

  Future<void> _onStartTrain(
    StartTrain event,
    Emitter<TrainsState> emit,
  ) async {
    emit(TrainsLoading());

    try {
      await reservationRepository.sendTrain(
        event.trainID,
        authenticationRepository.getSessionToken(),
      );

      emit(TrainOperationSuccess());
      add(LoadTrains());
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }

  Future<void> _onStopTrain(StopTrain event, Emitter<TrainsState> emit) async {
    emit(TrainsLoading());

    try {
      await reservationRepository.stopTrain(
        event.trainID,
        authenticationRepository.getSessionToken(),
      );

      emit(TrainOperationSuccess());
      add(LoadTrains());
    } catch (e) {
      emit(TrainsError(message: e.toString()));
    }
  }
}
