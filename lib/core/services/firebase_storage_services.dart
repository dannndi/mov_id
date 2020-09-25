import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mov_id/core/models/user.dart';

class FirebaseStorageServices {
  //base path colection for user
  static var _userCollection = FirebaseFirestore.instance.collection('users');

  //set data can be add new data or replace existing data
  static Future<void> setData(UserApp userApp) {
    //future but not have to wait, because we don't wait anything from this proscess,
    //it can be run on background though
    _userCollection.doc(userApp.id).set({
      'email': userApp.email,
      'fullName': userApp.name,
      'language': userApp.language,
      'preferedGenre': userApp.preferedGenre,
      'profilePicture': userApp.profilePicture ?? '',
      'balance': userApp.balance,
    });
  }

  static Future<UserApp> getData(String id) async {
    var _doc = await _userCollection.doc(id).get();
    return UserApp(
      id: id,
      name: _doc.data()['fullName'],
      email: _doc.data()['email'],
      language: _doc.data()['language'],
      profilePicture: _doc.data()['profilePicture'],
      balance: _doc.data()['balance'],
      preferedGenre: (_doc.data()['preferedGenre'] as List)
          .map((genre) => genre.toString())
          .toList(),
    );
  }
}
