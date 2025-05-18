part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class AuthenticationSubscriptionRequest extends AuthenticationEvent {}

final class AuthenticationLogoutPressed extends AuthenticationEvent {}