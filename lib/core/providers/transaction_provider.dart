import 'package:flutter/cupertino.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/models/user_transaction.dart';
import 'package:mov_id/core/services/firebase_storage_services.dart';

class TransactionProvider extends ChangeNotifier {
  //* user Transaction
  List<UserTransaction> _userTransasction;
  List<UserTransaction> get userTransaction => _userTransasction;

  Future<void> addTransaction({
    @required String userId,
    Ticket ticket,
    int balance,
  }) async {
    //add ticket to user => transaction
    await FirebaseStorageServices.addUserTransaction(
      userId: userId,
      balance: balance,
    );
    notifyListeners();
  }

  void clearTransaction() {
    _userTransasction = null;
  }
}
