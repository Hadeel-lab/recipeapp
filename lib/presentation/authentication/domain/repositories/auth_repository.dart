import '../../domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> signInWithGoogle();

  Future<AppUser?> signInWithEmail(String email, String password);

  Future<AppUser?> registerWithEmail(
    String name,
    String email,
    String password,
  );

  Future<void> signOut();
}
