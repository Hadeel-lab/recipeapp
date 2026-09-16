import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/register_with_email.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmail signInWithEmail;
  final RegisterWithEmail registerWithEmail;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signInWithEmail,
    required this.registerWithEmail,
  }) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);

    on<SignInWithEmailEvent>(_onSignInWithEmail);

    on<RegisterWithEmailEvent>(_onRegisterWithEmail);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await signInWithGoogle();

      if (user == null) {
        emit(AuthFailure('Google sign in was cancelled'));
        return;
      }

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(_getFirebaseErrorMessage(e)));
    }
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await signInWithEmail(event.email, event.password);

      if (user == null) {
        emit(AuthFailure('Login failed'));
        return;
      }

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(_getFirebaseErrorMessage(e)));
    }
  }

  Future<void> _onRegisterWithEmail(
    RegisterWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await registerWithEmail(
        event.name,
        event.email,
        event.password,
      );

      if (user == null) {
        emit(AuthFailure('Registration failed'));
        return;
      }

      emit(RegisterSuccess());
    } catch (e) {
      emit(AuthFailure(_getFirebaseErrorMessage(e)));
    }
  }

  String _getFirebaseErrorMessage(Object error) {
    final message = error.toString();

    if (message.contains('email-already-in-use')) {
      return 'This email is already registered.';
    }

    if (message.contains('invalid-email')) {
      return 'Please enter a valid email.';
    }

    if (message.contains('weak-password')) {
      return 'Password is too weak.';
    }

    if (message.contains('invalid-credential')) {
      return 'Email or password is incorrect.';
    }

    if (message.contains('user-not-found')) {
      return 'No account found with this email.';
    }

    if (message.contains('wrong-password')) {
      return 'Incorrect password.';
    }

    return 'Something went wrong. Please try again.';
  }
}
