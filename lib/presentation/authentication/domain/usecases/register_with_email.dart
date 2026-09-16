import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class RegisterWithEmail {
  final AuthRepository repository;

  RegisterWithEmail(this.repository);

  Future<AppUser?> call(String name, String email, String password) {
    return repository.registerWithEmail(name, email, password);
  }
}
