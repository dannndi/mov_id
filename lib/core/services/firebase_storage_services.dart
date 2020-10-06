import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mov_id/core/models/cinema.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/services/movie_services.dart';

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

  static Future<void> addUserTicket(Ticket ticket) async {
    var _userTicketCollection =
        _userCollection.doc(ticket.userId).collection('ticket');
    await _userTicketCollection.doc().set({
      'username': ticket.userName,
      'movie_id': ticket.movieDetail.id,
      'cinema': ticket.cinema.name,
      'date': ticket.bookedDate.millisecondsSinceEpoch,
      'seats': ticket.seats,
      'total_price': ticket.totalPrice,
      'date_of_buying': ticket.dateOfBuying.millisecondsSinceEpoch,
    });
  }

  static Future<List<Ticket>> getUserTicket(String userId) async {
    var _userTicketCollection =
        _userCollection.doc(userId).collection('ticket');

    var result = await _userTicketCollection.get();
    var docs = result.docs;
    List<Ticket> ticketList = [];
    for (var doc in docs) {
      //get detail movie
      var movieDetail = await MovieServices.getMovieById(
        doc.data()['movie_id'],
      );
      //add ticket to list
      ticketList.add(
        Ticket(
          bookingCode: doc.reference.id,
          movieDetail: movieDetail.movieDetail,
          userName: doc.data()['username'],
          cinema: Cinema(name: doc.data()['cinema']),
          bookedDate: DateTime.fromMillisecondsSinceEpoch(doc.data()['date']),
          seats: (doc.data()['seats'] as List)
              .map((seat) => seat.toString())
              .toList(),
          totalPrice: doc.data()['total_price'],
          dateOfBuying:
              DateTime.fromMillisecondsSinceEpoch(doc.data()['date_of_buying']),
        ),
      );
    }
    return ticketList;
  }
}
