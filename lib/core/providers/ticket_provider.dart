import 'package:flutter/cupertino.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/services/firebase_storage_services.dart';

class TicketProvider extends ChangeNotifier {
  //* user Ticket
  List<Ticket> _userTicket = [];
  List<Ticket> get userTicket => _userTicket;

  Future<void> buyTicket(
      {@required String userId,
      @required Ticket ticket,
      @required List<String> oldSeat}) async {
    //add ticket to user => ticket
    await FirebaseStorageServices.addUserTicket(
      userId: userId,
      ticket: ticket,
    );
    await FirebaseStorageServices.setBookedSeat(
      ticket: ticket,
      oldSeat: oldSeat,
    );
    notifyListeners();
  }

  void getTicket({String userId}) async {
    _userTicket = await FirebaseStorageServices.getUserTicket(userId: userId);
    notifyListeners();
  }

  void clearTicket() {
    _userTicket = null;
  }
}
