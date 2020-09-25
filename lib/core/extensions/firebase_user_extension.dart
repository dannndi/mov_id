import 'package:firebase_auth/firebase_auth.dart';
import 'package:mov_id/core/models/user.dart';

extension FirebaseUserExtension on User {
  //easy make UserApp from Firebase User when register new user
  UserApp converToUserApp({
    String name,
    List<String> preferedGenre = const [],
    String language = "",
    int balance = 100000,
  }) {
    return UserApp(
      id: this.uid,
      email: this.email,
      name: name,
      preferedGenre: preferedGenre,
      language: language,
      balance: balance,
    );
  }

  //easy geting userApp data Form Firebase Storage when user Login
}
