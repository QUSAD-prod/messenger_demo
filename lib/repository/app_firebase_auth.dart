import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
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
      switch (e.code) {
        default:
          onFailure();
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
      switch (e.code) {
        case "operation-not-allowed":
          onFailure();
          GetIt.I<Talker>().error("Firebase: anonymous auth hasn't been enabled for this project.");
          break;
        default:
          onFailure();
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
      switch (e.code) {
        //TODO Add error handler
        default:
          onFailure();
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
      switch (e.code) {
        //TODO Add error handler
        default:
          onFailure();
          GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
      }
    }
  }
}
