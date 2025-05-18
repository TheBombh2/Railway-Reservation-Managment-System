import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:manager_frontend/data/model/route.dart';
import 'package:manager_frontend/data/model/station.dart';
import 'package:manager_frontend/data/repositories/authentication_repository.dart';
import 'package:manager_frontend/data/repositories/reservation_repository.dart';
import 'package:meta/meta.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final ReservationRepository reservationRepository;
  final AuthenticationRepository authenticationRepository;
  RoutesBloc({
    required this.reservationRepository,
    required this.authenticationRepository,
  }) : super(RoutesInitial()) {
    on<LoadRoutes>(_onLoadRoutes);
    on<CreateRoute>(_onCreateRoute);
    on<LoadRouteConnections>(_onLoadRouteConnections);
    on<DeleteRoute>(_onDeleteRoute);
    on<LoadRouteConnectionsCreation>(_onLoadRouteConnectionsCreation);
  }

  Future<void> _onLoadRoutes(
    LoadRoutes event,
    Emitter<RoutesState> emit,
  ) async {
    emit(RoutesLoading());
    try {
      var routesList = await reservationRepository.getAllRoutes(
        authenticationRepository.getSessionToken(),
      );

      final stationsList = await reservationRepository.getAllStations(
        authenticationRepository.getSessionToken(),
      );

      for (var route in routesList.routes!) {
        final matchStation = stationsList.stations!.firstWhere(
          (station) => station.id == route.firstStationID,
        );

        route.firstStationName = matchStation.name;
      }

      emit(RoutesLoaded(routesList: routesList));
    } catch (e) {
      emit(RoutesError(message: e.toString()));
    }
  }

  Future<void> _onLoadRouteConnectionsCreation(
    LoadRouteConnectionsCreation event,
    Emitter<RoutesState> emit,
  ) async {
    emit(RoutesLoading());
    try {
      final stationsList = await reservationRepository.getAllStations(
        authenticationRepository.getSessionToken(),
      );

      emit(RoutesConnectionsCreationLoaded(stations: stationsList));
    } catch (e) {
      emit(RoutesError(message: e.toString()));
    }
  }

  Future<void> _onLoadRouteConnections(
    LoadRouteConnections event,
    Emitter<RoutesState> emit,
  ) async {
    emit(RoutesLoading());
    try {
      final list = await reservationRepository.getRouteConnections(
        event.routeID,
        authenticationRepository.getSessionToken(),
      );

      emit(RoutesConnectionsLoaded(connectionsList: list));
    } catch (e) {
      emit(RoutesError(message: e.toString()));
    }
  }

  Future<void> _onCreateRoute(
    CreateRoute event,
    Emitter<RoutesState> emit,
  ) async {
    emit(RoutesLoading());
    late String routeID;

    try {
      routeID = await reservationRepository.createNewRoute(
        event.routeData,
        authenticationRepository.getSessionToken(),
      );

      for (var con in event.connectionsList) {
        con.routeID = routeID;
        await reservationRepository.addRouteConnection(
          con,
          authenticationRepository.getSessionToken(),
        );
      }
      emit(RoutesOperationSuccess());
      add(LoadRoutes());
    } catch (e) {
      add(DeleteRoute(routeID: routeID));
      emit(RoutesError(message: e.toString()));
    }
  }

  Future<void> _onDeleteRoute(
    DeleteRoute event,
    Emitter<RoutesState> emit,
  ) async {
    if (state is RoutesLoaded) {
      final currentState = state as RoutesLoaded;
      try {
        await reservationRepository.deleteRoute(
          event.routeID,
          authenticationRepository.getSessionToken(),
        );
        emit(RoutesOperationSuccess());
        add(LoadRoutes());
      } catch (e) {
        emit(RoutesError(message: e.toString()));
        emit(currentState);
      }
    }
  }
}
