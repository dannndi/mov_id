import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mov_id/core/models/cinema.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/services/movie_services.dart';

class FirebaseStorageServices {
  //base path colection for user
  static var _userCollection = FirebaseFirestore.instance.collection('users');
  //base path collection for all ticket (seat)
  static var _ticketSeatCollection =
      FirebaseFirestore.instance.collection('ticket_seat');

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

  static Future<void> addUserTicket(Ticket ticket,
      {List<String> oldSeat}) async {
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

    //set booked ticket to global
    await setTicket(ticket: ticket, oldSeat: oldSeat);
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

  static Future<void> setTicket({Ticket ticket, List<String> oldSeat}) async {
    var cinema = ticket.cinema.name;
    var movieId = ticket.movieDetail.id.toString();
    var dateTime = ticket.bookedDate.millisecondsSinceEpoch.toString();

    var seats = [...oldSeat, ...ticket.seats];
    await _ticketSeatCollection
        .doc(cinema)
        .collection(movieId)
        .doc(dateTime)
        .set(
      {
        'seats': seats,
      },
    );
  }

  static Future<List<String>> getTicket(Ticket ticket) async {
    var seats = List<String>();
    var cinema = ticket.cinema.name;
    var movieId = ticket.movieDetail.id.toString();
    var dateTime = ticket.bookedDate.millisecondsSinceEpoch.toString();
    try {
      var result = await _ticketSeatCollection
          .doc(cinema)
          .collection(movieId)
          .doc(dateTime)
          .get();

      if (result.data() != null) {
        seats = (result.data()['seats'] as List)
            .map((seat) => seat.toString())
            .toList();
      }
      return seats;
    } catch (e) {
      return [];
    }
  }
}
