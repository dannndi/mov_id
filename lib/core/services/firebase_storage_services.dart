import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mov_id/core/models/cinema.dart';
import 'package:mov_id/core/models/ticket.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/models/user_transaction.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/services/movie_services.dart';

class FirebaseStorageServices {
  //* ================================================================
  //* Methode for modification on User
  //* ================================================================
  //*
  // base path colection for user
  static var _userCollection = FirebaseFirestore.instance.collection('users');
  // set data can be add new data or replace existing data
  static Future<void> setUserData({@required UserApp userApp}) {
    // future but not have to wait, because we don't wait anything from this proscess,
    // it can be run on background though
    _userCollection.doc(userApp.id).set({
      'email': userApp.email,
      'fullName': userApp.name,
      'language': userApp.language,
      'preferedGenre': userApp.preferedGenre,
      'profilePicture': userApp.profilePicture ?? '',
      'balance': userApp.balance,
    });
  }

  static Future<UserApp> getUserData({@required String userId}) async {
    var _doc = await _userCollection.doc(userId).get();
    return UserApp(
      id: userId,
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

  //* ================================================================
  //* Methode for modification on User Ticket and User Transaction
  //* ================================================================
  //*
  static Future<void> addUserTicket(
      {@required String userId, @required Ticket ticket}) async {
    var _userTicketCollection =
        _userCollection.doc(userId).collection('ticket');
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

  static Future<List<Ticket>> getUserTicket({@required String userId}) async {
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

  static Future<void> addUserTransaction({
    @required String userId,
    Ticket ticket,
    int balance,
  }) async {
    var _userTransactionCollection =
        _userCollection.doc(userId).collection('transaction');

    var title = ticket != null ? 'Buy Ticket' : 'Top up';
    var amount = ticket != null ? '${ticket.totalPrice}' : '$balance';
    var subTitle =
        ticket != null ? '${ticket.movieDetail.title}' : 'Top up my wallet';
    var date = DateTime.now().millisecondsSinceEpoch.toString();

    await _userTransactionCollection.doc().set({
      'title': title,
      'amount': amount,
      'sub_title': subTitle,
      'date': date,
    });
  }

  static Future<List<UserTransaction>> getUserTransaction(
      {@required String userId}) async {
    var _userTransactionCollection =
        _userCollection.doc(userId).collection('transaction');

    var result = await _userTransactionCollection.get();
    var docs = result.docs;
    List<UserTransaction> transactionList = [];
    for (var doc in docs) {
      //add ticket to list
      transactionList.add(
        UserTransaction(
          userId: doc.reference.id,
          amount: int.tryParse(doc.data()['amount']),
          title: doc.data()['title'],
          subTitle: doc.data()['sub_title'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(
              doc.data()['date'],
            ),
          ),
        ),
      );
    }
    return transactionList;
  }

  //* ================================================================
  //* Methode for modification on Cinema Ticket
  //* ================================================================
  //*
  //base path collection for all ticket (seat)
  static var _ticketSeatCollection =
      FirebaseFirestore.instance.collection('cinema');

  static Future<void> setBookedSeat(
      {@required Ticket ticket, @required List<String> oldSeat}) async {
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

  static Future<List<String>> getBookedSeat({@required Ticket ticket}) async {
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
