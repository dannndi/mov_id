import 'package:flutter/cupertino.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/services/firebase_storage_services.dart';

class UserProvider extends ChangeNotifier {
  UserApp _userApp;
  UserApp get userApp => _userApp;

  void getUser(String uid) async {
    _userApp = await FirebaseStorageServices.getData(uid);
    notifyListeners();
  }

  void updateUser({String name, int balance, String profilePicture}) async {
    var newData = _userApp.copyWith(
      name: name,
      balance: balance,
      profilePicture: profilePicture,
    );
    _userApp = newData;
    await FirebaseStorageServices.setData(newData);
    notifyListeners();
  }

  void clearUser() {
    _userApp = null;
  }
}
