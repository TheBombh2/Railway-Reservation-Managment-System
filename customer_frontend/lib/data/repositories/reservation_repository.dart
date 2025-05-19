import 'package:customer_frontend/data/model/reservation.dart';
import 'package:customer_frontend/data/model/station.dart';
import 'package:customer_frontend/data/model/ticket.dart';
import 'package:customer_frontend/data/model/train.dart';
import 'package:customer_frontend/data/services/reservation_service.dart';

class ReservationRepository {
  ReservationRepository({required ReservationService reservationService})
    : _reservationService = reservationService;

  final ReservationService _reservationService;

  Future<StationsListModel> getAllStations(String sessionToken) async {
    try {
      final raw = await _reservationService.getAllStations(sessionToken);
      final list = StationsListModel.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<TrainsListModel> getTrains(
    Station firstStation,
    Station secondStation,
    String sessionToken,
  ) async {
    try {
      final raw = await _reservationService.getTrains(
        firstStation.id!,
        secondStation.id!,
        sessionToken,
      );
      final list = TrainsListModel.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<Reservations> getCustomerReservations(
    String sessionToken,
  ) async {
    try {
      final raw = await _reservationService.getCustomerReservations(
        sessionToken,
      );
      final list = Reservations.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reserveTrain(Ticket ticket, String sessionToken) async {
    try {
      await _reservationService.reserveTrain(ticket.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }
}
