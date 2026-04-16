import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/auth_model.dart';

abstract class AuthRepo {
  Future<AuthModel> signInWithEmail(String email, String password);
  Future<AuthModel> signUpWithEmail(String email, String password);
  Future<AuthModel> signInWithGoogle();
  Future<void> signOut();
  Stream<AuthModel?> get authStateChanges;
}

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthModel _mapUserToModel(User user) {
    return AuthModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
    );
  }

  @override
  Future<AuthModel> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw FirebaseAuthException(code: 'user-not-found', message: 'User data not found.');
    return _mapUserToModel(user);
  }

  @override
  Future<AuthModel> signUpWithEmail(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw FirebaseAuthException(code: 'user-not-found', message: 'User data not found.');
    return _mapUserToModel(user);
  }

  @override
  Future<AuthModel> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign-in cancelled');

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) throw FirebaseAuthException(code: 'user-not-found', message: 'User data not found.');
    return _mapUserToModel(user);
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }

  @override
  Stream<AuthModel?> get authStateChanges {
    return _auth.authStateChanges().map(
      (user) => user != null ? _mapUserToModel(user) : null,
    );
  }
}
