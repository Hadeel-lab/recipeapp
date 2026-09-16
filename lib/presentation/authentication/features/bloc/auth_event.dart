abstract class AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailEvent({required this.email, required this.password});
}

class RegisterWithEmailEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterWithEmailEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignOutEvent extends AuthEvent {}
