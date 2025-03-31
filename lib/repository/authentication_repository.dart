import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AuthenticationRepository {
  static final _firebaseAuth = GetIt.I<FirebaseAuth>();
  static final _talker = GetIt.I<Talker>();

  static Future<void> checkAuthStatus({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onSignedIn,
    required VoidCallback onNotSignedIn,
    required VoidCallback onNotVerified,
  }) async {
    try {
      _talker.info('Firebase: try check auth status.');
      onLoading();
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.reload();
        if (_firebaseAuth.currentUser!.emailVerified || _firebaseAuth.currentUser!.isAnonymous) {
          onLoaded();
          _talker.info('Firebase: auth status is signed in.');
          onSignedIn();
        } else {
          onLoaded();
          _talker.info('Firebase: auth status is signed in with not verified email.');
          onNotVerified();
        }
      } else {
        onLoaded();
        _talker.info('Firebase: auth status is not signed in.');
        onNotSignedIn();
      }
    } on FirebaseAuthException catch (e) {
      _talker.error("Firebase: unknown error.\n${e.code}");
    }
  }

  static Future<void> checkEmailVerifyStatus({
    required VoidCallback onVerified,
  }) async {
    try {
      _talker.info('Firebase: try check email verify status.');
      await _firebaseAuth.currentUser!.reload();
      if (_firebaseAuth.currentUser!.emailVerified) {
        _talker.info('Firebase: email is verified.');
        onVerified();
      } else {
        _talker.info('Firebase: email is not verified.');
      }
    } on FirebaseAuthException catch (e) {
      _talker.error("Firebase: unknown error.\n${e.code}");
    }
  }

  static Future<void> sendVerificationEmail({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      _talker.info('Firebase: try send verification email.');
      onLoading();
      await _firebaseAuth.currentUser?.sendEmailVerification();
      onLoaded();
      _talker.info('Firebase: sent verification email.');
    } on FirebaseAuthException catch (e) {
      onFailure();
      _talker.error("Firebase: unknown error.\n${e.code}");
    }
  }

  static Future<void> sendResetPasswordEmail({
    required String email,
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required void Function({String? emailError, String? otherError}) onFailure,
  }) async {
    try {
      _talker.info('Firebase: try send reset password email.');
      onLoading();
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      onLoaded();
      _talker.info('Firebase: sent reset password email.');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'missing-email':
          onFailure(emailError: "missing email");
          _talker.error("Firebase: missing email error.");
          break;
        case 'invalid-email':
          onFailure(emailError: "invalid email");
          _talker.error("Firebase: invalid email error.");
          break;
        default:
          onFailure(otherError: "Unknown error.");
          _talker.error("Firebase: unknown error.\n${e.code}");
      }
    }
  }

  static Future<void> signOut({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      onLoading();
      _talker.info('Firebase: try signOut."');
      await _firebaseAuth.signOut();
      _talker.info("Firebase: signed out.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        default:
          _talker.error("Firebase: unknown error.\n${e.code}");
      }
    }
  }

  static Future<void> deleteAccount({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      onLoading();
      _talker.info('Firebase: try delete account."');
      await _firebaseAuth.currentUser?.delete();
      _talker.info("Firebase: account deleted.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        default:
          _talker.error("Firebase: unknown error.\n${e.code}");
      }
    }
  }

  static Future<void> signInAnonymously({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      onLoading();
      _talker.info('Firebase: try signIn with temporary account."');
      await _firebaseAuth.signInAnonymously();
      _talker.info("Firebase: signed in with temporary account.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        case "operation-not-allowed":
          _talker.error("Firebase: anonymous auth hasn't been enabled for this project.");
          break;
        default:
          _talker.error("Firebase: unknown error.\n${e.code}");
      }
    }
  }

  static Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required void Function({String? emailError, String? passwordError, String? otherError}) onFailure,
  }) async {
    try {
      onLoading();
      _talker.info('Firebase: try signUn with email and password."');
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _talker.info("Firebase: signed up with with email and password.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          _talker.error("Firebase: email is not valid or badly formatted.");
          onFailure(emailError: "email is not valid or badly formatted");
          break;
        case 'email-already-in-use':
          _talker.error("Firebase: an account already exists for that email.");
          onFailure(emailError: "an account already exists for that email");
          break;
        case 'operation-not-allowed':
          _talker.error("Firebase: operation is not allowed. Please contact support.");
          onFailure(otherError: "Operation is not allowed. Please contact support.");
          break;
        case 'weak-password':
          _talker.error("Firebase: please enter a stronger password.");
          onFailure(passwordError: "please enter a stronger password");
          break;
        case 'network-request-failed':
          _talker.error("Firebase: network request failed.");
          onFailure(otherError: "No internet connection");
          break;
        default:
          _talker.error("Firebase: unknown error.\n${e.code}");
          onFailure(otherError: "Unknown error.");
          break;
      }
    } catch (e) {
      _talker.error("Firebase: unknown error.");
      onFailure(otherError: "Unknown error.");
    }
  }

  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required void Function({String? emailError, String? passwordError, String? otherError}) onFailure,
  }) async {
    try {
      onLoading();
      _talker.info('Firebase: try signIn with email and password."');
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _talker.info("Firebase: signed in with with email and password.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          _talker.error("Firebase: email is not valid or badly formatted.");
          onFailure(emailError: "Email is not valid or badly formatted");
          break;
        case 'user-disabled':
          _talker.error("Firebase: this user has been disabled. Please contact support for help.");
          onFailure(otherError: "This user has been disabled. Please contact support for help.");
          break;
        case 'invalid-credential':
          _talker.error("Firebase: incorrect email or password.");
          onFailure(
            emailError: "Incorrect email or password",
            passwordError: "Incorrect email or password",
          );
          break;
        case 'network-request-failed':
          _talker.error("Firebase: network request failed.");
          onFailure(otherError: "No internet connection");
          break;
        default:
          _talker.error("Firebase: unknown error.\n${e.code}");
          onFailure(otherError: "Unknown error.");
      }
    } catch (e) {
      _talker.error("Firebase: unknown error.");
      onFailure(otherError: "Unknown error.");
    }
  }

  static Future<void> signInWithGoogle({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      onLoading();
      _talker.info('Firebase: try signIn with google."');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        _talker.info("Firebase: signed in with with google.");
        onLoaded();
      } else {
        onFailure();
        _talker.error("Firebase: unknown error.");
      }
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        case 'account-exists-with-different-credential':
          _talker.error("Firebase: account exists with different credentials.");
          break;
        case 'invalid-credential':
          _talker.error("Firebase: the credential received is malformed or has expired.");
          break;
        case 'operation-not-allowed':
          _talker.error("Firebase: operation is not allowed.  Please contact support.");
          break;
        case 'user-disabled':
          _talker.error("Firebase: this user has been disabled. Please contact support for help.");
          break;
        case 'user-not-found':
          _talker.error("Firebase: email is not found, please create an account.");
          break;
        case 'wrong-password':
          _talker.error("Firebase: incorrect password, please try again.");
          break;
        case 'invalid-verification-code':
          _talker.error("Firebase: the credential verification code received is invalid.");
          break;
        case 'invalid-verification-id':
          _talker.error("Firebase: the credential verification ID received is invalid.");
          break;
        default:
          _talker.error("Firebase: unknown error.\n${e.code}");
      }
    } catch (e) {
      onFailure();
      _talker.error("Firebase: unknown error.");
    }
  }
}
