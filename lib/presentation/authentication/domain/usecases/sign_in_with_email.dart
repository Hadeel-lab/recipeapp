import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  Future<AppUser?> call(String email, String password) {
    return repository.signInWithEmail(email, password);
  }
}
