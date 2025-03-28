import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AuthenticationRepository {
  static Future<void> checkAuthStatus({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onSignedIn,
    required VoidCallback onNotSignedIn,
    required VoidCallback onNotVerified,
  }) async {
    try {
      GetIt.I<Talker>().info('Firebase: try check auth status.');
      onLoading();
      if (GetIt.I<FirebaseAuth>().currentUser != null) {
        await GetIt.I<FirebaseAuth>().currentUser!.reload();
        if (GetIt.I<FirebaseAuth>().currentUser!.emailVerified || GetIt.I<FirebaseAuth>().currentUser!.isAnonymous) {
          onLoaded();
          GetIt.I<Talker>().info('Firebase: auth status is signed in.');
          onSignedIn();
        } else {
          onLoaded();
          GetIt.I<Talker>().info('Firebase: auth status is signed in with not verified email.');
          onNotVerified();
        }
      } else {
        onLoaded();
        GetIt.I<Talker>().info('Firebase: auth status is not signed in.');
        onNotSignedIn();
      }
    } on FirebaseAuthException catch (e) {
      GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
    }
  }

  static Future<void> checkEmailVerifyStatus({
    required VoidCallback onVerified,
  }) async {
    try {
      GetIt.I<Talker>().info('Firebase: try check email verify status.');
      await GetIt.I<FirebaseAuth>().currentUser!.reload();
      if (GetIt.I<FirebaseAuth>().currentUser!.emailVerified) {
        GetIt.I<Talker>().info('Firebase: email is verified.');
        onVerified();
      } else {
        GetIt.I<Talker>().info('Firebase: email is not verified.');
      }
    } on FirebaseAuthException catch (e) {
      GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
    }
  }

  static Future<void> sendVerificationEmail({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      GetIt.I<Talker>().info('Firebase: try send verification email.');
      onLoading();
      await GetIt.I<FirebaseAuth>().currentUser?.sendEmailVerification();
      onLoaded();
      GetIt.I<Talker>().info('Firebase: sent verification email.');
    } on FirebaseAuthException catch (e) {
      onFailure();
      GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
    }
  }

  static Future<void> signOut({
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      onLoading();
      GetIt.I<Talker>().info('Firebase: try signOut."');
      await GetIt.I<FirebaseAuth>().signOut();
      GetIt.I<Talker>().info("Firebase: signed out.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        default:
          GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
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
      GetIt.I<Talker>().info('Firebase: try delete account."');
      await GetIt.I<FirebaseAuth>().currentUser?.delete();
      GetIt.I<Talker>().info("Firebase: account deleted.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        default:
          GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
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
      GetIt.I<Talker>().info('Firebase: try signIn with temporary account."');
      await GetIt.I<FirebaseAuth>().signInAnonymously();
      GetIt.I<Talker>().info("Firebase: signed in with temporary account.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        case "operation-not-allowed":
          GetIt.I<Talker>().error("Firebase: anonymous auth hasn't been enabled for this project.");
          break;
        default:
          GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
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
      GetIt.I<Talker>().info('Firebase: try signUn with email and password."');
      await GetIt.I<FirebaseAuth>().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      GetIt.I<Talker>().info("Firebase: signed up with with email and password.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          GetIt.I<Talker>().error("Firebase: email is not valid or badly formatted.");
          onFailure(emailError: "email is not valid or badly formatted");
          break;
        case 'email-already-in-use':
          GetIt.I<Talker>().error("Firebase: an account already exists for that email.");
          onFailure(emailError: "an account already exists for that email");
          break;
        case 'operation-not-allowed':
          GetIt.I<Talker>().error("Firebase: operation is not allowed. Please contact support.");
          onFailure(otherError: "Operation is not allowed. Please contact support.");
          break;
        case 'weak-password':
          GetIt.I<Talker>().error("Firebase: please enter a stronger password.");
          onFailure(passwordError: "please enter a stronger password");
          break;
        case 'network-request-failed':
          GetIt.I<Talker>().error("Firebase: network request failed.");
          onFailure(otherError: "No internet connection");
          break;
        default:
          GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
          onFailure(otherError: "Unknown error.");
          break;
      }
    } catch (e) {
      GetIt.I<Talker>().error("Firebase: unknown error.");
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
      GetIt.I<Talker>().info('Firebase: try signIn with email and password."');
      await GetIt.I<FirebaseAuth>().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      GetIt.I<Talker>().info("Firebase: signed in with with email and password.");
      onLoaded();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          GetIt.I<Talker>().error("Firebase: email is not valid or badly formatted.");
          onFailure(emailError: "Email is not valid or badly formatted");
          break;
        case 'user-disabled':
          GetIt.I<Talker>().error("Firebase: this user has been disabled. Please contact support for help.");
          onFailure(otherError: "This user has been disabled. Please contact support for help.");
          break;
        case 'invalid-credential':
          GetIt.I<Talker>().error("Firebase: incorrect email or password.");
          onFailure(
            emailError: "Incorrect email or password",
            passwordError: "Incorrect email or password",
          );
          break;
        case 'network-request-failed':
          GetIt.I<Talker>().error("Firebase: network request failed.");
          onFailure(otherError: "No internet connection");
          break;
        default:
          GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
          onFailure(otherError: "Unknown error.");
      }
    } catch (e) {
      GetIt.I<Talker>().error("Firebase: unknown error.");
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
      GetIt.I<Talker>().info('Firebase: try signIn with google."');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        GetIt.I<Talker>().info("Firebase: signed in with with google.");
        onLoaded();
      } else {
        onFailure();
        GetIt.I<Talker>().error("Firebase: unknown error.");
      }
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        case 'account-exists-with-different-credential':
          GetIt.I<Talker>().error("Firebase: account exists with different credentials.");
          break;
        case 'invalid-credential':
          GetIt.I<Talker>().error("Firebase: the credential received is malformed or has expired.");
          break;
        case 'operation-not-allowed':
          GetIt.I<Talker>().error("Firebase: operation is not allowed.  Please contact support.");
          break;
        case 'user-disabled':
          GetIt.I<Talker>().error("Firebase: this user has been disabled. Please contact support for help.");
          break;
        case 'user-not-found':
          GetIt.I<Talker>().error("Firebase: email is not found, please create an account.");
          break;
        case 'wrong-password':
          GetIt.I<Talker>().error("Firebase: incorrect password, please try again.");
          break;
        case 'invalid-verification-code':
          GetIt.I<Talker>().error("Firebase: the credential verification code received is invalid.");
          break;
        case 'invalid-verification-id':
          GetIt.I<Talker>().error("Firebase: the credential verification ID received is invalid.");
          break;
        default:
          GetIt.I<Talker>().error("Firebase: unknown error.\n${e.code}");
      }
    } catch (e) {
      onFailure();
      GetIt.I<Talker>().error("Firebase: unknown error.");
    }
  }
}
