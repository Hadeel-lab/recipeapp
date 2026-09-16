import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource({required this.firebaseAuth});

  Future<User?> signInWithGoogle() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('email');

    final UserCredential userCredential = await firebaseAuth.signInWithPopup(
      googleProvider,
    );

    return userCredential.user;
  }

  Future<User?> signInWithEmail(String email, String password) async {
    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }

  Future<User?> registerWithEmail(
    String name,
    String email,
    String password,
  ) async {
    final UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    final User? user = userCredential.user;

    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();
    }

    return firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
