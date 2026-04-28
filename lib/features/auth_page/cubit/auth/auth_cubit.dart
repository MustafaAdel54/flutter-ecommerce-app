import 'package:e_commerce/shared/models/users_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      emit(AuthSuccess("Welcome back!"));
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      emit(AuthError("An unexpected error occurred"));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      await UsersRepo().createUser(userCredential.user!.uid, email, username);

      emit(AuthSuccess("Account created successfully!"));
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    if (email.isEmpty) {
      emit(AuthError("Please enter your email address first."));
      return;
    }

    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      emit(AuthSuccess("A password reset link has been sent to your email."));
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      emit(AuthError("An unexpected error occurred."));
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message = "Authentication failed";

    if (e.code == 'invalid-credential') {
      message = "Incorrect email or password. Please try again.";
    } else if (e.code == 'email-already-in-use') {
      message = "This email is already registered.";
    } else if (e.code == 'invalid-email') {
      message = "The email address is not valid.";
    }

    emit(AuthError(message));
  }
}
