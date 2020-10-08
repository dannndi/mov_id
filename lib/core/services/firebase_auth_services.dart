import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mov_id/core/models/result_model/auth_result.dart';
import 'package:mov_id/core/services/firebase_storage_services.dart';
import '../extensions/firebase_user_extension.dart';

class FirebaseAuthServices {
  //instance firebase
  static var _auth = FirebaseAuth.instance;
  //state user signin or not
  static Stream<User> get userStream => _auth.authStateChanges();
  //register New User
  static Future<AuthResult> login({String email, String password}) async {
    try {
      var _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return AuthResult(userId: _result.user.uid);
    } on FirebaseAuthException catch (e) {
      //return error Message
      return AuthResult(errorMessage: e.message);
    }
  }

  static Future<AuthResult> registerNewUser({
    String email,
    String password,
    String name,
    String language,
    List<String> preferenGenre,
  }) async {
    try {
      //create new user In Firebase Auth
      var _result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //get userApp data from firebase User
      var userApp = _result.user.converToUserApp(
        name: name,
        language: language,
        preferedGenre: preferenGenre,
        balance: 1000000,
      );
      //set userApp data to Firebase Storage
      await FirebaseStorageServices.setUserData(userApp: userApp);
      //return userApp data
      return AuthResult(userId: _result.user.uid);
    } on FirebaseAuthException catch (e) {
      //return error Message
      return AuthResult(errorMessage: e.message);
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }
}
