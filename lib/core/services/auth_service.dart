import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  // late final = created only when first used (so demo mode never touches Firebase)
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get currentUserStream => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<UserModel?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc.data()!, doc.id);
    }
    return null;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password, UserModel userModel) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (cred.user != null) {
      userModel.uid = cred.user!.uid;
      await _firestore.collection('users').doc(userModel.uid).set(userModel.toFirestore());
    }
    return cred;
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
    if (gUser == null) return null;
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    final cred = await _auth.signInWithCredential(credential);
    
    if (cred.user != null) {
      final doc = await _firestore.collection('users').doc(cred.user!.uid).get();
      if (!doc.exists) {
        final newUser = UserModel(
          uid: cred.user!.uid,
          name: cred.user!.displayName ?? 'User',
          email: cred.user!.email ?? '',
          bloodType: 'Unknown',
          governorate: 'cairo',
          phone: '',
        );
        await _firestore.collection('users').doc(newUser.uid).set(newUser.toFirestore());
      }
    }
    return cred;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
