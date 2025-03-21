import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppFirebaseAuth {
  static void checkAuthStatus({
    required VoidCallback onLoading,
    required VoidCallback onSignedIn,
    required VoidCallback onNotSignedIn,
  }) {
    try {
      GetIt.I<Talker>().info('Firebase: try check auth status.');
      onLoading();
      if (GetIt.I<FirebaseAuth>().currentUser != null) {
        GetIt.I<Talker>().info('Firebase: auth status is signed in.');
        onSignedIn();
      } else {
        GetIt.I<Talker>().info('Firebase: auth status is not signed in.');
        onNotSignedIn();
      }
    } on FirebaseAuthException catch (e) {
      GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
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
          GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
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
          GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
      }
    }
  }

  static Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      onLoading();
      GetIt.I<Talker>().info('Firebase: try signUn with email and password."');
      //TODO Add signUnMethod
      GetIt.I<Talker>().info("Firebase: signed up with with email and password.");
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        //TODO Add error handler
        default:
          GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
      }
    }
  }

  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required VoidCallback onLoading,
    required VoidCallback onLoaded,
    required VoidCallback onFailure,
  }) async {
    try {
      onLoading();
      GetIt.I<Talker>().info('Firebase: try signIn with email and password."');
      //TODO Add signInMethod
      GetIt.I<Talker>().info("Firebase: signed in with with email and password.");
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        //TODO Add error handler
        default:
          GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
      }
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
        GetIt.I<Talker>().error("Firebase: Unknown error.");
      }
    } on FirebaseAuthException catch (e) {
      onFailure();
      switch (e.code) {
        case 'account-exists-with-different-credential':
          GetIt.I<Talker>().error("Account exists with different credentials.");
          break;
        case 'invalid-credential':
          GetIt.I<Talker>().error("The credential received is malformed or has expired.");
          break;
        case 'operation-not-allowed':
          GetIt.I<Talker>().error("Operation is not allowed.  Please contact support.");
          break;
        case 'user-disabled':
          GetIt.I<Talker>().error("This user has been disabled. Please contact support for help.");
          break;
        case 'user-not-found':
          GetIt.I<Talker>().error("Email is not found, please create an account.");
          break;
        case 'wrong-password':
          GetIt.I<Talker>().error("Incorrect password, please try again.");
          break;
        case 'invalid-verification-code':
          GetIt.I<Talker>().error("The credential verification code received is invalid.");
          break;
        case 'invalid-verification-id':
          GetIt.I<Talker>().error("The credential verification ID received is invalid.");
          break;
        default:
          GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
      }
    } catch (e) {
      onFailure();
      GetIt.I<Talker>().error("Unknown error.");
    }
  }
}
