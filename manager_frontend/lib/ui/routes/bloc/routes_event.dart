part of 'routes_bloc.dart';

abstract class RoutesEvent {}

class LoadRoutes extends RoutesEvent {
  LoadRoutes();
}

class LoadRouteConnections extends RoutesEvent {
  final String routeID;
  LoadRouteConnections({required this.routeID});
}

class LoadRouteConnectionsCreation extends RoutesEvent {
  LoadRouteConnectionsCreation();
}

class CreateRoute extends RoutesEvent {
  final RouteCreate routeData;
  final List<RouteConnection> connectionsList;
  CreateRoute({required this.routeData, required this.connectionsList});
}

class DeleteRoute extends RoutesEvent {
  final String routeID;
  DeleteRoute({required this.routeID});
}
