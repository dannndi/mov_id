import 'package:flutter/cupertino.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/models/user_transaction.dart';
import 'package:mov_id/core/services/firebase_storage_services.dart';

class TransactionProvider extends ChangeNotifier {
  //* user Transaction
  List<UserTransaction> _userTransaction;
  List<UserTransaction> get userTransaction => _userTransaction;

  Future<void> addTransaction({
    @required String userId,
    Ticket ticket,
    int balance,
  }) async {
    //add ticket to user => transaction
    await FirebaseStorageServices.addUserTransaction(
      userId: userId,
      balance: balance,
      ticket: ticket,
    );
    notifyListeners();
  }

  void getTransaction(String id) async {
    _userTransaction =
        await FirebaseStorageServices.getUserTransaction(userId: id);
    notifyListeners();
  }

  void clearTransaction() {
    _userTransaction = null;
  }
}
