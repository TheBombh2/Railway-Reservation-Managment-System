part of 'register_bloc.dart';

sealed class RegisterState {}

final class RegisterInital extends RegisterState {}
final class RegisterLoading extends RegisterState {}

final class RegisterCompleted extends RegisterState {}
