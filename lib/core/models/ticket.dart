import 'package:equatable/equatable.dart';
import 'package:mov_id/core/models/cinema.dart';
import 'package:mov_id/core/models/movie_detail.dart';

class Ticket extends Equatable {
  final String id;
  final String userId;
  final MovieDetail movieDetail;
  final Cinema cinema;
  final DateTime date;
  final List<String> seats;
  final int pricePerSeat;
  final int totalPrice;

  Ticket({
    this.id,
    this.userId,
    this.movieDetail,
    this.cinema,
    this.date,
    this.seats,
    this.pricePerSeat,
    this.totalPrice,
  });

  Ticket copywith(
      {String id,
      String userId,
      MovieDetail movieDetail,
      Cinema cinema,
      DateTime date,
      List<String> seats,
      int pricePerSeat,
      int totalPrice}) {
    return Ticket(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      movieDetail: movieDetail ?? this.movieDetail,
      cinema: cinema ?? this.cinema,
      date: date ?? this.date,
      seats: seats ?? this.seats,
      pricePerSeat: pricePerSeat ?? this.pricePerSeat,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object> get props => [
        id,
        userId,
        movieDetail,
        cinema,
        date,
        seats,
        pricePerSeat,
        totalPrice,
      ];
}
