// Import relevant packages and files
import 'package:easychat/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository({required FirebaseAuth firebaseAuth, required GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  Future<AppUser> signIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = authResult.user!;
    return AppUser(id: user.uid, displayName: user.displayName, email: user.email, photoUrl: user.photoURL);
  }

  Future<AppUser> signUp() async {
    return signIn();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
  Future<bool> isUserSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }
}
