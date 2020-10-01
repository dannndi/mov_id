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
}
