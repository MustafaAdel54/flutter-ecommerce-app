import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_toggle_state.dart';

class AuthToggleCubit extends Cubit<AuthToggleState> {
  AuthToggleCubit() : super(AuthLoginState());

  void showLogin() => emit(AuthLoginState());

  void showSignUp() => emit(AuthSignUpState());

  void toggle() {
    if (state is AuthLoginState) {
      emit(AuthSignUpState());
    } else {
      emit(AuthLoginState());
    }
  }
}
