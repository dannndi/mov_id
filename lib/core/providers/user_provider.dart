import 'package:flutter/cupertino.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/models/user_transaction.dart';
import 'package:mov_id/core/services/firebase_storage_services.dart';

class UserProvider extends ChangeNotifier {
  //* user App
  UserApp _userApp;
  UserApp get userApp => _userApp;

  void getUser({@required String userId}) async {
    _userApp = await FirebaseStorageServices.getUserData(userId: userId);
    notifyListeners();
  }

  void updateUser({String name, int balance, String profilePicture}) async {
    var newData = _userApp.copyWith(
      name: name,
      balance: balance,
      profilePicture: profilePicture,
    );
    _userApp = newData;
    await FirebaseStorageServices.setUserData(userApp: newData);
    notifyListeners();
  }

  void clearUser() {
    _userApp = null;
  }
}
