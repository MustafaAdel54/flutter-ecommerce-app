part of 'auth_toggle_cubit.dart';

sealed class AuthToggleState {}

class AuthLoginState extends AuthToggleState {}

class AuthSignUpState extends AuthToggleState {}
