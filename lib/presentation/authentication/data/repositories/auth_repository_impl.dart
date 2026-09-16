import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_source/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<AppUser?> signInWithGoogle() async {
    final User? firebaseUser = await dataSource.signInWithGoogle();

    if (firebaseUser == null) {
      return null;
    }

    return _mapUser(firebaseUser);
  }

  @override
  Future<AppUser?> signInWithEmail(String email, String password) async {
    final User? firebaseUser = await dataSource.signInWithEmail(
      email,
      password,
    );

    if (firebaseUser == null) {
      return null;
    }

    return _mapUser(firebaseUser);
  }

  @override
  Future<AppUser?> registerWithEmail(
    String name,
    String email,
    String password,
  ) async {
    final User? firebaseUser = await dataSource.registerWithEmail(
      name,
      email,
      password,
    );

    if (firebaseUser == null) {
      return null;
    }

    return _mapUser(firebaseUser);
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }

  AppUser _mapUser(User user) {
    return AppUser(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
